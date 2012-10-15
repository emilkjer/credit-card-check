=begin
  * Name: Credit Card Validator 
  * Description: Includes all rspec tests to execute.
  * @Author: Emil Kjer
  * Date: 15/10/2012
=end

class CreditCardValidator
  
  def determine_card_type(card_digits_str)
    #34 or 37 => AMEX
    #6011 => Discover
    #51-55 => MasterCard
    #4 => Visa
    if card_digits_str =~ /^4[0-9]{12}(?:[0-9]{3})?$/
      return "VISA"
    elsif card_digits_str =~ /^5[1-5]\d{2}-?\d{4}-?\d{4}-?\d{4}$/ 
      return "MasterCard"
    elsif card_digits_str =~ /^3[47]\d{13}$/
      return "AMEX"
    elsif card_digits_str =~ /^6011-?\d{4}-?\d{4}-?\d{4}$/
      return "Discover"
    else
      return "Unknown"
    end
    
  end
  
end