#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *

= Definition of Cybersecurity

#showybox(
  frame: (
    border-color: green.lighten(60%),
    title-color: green.lighten(60%),
    body-color: green.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Definition by NIST (National Institute of Standards and Technology)*],
  [Prevention of damage to, protection of, and restoration of computers,
  electronic communications systems, electronic communications
  services, wire communication, and electronic communication, including
  information contained therein, to ensure its availability, integrity,
  authentication, confidentiality, and nonrepudiation.]
)

== A definition of Computer Security

Computer Security: Measures and controls that ensure *confidentiality*,
*integrity*, and *availability* of information system *assets* including
hardware, software, firm-ware, and information being processed, stored,
and communicated.

An asset is something important for the system.

== Assets 

The asset is a key concept, the assets are important for a person or a company and need to be protected. 

Some examples:
- Patient records
- Equipment
- Keys for net-banking

#showybox(
frame: (
  border-color: blue.lighten(60%),
  title-color: blue.lighten(60%),
  body-color: blue.lighten(95%)
),
title-style: (
  color: black,
  weight: "regular",
  align: center,
  boxed-style: (anchor: (y: horizon, x: left))
),
title: [*What should be protected?*],
[- *Personal Data* of users like name, surname, email ecc...
- *Company Data* like financial data, internal information about products or personal data of the customers, partners ecc...]
)

== Security Concepts and Relationships

#image("img/image.png")

== Threat Agent (Adversary)
Who conducts or has the intent ro conduct detrimental activities.

== Countermeasure
A device or technique that ha as its objective the impairment adversarial activity.

== Risk
A measure of the extent to which an entity is threatened by a potential circumstance or event.

== Threat
Any circumstance or event with the potential to adversely impact organizational operations.

== Vulnerability
Weakness in an information system, system security procedures, internal controls, or
implementation that could be exploited or triggered by a threat source.


#showybox(
  frame: (
    border-color: green.lighten(60%),
    title-color: green.lighten(60%),
    body-color: green.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Observation about Security*],
  [The security of a system, application or protocol is relative to:
  - A set of desidere properties
  - An adversary with specific capabilities

  For example the file access permissions in Linux or Windows are not effective against someone who can boot from a CD or USB drive.
  ]
)

== Threats
There are different type of threats.

- *Active Attack*: An attempt to alter system resources or affect their operation. Some example:
  - Replay
  - Masquerade
  - Modification on Messages
  - Denial of Service
- *Passive Attack*: An attempt to learn or make use of information from the system that does not affect
system resources. For example an adversary could steal some information for use them in the future in a new attack.
- *Inside Attack*: Initiated by an entity inside the security perimeter (an “insider”). The insider is
authorized to access system resources but uses them in a way not approved by those
who granted the authorization.
- *Outside Attack*: Initiated from outside the perimeter, by an unauthorized or ille-gitimate user of the
system (an “outsider”). On the Internet, potential outside attackers range from
amateur pranksters to organized criminals, international terrorists, and hostile
governments.

= Security Goals

There are 3 foundamental concepts in security, *C.I.A.*:
- *Confidentiality*
- *Integrity*
- *Availability*

== Confidentiality

The avoidance of the unauthorized disclosure of information. It involves the protection of data, providing access for those who are allowed to see it while disallowing others.

Let's look some *tools for confidentiality*


=== Encryption

The transformation of information using a secret, called an
*encryption key*, so that the transformed information can only be read
using another secret, called the *decryption key* (which may, in some cases,
be the same as the encryption key).

#image("img/image-1.png")

=== Access Control 

Rules and policies that limit access to confidential information to those people and/or systems with a “need to know.”

For example we can grant this "need to know" with a device, a password, a role ecc...

=== Authentication

The determination of the identity or role that someone has.
This determination can be done in a number of different ways:
- An object
- A password
- Fingerprint

=== Authorization

The determination if a person or system is allowed access to resources, based on an *access control policy*.

