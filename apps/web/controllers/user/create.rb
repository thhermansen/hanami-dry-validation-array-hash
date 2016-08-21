module Web::Controllers::User
  class Create
    include Web::Action

    # Action is called with the following params - see spec/web/controllers/user/create_spec.rb:
    #
    # {
    #   data: {
    #     attributes: {
    #       email: 'th@skalar.no',
    #       password: 'secret',
    #       alternative_emails: [
    #         {email: "th@skalar.no", description: "work"},
    #         {email: "th@home.no",   description: "home"}
    #       ]
    #     }
    #   }
    # }

    params do
      required(:data).schema do
        required(:attributes).schema do
          required(:email).filled(:str?, format?: /@/)
          required(:password).filled(:str?)


          # The following blocks of commented code is me trying different ways to
          # get the alternative_emails read correclty.
          #
          # Please read the #call and then each ATTEMPT below as each comment includes the
          # printed lines from #call.


          # ATTEMPT 1:
          #
          # required(:alternative_emails).each(:hash?)
          #
          # RESULT, printed out:
          #
          # ERRORS: {:data=>{:attributes=>{:alternative_emails=>{0=>["must be a hash"], 1=>["must be a hash"]}}}}
          #
          #
          # Looping over each alternative_emails; each expected to be a hash
          # CLASS: String: "{:email=>\"th@skalar.no\", :description=>\"work\"}"
          # CLASS: String: "{:email=>\"th@home.no\", :description=>\"home\"}"


          # ATTEMPT 2:
          #
          # required(:alternative_emails).each do
          #   schema do
          #     required(:email).filled(:str?, format?: /@/)
          #     required(:description).filled(:str?)
          #   end
          # end
          #
          # RESULT, printed out:
          #
          # # ERRORS: {:data=>{:attributes=>{:alternative_emails=>{0=>["must be a hash"], 1=>["must be a hash"]}}}}
          #
          #
          # Looping over each alternative_emails; each expected to be a hash
          # CLASS: String: "{:email=>\"th@skalar.no\", :description=>\"work\"}"
          # CLASS: String: "{:email=>\"th@home.no\", :description=>\"home\"}"



          # ATTEMPT 3:
          #
          # Comment out the *complete params bock* and run test. This actually returns expected
          # hashes.
          #
          # RESULT, printed out:
          #
          # Looping over each alternative_emails; each expected to be a hash
          # CLASS: Hash: {:email=>"th@skalar.no", :description=>"work"}
          # CLASS: Hash: {:email=>"th@home.no", :description=>"home"}
        end
      end
    end

    def call(params)
      puts "\nERRORS: #{params.errors.inspect}" if params.respond_to? :errors

      puts "\n\nLooping over each alternative_emails; each expected to be a hash"
      params.get('data.attributes.alternative_emails').each do |alternative|
        puts "CLASS: #{alternative.class}: #{alternative.inspect}"
      end


      puts "\n... Setting a response with values from params\n\n"

      self.body = {
        email: params.get('data.attributes.email'),
        password: params.get('data.attributes.password'),
        alternative_emails: params.get('data.attributes.alternative_emails')
      }.to_json
    end
  end
end
