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
  element '#mescalina'

  def initialize
    Show.on(:create) { |show|
      render
    }

    Show.on(:update) { |show|
      add_show show
      render
    }
  end

  def add_show(show)
    view = ShowView.new show
    view.render
    Element.find('#mescalina') << view.element
  end

  def load
    Show.all! -> (res) { Show.make Show.get_fields(res) }
  end
end