class Api::V1::HomeController < ApplicationController
	before_action :authenticate_api_v1_user!, only: [:list_of_domains]

	def sign_in_user
		auth_options = sign_in_params
		resource = Admin.find_by(email: auth_options[:email].downcase)
		resource ||= User.find_by(email: auth_options[:email].downcase)

		if resource.present? && resource.valid_password?(auth_options[:password])
			sign_in(resource)
			respond_with resource
		else
			render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unauthorized
		end
	end

	def list_of_domains 
		if current_api_v1_user.present? 
			render json: { domains: Tenant.all.select(:id, :name, :subdomain) }, status: :ok		
		end
	end

	def resume_parser
		parser = DaxtraParser.new(DAXTRA_SERVICE_URL, DAXTRA_USER);
		hrxml_profile = parser.parse_file("Ajit_Resume.pdf")
		render json: Hash.from_xml(hrxml_profile)
	end

	def add_candidate
		file = open("Ajit_Resume.pdf")
		base_64 = Base64.encode64(file.read)
		builder = Nokogiri::XML::Builder.new do |xml|
			xml.DxRequest {
				xml.Action "add_candidate"
				xml.Options "index"
				xml.Username DAXTRA_USERNAME
				xml.Password DAXTRA_PASSWORD
				xml.Database DAXTRA_DATABASE
				xml.Candidate {
					xml.Profile base_64
				}
			}
		end
		request_body = builder.to_xml  
		response = faraday.post '', request_body
		if response.status == 200
			response_body = response.body 
			response_json = Hash.from_xml(response_body)
			render json: response_json
			# Added Candidate information =  {"DxResponse"=>{"Status"=>{"Code"=>"100", "Description"=>"OK"}, "Candidate"=>{"CandidateId"=>"XC10", "ProfileType"=>"pdf;application/pdf", "StructuredOptions"=>{"FirstName"=>"Ajit", "LastName"=>"Jain", "CreatedDate"=>"2021-06-16 11:42:25", "UpdatedDate"=>"2021-06-16 11:42:25", "Address"=>{"City"=>"Vadodara", "Country"=>"IN"}, "Contact"=>{"Email"=>"ajitkumarjain123@gmail.com"}}, "Tags"=>nil}}}
		end
	end

	def get_candidate 
		builder = Nokogiri::XML::Builder.new do |xml|
			xml.DxRequest {
				xml.Action "get_candidate"
				xml.Username DAXTRA_USERNAME
				xml.Password DAXTRA_PASSWORD
				xml.Database DAXTRA_DATABASE
				xml.Candidate {
					xml.CandidateId "XC10"
				}
			}
		end
		request_body = builder.to_xml   
		response = faraday.post '', request_body
		if response.status == 200
			response_body = response.body 
			response_json = Hash.from_xml(response_body)
			render json: response_json
		end	
	end

	def add_vacancy 
		builder = Nokogiri::XML::Builder.new do |xml|
			xml.DxRequest {
				xml.Action "add_vacancy"
				xml.Username DAXTRA_USERNAME
				xml.Password DAXTRA_PASSWORD
				xml.Database DAXTRA_DATABASE
				xml.Vacancy {
					xml.Profile "Ruby On Rails"
					xml.HRXML "nohrxml"
					xml.StructuredOptions {
						xml.JobTitle "Ruby on Rails"
						xml.CompanyName "Poplify"
						xml.DatePosted "2021-06-16"
						xml.Location "London"
						xml.ContractType "Full Time"
						xml.Salary "2221"
						xml.Industry "IT"
						xml.Level "Senior"
						xml.Skills "Rails"
						xml.Qualifications "B.tech"
						xml.Description "Postgresql Ruby HTML CSS Javascript"
						xml.Keywords "Hardwork"
					}
				}
			}
		end
		request_body = builder.to_xml  
		response = faraday.post '', request_body 
		if response.status == 200
			response_body = response.body 
			response_json = Hash.from_xml(response_body)
			# Added Vacancy information =  {"DxResponse"=>{"Status"=>{"Code"=>"100", "Description"=>"OK"}, "Vacancy"=>{"VacancyId"=>"XV11", "StructuredOptions"=>{"JobTitle"=>"Ruby on Rails", "CreatedDate"=>"2021-06-16 12:25:59", "UpdatedDate"=>"2021-06-16 12:25:59", "CompanyName"=>"Poplify", "DatePosted"=>"2021-06-16 00:00:00", "Location"=>"London", "ContractType"=>"Full Time", "Salary"=>"2221", "Industry"=>"IT", "Level"=>"Senior", "Skills"=>"Rails", "Qualifications"=>"B.tech", "Description"=>"Postgresql Ruby HTML CSS Javascript", "Keywords"=>"Hardwork"}, "Tags"=>nil}}}
			render json: response_json
		end
	end

	def get_vacancy
		builder = Nokogiri::XML::Builder.new do |xml|
			xml.DxRequest {
				xml.Action "get_vacancy"
				xml.Username DAXTRA_USERNAME
				xml.Password DAXTRA_PASSWORD
				xml.Database DAXTRA_DATABASE
				xml.Vacancy {
					xml.VacancyId "XV11"
				}
			}
		end
		request_body = builder.to_xml   
		response = faraday.post '', request_body
		if response.status == 200
			response_body = response.body 
			response_json = Hash.from_xml(response_body)
			render json: response_json
		end	
	end

	private 
		def sign_in_params 
			params.require(:user).permit(:email, :password)
		end

		def respond_with(resource, _opts = {})
			response["Tenant-Name"] = resource.subdomain   
			cookies["Authorization"] = {value:	resource.get_jwt_token, httponly: true, same_site: "None", secure: true, domain: ".demo.localhost"}
      cookies["Tenant-Name"] = {value: resource.subdomain, httponly: true, same_site: "None", secure: true, domain: ".demo.localhost"}
			if resource.class == Admin 
			 	render json: AdminSerializer.new(resource), status: :ok
			else 
				render json: UserSerializer.new(resource), status: :ok
			end
		end
end
