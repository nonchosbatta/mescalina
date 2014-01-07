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

        if url.include? '/fansub/'
          url = url.gsub /\/(ongoing|finished|dropped|planned)/, ''
          str = "#{url}/#{id}"
        else
          str = "#/#{id}"
        end
        `window.location.href = str`
      end
    }
  end

  def load(filters = {})
    filters[:status] ||= :ongoing
    filters[:fansub] ||= ''

    Element.find('.show-row').remove

    Show.all!(filters[:status], filters[:fansub]) { |show|
      view = ShowView.new show
      view.render
      Element.find('#mescalina') << view.element
    }
  end
end