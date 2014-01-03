#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class EpisodeInfoView < Vienna::TemplateView
  def initialize(episode)
    @episode = episode
  end

  def render
    super

    element << "<td><a href=\"#{@episode.download}\" target=\"_blank\">#{@episode.episode}</a></td>"
    
    element << "<td class=\"#{@episode.translation}\">#{@episode.show.translator}</td>"
    element << "<td class=\"#{@episode.editing}\"    >#{@episode.show.editor}    </td>"
    element << "<td class=\"#{@episode.checking}\"   >#{@episode.show.checker}   </td>"
    element << "<td class=\"#{@episode.timing}\"     >#{@episode.show.timer}     </td>"
    element << "<td class=\"#{@episode.typesetting}\">#{@episode.show.typesetter}</td>"
    element << "<td class=\"#{@episode.encoding}\"   >#{@episode.show.encoder}   </td>"
    element << "<td class=\"#{@episode.qchecking}\"  >#{@episode.show.qchecker}  </td>"
  end

  def tag_name
    :tr
  end

  def class_name
    'episode-info'
  end
end