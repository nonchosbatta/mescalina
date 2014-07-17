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

  attributes :download, :episode, :show, :show_name
  attributes :translation, :editing, :checking, :timing, :typesetting, :encoding, :qchecking

  def belongs_to?(show)
    @show_name == show.name
  end

  def download=(url)
    @download = (!url || url.strip.empty?) ? '' : url
  end

  class << self
    def tasks
      [ :translation, :editing, :checking, :timing, :typesetting, :encoding, :qchecking ]
    end

    def to_role(task)
      index = Episode.tasks.index task
      index ? Show.roles[index] : nil
    end
    
    def of(show)
      Episode.all.select { |episode| episode.belongs_to? show }
    end

    def exists?(dat_episode)
      Episode.all.select do |episode|
        episode.show.name == dat_episode[:show].name &&
        episode.episode   == dat_episode[:episode]
      end.any?
    end

    def latest!(status = :ongoing)
      Database.get("/episodes/last/#{status}") do |episodes|
        if episodes.any?
          last_episode = []

          episodes.each do |res|
            episode = {}
            
            Episode.columns.each do |field|
              episode[field.to_sym] = res[field] if res.has_key? field
            end

            last_episode << Episode.new(episode)
          end

          yield last_episode
        else
          yield []
        end
      end
    end

    def all!(show)
      episodes = Episode.of show

      if episodes.any?
        yield episodes
      else
        Database.get("/episodes/#{show.name}") do |episodes|
          if episodes.any?
            episodes.each do |res|
              episode = { show: show }

              Episode.columns.each do |field|
                episode[field.to_sym] = res[field] if res.has_key? field
              end

              Episode.create episode
            end
            
            yield Episode.of show
          else
            yield []
          end
        end
      end
    end
  end
end
