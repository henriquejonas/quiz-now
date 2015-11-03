class Category < ActiveRecord::Base

	#== Associations
	has_many :questions, dependent: :destroy

	#== Fields
	has_attached_file :image

	#== Validations
	validates_presence_of :name
	
end

# == Schema Information
#
# Table name: categories
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#
