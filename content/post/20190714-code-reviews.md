---
title: "Code Reviews: An incomplete guide"
date: 2019-07-14
draft: false
---

# Why?

For years, many software projects could be easily completed by a single programmer working alone. However, most of the valuable single-man projects are long conquered. Sure, there are many places for small tools that do specific jobs, but most easy projects are finished. Complex projects dominate, and complex projects require armies of coders.

Participating with an army of other programmers requires special discipline.  Now, if a programmer wants to have a real impact they must become a "Software Engineer." The primary divergence between engineering and programming is the scale of teamwork. Team-oriented programming is no longer just a project of writing instructions for computers, but also a interpersonal communications problem.  Unfortunately, most of us by our nature are not social animals -- preferring instead to interact with computers more than humans.

If we want to become a software engineers, we must understand, and practice, working with other software engineers. Since software engineering uses code reviews as the fundamental unit of work, it makes sense to start with, and focus, there.

# Goals of a Code Review

Code reviews exist in order to provide an opportunity for engineers to collaborate in order to produce the highest quality, bug free code. Code reviews should be seen as an opportunity to learn -- both for the reviewer and the reviewee -- and as an opportunity to put the "finishing touches" on a piece of code. It is similar to the process of an editor helping a writer ready their book, or essay, for publishing.

This process of collaborating and editing is in contrast to acting as an adversary who is trying to prevent "bad code" from making into the master branch. However, this does not mean "rubber-stamping" pull requests should be done as a way to avoid conflict or collaboration. Additionally, reviews do not depend on the experience level of the person reviewing, if you don't understand what is being done in a pull request, probably other people won't either: ask questions!

Reviews should be taken seriously regardless of the relative experience of the engineers involved. Every person has unique life experiences and perspectives, and this overflows into the way they see engineering problems. That is to say, each member of a team can provide valuable insights that can make our software better -- even the most junior of team members. Everyone has something to learn, and to teach. 

# How To Begin a Pull Request

Prior to writing any code, you should discuss the feature, or change, with another engineer and come up with a plan for how the code will change -- pull requests should not be a surprise to the repository owner. As you work through the process of changing the code in the agreed upon way, you may run into roadblocks. It is sometimes beneficial to put up a "Work In Progress" (WIP) pull requests, and discuss where you're having difficulties. Some struggling is good for learning, but software engineering is a team effort and getting help is preferable to struggling in silence. There is no shame in asking for help.

Once your code is in good working order, and tests pass, put the code up for final review. Squash your personal work using `git fetch && git rebase -i origin/master` and write a compelling commit message by rewording and "fixing up" your commits. There is no good reason to have 15 "fixup" commits in a pull request, nor is it useful to have them as automated bullet points in an automatic squash commit message generated by Github.  It is *definitely* not useful to have these commits showing up in the merge tree for the master branch. Yet, all rules are meant to be broken, sometimes it can be useful to have multiple commits on a branch that is merged (rather than squashed) in to master depending on the complexity of the feature.  Those commits should still be atomic units of working code.

# [Break up your work](https://medium.com/@kurtisnusbaum/large-diffs-are-hurting-your-ability-to-ship-e0b2b41e8acf)

Often when working on a feature, some amount of refactoring is required. In order to make sure that code is reviewed properly, it needs to have as few changes as possible. This is important because:

* Large change sets won't get reviewed properly. Reviewers typically find the same number of bugs regardless of size!
* Reverting large diffs is hard
* Rebasing and merging large diffs is hard
* In the future, if an engineer has a question about a line of code, they will use `git blame` to find the commit, and commit message for that change.
  * All the code changed in the commit should be closely related to help give an understanding of what was being changed and why
  * The commit message should be informative to why the change was made in the code.
  * These points are especially important when responding to critical incidents involving behavioral changes in the software.

# [Commit Message (Not Pull Request Message!)](https://chris.beams.io/posts/git-commit/)

The goal of a commit message is to inform the reader about why the code is being changed in the way you are doing. Telling the reader what and how the code is changing is not helpful, as you are merely restating what the code itself tells the reviewer, or auditor. A basic commit message should tell you:

* What was the code doing before
* Why the code is being changed
* What the new behavior is
* Any tickets/issues associated with the change.

Commit message should be formatted to be easily legible. The commit summary (first line) should be less than 80 characters, and it should have a `Summary` and `Test Plan` section. The summary should be one or more paragraphs that clearly state the above three points. You should assume any  engineer, with limited context, is reading your commit message. The test plan may simply be a command that would need to be ran to verify the commit does what is intended. Assume a robot with no context is going to test your commit without your help.

Please note, it is easy to conflate the pull request message with a commit message. These are not the same thing -- although they should be. If you fill out your commit messages, and squash as recommended above, Github will propagate your message through into the pull request body, and the commit message when merged. If you do not include these contents when writing your commit message, and instead only include them when generating a pull-request, these contents will likely get lost when merging. It is important that the above information makes it into the commit message in the git repository!

## Commit Message Example

```
Add the ability to send money to the wallet screen
 
Summary:
This commit adds the ability to send money to the GUI wallet screen. We found through user studies that they would like to be able to send money directly from the GUI, rather than have to go to a CLI tool. This commit enables that functionality by adding a send money button and dialog.

Closes #1023

Test Plan:
1. Open the software to the send money screen
2. Enter a Bitcoin Address you contorl
3. Click "send money" 
4. Fill out the required information
5. Verify in a block explorer that the test coins were sent where you intended.
```

# Reviewing Code

As stated in the section on goals, reviewing a pull request should be an exercise in editing a teammates work to make sure it is as good as it can be. If you see things you think are wrong, or can be improved, you should suggest alternatives with sample code and within the pull request. Multiple review cycles due to unclear instructions is undesirable -- both the reviewer and reviewee should be seeking to minimize this.

Reviewers should keep in mind that submitting code to be reviewed by another person is a very vulnerable act. The person submitting the code is, in many ways, revealing their imperfect ability to write software. However, there is no perfect software engineer. We all submit code with mistakes in it; but this does not change how negative and non-constructive feedback can be perceived when coming from a place of vulnerability.

Reviewers should do their best to communicate clearly, and constructively, when reviewing pull requests. Attached are two very good references on dos, and do-nots, of reviewing code. Additionally, reviewees should do their best to understand that their personal identity, and their competency, is not wrapped up in the code they submit.

1. [How to review code like a human Part 1](https://mtlynch.io/human-code-reviews-1/)
2. [How to review code like a human Part 2](https://mtlynch.io/human-code-reviews-2/)

# Merging a Pull Request

In some code review processes, after a commit is approved, the code reviewee merges the code. However, the name "pull request" implies the owner of the repository is being requested to "pull" the code. The primary reason for this in open source software is one of permissions. However, it is also an act of acknowledgement that the code is finalized, and shared responsibility for the outcome (pull request reviewer and owner) of adding this source code to the master branch.
