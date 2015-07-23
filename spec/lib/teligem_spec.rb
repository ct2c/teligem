# -*- encoding : utf-8 -*-
require "spec_helper"

RSpec.describe Teligem do

  describe '#security_check' do
    context 'when request comes from telipass' do
      it 'should set response to true' do
        enduser_ip = "123456"
        ntu        = "123456"
        security_code = Teligem.get_security_code(enduser_ip, ntu)

        response = Teligem.security_check(security_code, enduser_ip, ntu)

        expect(response).to be true
      end
    end

    context 'when not from telipass plateform' do
      it 'should set response to false' do
        enduser_ip = "123456"
        ntu        = "123456"
        security_code = "not_matching_security_code"

        response = Teligem.security_check(security_code, enduser_ip, ntu)

        expect(response).to be false
      end
    end
  end

end
