---
title: "Bitcoin Cash Development Funding"
date: 2020-02-09
draft: false
---

There have been many different conversations about how Bitcoin Cash *node* development should be funded. Some of these have been:

1. That developers could sell some service
2. That developers could sell a product
3. That some percentage of the block reward could go to developers.

The first two of these ideas amount to saying that developers should work on the node software in addition to doing some other work. This doesn't really solve the key issue at hand, and it misaligns the incentives of developers. They end up forming companies to build things like the Liquid network which have harmed Bitcoin in a not insignificant way.

The third option is to explicitly charge a mining fee to produce blocks for the Bitcoin Cash network. There is a lot of contention that this is a bad idea for a variety of reasons. The two main reasons are the argument that it is (1) coercive, and (2) produces a centralized organization controlling BCH.

Setting aside the point of coercion briefly, it is economically sound in that it aligns the incentives of developers with that of the network. However, this does not mean that it is a good idea. The point of centralization still stands. Whichever centralized authority controls these funds would have a significant amount of power over the Bitcoin Cash network and its future. This problem can be addressed by invoking a distributed consensus mechanism to decide who gets funds.  Nakamoto consensus can work very well for this purpose.

Now, the original proposal, which was a soft fork, had a large cartel of mining pools refuse blocks which did not include payment to a development fund. However, this created a situation where these miners risk ending up in a minority fork and unable to sell their block rewards. This risk has caused the proposal to be amended to be a hardfork, with all nodes validating that the mining fee exists.

In the proposal becoming a hardfork, distributed consensus was removed, and developer consensus was emplaced. This is not a good idea where it can be avoided. This alone would make the proposal a bad idea that should not be implemented. With the issue of this proposal being a bad idea now settled, the question as to if the proposal is coercive remains.

Currently, the software pays only miners to run it. However, individual miners and pools are economically disincentivized to fund developers. Any additional overhead takes away from their ability to re-invest in their own mining farms and continue to compete with other miners on level footing. As such, miners have not been funding development at a level required to maintain software as complex as Bitcoind.  The only way in which funding development makes economic sense for miners would be if they all had to fund it together. This situation is equivalent to the [public good game](https://en.wikipedia.org/wiki/Public_goods_game).

Yet, by making developers also profit, from the node software, their incentives become aligned with miners. An explicit incentive is created for developers to build what businesses need and what will bring value into the Bitcoin Cash network. No such incentive exists, except for the price increase in whatever coins they may have purchased themselves.

Yes, sending some of the block reward back to developers comes at the expense of some security. It will lower the total security that is being demanded of the entire SHA256 pool. As such, it comes at the expense of every SHA256 mining group. It makes sense for most miners to oppose such a change as it cuts into their profit margins. Most miners have no inherent loyalty to Bitcoin Cash -- they mine what is profitable.

However, labeling this proposal as "coercive", or a "tax", is far from true. Miners are entitled to run whatever software they want, but they do so knowing what that software does -- and that may be a different reward structure than they would like.  The fact that the node software will no longer demand as much SHA256 hashing is far from coercive. Actually, the opposite is true -- demanding that the developers of Bitcoin Cash write software that continues to buy, the same amount of SHA256 security, is coercive.

This is visible when considering what is actually required of each ideological party in this disagreement. Opposing the mining fee involves demanding that developers NOT do something. Whereas, if developers new version of the software that refuses to validate blocks that don't pay them it is completely up to miners to choose to run that new software or not. There is only a demand being made of one group of people: developers.

In fact, this proposal was originally discussed in Hong Kong in June of 2018. A meeting was held with some of the largest miners that were participating in the development of Bitcoin Cash. At that meeting, the only miner which in opposition was nChain/Coingeek -- a company which was concurrently trying to deprive ABC of funding, and become the sole source of funding, so that it could control the future direction of Bitcoin Cash.

Now, the voluntary nature of the mining fee does not return this proposal to good standing. In creating centralized governance, it would create a single point of failure for the Bitcoin Cash network. No one development group should be making decisions about what is funded. It is incredibly important that choosing where funds are allocated does not require centralized coordination.

Therefore, I am proposing the following change to the proposal to add a development fee as such:

1. Initially, the node software will be seeded with a whitelist of acceptable donation addresses for Bitcoin Cash node implementations.
2. The software will then validate that the coinbase includes UTXOs that pay a total of 12.5% to a combination of this whitelist.
3. If any additional address appears within some threshold of recent blocks (e.g. 90% of the last 2016 blocks) that address will be added to the whitelist by the node software.

In this way, miners who want to redirect funds to a different development group can do so by donating a small amount -- above and beyond the 12.5% -- to a new organization over the course of two weeks. After that time, the address would be counted within the total 12.5% and the miners who wish to donate to that address could return to their normal profitability.

Additionally, this provides a mechanism whereby a supermajority of miners can turn these consensus rules off by adding their own addresses to the whitelist. As such, these consensus rule changes do not need to be temporary for the purpose of trying them out.  Miners can, if they so agree with each other, turn them off at any point. 

If the proposal is amended in this way, I would be very happy to see it implemented and give Bitcoin Cash a fighting chance with continued development and improvement. Bitcoin Cash is the most important project, for human freedom, in the world. Supplying proper funding for maintenance, and improvements, are of critical importance. Establishing funding, in this way, is aligned with the belief that increasing human freedom increases human prosperity.


