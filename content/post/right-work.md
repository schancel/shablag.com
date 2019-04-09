---
title: "Right Work"
date: 2019-04-09
draft: false
---

This post is for anyone who wishes they could contribute to Bitcoin-ABC but doesn't really know where to start.  If that's you, then you should start with what Andre Alexandrescu calls "[right work.](https://forum.dlang.org/post/q7u6g1$94p$1@digitalmars.com)" The linked post was recently [added to the Bitcion-ABC Contributing Guide](https://reviews.bitcoinabc.org/D2780).

The gist was that there are three important classifications of open source contributions:

1. Great work: It solves a problem eligantly and simply.  The solution does not add a disproportionate amount of complexity to the codebase.
2. Good work: Adds some useful feature, but is often complex and hard to review.  It also often introduces bugs, and increases the future maintenance burden of the codebase.
3. Right work: Here Dr. Alexandrescu uses a lot of examples specificly relating to the D programming language and its standard library and compiler frontend. The changes are easy and fast to review. Also, the more right work is done, the more likely Great Work can be done easily in the future.

There is a huge and undersupplied demand for Right Work in the world of software engineering, and especially open source.  The reason for this is that right work does not result in any directly visible impact to the user[^1] -- no bug is fixed, nor feature added.  The only discernible impact is that future work on the codebase is easier.  Unfortunately, other engineers are often the least likely to give praise, even for this type of work.  

But what _exactly_ is "right work"? Right work, simply put, is cleaning up small messes. Now, you may think that if every new patch that went into a project was perfect, that the project as a whole would never need any "right work".  However, `bitcoind` is a relatively old codebase that has had lots of contributors. Often with open source projects, authors come in and add some functionality and then leave.  They might have done a great job, but then later another person will come and remove or alter the functionality.  Possibly because it is no longer useful, or maybe they generalize it.  Unfortunately, it is easy to leave unnecessary code behind which needs encurs a maintenance cost -- although it may provide no function to the software.

Another common occurrence in open source is that someone, needing to add functionality, does so with the minimum amount of effort.  They add some global in one part of the code, an additional `if` statement somewhere else, and call it good.  Over time, this results in an explosion of complexity from too much "[action at a distance](https://en.wikipedia.org/wiki/Action_at_a_distance_(computer_programming))" in the code.  This makes it very hard to reason about the code, and to make sure that it is thread safe.

Often, code is moved or changed, but "comment blindness" causes [comments to not be updated](https://github.com/bitcoin/bitcoin/commit/eb837199a06293ea541171bdc4652591c6506921), resulting in confusion down the road.

There are many other phenomenon that happens from code churn in open source projects.  The disorder that slowly grows in a codebase makes it progressively more challenging to reason about, and difficult to reliably change.  Slowly, the code ossifies -- especially in the case of Bitcoin where bugs are catastrophic.  Most engineers contributing to open source do so only to fix a bug, or add a feature, that is directly impacting them.  Very few contributors want to take on the role of [Maxwell's Daemon](https://en.wikipedia.org/wiki/Maxwell%27s_demon) and start tidying up a code base[^2].

Rarely are examples of "right work" highlighted over "great work" or "good work".  This is unfortunate, because it sets the wrong precident for what work people should strive toward.  "Right work" is a great exercise for learning the codebase, and also provides a lot of value to software engineers who come after. The best thing about right work is that almost anyone can do it.

So, here's some major classes of types of "right work" I've seen in Bitcoin-ABC, and examples thereof:

### Maintaining build and test infrastructure

* [Switch to GCC 7 on Travis, disable currently non-functional ARM + Windows builds](https://reviews.bitcoinabc.org/D626)

### Fix major usability bugs

* [Support for encoding addresses using cashaddr](https://reviews.bitcoinabc.org/D623) - Dagur Valberg Johannsson

### Remove unnecessary dependencies

* [Replace boost::unordered_map and boost::unordered_set with std:: variant](https://reviews.bitcoinabc.org/D382) - Awemany
* [Removed all usages of boost::assign::list_of in favor of C++11 initializer lists](https://reviews.bitcoinabc.org/D465) - Calin Culianu

### Delete unused code

* [Get rid of SCRIPT_VERIFY_DISCOURAGE_UPGRADABLE_WITNESS_PROGRAM](https://reviews.bitcoinabc.org/D1446) -- Andrea Suisani
* [Fix undefined behaviour errors due to long int overflow in Amount](https://reviews.bitcoinabc.org/D2179) - Fabien
* [Delete block policy estimator](https://reviews.bitcoinabc.org/D2172)
* [Remove much of the remaining BIP9 code](https://reviews.bitcoinabc.org/D2783)
* [Removed unused parameter from validFeeEstimates](https://reviews.bitcoinabc.org/D2784)
* [Remove unused parameter from AcceptBlock](https://reviews.bitcoinabc.org/D2127)
* [Remove extraneous parameter from PrioritizeTransaction](https://reviews.bitcoinabc.org/D2853)
* [Remove unused fAllowFree variable from coincontrolwallet.cpp](https://reviews.bitcoinabc.org/D1387)
* [Remove IsPayToWitnessScriptHash](https://reviews.bitcoinabc.org/D1030) -- Andrea Suisani
* [Remove incremental relay fee](https://reviews.bitcoinabc.org/D1174)
* [Cleanup configure.ac to remove old boost versions workarounds](https://reviews.bitcoinabc.org/D2255) - Fabien
* [Remove unused seeder/compat.h](https://reviews.bitcoinabc.org/D2728) - Fabien

### Delete duplicate code

* [Remove duplicated code which can be obtained by linking crypto lib](https://reviews.bitcoinabc.org/D581)
* [Remove a ton of code from seeder's util](https://reviews.bitcoinabc.org/D733) - Amaury Séchet

### Fix warnings

* [Fix a bunch of clang warnings](https://reviews.bitcoinabc.org/D1427)
* [Fix a Clang -Wshadow warning in rcu.h](https://reviews.bitcoinabc.org/D2491) - Fabien
* [Fix clang warnings](https://reviews.bitcoinabc.org/D2220) - Fabien
* [Fix some compiler warnings regarding override](https://reviews.bitcoinabc.org/D729)

### Update code to latest standards

* [Use static_cast instead of C-style casts for non-fundamental types](https://reviews.bitcoinabc.org/D2765) - Nico Guiton

## Fix flaky tests

* [Fix sporadic policyestimator_tests failure due to unspecified operand evaluation order](https://reviews.bitcoinabc.org/D621) -- Freetrader
* [Remove redundant connect_nodes call in abc-parkedchain.py](https://reviews.bitcoinabc.org/D2189) -- Jason Cox

### Remove deprecated functionality

* [Remove deprecated estimateSmartPriority function](https://reviews.bitcoinabc.org/D1355)

### Refactor for dependency injection

* [Make Config more available in Qt](https://reviews.bitcoinabc.org/D708) - Dagur Johannsson 
* [Accept Mempool as a parameter to CBlockAssembler](https://reviews.bitcoinabc.org/D2048)

### Remove global variables

* [Remove minTxFee from wallet](https://reviews.bitcoinabc.org/D1800)
* [De-globalize blocksize related parameters](https://reviews.bitcoinabc.org/D2018)
* [De-globalize rpc configuration variables](https://reviews.bitcoinabc.org/D2017)
* [Move minimum relay fee](https://reviews.bitcoinabc.org/D1361)
* [Move handling for `-maxtxfee` to the config object](https://reviews.bitcoinabc.org/D1936)

### Make code more legible

* [Removed using namespace std and replaced with std:: throughout file](https://reviews.bitcoinabc.org/D381) - gbrown
* [Use std for make_pair in walletdb.cpp](https://reviews.bitcoinabc.org/D391) -- Freetrader
* [Remove blockFinished from BlockAssembler](https://reviews.bitcoinabc.org/D1591)
* [Clean up addPriorityTxns](https://reviews.bitcoinabc.org/D1590)
* [Typedef for TXmodifiers](https://reviews.bitcoinabc.org/D1383)

### Make the code type safe

* [Add Amount class and use it for CENT and COIN](https://reviews.bitcoinabc.org/D529)

### Read and fix/add comments

* [Comment, cast and assert cleanup in pow.cpp](https://reviews.bitcoinabc.org/D635) - Freetrader
* [Fix comment in CheckInputs to match changed code](https://reviews.bitcoinabc.org/D2785)
* [Make comments in abandonconflict legible](https://reviews.bitcoinabc.org/D1532)

### Add tests/Fix Tests

* [Add ATMP test for undersize transaction](https://reviews.bitcoinabc.org/D1925) - Dagur Johannsson
* [Fix tx padding](https://reviews.bitcoinabc.org/D2374) -- Dagur Johannsson
* [Fix p2p-fullblocktest to pad transactions properly](https://reviews.bitcoinabc.org/D1907) - Jason Cox 
* [Add a test case to ensure mempool accounting is correct](https://reviews.bitcoinabc.org/D1892)
* [Check that key length is correct when deserializing CExtKey](https://reviews.bitcoinabc.org/D2552) - Amaury Séchet -- Add test for extPuBkey
* [Add test cases to test new bitcoin-tx functionality](https://github.com/bitcoin/bitcoin/commit/b7e144bb731857106cae7c7d2d49d2ccc03b7ef1) - John Newberry
* [add testcases for getrawtransaction](https://github.com/bitcoin/bitcoin/commit/240189b2c14244c3058e80b40bd4dacbd200c4c7) - John Newberry
* Lots of other great work from John Newberry

### Organize source files

* [Move block undo out of core](https://github.com/bitcoin/bitcoin/commit/999a2ab41ec96311c145d74822c246a3b92a9b33) -- Jorge Timón
* [Move network processing code out of main.cpp](https://github.com/bitcoin/bitcoin/commit/e736772c56a883e2649cc8534dd7857a0718ec56) -- Matt Corallo 
* [Move CFeeRate into its own source files](https://reviews.bitcoinabc.org/D1673)
* [Removed CBlockStatus class from chain.h and placed into its own .h file](https://reviews.bitcoinabc.org/D1719) - Nico Guitan

### Update packaging

* [Ubuntu PPA Maintenance](https://launchpad.net/~bitcoin-abc/+archive/ubuntu/ppa) by Andrea Suisani
* [Dockerfiles](https://github.com/zquestz/docker-bitcoin) by Josh Ellithorpe
* [Update various debian packaging files](https://reviews.bitcoinabc.org/D347) -- Freetrader
* [OSX: Change app bundle name and executable name to BitcoinABC-Qt.app and change related OSX-specific handlers and Info.plist stuff to match.](https://reviews.bitcoinabc.org/D510) -- Calin Culianu

[^1]: Who might be a software engineer being inconvenienced enough to contribute.

[^2]: Especially when their livelyhoods do not depend on the codebase being tidy; or worse their livelihoods depends on the codebase NOT being tidy...