require 'json'
require 'base64'
class PaymentsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create_approve_url
    payment_request = PaymentRequest.create(payment_params)
    puts process_payment_payment_url(payment_request.token)
    render json: { approve_url: process_payment_payment_url(payment_request.token)}.to_json
  end

  def process_payment
    begin
      payment_request = PaymentRequest.where(token: params[:id]).take
      encoded_string = transform_string(payment_request)
      redirect_to "#{params[:return_url]}?encoded_string=#{encoded_string}"
    rescue Exception => error
      puts error
    end
  end

  private

  def payment_params
    #use strong params here
    { encoded_string: params[:encoded_string] }
  end

  def transform_string(payment_request)
    decoded_xml = Base64.decode64(payment_request.encoded_string)
    decoded_hash = Hash.from_xml(decoded_xml).to_json
    decoded_hash = JSON.parse(decoded_hash.upcase)["HASH"]
    encoded_string = Base64.urlsafe_encode64(decoded_hash.to_xml)
  end
end
