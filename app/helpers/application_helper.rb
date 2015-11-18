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
end
