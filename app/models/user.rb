class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

  
  
  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = rails.root.join('app/assets/images/no-image-icon.jpg')
      profile_image.attach(io:File.open(file_path),filename: 'default_image.jpg',content_type: 'image/jpeg')
    end
    profile_image.variant(rerize_to_limit: [width,height]).processed
  end
end