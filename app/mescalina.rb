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

      router.route('/:status') do |params|
        @mescalina.load :get, status: params[:status]
      end

      router.route('/search/:keyword') do |params|
        @mescalina.load :find, keyword: params[:keyword]
      end

      router.route('/fansubs/:fansub') do |params|
        @mescalina.load :get, fansub: params[:fansub]
      end

      router.route('/fansubs/:fansub/:status') do |params|
        @mescalina.load :get, status: params[:status], fansub: params[:fansub]
      end

      router.route('/users/:user/:role') do |params|
        @mescalina.load :get, user: params[:user], role: params[:role].to_sym
      end

      router.route('/users/:user/:role/:status') do |params|
        @mescalina.load :get, status: params[:status], user: params[:user], role: params[:role].to_sym
      end
    end
  end
end

Document.ready? do
  Mescalina.new.run
end
