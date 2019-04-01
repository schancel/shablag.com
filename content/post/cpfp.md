---
title: "Child Pays for Parent"
date: 2019-03-31T10:44:43-07:00
draft: false
---

Bitcoin-ABC inherited a feature from Bitcoin Core called "Child Pays For Parent" (CPFP). The purpose of this feature is to allow transactions which spend outputs from other transactions, which are currently in the mempool, to pay fees on behalf of the parent transactions. This is useful in the case where the parent would not be included in the next block, and someone desires to spend it's output immediately. From a mining perspective, it would be more profitable to include the pair of transactions, receiving both their fees, than include some entirely different transaction.

While this seems like a useful feature, it causes several scaling issues. When constructing a new block, the software needs to know which transactions to include in the block -- but it is no longer based solely on individual transaction fees, but instead on transaction fees of each chain of transactions (herein called a package).

As new transactions in a package come in, we must look up all their parents, and update the ancestors. This means, for a package of size N, we must do this N! times:
```C++
bool CTxMemPool::addUnchecked(...) {
    ...
    const CTransaction &tx = newit->GetTx();
    std::set<uint256> setParentTransactions;
    for (const CTxIn &in : tx.vin) {
        mapNextTx.insert(std::make_pair(&in.prevout, &tx));
        setParentTransactions.insert(in.prevout.GetTxId());
    }
    ... 
    // Update ancestors with information about this tx
    for (const uint256 &phash : setParentTransactions) {
        txiter pit = mapTx.find(phash);
        if (pit != mapTx.end()) {
            UpdateParent(newit, pit, true);
        }
    }
    UpdateAncestorsOf(true, newit, setAncestors);
    UpdateEntryForAncestors(newit, setAncestors);
    ...
}
```

Additionally, when a new block is found, it's transactions must be removed from the mempool. In this case, this extra accounting must be updated again.  In order to ensure that chains are not broken up while updating the accounting, this needs to be done in topological order. Since the introduction of CTOR, blocks are no longer in topological order, so they must be first sorted.  [Topological sorting](https://en.wikipedia.org/wiki/Topological_sorting) is linear time in the number of nodes and edges(approximately linear in terms of block size).  Once we have topologically ordered them, we must then update each each descendants's accounting. This is again N! time:

```C++
void CTxMemPool::removeForBlock(...) {
    ...
    for (const CTransactionRef &tx : reverse_iterate(disconnectpool.GetQueuedTx().get<insertion_order>())) {
        ...
        setEntries setDescendants;
        CalculateDescendants(tx, setDescendants);
        for (txiter dit : setDescendants) {
            mapTx.modify(dit, update_ancestor_state(...));
        }
        ...
        removeUnchecked(tx);
    }
    ...
}
```

Now, since the the algorithms required are nonlinear, making it an excellent place to cause a DoS.  So, the following code is added when accepting transactions to the mempool:

```C++
static bool AcceptToMemoryPoolWorker(...) {
    ...
    if (!pool.CalculateMemPoolAncestors(
            entry, setAncestors, nLimitAncestors, nLimitAncestorSize,
            nLimitDescendants, nLimitDescendantSize, errString)) {
        return state.DoS(0, false, REJECT_NONSTANDARD,
                         "too-long-mempool-chain", false, errString);
    }
    ...
}
```

So, while this feature appears useful, it causes a couple of problems:

1. It adds n! complexity to both accepting new chained transactions.
2. It adds n! complexity to processing (not validating) a new block.
3. It prevents long chains of zero-conf transactions for high-frequency, in order to prevent DoS attacks.

![Effect of Raising Chained Tx Limit](/20180331-MempoolAccept.png "Performance Impacts of Raising the Ancestor andDescendant Transaction Limit for Bitcoin Cash")
Taken from [Raising the Ancestor and Descendant Transaction Limit for Bitcoin Cash](/20180331-ChainedTx.pdf)

Now, this feature only has practical applicability when the mempool size is larger than the maximum blocksize for an extended period of time. In the case where the mempool size is less than the maximum blocksize, it will be cleared with each new block.  In this case, any logic to choose which transactions should be in a block is rendered meaningless.

There are two conditions where the mempool size would be larger than the block size in practice:

1. Sustained usage which exceeds demand for blockspace.
2. Attempts to DDoS Bitcoin by sending lots of transactions with small fees.

For the first case, this is undesirable as it means the user experience is bad.  Additionally, if users are generating transactions faster than they can be confirmed, new transactions may never be confirmed, and possibly dropped from the mempool as it grows larger.  Bitcoin Cash is based on the belief that this condition should never occur.

For the second case, we have not observed that this occurs for any significant length of time. It is actually quite costly to carry out such an attack, and gains the perpetrator nearly nothing. At most, we need to ensure that we have some quality of service mechanism in place. 

So, we can replace this complicated accounting with the following requirements:

1. When receiving an orphan transaction which has a high fee, request the transaction from your peers, in case you did not receive the relayed transaction.  Make a special exception for receiving this transaction.
2. When a new transaction is admitted to the memory pool, if it's parent is not in the current block template, calculate a modified fee for the immediate parents, and attempt to put them all in the current block template. If this fails, place the transaction in a reconsideration pool.
3. When a new block comes in, and it's transactions have been removed from the mempool, process the reconsideration pool.

Now, currently the block template is not maintained concurrently as new transactions are processed.  Instead, when mining pool software calls the `getblocktemplate` rpc, a new template is created from scratch.  Additionally, the template constructor uses the mempool's accounting data to include transactions in fee-order.  In order to carry out the above steps, we will need to invert this process.

Replacing this code is tedious as any mistake can cost miners significant amounts of money when if they produce an invalid block.  It could also cause a service outage if the problem is deterministic, and user-triggerable, and no miners are able to produce blocks until the problem is addressed.  Therefor, we need to have a solid plan to refactor the block template constructor.

# Process

1. Create a new block template constructor that does not depend on the mempool. Instead of querying the mempool for transactions, the block template constructor will expect to be fed transactions from some outside source(e.g. a test, or the mempool).  The new template constructor can simply add transactions to a list, while ensuring all the validity of the block is maintained.

2. The mempool will be changed to start adding transactions to this block template.  It will need to add transactions to it when `addUnchecked` is called, and carry out the logic in requirement 2, and requirement 3.

3. Add a new `getblocktemplate2` call which is able to fetch the current template from the mempool.  This should only return the header, unlike `getblocktemplate`

4. Add logic to request orphan parents from requirement 1.

4. Update `getblocktemplate` to use the new template generator, and deprecate the call.

5. Remove excess accounting code from the mempool.

In its entirety, the whole process will probably take multiple months.