=== Physical Security

The establishment of physical barriers to limit access to protected computational resources.

== Integrity

The property that something has not be altered in an unauthorized way. Some tools for integrity:

- *Backups*: Periodic archiving of data.
- *Checksums*: The computation of a function that maps the contents of a file to a numerical value. A checksum function depends on the entire contents of a file and is designed in a way that even a small change to the input file (such as flipping a single bit) is highly likely to result in a different output value.
- *Data correcting codes*: Methods for storing data in such a way that small changes can be easily detected and automatically corrected.

== Availability

The property that something is accessible and modifiable in a timely fashion by those authorized to do so.

Some tools for the availability:
- *Physical Protections*: Infrastructure meant to keep information available
even in the event of physical challenges.
- *Computational redundancies*: Computers and storage devices that serve as
fallbacks in the case of failures.

== Other Security Concepts

Some other important concepts are *Authenticity, Accountability e Anonymity*.

=== Authenticity
Is the ability to determine that statements, policies, and permissions issued by persons or systems are genuine.

An example of tool for authenticity could be *digital signature*

=== Accountability

Is the security goal that generates the requirement for actions of an entity to be traced uniquely to that entity.

The system must keep records of their activities to permit later forensic analysis to trace security breaches or to aid in transaction disputes.

This goal supports non-repudiation, intrusion detection, recovery, legal action and other security concepts.

=== Anonymity

The property that certain records or transactions not to be attributable to any individual. Some useful tools:
- Aggregation: The combining of data from many individuals.
- Mixing: The interwining of transactions, information or communications in a way that cannot be traced to any individual.
- Proxies: Trusted agents that are willing to engage in actions for an individual in a way that cannot be traced back to that person.
- Pseudonyms: Fictional identities that can fill in for real identities in communications and transactions but are known only by trusted identity.

== Threat Consequences

=== Unauthorized Disclosure

This is a threat to confidentialy. Is a circumstance or event where an entity gains access to data for which the entity is not authorized.

In this event can occurs:
- Exposure: Sensitive data are directly released to an unauthorized entity.
- Interception: An unauthorized entity directly accesses sensitive data traveling between authorized sources and destinations.

#align(center,
  image("img/image1.png", width: 60%)
)

- Inference: A threat action where an unauthorized entity indirectly accesses sensitive data by reasoning from characteristics or by-products of communications.

Inference is also called *correlation or traceback*, is the integration of multiple data sources and information flows to determine the source of a particular data stream or piece of information.

#align(center,
  image("img/image2.png", width: 60%)
)

- Intrusion: An unauthorized entity gains access to sensitive data by circumventing a system's security protection.

=== Deception

Is a threat to system integrity and data integrity. An authorized entity receive false data and believe it to be true.

Some type of attack:
- Masquerade: An unauthorized entity gains access to a system or performs a malicious act by posing as an authorized entity.
- Falsification: False data deceive an authorized entity. For example the *man-in-the-middle attack* where a network stream is intercepted, modified and retransmitted.

#align(center,
  image("img/image3.png")
)

- Repudiation: An entity deceives another by falsely denying responsability for an act.

=== Disruption

Is a threat to availability or system integrity. An event that interrupts or prevents the correct operation of system services.

Some example:
- Incapacitation: Prevents or interrupts system operation by disabling a system component.
- Corruption: Undesirably alters system operation by adversely modifying system functions or data.
- Obstruction: A threat action that interrupts delivery of system services by hindering system operation.

- *Denial-of-service*: The obstruction or degradation of a data service or information access. For example email spam.

=== Usurpation

Is a threat to system integrity. An event that results in control of system services by an uauthorized entity.

- Misappropriation: An entity assumes unauthorized logical or physical control of a system resource.

- Misuse: Causes a system component to perform a function or service that is detrimental to system security.

