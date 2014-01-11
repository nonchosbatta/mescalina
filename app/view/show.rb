#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class ShowView < Vienna::TemplateView
  def initialize(show)
    @show = show
  end

  on :click do |evt|
    target = evt.target
    if target.tag_name == ?a
      Vienna::Router.new.navigate target['href']
      return
    end

    Episode.all!(@show) { |episode|
      if episode
        view = EpisodeView.new episode
        view.render
        element << view.element
        
        `$('#episode').modal();`
      else
        `$('#episode-error').modal();`
      end
    }
  end

  def render
    super

    Episode.all!(@show) { |episodes|
      episode = episodes.last

      Show.columns.each { |field|
        next if Show.exclude? field
        
        view = ShowInfoView.new @show, field
        view.render
        
        if Episode.status? field
          key = Episode.to_task field
          view.element.add_class episode.send(key).to_s if key
        end

        element << view.element
      }
    }
  end

  def tag_name
    :tr
  end

  def class_name
    'show-row'
  end
end