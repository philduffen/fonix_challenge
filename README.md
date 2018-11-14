# Fonix Challenge

 - end to end is working as per the challenge.
 - additonal error checking (required)
 - more comprehenive tests (required)
 - refactoring (required)

* Ruby 2.5.1

* Rails 5.2.1

* git clone https://github.com/philduffen/fonix_challenge.git

* bundle install

* phone number is UK mobile number format i.e. starting with 07.

* localhost:3000/ will give you the start page

* 4 digit code will be sent via SMS to phone with number entered on first page.

* Confirmation if correct - return to start page if not.


Note: one of the spec tests will fail at the moment. To get it to pass change the following method in challenges_controller.rb

  def generate_code
    rand.to_s[2..5] <- subsitute with the code string e.g. '1234'
  end