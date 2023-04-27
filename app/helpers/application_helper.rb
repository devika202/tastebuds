module ApplicationHelper
    def gravatar_for(user, options = { size: 80 })
      if user.nil?
        username = "Unknown user"
        email = ""
      else
        username = user.username.downcase
        email = user.email.downcase
      end
      hash = Digest::MD5.hexdigest(email)
      size = options[:size]
      gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
      image_tag(gravatar_url, alt: username, class: "rounded shadow mx-auto d-block")
    end
  end
  