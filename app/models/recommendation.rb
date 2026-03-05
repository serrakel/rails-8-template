# == Schema Information
#
# Table name: recommendations
#
#  id              :bigint           not null, primary key
#  author          :string
#  cover_image_url :string
#  description     :text
#  published_year  :integer
#  reason          :text
#  status          :string           default("pending")
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint
#
# Indexes
#
#  index_recommendations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Recommendation < ApplicationRecord
  belongs_to :user

  validates :title, :author, presence: true
  validates :status, inclusion: { in: %w[pending pinned rejected] }

  scope :visible, -> { where(status: %w[pending pinned]) }
  scope :pinned, -> { where(status: "pinned") }
  scope :pending, -> { where(status: "pending") }
end
