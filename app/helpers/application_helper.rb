module ApplicationHelper
  def tick(value)
    if(value)
      '<span class="tick">yes</span>'
    else
      '<span class="cross">no</span>'
    end
  end
end
