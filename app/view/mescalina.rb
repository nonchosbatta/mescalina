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
      add_show show
      render
    }

    Show.on(:update) { |show|
      add_show show
      render
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

    planned = PlannedView.new
    planned.render
    Element.find('.planned') << planned.element
  end

  def add_show(show)
    view = ShowView.new show
    view.render
    Element.find('#mescalina') << view.element
  end

  def load(filters = {})
    filters[:status] ||= :ongoing
    filters[:fansub] ||= ''

    Element.find('.show-row').remove
    Show.all! filters[:status], filters[:fansub], -> (res) { Show.make Show.get_fields(res), filters }
  end
end