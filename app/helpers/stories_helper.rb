module StoriesHelper
#   def video_url(object, thumb = :small)
#     path = File.join(RAILS_ROOT, "public", "uploads", object.photo.path(thumb)) rescue ''
#     if File.exists? path
#       link_to(image_tag("../uploads/" + object.photo.path(thumb)), "../uploads/" + object.photo.path(:original))
#     else
#       link_to(image_tag(object.photo.url(thumb)), object.photo.url(:original))
#     end
#   end
end
