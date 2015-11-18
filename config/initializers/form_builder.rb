# Uma forma de personalizar o FormBuilder padrão do Rails.
class ActionView::Helpers::FormBuilder
  delegate :content_tag, :to => :@template

  # Exibe informações sobre os erros de um formulário.
  def error_messages
    if object.errors.any?
      content_tag(:div, :class => 'panel panel-danger') do
        content_tag(:div, :class => 'panel-heading') do
          content_tag(:h4, 'Corrija os erros abaixo para continuar', :class => 'panel-title')
        end + content_tag(:div, :class => 'panel-body') do
          content_tag(:ul) do
            object.errors.full_messages.map do |error_message|
              content_tag(:li, error_message)
            end.join.html_safe
          end
        end
      end
    end
  end
end