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
  def initialize
    %w(ongoing finished dropped planned).each { |id|
      Element["##{id}"].on :click do |e|
        e.prevent_default
        url = `window.location.href`

        if url.include?('/fansubs/') || url.include?('/users/')
          url = url.gsub /\/(ongoing|finished|dropped|planned)/, ''
          str = "#{url}/#{id}"
        elsif url.include? '/search/'
          str = false           
        else
          str = "#/#{id}"
        end
        `window.location.href = str` if str
      end
    }

    Element['#get-stats'].on :click do |e|
      e.prevent_default
      get_stats
    end
  end

  def find_shows(filters)
    load_shows filters, ->(filters, &block) { Show.search!(filters[:keyword], &block) }
  end

  def get_shows(filters)
    load_shows filters, ->(filters, &block) { Show.all!(filters, &block) }
  end

  def get_stats
    Show.stats! do |stats|
      stats.each do |stat|
        view = StatsView.new stat
        view.render
        Element['#stat'] << view.element
      end
      
      `$('#stats').modal();`
    end
  end

  def load(what, filters = {})
    filters[:status] ||= :ongoing

    Element.find('.show-row').remove
    SearchView.new.element
    SearchButtonView.new.element

    what = :get if (`what === undefined` || what != :stats) && (!filters.has_key?(:keyword) || filters[:keyword].empty?)
    case what
      when :get   then get_shows  filters
      when :find  then find_shows filters
      when :stats then get_stats
    end
  end

private
  def load_shows(filters, show_method)
    Episode.latest!(filters[:status]) do |episodes|
      show_method.call(filters) do |show|
        view = ShowView.new show, episodes.select { |ep| ep.belongs_to? show }.first
        view.render

        airing_status = show.airing ? 'airing' : 'finished'
        Element["#mescalina-#{airing_status}"] << view.element
      end
    end
  end
end
