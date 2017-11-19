module NokogiriMixins
  def sentences
    self.xpath("//sentences//sentence")
  end

  def tokens
    self.xpath(".//tokens//token")
  end

  def _word
    self.at_xpath(".//word")
  end
end
