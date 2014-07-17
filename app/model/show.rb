#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Show < Vienna::Model
  adapter Vienna::LocalAdapter

  attributes :name, :tot_episodes, :fansub, :status, :stub
  attributes :translator, :editor, :checker, :timer, :typesetter, :encoder, :qchecker

  def info?
    tot_episodes
  end
    alias_method :infos?,     :info?
    alias_method :has_infos?, :info?

  class << self
    def roles
      [ :translator,  :editor,  :checker,  :timer,  :typesetter,  :encoder,  :qchecker  ]
    end

    def to_task(role)
      index = Show.roles.index role
      index ? Episode.tasks[index] : nil
    end
    
    def exclude?(field)
      [ :status, :stub ].include? field
    end

    def get(find_dat_show)
      shows = Show.all.select { |show| show[:name] == find_dat_show[:name] }
      shows.any? ? shows.first : nil
    end

    def exists?(show)
      !!Show.get(show)
    end

    def all!(filters)
      if filters.has_key? :fansub
        options = "/fansubs/#{filters[:fansub]}"
      elsif filters.has_key? :user
        if filters.has_key? :role
          options = "/users/#{filters[:user]}/#{filters[:role]}"
        else
          options = "/users/#{filters[:user]}"
        end
      end

      Database.get("/#{options}/shows/all/#{filters[:status]}") do |shows|
        shows.each do |res|
          show = {}

          Show.columns.each do |field|
            show[field.to_sym] = res[field] if res.has_key? field
          end

          if Show.exists? show
            Show.get(show).update stub: rand
          else
            Show.create show
          end

          yield Show.get show
        end
      end
    end

    def search!(show)
      Database.get("/shows/search/#{show}") do |shows|
        shows.each do |res|
          show = {}

          Show.columns.each do |field|
            show[field.to_sym] = res[field] if res.has_key? field
          end

          if Show.exists? show
            Show.get(show).update stub: rand
          else
            Show.create show
          end

          yield Show.get show
        end
      end
    end
  end
end
