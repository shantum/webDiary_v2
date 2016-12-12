class User < ApplicationRecord
  has_many :user_links, dependent: :destroy
  has_many :links, through: :user_links
  has_many :user_feeds, dependent: :destroy
  has_many :feeds, through: :user_feeds
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
