aes_encryption
==============

I was doing a partner integration with open ssl. We are encrypting using AES and they are decrypting in a different language.
Our encryptions with the same data differed, so I thought I'd take a look at some known test sets. The tests are from http://www.inconteam.com/software-development/41-encryption/55-aes-test-vectors.
With the code I have now all of the tests encrypt and decrypt back to the original value, but the expected encrypted data does not match the expected encrypted data.



To get up and running 
bundle install
bundle exec rspec 

Thanks for any help.