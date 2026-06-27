# Notation and Abbreviations

Reference list of acronyms and terms used throughout the paper and
repository documentation.

| Term | Expansion |
|---|---|
| API | Application Programming Interface |
| CRQC | Cryptographically Relevant Quantum Computer |
| ECDH / ECDHE | Elliptic-Curve Diffie-Hellman / Ephemeral |
| ECDSA | Elliptic Curve Digital Signature Algorithm |
| FIPS | Federal Information Processing Standard |
| HNDL | Harvest-Now, Decrypt-Later |
| IETF | Internet Engineering Task Force |
| JWT | JSON Web Token |
| KDF | Key Derivation Function |
| KEM | Key Encapsulation Mechanism |
| ML-DSA | Module-Lattice-Based Digital Signature Algorithm (FIPS 204) |
| ML-KEM | Module-Lattice-Based Key Encapsulation Mechanism (FIPS 203) |
| MLWE | Module Learning With Errors |
| MSIS | Module Short Integer Solution |
| NIST | National Institute of Standards and Technology |
| NSA | National Security Agency |
| OAuth 2.0 | Open Authorization 2.0 framework |
| PQC | Post-Quantum Cryptography |
| RSA | Rivest-Shamir-Adleman (public-key cryptosystem) |
| SLH-DSA | Stateless Hash-Based Digital Signature Algorithm (FIPS 205) |
| TLS | Transport Layer Security |
| X.509 | ITU-T standard defining the format of public-key certificates |

## Symbol Conventions

- Key and signature sizes are reported in bytes (B) unless otherwise noted.
- NIST PQC "Security Category 1" corresponds to a brute-force search
  cost comparable to a 128-bit symmetric key (AES-128).
- Algorithm names follow final NIST FIPS naming (ML-KEM, ML-DSA,
  SLH-DSA) rather than the original competition names (Kyber,
  Dilithium, SPHINCS+), except when referring to the original
  research literature describing those constructions.
