require 'openssl'
require 'base64'

#Based on an example from http://www.brentsowers.com/2007/12/aes-encryption-and-decryption-in-ruby.html

module AESCrypt
  # Decrypts a block of data (encrypted_data) given an encryption key
  # and an initialization vector (iv).  Keys, iv's, and encoded_data
  # are base64 encoded, and the data returned is a text string.  Cipher_type should be
  # "AES-256-CBC", "AES-256-ECB", or any of the cipher types
  # supported by OpenSSL.  Pass nil for the iv if the encryption type
  # doesn't use iv's (like ECB).
  #:return: => String
  #:arg: encrypted_data => String 
  #:arg: key => String
  #:arg: iv => String
  #:arg: cipher_type => String
  def AESCrypt.decrypt(encrypted_data, key, iv, cipher_type)
    aes = OpenSSL::Cipher::Cipher.new(cipher_type)
    aes.decrypt
    aes.key = Base64.strict_decode64(key)
    aes.iv = Base64.strict_decode64(iv) if iv != nil
    aes.update(Base64.strict_decode64(encrypted_data)) + aes.final  
  end
  
  # Encrypts a block of data given an encryption key and an 
  # initialization vector (iv).  Keys, iv's are base64 encoded,
  # and the data returned also base64.  Cipher_type should be
  # "AES-256-CBC", "AES-256-ECB", or any of the cipher types supported by OpenSSL.  
  # Pass nil for the iv if the encryption type doesn't use iv's (like
  # ECB).
  #:return: => String
  #:arg: data => String 
  #:arg: key => String
  #:arg: iv => String
  #:arg: cipher_type => String  
  def AESCrypt.encrypt(data, key, iv, cipher_type, expected = nil)
    aes = OpenSSL::Cipher::Cipher.new(cipher_type)
    aes.encrypt
    aes.key = Base64.strict_decode64(key)
    aes.iv = Base64.strict_decode64(iv) if iv != nil 
    Base64.strict_encode64(aes.update(data) + aes.final)
  end

  def AESCrypt.encrypt2(data, key, iv, cipher_type)
    aes = OpenSSL::Cipher::Cipher.new(cipher_type)
    aes.encrypt
    aes.key = key
    aes.iv = iv if iv != nil
    aes.update(data) + aes.final      
  end

end
 

