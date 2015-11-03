ActiveAdmin.register Answer do

	#== Strong parameters
  permit_params :question_id, :image, :answer, :order

  index do
    selectable_column
    id_column
    column :answer
    column :question do |answer|
    	link_to answer.question, admin_question_path(answer.question)
    end
    column :order
    column :image do |answer|
      image_tag answer.image.url, :style => 'width: 80px;'
    end
    actions
  end

  show do
    attributes_table do
      row :question do
      	answer.question.question
      end
      row :answer
      row :image do
        image_tag answer.image.url, :style => 'width: 80px;'
      end
      row :order
    end
  end

  filter :question, as: :select

  form do |f|
    f.inputs  do
      f.input :question
      f.input :answer
      f.input :image, :as => :file, :hint => image_tag(f.object.image.url) 
      f.input :order
    end
    f.actions
  end

end
