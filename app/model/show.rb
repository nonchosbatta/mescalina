#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++
require 'vienna/adapters/local'

class Show < Vienna::Model
  adapter Vienna::LocalAdapter

  attributes :name, :tot_episodes, :status, :airing
  attributes :translator, :editor, :checker, :timer, :typesetter, :encoder, :qchecker

  def info?
    tot_episodes
  end
    alias_method :infos?,     :info?
    alias_method :has_infos?, :info?

  class << self
    def get_fields(res)
      Array.new.tap { |data|
        [res.json].flatten.each { |show|
          data << Hash.new.tap { |fields|
            Show.columns.each { |field|
              fields[field.to_sym] = show[field] if show.has_key?(field)
            }
          }
        }
      }
    end

    def make(fields)
      fields.each { |data|
        current = Show.all.select { |show| show['name'] == data[:name] }

        if current.any?
          current.each { |show|
            show.update data
          }
        else
          Show.create data
          Show.all.each { |show|
            Show.get! show.name, ->(res) { Show.make get_fields(res) }
          }
        end
      }
    end

    def all!(on_success = nil, on_failure = nil)
      Pigro.get '/shows/all',               on_success, on_failure
    end

    def search!(keyword, on_success = nil, on_failure = nil)
      Pigro.get "/shows/search/#{keyword}", on_success, on_failure
    end

    def get!(show, on_success = nil, on_failure = nil)
      Pigro.get "/shows/get/#{show}",       on_success, on_failure
    end
  end
end
