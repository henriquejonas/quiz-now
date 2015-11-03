ActiveAdmin.register Category do

	#== Strong parameters
  permit_params :name, :image

  index do
    selectable_column
    id_column
    column :name
    column :image do |category|
      image_tag category.image.url, :style => 'width: 80px;'
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :image do
        image_tag category.image.url, :style => 'width: 80px;'
      end
    end
  end

  filter :name

  form do |f|
    f.inputs  do
      f.input :name
      f.input :image, :as => :file, :hint => image_tag(f.object.image.url) 
    end
    f.actions
  end

end
