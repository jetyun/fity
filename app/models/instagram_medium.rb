class InstagramMedium < ActiveRecord::Base
  
  belongs_to :user, class_name: InstagramUser, foreign_key: "user_id"

  def sync!(data)
    data.extend Hashie::Extensions::DeepFetch

    self.extra = data.to_h
    self.upcode = data["id"]
    self.caption_id =  data.deep_fetch("caption", "id") { "" }
    self.caption_text =  data.deep_fetch("caption", "text") { "" }

    self.likes_count =  data.deep_fetch("likes", "count") { 0 }
    self.comments_count =  data.deep_fetch("comments", "count") { 0 }

    self.attributes = data.slice("type", "link", "created_time")

    save!
  end
end
