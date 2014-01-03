#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class EpisodeView < Vienna::TemplateView
  def initialize(episode)
    @episode = episode
  end

  def render
    super

    @episode.each { |episode|
      view = EpisodeInfoView.new episode
      view.render
      Element.find('#episode-info') << view.element
    }
  end
end