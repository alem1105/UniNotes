#import "@preview/showybox:2.0.4": showybox

= Crypto Concepts

== Symmetric encryption
The universal technique for providing confidentiality for transmitted or stored data, it uses a single-key encryption.

Two requirements for secure use:
- Need a strong encryption algorithm
- Sender and receiver must have obtained copies of the secret key in a secure way and must keep the key secure.

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
  title: [*Simplified model of symmetric encryption*],
  [#align(center,image("img/symmetric_encryption.png", width: 80%))]
)

=== Attacking Symmetric Encryption 
There two main type of attacks:
- *Cryptanalytic Attack*: They rely on the *nature of the algorithm*, some knowledge of the general characteristics of the plaintext, some sample plaintext-ciphertext pairs. Ususally the exploits the characteristics of the algorithm to attempt to deduce a specific plaintext or the key being used.
- *Brute-Force Attacks*: Try all possible keys on some ciphertext until an intelligible translation into plaintext is obtained.

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
  title: [*Bruteforcing Modern Block Ciphers*],
  [#align(center,image("img/bruteforce.png", width: 80%))]
)

=== Symmetric Encryption Algorithms
- *AES*: Advanced Encryption Standard (Rijndael)
  - 128 bit lock cipher 
  - 128, 192 or 256 bit secret keys
- *DES*: Data Encryption Standard (now insecure)
  - 64 bit locker cipher 
  - 56 bit secret key 
  - 3DES (Triple-DES), variant with secret of 112 or 168 bits. (It repeat the basic DES three times)

  It was the most studied encryption algorithm in existence but the speed of commercial processors makes the 56bit key woefully inadequate
- *RC4* (now insecure, also known as ARC4 or ARCFOUR)
  - Stream cipher 
  - 40-2048 bits secret keys

== Practical Security Issues
Typically symmetric encryption is applied to a unit of data larger than a single 64-bit or 128-bit block. *ECB (Electronic codebook)* is the simplest approach to multiple-block encryption:
- Each block of plaintext is encrypted using the same key 
- Cryptanalysts may be able to exploit regularities in the plaintext 

Alternatives techniques developed to increse the security of symmetric block encryption for large sequences.

=== Block vs Stream Ciphers 
- *Block Cipher*: Processes the input one block of elements at a time and produces an output block for each input block.

- *Stream Cipher*: Processes the input continuously and produces output one element at a time. They are almost always faster and use far less code. Pseudorandom stream is one that is unpredictable without knowledge of the input key.

== Message Authentication
Protects against active attacks by verifing that received messages are authentic:
- Contents have not been altered
- From authentic source
- Timely and in correct sequence 

It can use concentional encryption where only sender and receiver share a key.

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
  title: [*Message Authentication Without Confidentiality*],
  [Message encryption by itself does not provide a secure form of authentication but we can combine authentication and confidentiality in a single algorithm:
  - Encryption + Authentication Tag]
)

=== Message Authentication Code (MAC)
A number of algorithms could be used to generate the code, however, authentication algorithm need not be reversible.

When we send a message we generate and send a MAC tag, the receiver need to calculate the MAC tag from the message and if the two tags are the same means that the message is arrived with integrity.

The MAC function takes in input a shared secret key within the message.

=== Cryptographic hash function
The purpose of a hash function is to produce a "fingerprint" of a file, message or other block of data. It generates a set of $k$ bits from a set of $L(>=k)$ bits.

The result of applying a hash function is called *hash value*, or message digest, or checksum.

=== MAC with one-way hash functions
As we said, unline the MAC an hash function does not take a secret key as input but just the plain text (or file). However it is possibile to get MACs using hash functions.

Some methods:

#align(center,image("img/image5.png", width: 80%))

The public-key approach advantages:
- It provides a digital signature as well as message authentication 
- It does not require the distribution of keys to communicating parties.ù

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
  title: [*Properties for a good hash function*],
  [
    - Can be applied to a block of data of any size
    - Produces a fixed-length output
    - H(x) is relatively easy to compute for any given x
    - One-way or pre-image resistant, computationally infeasible to find x such that H(x)=h
    - Computationally infeasible to find $y eq.not x$ such that $H(y)=H(x)$
    - Collision resistant or strong collision resistance, computationally infeasible to find any pair $(x,y)$ such that $H(X)=H(y)$
  ]
)

There are two approaches to attacking a secure hash function:
- Exploit logical weaknesses in the algorithm 
- Strength of hash function depends solely on the length of the hash code produced by the algorithm

The SHA is the most widely used hash algorithm.

= Public-Key Encryption Structure
This is based on mathematical functions, it's asymmetric so it uses two separate keys, the public keys and the private keys.

#align(center, image("img/image6.png", width: 80%))

It works with pair of public and private key, you need to encrypt a message with a public key and only the people with the matching private key can decrypt the message. Everyone can see us encrypting a message with a public key but the important thing is that the private key remains secret.

We can classify the use of public-key cryptosystems into three categories:
- Digital signature
- Symmetric key distribution
- Encryption of secret keys 

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
  title: [*Requirements for Public-Key Cryptosystems*],
  [
    - Computationally easy to create key pairs 
    - Computationally easy for sender knonwing public key to encrypt messages
    - Computationally easy for receiver knowing private key to decrypt ciphertext
    - Computationally infeasible for opponent to determine private key from public key
    - Computationally infeasible for opponent to otherwise recover original message
    - Useful if either key can be used for each role
  ]
)

There different asymmetric encryption algorithms:
- *RSA (Rivest, Shamir, Adleman):* Most widely accepted and implemented approach to public-key encryption. Block cipher in which the plaintext and ciphertext are integers between 0 and n-1 for some n.
- *Diffie-Hellman key exchange algorithm*: Enables two parties to securely reach agreement about a shared secret for subsequent symmetric encryption of messages. Limited to exchange of the keys.
- *Digital Signature Standard (DSS)*: Provides only a digital signature function with SHA-1, cannot be used for encryption or key exchange.
- *Elliptic curve cryptography (ECC)*: Security like RSA, but with much smaller keys.

The NIST FIPS PUB 186-4 defines a digital signature as: 

_”The result of a cryptographic transformation of data that, when properly
implemented, provides a mechanism for verifying origin authentication, data
integrity and signatory non-repudiation.”_

A digital signature is a data-dependent bit pattern, generated by an agent as a function of a file, messagem or other form of data block. It specifies the use of one of three digital signature algorithms:
- DSA, Digital Signature Algorithm
- RSA Digital Signature Algorithm 
- Elliptic Curve Digital Signature Algorithm (ECDSA)

Digital signature process: 

#align(center,image("img/image7.png", width: 80%))

How the public key certificate works:

#align(center,image("img/image8.png", width: 80%))

*CA* is the Certificate Authority.

Digital Envelope:

#align(center,image("img/image9.png", width: 80%))

To generate those keys or for other algorithms, usually we need *random numbers*, but in a computer we can't have a 100% randomness so we need to match some properties:
- Uniform distribution: Frequency of occurrence of each number should be approximately the same
- Independence: No one value in the sequence can be inferred from the others
- Unpredictability, opponent should not be able to predict future elements of the sequence on the basis of earlier elements

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
  title: [*Random vs Pseudorandom*],
  [
    Cryptography applications typically make use of algorithmic techniques for random number generation, those algorithms are deterministic and therefore produce sequences of numbers that are not statistically random.

    Pseudorandom number are sequences that satisfy statistical randomness tests but they are predictable.

    True random number generator uses a nondeterministic source to produce randomness, most of them operate by measuring unpredictable natural processes like radiation, gas discharge, leaky capacitors.
  ]
)