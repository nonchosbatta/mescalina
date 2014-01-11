#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class MescalinaView < Vienna::View
  element '#mescalina'

  def initialize
    %w(ongoing finished dropped planned).each { |id|
      Element["##{id}"].on :click do
        url = `window.location.href`

        if url.include?('/fansub/') || url.include?('/users/')
          url = url.gsub /\/(ongoing|finished|dropped|planned)/, ''
          str = "#{url}/#{id}"
        else
          str = "#/#{id}"
        end
        `window.location.href = str`
      end
    }
  end

  def find_shows(keyword)
    Show.search!(keyword) { |show|
      view = ShowView.new show
      view.render
      Element.find('#mescalina') << view.element
      get_preview show
    }
  end

  def get_shows(status, filters)
    Show.all!(status, filters) { |show|
      view = ShowView.new show
      view.render
      Element.find('#mescalina') << view.element
      get_preview show
    }
  end

  def get_preview(show)
    Episode.all!(show) { |episode|
      next if episode.empty?
      
      Element['.show-row'].each { |row|
        next if row.find('.name').text != show.name

        Show.roles.each { |role|
          row.find(".#{role}").add_class episode.last.send(Show.to_task(role)).to_s
        }
      }
    }
  end

  def load(what, filters = {})
    filters[:status] ||= :ongoing

    Element.find('.show-row').remove
    SearchView.new.element

    what = :get if !filters.has_key?(:keyword) || filters[:keyword].empty?
    case what
      when :get  then get_shows  filters
      when :find then find_shows filters[:keyword]
    end
  end
end