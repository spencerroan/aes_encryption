require 'pry'
require 'aes_crypt'
require 'crypt_helper'

describe AESCrypt do

  shared_examples 'crypt' do |cipher_type, _key, _initialization_vector, _test_vector, _cipher_text|
    let(:key)                   {CryptHelper.hexdigest_to_hexstr(_key)}
    let(:initialization_vector) {CryptHelper.hexdigest_to_hexstr(_initialization_vector)}
    let(:test_vector)           {CryptHelper.hexdigest_to_hexstr(_test_vector)}
    let(:cipher_text)           {CryptHelper.hexdigest_to_hexstr(_cipher_text)}

    let(:encrypted) {AESCrypt.encrypt(test_vector, key, initialization_vector, cipher_type)}
    let(:decrypted) {AESCrypt.decrypt(encrypted,   key, initialization_vector, cipher_type)}

    it 'sub_match' do
      encrypted.should include(cipher_text)
    end

    it 'correct size' do
      encrypted.size.should eq cipher_text.size
    end

    it 'encrypts' do 
      encrypted.should eq cipher_text
    end

    it 'decrypts' do 
      decrypted.should eq test_vector
    end

  end

  key_128='2b7e151628aed2a6abf7158809cf4f3c'
  key_192='8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b'
  key_256='603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4'

  context 'cbc' do
    describe '128' do 
      cipher_type = 'aes-128-cbc'
      it_behaves_like 'crypt', cipher_type, key_128, '000102030405060708090A0B0C0D0E0F', '6bc1bee22e409f96e93d7e117393172a', '7649abac8119b246cee98e9b12e9197d'
      it_behaves_like 'crypt', cipher_type, key_128, '7649ABAC8119B246CEE98E9B12E9197D', 'ae2d8a571e03ac9c9eb76fac45af8e51', '5086cb9b507219ee95db113a917678b2'
      it_behaves_like 'crypt', cipher_type, key_128, '5086CB9B507219EE95DB113A917678B2', '30c81c46a35ce411e5fbc1191a0a52ef', '73bed6b8e3c1743b7116e69e22229516'
      it_behaves_like 'crypt', cipher_type, key_128, '73BED6B8E3C1743B7116E69E22229516', 'f69f2445df4f9b17ad2b417be66c3710', '3ff1caa1681fac09120eca307586e1a7'
    end

    describe '192' do
      cipher_type = 'aes-192-cbc'
      it_behaves_like 'crypt', cipher_type, key_192, '000102030405060708090A0B0C0D0E0F', '6bc1bee22e409f96e93d7e117393172a', '4f021db243bc633d7178183a9fa071e8'
      it_behaves_like 'crypt', cipher_type, key_192, '4F021DB243BC633D7178183A9FA071E8', 'ae2d8a571e03ac9c9eb76fac45af8e51', 'b4d9ada9ad7dedf4e5e738763f69145a'
      it_behaves_like 'crypt', cipher_type, key_192, 'B4D9ADA9AD7DEDF4E5E738763F69145A', '30c81c46a35ce411e5fbc1191a0a52ef', '571b242012fb7ae07fa9baac3df102e0'
      it_behaves_like 'crypt', cipher_type, key_192, '571B242012FB7AE07FA9BAAC3DF102E0', 'f69f2445df4f9b17ad2b417be66c3710', '08b0e27988598881d920a9e64f5615cd'
    end

    describe '256' do
      cipher_type = 'aes-256-cbc'
      it_behaves_like 'crypt', cipher_type, key_256, '000102030405060708090A0B0C0D0E0F', '6bc1bee22e409f96e93d7e117393172a', 'f58c4c04d6e5f1ba779eabfb5f7bfbd6'
      it_behaves_like 'crypt', cipher_type, key_256, 'F58C4C04D6E5F1BA779EABFB5F7BFBD6', 'ae2d8a571e03ac9c9eb76fac45af8e51', '9cfc4e967edb808d679f777bc6702c7d'
      it_behaves_like 'crypt', cipher_type, key_256, '9CFC4E967EDB808D679F777BC6702C7D', '30c81c46a35ce411e5fbc1191a0a52ef', '39f23369a9d9bacfa530e26304231461'
      it_behaves_like 'crypt', cipher_type, key_256, '39F23369A9D9BACFA530E26304231461', 'f69f2445df4f9b17ad2b417be66c3710', 'b2eb05e2c39be9fcda6c19078c6a9d1b'
    end
  end

  context 'cfb' do 
    describe '128' do 
      cipher_type = 'aes-128-cfb'
      it_behaves_like 'crypt', cipher_type, key_128, '000102030405060708090A0B0C0D0E0F', '6bc1bee22e409f96e93d7e117393172a', '3b3fd92eb72dad20333449f8e83cfb4a'
      it_behaves_like 'crypt', cipher_type, key_128, '3B3FD92EB72DAD20333449F8E83CFB4A', 'ae2d8a571e03ac9c9eb76fac45af8e51', 'c8a64537a0b3a93fcde3cdad9f1ce58b'
      it_behaves_like 'crypt', cipher_type, key_128, 'C8A64537A0B3A93FCDE3CDAD9F1CE58B', '30c81c46a35ce411e5fbc1191a0a52ef', '26751f67a3cbb140b1808cf187a4f4df'
      it_behaves_like 'crypt', cipher_type, key_128, '26751F67A3CBB140B1808CF187A4F4DF', 'f69f2445df4f9b17ad2b417be66c3710', 'c04b05357c5d1c0eeac4c66f9ff7f2e6'
    end
 
    describe '192' do
      cipher_type = 'aes-192-cfb'
      it_behaves_like 'crypt', cipher_type, key_192, '000102030405060708090A0B0C0D0E0F', '6bc1bee22e409f96e93d7e117393172a', 'cdc80d6fddf18cab34c25909c99a4174'
      it_behaves_like 'crypt', cipher_type, key_192, 'CDC80D6FDDF18CAB34C25909C99A4174', 'ae2d8a571e03ac9c9eb76fac45af8e51', '67ce7f7f81173621961a2b70171d3d7a'
      it_behaves_like 'crypt', cipher_type, key_192, '67CE7F7F81173621961A2B70171D3D7A', '30c81c46a35ce411e5fbc1191a0a52ef', '2e1e8a1dd59b88b1c8e60fed1efac4c9'
      it_behaves_like 'crypt', cipher_type, key_192, '2E1E8A1DD59B88B1C8E60FED1EFAC4C9', 'f69f2445df4f9b17ad2b417be66c3710', 'c05f9f9ca9834fa042ae8fba584b09ff'
    end

    describe '256' do
      cipher_type = 'aes-256-cfb'
      it_behaves_like 'crypt', cipher_type, key_256, '000102030405060708090A0B0C0D0E0F', '6bc1bee22e409f96e93d7e117393172a', 'DC7E84BFDA79164B7ECD8486985D3860'
      it_behaves_like 'crypt', cipher_type, key_256, 'DC7E84BFDA79164B7ECD8486985D3860', 'ae2d8a571e03ac9c9eb76fac45af8e51', '39ffed143b28b1c832113c6331e5407b'
      it_behaves_like 'crypt', cipher_type, key_256, '39FFED143B28B1C832113C6331E5407B', '30c81c46a35ce411e5fbc1191a0a52ef', 'df10132415e54b92a13ed0a8267ae2f9'
      it_behaves_like 'crypt', cipher_type, key_256, 'DF10132415E54B92A13ED0A8267AE2F9', 'f69f2445df4f9b17ad2b417be66c3710', '75a385741ab9cef82031623d55b1e471'
    end
  end

  context 'ofb' do
    describe '128' do 
      cipher_type = 'aes-128-ofb'
      it_behaves_like 'crypt', cipher_type, key_128, '000102030405060708090A0B0C0D0E0F', '6bc1bee22e409f96e93d7e117393172a', '3b3fd92eb72dad20333449f8e83cfb4a' # same as CFB?
      it_behaves_like 'crypt', cipher_type, key_128, '50FE67CC996D32B6DA0937E99BAFEC60', 'ae2d8a571e03ac9c9eb76fac45af8e51', '7789508d16918f03f53c52dac54ed825'
      it_behaves_like 'crypt', cipher_type, key_128, 'D9A4DADA0892239F6B8B3D7680E15674', '30c81c46a35ce411e5fbc1191a0a52ef', '9740051e9c5fecf64344f7a82260edcc'
      it_behaves_like 'crypt', cipher_type, key_128, 'A78819583F0308E7A6BF36B1386ABF23', 'f69f2445df4f9b17ad2b417be66c3710', '304c6528f659c77866a510d9c1d6ae5e'
    end

    describe '192' do
      cipher_type = 'aes-192-ofb'
      it_behaves_like 'crypt', cipher_type, key_192, '000102030405060708090A0B0C0D0E0F', '6bc1bee22e409f96e93d7e117393172a', 'cdc80d6fddf18cab34c25909c99a4174' # same as CFB?
      it_behaves_like 'crypt', cipher_type, key_192, 'A609B38DF3B1133DDDFF2718BA09565E', 'ae2d8a571e03ac9c9eb76fac45af8e51', 'fcc28b8d4c63837c09e81700c1100401'
      it_behaves_like 'crypt', cipher_type, key_192, '52EF01DA52602FE0975F78AC84BF8A50', '30c81c46a35ce411e5fbc1191a0a52ef', '8d9a9aeac0f6596f559c6d4daf59a5f2'
      it_behaves_like 'crypt', cipher_type, key_192, 'BD5286AC63AABD7EB067AC54B553F71D', 'f69f2445df4f9b17ad2b417be66c3710', '6d9f200857ca6c3e9cac524bd9acc92a'
    end

    describe '256' do
      cipher_type = 'aes-256-ofb'
      it_behaves_like 'crypt', cipher_type, key_256, '000102030405060708090A0B0C0D0E0F', '6bc1bee22e409f96e93d7e117393172a', 'DC7E84BFDA79164B7ECD8486985D3860' # same as CFB?
      it_behaves_like 'crypt', cipher_type, key_256, 'B7BF3A5DF43989DD97F0FA97EBCE2F4A', 'ae2d8a571e03ac9c9eb76fac45af8e51', '4febdc6740d20b3ac88f6ad82a4fb08d'
      it_behaves_like 'crypt', cipher_type, key_256, 'E1C656305ED1A7A6563805746FE03EDC', '30c81c46a35ce411e5fbc1191a0a52ef', '71ab47a086e86eedf39d1c5bba97c408'
      it_behaves_like 'crypt', cipher_type, key_256, '41635BE625B48AFC1666DD42A09D96E7', 'f69f2445df4f9b17ad2b417be66c3710', '0126141d67f37be8538f5a8be740e484'
    end
  end

  # CTR is not supported by openssl
  #context 'ctr' do
  #  ctr_initialization_vector = 'f0f1f2f3f4f5f6f7f8f9fafbfcfdfeff'
  #  describe '128 bit' do
  #    cipher_type = 'aes-128-ctr'
  #    it_behaves_like 'crypt', cipher_type, key_128, ctr_initialization_vector, '6bc1bee22e409f96e93d7e117393172a', '874d6191b620e3261bef6864990db6ce'
  #    it_behaves_like 'crypt', cipher_type, key_128, ctr_initialization_vector, 'ae2d8a571e03ac9c9eb76fac45af8e51', '9806f66b7970fdff8617187bb9fffdff'
  #    it_behaves_like 'crypt', cipher_type, key_128, ctr_initialization_vector, '30c81c46a35ce411e5fbc1191a0a52ef', '5ae4df3edbd5d35e5b4f09020db03eab'
  #    it_behaves_like 'crypt', cipher_type, key_128, ctr_initialization_vector, 'f69f2445df4f9b17ad2b417be66c3710', '1e031dda2fbe03d1792170a0f3009cee'
  #  end

  #  describe '192 bit' do
  #    cipher_type = 'aes-192-ctr'
  #    it_behaves_like 'crypt', cipher_type, key_192, ctr_initialization_vector, '6bc1bee22e409f96e93d7e117393172a', '1abc932417521ca24f2b0459fe7e6e0b'
  #    it_behaves_like 'crypt', cipher_type, key_192, ctr_initialization_vector, 'ae2d8a571e03ac9c9eb76fac45af8e51', '090339ec0aa6faefd5ccc2c6f4ce8e94'
  #    it_behaves_like 'crypt', cipher_type, key_192, ctr_initialization_vector, '30c81c46a35ce411e5fbc1191a0a52ef', '1e36b26bd1ebc670d1bd1d665620abf7'
  #    it_behaves_like 'crypt', cipher_type, key_192, ctr_initialization_vector, 'f69f2445df4f9b17ad2b417be66c3710', '4f78a7f6d29809585a97daec58c6b050'
  #  end

  #  describe '256 bit' do
  #    cipher_type = 'aes-256-ctr'
  #    it_behaves_like 'crypt', cipher_type, key_256, ctr_initialization_vector, '6bc1bee22e409f96e93d7e117393172a', '601ec313775789a5b7a7f504bbf3d228'
  #    it_behaves_like 'crypt', cipher_type, key_256, ctr_initialization_vector, 'ae2d8a571e03ac9c9eb76fac45af8e51', 'f443e3ca4d62b59aca84e990cacaf5c5'
  #    it_behaves_like 'crypt', cipher_type, key_256, ctr_initialization_vector, '30c81c46a35ce411e5fbc1191a0a52ef', '2b0930daa23de94ce87017ba2d84988d'
  #    it_behaves_like 'crypt', cipher_type, key_256, ctr_initialization_vector, 'f69f2445df4f9b17ad2b417be66c3710', 'dfc9c58db67aada613c2dd08457941a6'
  #  end
  #end

  describe 'simple tests' do
    cipher_type           = 'aes-128-cbc'
    it 'complex' do
      key                   = Base64.strict_encode64(['2b7e151628aed2a6abf7158809cf4f3c'].pack('H*'))
      initialization_vector = Base64.strict_encode64(['000102030405060708090A0B0C0D0E0F'].pack('H*')) 
      test_vector           = '6bc1bee22e409f96e93d7e117393172a'
      cipher_text           = Base64.strict_encode64(['7649abac8119b246cee98e9b12e9197d'].pack('H*'))

      AESCrypt.encrypt(test_vector, key, initialization_vector, cipher_type).should eq cipher_text
    end
  end

  context 'crazy_time' do
      
    key_0x                   = 0x2b7e151628aed2a6abf7158809cf4f3c
    initialization_vector_0x = 0x000102030405060708090A0B0C0D0E0F 
    test_vector_0x           = 0x6bc1bee22e409f96e93d7e117393172a
    cipher_text_0x           = 0x7649abac8119b246cee98e9b12e9197d
    #AESCrypt.encrypt2(test_vector_0x, key_0x, initialization_vector_0x, cipher_type)

  end

end


