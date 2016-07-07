##
# 全局共用Helper
module ApplicationHelper

  ##
  # 补全title
  def full_title(title_prefix)
    base_title = "Weibo With ROR5"
    if title_prefix.empty?
      base_title
    else
      title_prefix + " | #{base_title}"
    end
  end
end
