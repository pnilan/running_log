require "spec_helper"

describe UserMailer do

  	describe "password_reset" do
  		let(:user) { FactoryGirl.create(:user) }
  		let(:mail) { UserMailer.password_reset(user) }

  		it "sends user password reset url" do
  			mail.subject.should eq("SecondWind Password Reset")
  			mail.to.should eq([user.email])
  			mail.from.should eq(["passwordreset@secondwind.co"])
  		end

  		it "renders the body" do
  			mail.body.encoded.should match(edit_password_reset_path(user.password_reset_token))
  		end
  	end
end
