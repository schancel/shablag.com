---
title: "What is Reliability Engineering?"
date: 2019-06-21
draft: false
---

Site Reliability engineers engineer site reliability reliability -- obviously. In order to understand what it means to engineer reliability we should first understand what it means to be reliable. Google says that reliability is ”the quality of being trustworthy or of performing consistently well.” and also “the degree to which the result of a measurement, calculation, or specification can be depended on to be accurate.” 

To put another way, something that is reliable performs in a way that is unsurprising and meets expectations.  With regards to a particular computer service, when we think of reliability we think that it has these characteristics:

1. Does the same thing each time (consistent behavior)
2. Takes the same amount of time (low response variance, consistent latency)
3. Does it autonomously (does not require intervention, trustworthy to complete)

However, since site reliability engineers are not typically responsible for writing, or maintaining services, how do they engineer reliability into them? Conway’s observation tells us that:

the software interface structure of a system will reflect the social boundaries of the organization(s) that produced it, across which communication is more difficult

Now, the sources of unreliability typically manifest in the software interface structures.  As such, if we want to engineer reliability, we should actually start with teams of people, not software.  In order to ensure we’re producing reliable software we want to ensure each team is:

1. Able to respond consistently to outside demands
2. Have low variance in their response times.
3. Are autonomous and can stay focused on the mission.

Teams operate most efficiently and reliably when they are autonomous within their area of competency. Therefore, it is the job of SREs to ensure that teams are able to operate autonomously. This means an SRE ensures the team is:

1. Ensures their team knows what they are expected to be responsible for, and that other teams know what they are responsible for as well.
2. Ensure they are autonomous
3. Ensure their team has the ability to make decisions within the scope of their duties
4. That they are held accountable for the decisions they make which affect their services.
5. Create cross-cutting standards and tools for repeat problems so teams can keep a mission-focused mindset, rather than worrying about reinventing the wheel. (PFE vs NIH)
6. Holding your team accountable for having proper monitoring, alerting, and incident response procedures
7. Ensure that individuals who are on call understand the need for: 
    1. Integrity
    2. Formality
    3. Procedural Compliance
    4. Level of Knowledge
    5. Questioning Attitude
    6. Forceful Backup

By ensuring the above things for the team which they are embedded on, the team will produce more reliable services.  As such, you will find SREs doing a variety of tasks for the team they are embedded on in order to meet the above goals. While the specific tasks an SRE will be doing will depend on what they see as the most urgent area, you can find them:

1. Demonstrating best practices for logging, monitoring, and alerting.
2. Teaching best practices for deploying and managing software services
3. Ensuring that data about services is being surfaced to the correct people. (e.g. downstream consumers)
4. That the whole company is able to tell who is responsible for what services.
5. Teaching appropriate formality when dealing with incident response.
6. Be a resource for advice on best practices, architecture decisions, and code reviews
7. Holding your team accountable for proper monitoring and alerting.
8. Create cross-cutting standards and tools for repeat problems to enable individual teams can keep a mission-focused mindset, rather than worrying about reinventing the wheel. (PFE vs NIH)

# Things SRE is NOT responsible for:

1. Instrumenting services with logging, monitoring, and alerting -- although they can help where necessary.
2. Being on call for services they did not write -- unless they are helping train with the process.
3. Telling people what to do -- software engineers own their code, and the responsibility for their bugs.
