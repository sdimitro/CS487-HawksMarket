class User < ActiveRecord::Base
  
# Relations
has_many :posts

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  # Pagination
  paginates_per 100

  # Validations
  # :email
<<<<<<< HEAD
  validates_format_of :email, with: /\A([^@\s]+)@(?:hawk.){0,1}iit\.edu\Z/i
=======
<<<<<<< HEAD
   #validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
   validates_format_of :email, with: /\b(?:(?![_.-])(?!.*[_.-]{2})[a-z0-9_.-]+(?<![_.-]))@(?:(?!-)(?!.*--)[a-z0-9-]+(?<!-)\.)*iit\.edu\b/i
=======
  validates_format_of :email, with: /\A([^@\s]+)@(?:hawk.){0,1}iit\.edu\Z/i
>>>>>>> upstream/master
>>>>>>> e51cb067b1aa6413b0a93178946e77d33323d197

  def self.paged(page_number)
    order(admin: :desc, email: :asc).page page_number
  end

  def self.search_and_order(search, page_number)
    if search
      where("email LIKE ?", "%#{search.downcase}%").order(
      admin: :desc, email: :asc
      ).page page_number
    else
      order(admin: :desc, email: :asc).page page_number
    end
  end

  def self.last_signups(count)
    order(created_at: :desc).limit(count).select("id","email","created_at")
  end

  def self.last_signins(count)
    order(last_sign_in_at:
    :desc).limit(count).select("id","email","last_sign_in_at")
  end

  def self.users_count
    where("admin = ? AND locked = ?",false,false).count
  end
end
