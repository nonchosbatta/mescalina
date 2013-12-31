#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class ShowView < Vienna::TemplateView
  def initialize(show)
    @show = show
  end

  def remove
    element.remove
  end

  def render
    super

    Show.columns.each { |field|
      view = ShowInfoView.new @show, field
      view.render
      element << view.element
    }
  end

  def tag_name
    :tr
  end
end