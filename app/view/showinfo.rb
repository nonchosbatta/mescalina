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
    @field = field.to_sym
  end

  def render
    super

    data = @show.send @field
    if @field == :fansub
      element << "<a href='/#/fansubs/#{data}'>#{data}</a>"
    elsif Show.roles.include? @field
      element << "<a href='/#/users/#{data}/#{@field}'>#{data}</a>"
    else
      element << data
    end
  end

  def tag_name
    :td
  end

  def class_name
    @field.to_s
  end
end