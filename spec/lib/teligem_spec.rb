# -*- encoding : utf-8 -*-
require "spec_helper"

RSpec.describe Teligem do

  describe '#security_check' do
    before(:each) do
      @enduser_ip = "123456"
      @ntu        = "123456"

      hash = YAML.load_file("config/secrets.yml")
      code = @enduser_ip + @ntu + hash['telikey']
      @security_code = Digest::MD5.hexdigest(code)
    end
    context 'when request comes from telipass' do
      it 'should set response to true' do
        @params = {
          security_code: @security_code,
          enduser_ip:    @enduser_ip,
          ntu:           @ntu
        }

        response = Teligem.new.security_check(@params)

        expect(response).to be true
      end
    end

    context 'when not from telipass plateform' do
      it 'should set response to false' do
        @params = {
            security_code: "not_matching_security_code",
            enduser_ip:    @enduser_ip,
            ntu:           @ntu
        }

        response = Teligem.new.security_check(@params)

        expect(response).to be false
      end
    end
  end

end
