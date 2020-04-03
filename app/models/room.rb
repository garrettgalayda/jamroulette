# frozen_string_literal: true

class Room < ApplicationRecord
  validates :public_id, uniqueness: true
  validates :name, presence: true
  after_initialize :generate_public_id

  belongs_to :user

  has_many :jams, dependent: :destroy
  has_many :users, through: :jams

  has_many :activities, as: :subject, dependent: :destroy
  has_many :notifications, as: :target, dependent: :destroy

  scope :recommended, -> { joins(:jams).order("RANDOM()") }

  after_create :create_activity

  def to_param
    public_id
  end

  private

  def create_activity
    activities.create!(user: user)
  end

  def generate_public_id
    self.public_id ||= SecureRandom.hex
  end
end
