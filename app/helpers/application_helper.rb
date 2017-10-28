module ApplicationHelper
  def gravatar_for(user, options={size:200})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    taille = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{taille}"


    image_tag(gravatar_url, alt: user.username)
    
  end

end
