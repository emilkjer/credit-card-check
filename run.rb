=begin
  * Name: Credit Card Validator 
  * Description: Simple run and display class.
  * @Author: Emil Kjer
  * Date: 15/10/2012
=end

require_relative './credit_card_validator.rb'  

class CreditCardValidationExecuter
  def initialize
    @credit_card_validator = CreditCardValidator.new
  end
  
  def check_card_digits(card_digits)
    # Validate, determine type and display result
    validity = @credit_card_validator.validate_card_luhn(card_digits)
    type = @credit_card_validator.determine_card_type(card_digits)
    puts type.to_s + ": " + card_digits.to_s + " ("+ (validity ? 'valid' : 'invalid') + ")"
  end
  
end
  
if __FILE__ == $0
  credit_card_validation_executer = CreditCardValidationExecuter.new
  
  puts "Please input creditcard digits or 'q' "
  
  # Repeat until 'q' is pressed
  while true
    STDOUT.flush()
    input = STDIN.gets.chomp
    exit if 'q' == input
    credit_card_validation_executer.check_card_digits(input)
  end
end