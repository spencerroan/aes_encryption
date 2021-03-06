module CryptHelper
  def self.hexdigest_to_hexstr digest
    [digest].pack('H*')
  end

  def self.hexdigest_to_hexstr2 digest
    digest.scan(/../).map {|c|c.hex.chr}.join 
  end

  #my own implementation converting an int to a hexstr
  #def int_to_str(int, times) 
  #  chars = [] 
  #  times.times {
  #    chars.unshift (int & 255).chr 
  #    int >>= 8; 
  #  }
  #  chars.join
  #end

end
