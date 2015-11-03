class Question < ActiveRecord::Base

	#== Associations
  belongs_to :category

  has_many :categories, dependent: :destroy

  #== Fields
  has_attached_file :image

  #== Validations
  validates_presence_of :question, :category

  def to_s
  	question.truncate(100)
  end
  
end

# == Schema Information
#
# Table name: questions
#
#  id                 :integer          not null, primary key
#  question           :text
#  reference          :text
#  category_id        :integer
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#
# Indexes
#
#  index_questions_on_category_id  (category_id)
#
