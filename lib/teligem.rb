#encoding: utf-8
require 'yaml'

class Teligem

  def self.security_check(security_code, enduser_ip, ntu)
    unless security_code.nil? || enduser_ip.nil? || ntu.nil?
      hash = get_security_code(enduser_ip, ntu)
    end

    if !hash.nil? && (security_code == hash)
      response = true
    else
      response = false
    end

    return response
  end

  private
    def self.get_security_code(enduser_ip, ntu)
      code = enduser_ip + ntu + get_secret
      Digest::MD5.hexdigest(code)
    end

    def self.get_secret
      hash = YAML.load_file("config/secrets.yml")
      return hash['telikey']
    end

end
