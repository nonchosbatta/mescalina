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
  def initialize(show, field, episode)
    @show    = show
    @field   = field.to_sym
    @episode = episode
  end

  def urls_for(label, infos, *fillers)
    fillers = ([''] + fillers).join('/')

    [].tap do |url|
      infos.split(?+).each do |info|
        url << "<a href='/#/#{label}/#{info.strip}#{fillers}'>#{info}</a>"
      end
    end.join(' + ')
  end

  def render
    super

    data = @show.send @field
    if @field == :fansub
      element << urls_for(:fansubs, data)
    elsif Show.roles.include? @field
      element << urls_for(:users, data, @field)
      element.add_class(@episode.send(Show.to_task(@field)).to_s) if @episode
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