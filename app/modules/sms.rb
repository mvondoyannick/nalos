class Sms

  # SEND SMS USING NEXAH PLATEFORM
  # @param [String] phone
  # @param [String] message
  def self.send(argv)

    @msg = argv[:msg]
    @phone = argv[:phone]

    # starting post request
    HTTParty.post('https://smsvas.com/bulk/public/index.php/api/v1/sendsms',
                  body: {
                    user: 'info@jfn-it.com',
                    password: 'jfn-itdouala1',
                    senderid: 'NALSCHOOL', #App.first.name.upcase, #"PAYMEQUICK",
                    sms: @msg,
                    mobiles: @phone
                  }.to_json,
                  headers: {
                    'Content-Type' => 'application/json'
                  })

  end

end