ActiveAdmin.register Question do

	#== Strong parameters
  permit_params :question, :image, :reference, :category_id, answers_attributes: [:answer, :image, :order, :id, :correct]

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
    f.semantic_errors *f.object.errors.keys
    f.inputs "Detalhes da Questão" do
      f.input :question
      f.input :category
      f.input :image, :as => :file, :hint => image_tag(f.object.image.url) 
      f.input :reference
    end
    f.inputs "Respostas da Questão" do
      f.has_many :answers, allow_destroy: true do |a|
        a.input :answer
        a.input :image, :as => :file, :hint => image_tag(a.object.image.url) 
        a.input :order
        a.input :correct, as: :select, collection: [['Yes', true],['No', false]]
      end
    end
    f.actions
  end

end
