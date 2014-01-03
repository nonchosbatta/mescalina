#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class ShowInfoView < Vienna::TemplateView
  def initialize(show, field)
    @show  = show
    @field = field
  end

  def render
    super
    
    element << @show.send(@field.to_sym)
  end

  def tag_name
    :td
  end
end