#showybox(
  frame: (
    border-color: blue.lighten(60%),
    title-color: blue.lighten(60%),
    body-color: white
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Example*],
  [
    #image("img/image4.png")
  ]
)

= Attack Surfaces

Consist of the reachable and exploitable vulnerabilities in a system.

Examples:
- Open ports on outward facing Web and others servers, nad code listening on those ports
- Services available on the inside of a firewall.
- Code that processes incoming data, email, XML, office documents, and industry-specific custom data exchange formats.
- Interfaces, SQL, Web Forms.
- An employee with access to sensitive information vulnerable to a social engineering attack.

== Attack Surface Categories

*Network Attack Surface*

Vulnerabilities over an enterprise network, wide-area network or the Internet. This also include network protocol vulnerabilities.

*Software Attack Surface*

Vulnerabilities in application, utility, or operating system code, with particular focus on Web Server Software.

*Human Attack Surface*

Vulnerabilities created by personnel or outsiders with social engineering, human error or trusted insiders.

= Computer Security Strategy

- *Security Policy*: Formal statement of rules and practices that specify or regulate how a system or organization provides security services to protect sensitive and critical system resources.

- *Security Implementation*: Involves four complementary courses of action:
  - Prevention
  - Detection 
  - Response 
  - Recovery 

- *Assurance*: Encompassing both system design and system implementation, assurance is an attribute of an information system that provides grounds for having confidence that the system operates such taht the system's security policy is enforced.

- *Evaluation*: Process of examining a computer product or system with respect to certain criteria. It also involves testing and may also involve formal analytic  or mathematical techniques.

= Standards
Standards have been developed to cover management practices and the overall architecture of security mechanisms and services. The most important are:
- *National Institute of Standards and Technology (NIST)*: A U.S. Federal Agency that deals with measurement science, standards, and technology.
- *Internet Society (ISOC)*: A professional membership society that provides leadership in addressing issues that confront the future of the internet.
- *International Telecommunication Union (ITU-T)*: ITU is a United Nations agency in which governments and the private sector coordinate global telecom networkds and services.
- *Internetional Organization for Standardization (ISO)*: ISO is a nongovernmental organizaton whose work results in international agreements that are published as International Standards.

= Economy of Mechanism
This principle stresses simplicity in the design and implementation of security measures.

The notion of simplicity is especially important in the security domain, since a simple security framework facilitates its understanding by developers and users and enables the efficient development and verification of enforcement methods for it.

== Fail-Safe defaults
This principle states that the defualt configuratoin of a system should have a *conservative protection scheme*. For example when adding a new user to an operating system the default group of the user should have minimal access rights. Unfortunately, operating systems and applications often have default options that favor usability over security.

== Complete Mediation
The idea behind this principle is that every access to a resource must be checked for compliance with a protection scheme.

== Open Design 
The security architecture and design of a system should be made publicly available.
- Keeping cryptographic keys secret
- Open design allows for a system to be scrutinized by multiple parties.
- The open design principle is the opposite of the approach knows as security by obscurity, which tries to achieve security by keeping cryptographic algorithms secret and which has been historically used without success by several organizations.

== Separation of Privilige
This principle dictates that multiple conditions should be required to achieve access to restricted resources or have a program perfrom some action.

== Least Privilege
Each program and user of a computer system should operate with the bare minimum privileges necessary to function properly.

== Least common mechanism
In systems with multiple users, mechanism allowing resources to be shared by more than one user should be minimized.

== Psychological Acceptability
This principle states that user interfaces should be well designed and intuitive, and all security-related settings should adhere to what an ordinary user might expect.

== Work Factor
According to this principle, the cost of circumventing a security mechanism should be compared with the resources of an attacker when designing a security scheme. For example a system developed to protect student grades which may be attacked by snoopers or students trying to change theri grades, probably needs less sophisticated security measures than a system built to protect military secrets.

== Compromise Recording
This principle states that sometimes it is more desirable to record the details of an intrusion than to adopt more sophisticated measures to prevent it.