---
title: "Money, Economies, States, Taxation and Bitcoin for Dummies"
date: 2019-05-02
draft: true
---

# Computational Irreducibility

The concept of [computational irreducibility](https://en.wikipedia.org/wiki/Computational_irreducibility) is probably one of the most modern under appreciated concepts in mathematics.  It has wide impact both on math, philosophy, and even physics.

The idea is simple: there are some [recursively defined sequences](https://en.wikipedia.org/wiki/Recursively_enumerable_set) such that you cannot know the Nth item in a sequence unless you also know (N-1)th, (N-2)th, … and 1st items in the sequence.  A hypothetical oracle machine could tell you, but even it would need to have done the computation -- otherwise it’s knowledge is as best a lucky guess and that guess would not be verifiable even to the oracle.

## Another Phrasing

The set of computable numbers is greater than the set of sequences that can be written as a [closed-form[^1] function](https://en.wikipedia.org/wiki/Closed-form_expression).  This is an unintuitive result given that the domain of closed-form functions has a higher cardinality, but it’s range is of lower cardinality.  A reader 

## P != NP

Another possible application of arguments invoking computational irreducibility is to prove P != NP.  If these exists a sequence whose elements are defined recursively, computationally irreducible, and takes non-polynomial time to compute, then that problem cannot be reduced to a polynomial-time problem per the definition of computational irreducibility.

## Discreteness of Time

If computational irreducible algorithms exist in reality, it also means that time is discrete.  Take the example above of the oracle machine.  It must undergo some process by which it is able to ascertain the sequence defined by the algorithm.  However, since the items are defined[^2] recursively, it cannot know all the elements simultaneously.  In order to know a particular elements it must process the sequence in order.

However, since the elements must be processed in order, you cannot use a real-number indexed sequence (e.g. a standard closed-form real-valued function). This is because real numbers do not admit a [“least element”](https://en.wikipedia.org/wiki/Greatest_and_least_elements) for sets -- or to put it another way, real numbers do not have a “next number operator,” they are uncountable.

How does this relate to the discreteness of time? Basic premise is this:
1. Computationally irreducible problems cannot be represented by functions of continuous variables (or their would be a shortcut)
2. Physics is assumed to be described by functions of continuous variables.
3. The existence of a computationally irreducible process embedded in spacetime would imply that you have a computationally irreducible function described by a subset of a function of continuous variables.
4. There exists such processes (e.g. solving a sudoku puzzle, the game of life, etc).  
5. Therefore, spacetime cannot be described completely by functions of continuous variables.

## Open-theism

Another consequence of the idea of computational irreducibility, much to the chagrin of Calvinist philosophers, is that their conception of God cannot be omniscient. First, it is important to make note of [actual vs potentially infinite sets](https://en.wikipedia.org/wiki/Actual_infinity). The key point here being that some sets have the potential to be infinite (you can compute any arbitrary element) vs actually infinite sets (this is a giant bag, and there are an infinite set of independent elements).  If computationally irreducible sets exist, then the [axiom of infinity](https://en.wikipedia.org/wiki/Axiom_of_infinity) must be soundly rejected, at least for irreducible sets.

Without an actual infinity for God to know (and our Oracle) cannot know, without simulating, what the future will be.

## Free will

Since not even God can know irreducible sequences without computing them, then it stands to reason that there is real value in going through the process of doing so.  If there is value in doing so, and if our lives are properly understood as irreducible sequences of actions, then we have value.

While it may or may not be true that there is free will, the determiner of your actions (you) is autonomous. And although many people get hung up on the question of determinism when discussing free will, the actual definition of free will is “the ability to act at one's own discretion.”  This is simply another way of saying autonomous.

Again, if our actions were not determined in such a way, they would have no meaning. Our actions, being undetermined, would have no meaning because they would carry no information.  The presence of information is another way to say that there exists is a homomorphism between two sets given the data provided.  Without determinism, there is only data, and no meaning thereof.

Said again, data having meaning (information) is explicitly due to that data being the result of a process.

[^1]:  A reader may take issue with restricting the solutions here to closed-form functions.  However, open-form functions require computing an actual infinity of terms from a potential infinity of terms.  Such a feat is not possible.  Open-form functions do not exist in-reality, and only serve as a way to generate an approximation of arbitrary accuracy.

[^2]: Some philosophers like to disagree about the ability of the Oracle.  However, it is critical to understand that irreducible sequences are defined recursively.  This means that unless the oracle can find a homomorphic algorithm to compute the result, it cannot know all the elements simultaneously.  However, if it does have a homomorphism to a completed set, then the original sequence was not computationally irreducible in the first place. As such, you've arrived at a contradiction.  And the contradiction isn't based in a weak approximation of reality, it's based in how the problem has been defined. So unless the oracle can destroy our definitions, it cannot defeat the restriction.
