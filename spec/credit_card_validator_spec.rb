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
    it "should return VISA 4408041234567893" do
      card_digits = "4408041234567893"
      @credit_card_validator.determine_card_type(card_digits).should eq('VISA') 
    end
    
    it "should return AMEX 378282246310005" do
      card_digits = "378282246310005"
      @credit_card_validator.determine_card_type(card_digits).should eq('AMEX') 
    end

    it "should return AMEX 348282246310005" do
      card_digits = "348282246310005"
      @credit_card_validator.determine_card_type(card_digits).should eq('AMEX') 
    end
    
    it "should return Discover 6011111111111117" do
      card_digits = "6011111111111117"
      @credit_card_validator.determine_card_type(card_digits).should eq('Discover') 
    end
    
    it "should return MasterCard 5105105105105100" do
      card_digits = "5105105105105100"
      @credit_card_validator.determine_card_type(card_digits).should eq('MasterCard')
      card_digits = "5505105105105100"
      @credit_card_validator.determine_card_type(card_digits).should eq('MasterCard')
    end


    it "should return Unknown 5605105105105100" do
      card_digits = "5605105105105100"
      @credit_card_validator.determine_card_type(card_digits).should eq('Unknown') 
      #Too short
      card_digits = "550510510510510"
      @credit_card_validator.determine_card_type(card_digits).should eq('Unknown') 
      #Too long
      card_digits = "55051051051051000"
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
  end
  
  
end