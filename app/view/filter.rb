#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class OngoingView < Vienna::View
  element '#ongoing'

  on :click do
    url = `window.location.href`

    if url.include? '/fansub/'
      url = url.gsub /\/(ongoing|finished|dropped|planned)/, ''
      `window.location.href = url + '/ongoing'`
    else
      `window.location.href = '#/ongoing'`
    end
  end
end

class FinishedView < Vienna::View
  element '#finished'

  on :click do
    url = `window.location.href`

    if url.include? '/fansub/'
      url = url.gsub /\/(ongoing|finished|dropped|planned)/, ''
      `window.location.href = url + '/finished'`
    else
      `window.location.href = '#/finished'`
    end
  end
end

class DroppedView < Vienna::View
  element '#dropped'

  on :click do
    url = `window.location.href`

    if url.include? '/fansub/'
      url = url.gsub /\/(ongoing|finished|dropped|planned)/, ''
      `window.location.href = url + '/dropped'`
    else
      `window.location.href = '#/dropped'`
    end
  end
end

class PlannedView < Vienna::View
  element '#planned'

  on :click do
    url = `window.location.href`

    if url.include? '/fansub/'
      url = url.gsub /\/(ongoing|finished|dropped|planned)/, ''
      `window.location.href = url + '/planned'`
    else
      `window.location.href = '#/planned'`
    end
  end
end