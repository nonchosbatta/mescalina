#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Database
  HOST = 'http://pigro.omnivium.it:4567/api/v1'

  def self.get(url)
    url = url.start_with?(?/) ? "#{HOST}#{url}" : url
    
    HTTP.get(url) do |res|
      yield [res.json].flatten
    end
  end
end