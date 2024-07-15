module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym #シンボルに変換
      when :success then 'bg-success'
      when :alert then 'bg-error'
      else 'bg-grey-500'
    end
  end
end
