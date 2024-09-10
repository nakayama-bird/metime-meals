module ApplicationHelper
  def page_title(title = '')
    base_ttitle = 'Me Time Meals'
    if title.empty?
      base_ttitle
    else
      "#{title} | #{base_ttitle}"
    end
  end

  def flash_background_color(type)
    case type.to_sym # シンボルに変換
    when :success then 'bg-success'
    when :alert then 'bg-error'
    else 'bg-grey-500'
    end
  end
end
