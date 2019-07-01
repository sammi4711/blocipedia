require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "attributes" do 
    it "responds to role" do
      expect(user).to respond_to(:role)
    end
 
    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end
 
    it "responds to standard member?" do
      expect(user).to respond_to(:standard_member?)
    end

    it "responds to premium member?" do 
      expect(user).to respond_to(:premium_member)
    end
  end

  describe "roles" do
    it "is standard member by default" do
      expect(user.role).to eql("standard_member")
    end
 
    context "standard member user" do
      it "returns true for #standard_member?" do
         expect(user.standard_member?).to be_truthy
      end
 
      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end

      it "returns false for #premium_member?" do 
        expect(user.premium_member?).to be_falsey 
      end
    end

    context "premium member user" do 
      before do 
        user.premium_member! 
      end

      it "returns false for #standard_member?" do 
        expect(user.standard_member?).to be_falsey 
      end

      it "returns false for #admin?" do 
        expect(user.admin?).to be_falsy 
      end
      
      it "returns true for #premium_member?" do 
        expect(user.premium_member?).to be_truthy 
      end
    end
 
    context "admin user" do
      before do
        user.admin!
      end
 
      it "returns false for #standard_member?" do
        expect(user.standard_member?).to be_falsey
      end

      it "returns false for #premium_member?" do 
        expect(user.premium_member?).to be_falsey 
      end 
 
      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end
    end
end
