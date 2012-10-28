if defined?(GravatarImageTag)
  GravatarImageTag.configure do |config|
    config.default_image           = nil   # Set this to use your own default gravatar image rather then serving up Gravatar's default image [ 'http://example.com/images/default_gravitar.jpg', :identicon, :monsterid, :wavatar, 404 ].
    config.filetype                = nil
    config.include_size_attributes = true  # The height and width attributes of the generated img will be set to avoid page jitter as the gravatars load.  Set to false to leave these attributes off.
    config.rating                  = nil
    config.size                    = 16
    config.secure                  = false # Set this to true if you require secure images on your pages.
  end
end
