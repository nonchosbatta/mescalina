#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Pigro
  HOST = 'http://pigro.omnivium.it:4567/api/v1'

  def self.get(url, on_success = nil, on_failure = nil)
    url = url.start_with?(?/) ? "#{HOST}#{url}" : url
    
    HTTP.get(url) do |res|
      if res.ok?
        on_success.call res if on_success
      else
        on_failure.call res if on_failure
      end
    end
  end
end