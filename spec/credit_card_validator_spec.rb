=begin
  * Name: Credit Card Validator 
  * Description: Test of the credit card validator
  * @Author: Emil Kjer
  * Date: 15/10/2012
=end

require 'spec_helper'

describe CreditCardValidator do
  before :each do
    @credit_card_validator = CreditCardValidator.new
    @card_digits_valid = [ "4111111111111111",
                            "4012888888881881",
                            "378282246310005",
                            "6011111111111117",
                            "5105105105105100"]
                            
    @card_digits_invalid = [  "4111111111111",
                              "5105105105105106",
                              "9111111111111111"]
  end
  
  describe "#determine_card_type" do
    it "should determine VISA" do
      # Begin with 4
      # Determine 16 digits
      card_digits = '4408041234567893'
      @credit_card_validator.determine_card_type(card_digits).should eq('VISA')
      # Determine 13 digits
      card_digits = '4408041234567'
      @credit_card_validator.determine_card_type(card_digits).should eq('VISA')
      #Too short
      @credit_card_validator.determine_card_type(card_digits[0..-2]).should eq('Unknown') 
      #Too long
      @credit_card_validator.determine_card_type(card_digits+"0").should eq('Unknown') 
    end

    it "should determine AMEX" do
      # Begin with 34
      card_digits = "348282246310005"
      @credit_card_validator.determine_card_type(card_digits).should eq('AMEX')
      # Begin with 37
      card_digits = "378282246310005"
      @credit_card_validator.determine_card_type(card_digits).should eq('AMEX') 
      #Too short
      @credit_card_validator.determine_card_type(card_digits[0..-2]).should eq('Unknown') 
      #Too long
      @credit_card_validator.determine_card_type(card_digits+"0").should eq('Unknown')
    end
    
    it "should determine Discover" do
      # Begin with 6011
      card_digits = "6011111111111117"
      @credit_card_validator.determine_card_type(card_digits).should eq('Discover')
      #Too short
      @credit_card_validator.determine_card_type(card_digits[0..-2]).should eq('Unknown') 
      #Too long
      @credit_card_validator.determine_card_type(card_digits+"0").should eq('Unknown') 
    end
    
    it "should determine MasterCard" do
      # Begin with range 51-55
      card_digits = "5105105105105100"
      @credit_card_validator.determine_card_type(card_digits).should eq('MasterCard')
      card_digits = "5205105105105100"
      @credit_card_validator.determine_card_type(card_digits).should eq('MasterCard')
      card_digits = "5305105105105100"
      @credit_card_validator.determine_card_type(card_digits).should eq('MasterCard')
      card_digits = "5405105105105100"
      @credit_card_validator.determine_card_type(card_digits).should eq('MasterCard')
      card_digits = "5505105105105100"
      @credit_card_validator.determine_card_type(card_digits).should eq('MasterCard')
      card_digits = "5005105105105100"
      @credit_card_validator.determine_card_type(card_digits).should eq('Unknown')
      card_digits = "5605105105105100"
      @credit_card_validator.determine_card_type(card_digits).should eq('Unknown')
      
      card_digits = "5105105105105100"
      #Too short
      @credit_card_validator.determine_card_type(card_digits[0..-2]).should eq('Unknown') 
      #Too long
      @credit_card_validator.determine_card_type(card_digits+"0").should eq('Unknown')
    end


    it "should return Unknown on 1234" do
      card_digits = "1234"
      @credit_card_validator.determine_card_type(card_digits).should eq('Unknown') 
    end

    it "should return Unknown on 'abc'" do
      card_digits = "abc"
      @credit_card_validator.determine_card_type(card_digits).should eq('Unknown') 
    end
            
  end
  
  describe "#validate_card_luhn" do
    it "should validate TRUE" do
      @card_digits_valid.each do |card|
        @credit_card_validator.validate_card_luhn(card).should be true
      end
    end

    
    it "should validate FALSE" do
      @card_digits_invalid.each do |card|
        @credit_card_validator.validate_card_luhn(card).should be false
      end
    end
    
    it "should validate text" do
      card = "abc"
      @credit_card_validator.validate_card_luhn(card).should be false
    end

    it "should validate double" do
      card = "0.0"
      @credit_card_validator.validate_card_luhn(card).should be false
    end

  end
  
  
end