class Train < ActiveRecord::Base
  belongs_to :user

  def duration
    (ended_at - started_at)/60
  end
end

# == Schema Information
#
# Table name: trains
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  score      :integer
#  started_at :datetime
#  ended_at   :datetime
#  created_at :datetime
#  updated_at :datetime
#
