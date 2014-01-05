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
      can = true
      $filters.each_pair { |k, v| can = false if show.send(k) != v }
      if can
        add_show show
        render
      end
    }

    ongoing = OngoingView.new
    ongoing.render
    Element.find('.ongoing') << ongoing.element

    finished = FinishedView.new
    finished.render
    Element.find('.finished') << finished.element

    dropped = DroppedView.new
    dropped.render
    Element.find('.dropped') << dropped.element
  end

  def add_show(show)
    view = ShowView.new show
    view.render
    Element.find('#mescalina') << view.element
  end

  def load(filters = { status: :ongoing })
    $filters = filters
    Element.find('.show-row').remove
    Show.all! -> (res) { Show.make Show.get_fields(res) }
  end
end