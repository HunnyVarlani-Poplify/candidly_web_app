require 'base64'
require 'savon' 


class  DaxtraParser
    def initialize(service_url, service_account) 
        @ACCOUNT = service_account
        @client = Savon::Client.new(wsdl: service_url + "/cvx/CVXtractorService.wsdl")
    end
    def parse_file(file_to_process)
        content = File.binread(file_to_process)
        encoded = Base64.encode64(content)
        response = @client.call(:process_cv, message: { "document_url" => encoded, "account" => @ACCOUNT })
        response.body[:process_cv_response][:hrxml]
    end
end


# #-- Now you can use DaxtraParser objects in your Ruby on Rails program


# parser = DaxtraParser.new(service_url, service_account);
# hrxml_profile = parser.parse_file(file_to_process)
# hrxml_profile = parser.parse_file("Ajit_Resume.pdf")