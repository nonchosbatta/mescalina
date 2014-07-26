#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class StatsView < Vienna::TemplateView
  def initialize(stats)
    @stats = stats
  end

  def render
    super

    element << "<td class=\"fansub\">#{@stats[:fansub]}</td>"
    element << "<td class=\"series-count\" title=\"#{@stats[:series_done]}\">#{@stats[:series_done_count]}</td>"
    element << "<td class=\"episodes-count\">#{@stats[:episodes_done_count]}</td>"
  end

  def tag_name
    :tr
  end

  def class_name
    'stats'
  end
end