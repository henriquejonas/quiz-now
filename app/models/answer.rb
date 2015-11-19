class Answer < ActiveRecord::Base

	#== Associations
  belongs_to :question

  #== Fields
  has_attached_file :image, default_url: ''

  #== Validations
  validates_presence_of :question, :order, :answer

  #== Callbacks
  after_initialize do
  	self.order ||= 1
    self.correct ||= false
  end
  
end

# == Schema Information
#
# Table name: answers
#
#  id                 :integer          not null, primary key
#  answer             :text
#  question_id        :integer
#  order              :integer
#  correct            :boolean
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#
