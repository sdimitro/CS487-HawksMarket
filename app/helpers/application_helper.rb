module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Hawksmarket"
    end
  end
end
