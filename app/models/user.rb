class User < ApplicationRecord
  has_many :user_links, dependent: :destroy, through: :links
  has_many :user_feeds, dependent: :destroy, through: :feeds
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
