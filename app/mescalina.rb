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
      router.route('/') do
        @mescalina.load
      end

      router.route('/ongoing') do
        @mescalina.load
      end

      router.route('/dropped') do
        @mescalina.load status: :dropped
      end

      router.route('/finished') do
        @mescalina.load status: :finished
      end

      router.route('/planned') do
        @mescalina.load status: :planned
      end

      router.route('/fansub/:fansub') do |params|
        @mescalina.load fansub: params[:fansub]
      end

      router.route('/fansub/:fansub/ongoing') do |params|
        @mescalina.load fansub: params[:fansub]
      end

      router.route('/fansub/:fansub/dropped') do |params|
        @mescalina.load fansub: params[:fansub], status: :dropped
      end

      router.route('/fansub/:fansub/finished') do |params|
        @mescalina.load fansub: params[:fansub], status: :finished
      end

      router.route('/fansub/:fansub/planned') do |params|
        @mescalina.load fansub: params[:fansub], status: :planned
      end
    end
  end
end

Document.ready? do
  Mescalina.new.run
end
