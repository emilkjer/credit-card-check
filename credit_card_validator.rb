=begin
  * Name: Credit Card Validator 
  * Description: Includes all rspec tests to execute.
  * @Author: Emil Kjer
  * Date: 15/10/2012
=end

class CreditCardValidator
  
  def determine_card_type(card_digits_str)
    # Determine the credit card type based on first digits and
    # the length of the number of digits.
    # Determined by the following patterns:
    # start with 34 or 37, length 15 => AMEX
    # start with 6011, length 16 => Discover
    # start with 51-55, length 16 => MasterCard
    # start with 4, length 13 or 16 => Visa
    
    if card_digits_str =~ /^4[0-9]{12}(?:[0-9]{3})?$/
      "VISA"
    elsif card_digits_str =~ /^5[1-5]\d{2}-?\d{4}-?\d{4}-?\d{4}$/ 
      "MasterCard"
    elsif card_digits_str =~ /^3[47]\d{13}$/
      "AMEX"
    elsif card_digits_str =~ /^6011-?\d{4}-?\d{4}-?\d{4}$/
      "Discover"
    else
      "Unknown"
    end
  end
  
  def validate_card_luhn(card_digits_str)
    # Validate card digits with the Luhn algorithm 
    # Ref: http://en.wikipedia.org/wiki/Luhn_algorithm
    sum = 0
    card_digits_str.reverse.split("").each_with_index do |i,idx|
      if idx % 2 != 0
        sub = i.to_i*2
        sub -= 9 if sub > 9
        sum += sub 
      else
        sum += i.to_i
      end
    end
    sum % 10 == 0
  end
  
  
end