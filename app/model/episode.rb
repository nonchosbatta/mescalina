#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Episode < Vienna::Model
  adapter Vienna::LocalAdapter

  attributes :download,    :episode, :show
  attributes :translation, :editing, :checking, :timing, :typesetting, :encoding, :qchecking

  def belongs_to?(show)
    @show.name == show.name
  end

  def download=(url)
    @download = url || ?#
  end

  class << self
    def get_fields(res)
      Array.new.tap { |data|
        [res.json].flatten.each { |show|
          data << Hash.new.tap { |fields|
            Episode.columns.each { |field|
              fields[field.to_sym] = show[field] if show.has_key?(field)
            }
          }
        }
      }
    end

    def of(show)
      Episode.all.select { |episode| episode.belongs_to? show }
    end

    def exists?(dat_episode)
      Episode.all.select { |episode|
        episode.show.name == dat_episode[:show].name &&
        episode.episode   == dat_episode[:episode]
      }.any?
    end

    def make(show, episodes)
      episodes.each { |episode|
        episode[:show] = show
        Episode.create(episode) unless Episode.exists? episode
      }
    end

    def all!(show, on_success = nil, on_failure = nil)
      Pigro.get "/shows/get/#{show}/episodes/all", on_success, on_failure
    end
  end
end
