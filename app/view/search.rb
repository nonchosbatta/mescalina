#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class SearchView < Vienna::View
  element '#keyword'

  search_term_control = ''
  search = -> do
    search_term = Element[self.element].value
    if search_term != search_term_control
      search_term_control = search_term

      if search_term.strip.empty?
        $mescalina.load
      else
        $mescalina.load :find, keyword: search_term
      end
    end
  end

  initialized = false
  on :keydown do
    unless initialized
      search!
      initialized = true
    end
  end

  def search!
    `setInterval(search, 700)`
  end
end

class SearchButtonView < Vienna::View
  element '#search'

  on :click do
    search_term = Element['#keyword'].value
    Vienna::Router.new.navigate "/search/#{search_term}"
  end
end
