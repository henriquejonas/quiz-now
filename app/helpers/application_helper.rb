module ApplicationHelper
  # Define o título da página
  def title(page_title, show_title = true)
    @page_title = page_title
    @show_title = show_title
  end

  # Define o subtítulo da página
  def subtitle(page_subtitle)
    @page_subtitle = page_subtitle
  end

  def head_title
    head_title = t('labels.application_title')

    unless @page_title.nil?
      head_title = "#{@page_title} - " + head_title
    end

    head_title
  end

  def alert_contextual_css_class(flash_name)
    case flash_name
      when :info
        'alert-info'
      when :success, :notice
        'alert-success alert-auto-hide'
      when :warn, :alert
        'alert-warning'
      when :error
        'alert-danger'
      else
        nil
    end
  end
end
