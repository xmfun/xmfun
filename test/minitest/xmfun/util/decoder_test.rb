require 'mini_test_helper'

module Xmfun
  module Util
    class TestDecoder < Minitest::Test
      def setup
        @decoder  = Xmfun::Util::Decoder
      end

      def test_decode__return_valid_url
        url_1 = "http://m5.file.xiami.com/1/169/7169/320390/3562717_365342_l.mp3?auth_key=30dc8ee47200ee626fdc2eadac2e3fb8-1407888000-0-null"
        url_2 = "http://f1.xiami.net/355/1133/13218_13218.mp3"

        location_1 = "8h2fmF%2956mtDe%fc185utFii12F%65ph3e5d24%Elt%l.%F35233_%4Ece%5-lp2ec272E74%k57e235E%%F.oF1%%123eE2eefE%53mxm16527_Fyd%6ab75EA5i%69EF_la%c52d88E-%.a29%333.u38E6a-8%n"
        location_2 = "10h%i5F1t2.%18tFn23.pfeF2m%1t11p3.%183Ax23_%iF312a3%3Fm522"

        assert_equal @decoder.decode(location_1), url_1
        assert_equal @decoder.decode(location_2), url_2
      end

      def test_decode__return_false_with_invalid_url
        location   = "this_is_invalid_url"

        refute @decoder.decode(location)
      end

      def test_strtok__return_an_array
        location = "8h2fmF%2956mtDe%fc185utFii12F%65ph3e5d24%Elt%l.%F35233_%4Ece%5-lp2ec272E74%k57e235E%%F.oF1%%123eE2eefE%53mxm16527_Fyd%6ab75EA5i%69EF_la%c52d88E-%.a29%333.u38E6a-8%n"
        expected = [8, location[1..-1].chars.to_a]

        assert_equal @decoder.strtok(location), expected
      end

      def test_strtok__raise_exception_with_invalid_url
        location   = "h2fmF%2956mtDe%fc185utFii12F%65ph3e5d24%Elt%l.%F35233_%4Ece%5-lp2ec272E74%k57e235E%%F.oF1%%123eE2eefE%53mxm16527_Fyd%6ab75EA5i%69EF_la%c52d88E-%.a29%333.u38E6a-8%n"
        expect_msg = "invalid input #{location}"

        assert_raises(ArgumentError){@decoder.strtok(location)}
      end
    end
  end
end
