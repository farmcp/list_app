module ApplicationHelper
  # returns the full title on a per page basis
  def full_title(page_title)
    base_title = 'Bitelist'
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def link_to_phone(number_str)
    if number_str
      formatted_str = number_str.sub(/(\d{3})(\d{3})(\d{4})/, "( \\1 ) \\2-\\3")
      link_to formatted_str, "tel:#{number_str}", style: 'font-weight:normal; margin-top:3px;', class: 'btn btn-warning pull-left'
    end
  end

end
