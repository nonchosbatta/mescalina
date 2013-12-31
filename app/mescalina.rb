#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Mescalina
  def run
    @mescalina = MescalinaView.new
    router.update
  end

  def router
    @router ||= Vienna::Router.new.tap do |router|
      router.route('/') do |params|
        @mescalina.load
      end
    end
  end
end

Document.ready? do
  Mescalina.new.run
end
