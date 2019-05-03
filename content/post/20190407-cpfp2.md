---
title: "Child Pays for Parent: Part 2"
date: 2019-04-07
draft: false
---

After working for awhile toward the goals outlined in [Child Pays For Parent](/article/child-pays-for-parent) it has become apparent there was some problems with my initial design. Originally, I was hoping to make a simple copy of the `BlockAssembler` code.  Then remove from it all the complexity surrounding mempool packages, and convert it to a long-lived object which can have transactions added and removed from it.

However, the `BlockAssembler` needs to have a couple things happend:
1. It needs to know which block it's building on top of for providing hashPrevBlock, and ensuring that only valid transactions are being mined.
2. It needs to be able to be disposed of, or cleared, when a new chainTip is found.

Unfortunately, the `mempool` is currently a global object.  Meaning it's initialization order is indeterminate with other global objects.  Therefor it cannot create a `BlockAssembler` on startup given the dependency on a chainTip.  Additionally, the mempool is not currently notified when a the chainTip is updated.  Instead, it has calls such as `removeForBlock` which reconcile the mempool to the chainstate. but do not provide block information.  Additionally, these calls occur multiple times during `ActivateBestChain` rather than only upon completion.

While we could add new notifications to the mempool to handle this, it is not desirable.  The reason being, is that when a new block arrives, we should immediately dispose of the current `BlockAssembler` and create a new blank one.  If there are any transactions remaining in the mempool, these need to be added to the new `BlockAssembler.` Now, there normally should not be any, but in the case where there is a large mempool due to a spam attack, we want to be able to do this reprocessing out-of-line with block processing for `ActivateBestChain`.

As such, it seems to be a better idea to:

1. Introduce a `BlockCandidate`, which is responsible for maintaining a CBlockHeader (minus the nonce), the coinbase, and a list of transactions.  It will ensure that only transactions which would not render the block invalid may be added or removed.  This take many of the responsibilities of `BlockAssembler`.
2. Introduce a `Blockworks` which manages the lifetime of all `BlockCandidate`, shovelling transations from the mempool into the active BlockCandidate, and handling `getblocktemplate` RPC requests.

This gives us the benefit that all our quality-of-service priotiziation code can be in one place, handled outside of the critical path.  Additionally, all the validity checks for the block candidate will be self-contained.  The ultimate result will be separation of concerns:

1. BlockCandiate will be limited to ensuring its own consistency.
2. Blockworks will handle all transaciton prioritization code, and BlockCandidate lifecycles.
3. Mempool will be limited to ensuring its own consistency.

Onward...