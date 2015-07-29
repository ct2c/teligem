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

  describe '#check_status' do
    it 'should return true if status valid' do
      expect(Teligem.new.check_status(1)).to eq true
    end
    it 'should return false if status rejected' do
      expect(Teligem.new.check_status(2)).to eq false
    end
    it 'should return false if status differed' do
      expect(Teligem.new.check_status(3)).to eq false
    end
    it 'should return true if status test' do
      expect(Teligem.new.check_status(4)).to eq false
    end
  end

  describe '#get_earning' do
    it 'should return correct earning' do
      Teligem::EARNING = {
        "FRSMS10" => 10,
        "FRSMS20" => 20
      }

      expect(Teligem.new.get_earning("FRSMS10")).to eq 10
      expect(Teligem.new.get_earning("FRSMS20")).to eq 20
      expect(Teligem.new.get_earning("UNKNOWN")).to eq 0
    end
  end
end
