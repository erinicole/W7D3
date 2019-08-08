# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'


RSpec.describe User, type: :model do
  describe "validations" do
  # it 'ensures there is a session token' do
  #   expect(self.session_token).not_to be_nil 
  # end

    subject(:user) do 
      User.create!(username: 'Alissa', password: '123456')
    end

    it { should validate_presence_of(:username)}
    it { should validate_presence_of(:password_digest)} 
    it { should validate_presence_of(:session_token)} 
    
    it { should validate_uniqueness_of(:username)}
    it { should validate_uniqueness_of(:session_token)}

    it { should validate_length_of(:password).is_at_least(6)}
  end

  describe "ensure_session_token" do
    it "ensures and sets a session token (lazily)" do
      user = User.create!(username: 'Alissa', password: '123456')
      expect(user.session_token).not_to be nil
    end
  end

  describe "reset_session_token" do
    it "resets the user's session token" do
      user = User.create!(username: 'Alissa', password: '123456')
      session_token = user.session_token
      expect(user.reset_session_token).not_to be(session_token)
    end
  end

  describe "find by creditials" do
    
  

    it "returns nil if username or password is missing" do
      user1 = User.new(username: 'Alissa', password: '123456')
      expect(User.find_by_credentials('Ronil', '123456')).to be_nil
      expect(User.find_by_credentials('Alissa', '12345')).to be_nil

    end

    it "returns user if both password and username are found" do
      user1 = User.create(username: 'Alissa', password: '123456')
      expect(User.find_by_credentials('Alissa', '123456')).not_to be_nil
    end
  end

end

#ensure_session_token
