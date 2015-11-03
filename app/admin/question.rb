ActiveAdmin.register Question do

	#== Strong parameters
  permit_params :question, :image, :reference, :category_id

  index do
    selectable_column
    id_column
    column :question
    column :reference
    column :category_id
    column :image do |question|
      image_tag question.image.url, :style => 'width: 80px;'
    end
    actions
  end

  show do
    attributes_table do
      row :question
      row :reference
      row :category_id
      row :image do
        image_tag question.image.url, :style => 'width: 80px;'
      end
    end
  end

  filter :question,  as: :string
  filter :reference, as: :string
  filter :category,  as: :select

  form do |f|
    f.inputs  do
      f.input :question
      f.input :category
      f.input :image, :as => :file, :hint => image_tag(f.object.image.url) 
      f.input :reference
    end
    f.actions
  end

end
