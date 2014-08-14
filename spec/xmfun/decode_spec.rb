# -*- encoding : utf-8 -*-
require 'spec_helper'

module Xmfun
  describe Decoder do
    before do
      @decoder  = Xmfun::Decoder
      @location = "8h2fmF%2956mtDe%fc185utFii12F%65ph3e5d24%Elt%l.%F35233_%4Ece%5-lp2ec272E74%k57e235E%%F.oF1%%123eE2eefE%53mxm16527_Fyd%6ab75EA5i%69EF_la%c52d88E-%.a29%333.u38E6a-8%n"
      @url      = "http://m5.file.xiami.com/1/169/7169/320390/3562717_365342_l.mp3?auth_key=30dc8ee47200ee626fdc2eadac2e3fb8-1407888000-0-null"
    end

    it "#should return a decoded url" do
      expect(@decoder.decode(@location)).to eq(@url)
    end
  end
end
