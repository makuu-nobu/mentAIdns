class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_validation :generate_email_and_password, on: :create
  before_create :create_answer

  validates :release_option, presence: true
  
  has_many :answers


  private

  def generate_email_and_password
    self.email = Faker::Internet.unique.email
    self.password = Faker::Internet.password
  end

  def create_answer
    build_answer(username: self.username)
  end  

end
