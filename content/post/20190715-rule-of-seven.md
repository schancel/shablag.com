---
title: "Software and the Magic Number Seven"
date: 2019-07-14 01:00:00
draft: false
---

# The Magic Number Seven, Give or Take Two

If you want to be part of a high efficiency software engineering team then you should pay attention to the number seven. If you learn the secrets of the number seven, your team will produce more valuable code, produce it more quickly, produce it with less bugs, and ultimately make more profit.

Now, the number seven comes up constantly in the mystical traditions of every culture. Software Engineering should not concern itself with mysticism, and modern rationalism rejects the concepts associated with numerology. However, I believe that the mysticism surrounding seven is actually reflection of human limitation. A quick perusal of psychology, management, and marketing literature, will reveal that the number seven is indeed "set apart" from other numbers.

[Miller's law](https://en.wikipedia.org/wiki/The_Magical_Number_Seven,_Plus_or_Minus_Two) tells us that human working memory on average can old seven chunks of information (plus or minus 2 depending on the person). This is incredibly important, and under-appreciated, within the discipline of software engineering. It has huge ramifications, and so it bears stating explicitly!

## Impact On Software Structure

The impact of this fact means that a software engineer, or any creative worker, can only hold 7 interacting chucks at any given time. This means that software code, user interfaces, and other functionality, should be structured around that limitation. This is not to say that people can't work with more than seven things at a time, but they must be able to be nicely grouped into 7 "chunks" that can be thought about independently.

Functions should take a *most* seven parameters. This should preferrably fewer since there are likely local variables to deal with as well. 
If you see a function like this:
```C++
static bool AcceptToMemoryPoolWorker(
    const Config &config, CTxMemPool &pool, CValidationState &state,
    const CTransactionRef &ptx, bool fLimitFree, bool *pfMissingInputs,
    int64_t nAcceptTime, bool fOverrideMempoolLimit, const Amount nAbsurdFee,
    std::vector<COutPoint> &coins_to_uncache, bool test_accept)
```
you should think: "what the expletive?" and then fix it.  Clearly from looking at this, there are number of configuration parameters to change behavior, and one excess return value.  A fixed version of this function, while very verbose, looks like this:

```C++
class ValidationState {
    private:
    enum AcceptanceStatus : uint8_t {
        Accepted = 0,
        MissingInputs = 1,
    } state;
    ValidationState(AcceptanceStatus _state) : state(_state) {}
    public:
    ValidationState() : state(AcceptanceStatus::Accepted) {}
    // ...
    bool IsAccepted() {
        return state == AcceptanceStatus::Accepted;
    }
    bool IsMissingInputs() {
        return (state & MissingInputs) != 0;
    }
    ValidationState Merge(const ValidationState a) const {
        return AcceptanceStatus(a.state & state);
    }
};

class AcceptanceOptions {
private:
    enum AcceptanceFlags : uint8_t {
        None = 0,
        LimitFree = 1,
        OverrideMempoolLimit = 2,
        TestAcceptance = 4,
    } flags;
    Amount nAbsurdFee;
    int64_t AcceptTime;
    std::vector<COutPoint> &coins_to_uncache;
public:
    AcceptanceOptions(
        /// ...
        std::vector<COutPoint> &uncache) 
        : coins_to_uncache(uncache), flags(AcceptanceFlags::None) { 
        AcceptTime = GetTime();
        //...
    }
    // ... 
};

// Use return value optimization instead of passing return values in!
// https://en.wikipedia.org/wiki/Copy_elision#Return_value_optimization
ValidationState AcceptToMemoryPoolWorker(
        const Config &config,
        const CTransactionRef &ptx, 
        const AcceptanceOptions& options,
        CTxMemPool &pool
) {
        ValidationState state;
        // ...
        return state;
}
```
Yes the above is *significantly* more typing and code. However, it really isn't that much time and will be well worth the effort in the future. This sample is a real piece of code in a safety-critical piece of code: Bitcoind. The function body itself is 300 lines of code. The extra 40 is well worth the cognitive load it will ease when working with this function.

Second, as much as possible, functions should be limited to seven clearly demarcated stanzas (although every rule has expcetions)! If there is more than this, you should start considering how you could break the function up into clearly independent parts. Each part should take input and return input linearly. Each step should take something the output from the previous step, do something to it, and return a new output. Good ways to identify chunks to factor out are:

  1. Code that has [multiple levels of indentation](https://www.kernel.org/doc/html/v4.10/process/coding-style.html#indentation)
  1. Chunks that have multiple preceeding operations required to produce their input:
```
func main() {
    thingOne := ProcessA()
    thingTwo := ProcessB()
    thingThree := ProcessC()
    err := MakeWidget(thingOne, thingTwo, thingThree)
}
```
  1. Any other chunks which have local variables that are clearly scoped to one area.

If the two rules above are followed, then every level of abstraction will have less than 7 chunks to it, and programmers can "bulk load" the entire mental context as they move up and down the hierarchy of the stack.  Your code will look like a tree that mirrors directly the call stack:

```
1. main()
  1. do something
    1. do something else
    ...
    7. ...
  2. call independent library function
  3. call another library function
  ...
  7. return
```
Each bullet point should be able to be "collapsed" in your mind when working with it. It does "one thing" from the perspective of the a higher level of abstraction.

Global variables should be avoided as these represent potential sites for [action at a distance](https://en.wikipedia.org/wiki/Action_at_a_distance). Action at a distance prevents code from being truly modular. This is a cause of leaky abstractions and prevents the individual pieces from being thought about as independent chunks. When both pieces read and update the same globals, their code ends up with a synergy that prevents them from being worked on independently.

#s## Wait... if you're right, how do we get such unwieldy code in the first place!?

You might ask, if the above limitation were true, how does software become so unweildy in the first place? Did some super-intelligent God write the overly complicated pieces of software? No! Well, in some cases maybe someone with an exceptional working memory generates things with 9 chunks, but in general no.

Instead, what happens is progressive addition. A piece of code requires some added functionality, and an engineer (without fully understanding the existing code) adds something to what was already there. Several iterations of this, and you end up with functions that take too many parameters, that do too many things, and with broken abstractions. Why wants to be the poor sob who has to write the "extra 40 lines of code" in the above example!?

If already complex code is being added to, it should be first refactored to "chunk" it up. This should be enforced in [code reviews](https://shablag.com/article/code-reviews-an-incomplete-guide/)

# The Magic Number Seven and Corporations

Finally, seven has a big impact on how teams should be structured. While [Dunbar's Number](https://en.wikipedia.org/wiki/Dunbar%27s_number) is 150, the actual value for social groups doing collaborative work is much smaller. It is [around seven people](http://www.lifewithalacrity.com/2004/03/the_dunbar_numb.html). In the Navy, there's a "rule of seven" that states that any officer should have at most seven subordinates. This means you need `log_7(N)` levels of management for a company of `N` people. Too few, and managers are inefficiently loaded, and too many means they are not able to properly oversee the needs of their reports.

This is also important from a software reliability and engineering perspective. [Conway's law](https://en.wikipedia.org/wiki/Conway%27s_law) tells us that:

> organizations which design systems ... are constrained to produce designs which are copies of the communication structures of these organizations.

This means that our organizations and communication structures should mirror the above rules for designing systems:

1. Organizations producing software should be organized into a hierarchy
1. Each team should have no more than 7 people. Each manager should have no more than 7 reports.
1. Each team should be given an area of responsibility, and be autonomous in making decisions over their processes
    1. Meaning they can make decisions independently
    1. They are responsible for the outcome of their decisions
1. Meetings should follow the [two-pizza rule](https://www.inc.com/business-insider/jeff-bezos-productivity-tip-two-pizza-rule.html)
1. Communication across teams, while it can happen, should be bubbled up and down the "[organizational hierarchy](https://en.wikipedia.org/wiki/Hierarchical_organization)"
1. If there is a need for a repeated type of cross-team communication, there should be a team that handles that process. (Somewhat like a software library)

If an organization follows the above maxims, then it will be structured as hierarchy of independent pieces. This will result in the software being structured as a hierarchy of independent pieces. The end result will be software which engineers can easily and efficiently work on -- and that means higher velocity, less bugs, and more revenue.

Indeed, the US Nuclear Navy does follow the above maxims. They are arguably the largest, most efficient, and safest, organization in existence.
