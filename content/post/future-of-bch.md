---
title: "The Future of Bitcoin Cash"
date: 2019-04-08
draft: false
---

The following is a letter which was sent to the developers of Bitcoin ABC, Bitcoin Unlimited, Bitcoin XT, Bitprim on March 15th of 2018. At the time, I was handling official releases for Bitcoin ABC; although I am no longer a maintainer.  This letter is being published for the edification of people outside the Bitcoin Cash development community.  It was written in response to what I perceived as a general disagreement about *how* we were trying to work together, what we were trying to accomplish, and specifically over the May 15th protocol upgrade.  It is worth noting that it was an ongoing challenge to facilitate cohesion between developer groups. There were many uncooperative factions and individuals at every Bitcoin Cash protocol upgrade –- August 2017, November 2017, May 2018, and November 2018[^1].  Even the addition of CashAddr to Bitcoin-ABC, which was a non-consensus change, has faced a significant backlash.  Had Bitcoin Cash developers stopped working every time someone decided to dispute changes, for ideological reasons[^2], none of the of the many things which have been accomplished over the last year and a half would have happened -- including the birth of Bitcoin Cash.

The letter is as follows:

# The Future of Bitcoin Cash

Bitcoin Cash exists due to a faulty development process existing for Bitcoin Core. We are currently a minority fork due to the way in which the development process was converted into a design committee and co-opted by individuals who were demonstrably not interested in ensuring the success of Bitcoin.

The expense of generating the Bitcoin Cash fork to the ecosystem has not been insignificant; and Bitcoin Cash remains a minority fork to this date. However, I believe that if we continue to do our job, BTC will eventually fail completely, and ​we will be ready​. This will lead to BCH becoming the majority fork and currency.

However, any open source project potentially has the same social vulnerabilities as Bitcoin Core. With the amount of money involved in this space, there are strong incentives to control the future of Bitcoin Cash. As such, it was my understanding that there was generally understood principles that were shared by the Bitcoin Cash developers at the time of launch. These ideals were shared to prevent a repeat of the events leading up to the Bitcoin Cash fork.

However, no document has clearly articulated what these were. Therefore, I am attempting to articulate those ideals insomuch as I understand them. It is my agenda within the Bitcoin Cash community to ensure that these ideals are realized.

It is my understanding that there were two shared ideals, both of which are necessary to support the other. These two ideals each have two critical ramifications.

### [Multiple implementations are necessary](https://www.youtube.com/watch?v=64hqihJyP9U)

The first ramification of having multiple implementations is that exchanges and miners will be able to have modular redundancy. As the value of the Bitcoin Cash ecosystem grows, exchanges will ultimately need [​triple modular redundancy​](https://en.wikipedia.org/wiki/Triple_modular_redundancy) via running three implementations at the same time. Double modular redundancy is already in place at some large exchanges. However, as the saying goes: ”Never go to sea with two chronometers; take one or three." The second ramification is that no single team will have control over the specification of the Bitcoin Cash protocol; a majority of implementations must agree on the details of the protocol at all times.

### Forced Routine Protocol Upgrades

Forced routine upgrades are also critically important to Bitcoin Cash. The first ramification of this is that that protocol upgrades can be done on routine intervals and that no team can stymie the further development of the protocol. This principle is a necessary protection to prevent a repeat of what happened with the 1MB block size limit. The second ramification is that exchanges will be aware well in advance when they need to prepare for software upgrades, and can make educated decisions about which software they will choose to run leading into each protocol upgrade along with which of their own patches they wish to apply.

### How do we meet these ideals

In order to meet this ideals as a group we are ​forced​ to work together collaboratively rather than combatively. We must have clients released well in advance of protocol upgrade dates so that exchanges may install multiple node implementations, and test them well in advance.

This also means we ​must ​agree to collaborate and get review from our peers in a timely manner, and must work together to provide a specification for what we will be doing in the next upgrade ​well in advance. ​ Implementations which fail to do this will ultimately be left behind by the teams who do work together.

This ensures that there are other lead implementation engineers who ​can​ veto protocol decisions when they are poor. However, these leads must also work together to ensure that the above ideals are realized. Once they are truly established, they will be become entrenched and serve to protect the development process for the world currency. 

Any team which wishes to build this future with me must commit to a reasonable release schedule, providing binaries to exchanges in a timely manner, and a QA process that is suitable for a currency. Our benchmark for this degree of rigour should exceed what is required of banks and security organizations. Together we must define what this process is and how they will be continuously improved over time (static analysis, fuzzing, and other QA processes we do not currently have).

I know many of the developers currently working on Bitcoin Cash wish to realize this goal with me; as I have spoken with you one on one. It has become clear that not everyone shares my vision for Bitcoin Cash, and attempting to work together without shared values is ultimately fruitless. Going forward, I will only be working with teams who want to realize this goal with me.

I hope that we can work together to agree on a schedule that we can stick to, and which meets the requirements of our customers. As such, I have proposed a workflow, and the timeline was established in London[^3] to be 6 months; with feature freezes 3 months in advance. Please propose adjustments to ​agenda for the first QA meeting.

Respectfully,


Shammah Chancellor<br />
Release Manager, Bitcoin ABC

[^1]: The original birthing fork was contentious due to the block size. November 2017 was contentious due to changing the difficulty adjustment algorithm. Some wanted it to go back to the original, others didn't want to change away from the EDA, and a few others claimed the newly written DAA would be catastrophic. Jan 2018, the non-consensus addition of CashAddr, had a astroturf campaign against it. May 2018 was highly contentious because there was "community support" for OP_GROUP and because some developers simply wouldn't agree to any specification without BIP135. November 2018 was contentious for an unintelligible slew of reasons, which are still being debated on the Bitco.in forum, and also because one lead developer still wanted BIP135. Ultimately, Bitcoin Cash protocol development is *NOT* a political game.  Changes to the underlying protocol must be made using sound technical judgement, and for the explicit purpose of enabling global p2p cash.

[^2]: The vast majority of contention has always been around deviating somehow from the "original vision" of what makes something Bitcoin.  Starting with the 1MB block size cap, miner voting, address formats, and the like.  No disagreements over technicals were ever swept aside without consideration. Ultimately, changes require broad support from developers, users, and miners to activate -- Bitcoin ABC can not dictate that people run their software.  We saw with Nov 2018, when a minority of users who do not agree with changes did fork away.  While this fork was unfortunate, it was also inevitable.  The propaganda being distributed against CTOR and CHECKDATASIG to try to prevent the fork has now been shown to be false.  This propaganda was shown to be false by the simple fact that CTOR and CHECKDATASIG are now ACTIVE ON THE NETWORK.  The fact that so many different lies were spread should be indicative that CTOR and CHECKDATASIG were *not* the real reason that BSV was forked.  Developers are incentivized to do the most desirable thing if they want people to continue to use their software. There are too many other cryptocurrency options to do otherwise.

[^3]: The first meeting of the Bitcoin Cash developers was held in London in late 2017.  The purpose was to establish a shared roadmap and goals.
