#encoding: utf-8
require 'yaml'

class Teligem

  def initialize
    @configs = YAML.load_file("config/secrets.yml")
  end

  # === security_check(params)
  # Hash that must at least contains:
  # * security_code: the security code sent by telipass
  # * enduser_ip: the enduser ip address
  # * ntu: unique transaction number sent by telipass
  def security_check(params)
    security_code = params[:security_code]
    enduser_ip    = params[:enduser_ip]
    ntu           = params[:ntu]

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

  # === check_status(status)
  # Return true if status is 1 (valid)
  # Otherwise return false
  def check_status(status)
    case status.to_i
    when 1 # Valid
      true
    when 2 # Rejected
      false
    when 3 # Differed
      false
    when 4 # Test
      false
    else
      false
    end
  end

  # === get_earning(point_name)
  # Get earning from the hash Teligem::EARNING
  # Hash exemple:
  # Teligem::EARNING =
  # { "FRSMS10" => 10,
  #   "FRSMS20" => 20
  # }
  # Return 0 if key unknown
  def get_earning(point_name)
    return Teligem::EARNING[point_name].to_i
  end

  private
    def get_security_code(enduser_ip, ntu)
      code = enduser_ip.to_s + ntu.to_s + @configs['telikey'].to_s
      Digest::MD5.hexdigest(code)
    end

end
