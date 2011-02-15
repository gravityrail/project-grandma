class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :opt_in, :fb_id

  validates_presence_of :email, :message => "please fill out the required fields"
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i, :message => 'email address must be valid'  
#  before_create :set_unique_key
  
  def self.new_without_password(args = {})
    password = Devise.friendly_token[0,20]
    User.new(args.merge(:password=>password, :password_confirmation=>password))
  end
  
#  def set_unique_key
    #generate out unique reference as the MD5 of the email, we do this for tracking our users
#    self.unique_key = Digest::MD5.hexdigest('gothttps:' + self.email)
#  end
  
  #Facebook user finder class method
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    
    puts "facebook data: #{data.inspect}"
    
    if user = User.find_by_email(data["email"])
      user
    else # Create an user with a stub password. 
#       password = Devise.friendly_token[0,20]
      
      props = facebook_properties(data)#.merge({:password => password, :password_confirmation=>password})
      
      u = User.new_without_password(props)
      u.save!
      
      u
      
      #Member.create!(props) #
    end
  end 
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
        user.facebook_raw = data.inspect
      end
    end
  end
  
  private 
  
    #return a hash of properties from the facebook authentication token hash
    def self.facebook_properties(attrs = {})
    
      #user_info = attrs["user_info"]
      
      #puts "user properties #{attrs}"
      
      props = {
        :email => attrs['email'],
        :fb_id => attrs['id'],
        :first_name => attrs['first_name'],
        :last_name => attrs['last_name']
      }
      
      return props
      
    end
end
