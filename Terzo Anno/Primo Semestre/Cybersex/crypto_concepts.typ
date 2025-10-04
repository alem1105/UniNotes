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

#align(center,image("image.png", width: 80%))

The public-key approach advantages:
- It provides a digital signature as well as message authentication 
- It does not require the distribution of keys to communicating parties.