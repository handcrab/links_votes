class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :links  

  before_destroy :adopt_orphant_links

  
  # TODO
  def self.default_user
    find_by(email: 'default@default.default') || create(email: 'default@default.default', password: 'defaultdefault', name: 'default')
  end

  private
    def adopt_orphant_links
      self.links.update_all user_id: User.default_user
      # self.links.each {|link| link.update_attributes user_id: User.default_user}
    end     
end
