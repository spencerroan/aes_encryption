require 'openssl'
require 'base64'

#Based on an example from http://www.brentsowers.com/2007/12/aes-encryption-and-decryption-in-ruby.html

module AESCrypt

  def AESCrypt.encrypt(data, key, iv, cipher_type)
    aes = OpenSSL::Cipher::Cipher.new(cipher_type)
    aes.encrypt
    aes.key = key
    aes.iv = iv 
    aes.update(data) + aes.final      
  end

  def AESCrypt.decrypt(encrypted_data, key, iv, cipher_type)
    aes = OpenSSL::Cipher::Cipher.new(cipher_type)
    aes.decrypt
    aes.key = (key)
    aes.iv = (iv) 
    aes.update(encrypted_data) + aes.final  
  end

  def AESCrypt.encrypt64(data, encoded_key, encoded_iv, cipher_type)
    decoded_key = Base64.strict_decode64(encoded_key)
    decoded_iv = Base64.strict_decode64(encoded_iv) 
    Base64.strict_encode64(encrypt(data, decoded_key, decoded_iv, cipher_type))
  end

  def AESCrypt.decrypt64(encoded_encrypted_data, encoded_key, encoded_iv, cipher_type)
    decoded_encrypted_data = Base64.strict_decode64(encoded_encrypted_data)
    decoded_key            = Base64.strict_decode64(encoded_key)
    decoded_iv             = Base64.strict_decode64(encoded_iv) 
    decrypt(decoded_encrypted_data, decoded_key, decoded_iv, cipher_type)
  end
  
end
 

