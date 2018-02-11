class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :started_games, class_name: "Game", foreign_key: "owner_id"
  has_many :opponent_games, class_name: "Game", foreign_key: "opponent_id"
end
