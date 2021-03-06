class UserLink < ApplicationRecord
  belongs_to :user
  belongs_to :link
  has_many :user_link_tags
  has_many :tags, through: :user_link_tags
  has_many :user_link_notes, dependent: :destroy
  validates_presence_of :user, :link, :user_id, :link_id

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def all_tags_array
    self.tags.map(&:name)
  end

  def add_tag(tag_name)
    @tag = Tag.new(name: tag_name)
    @user_link_tag = UserLinkTag.create(user_link: self, tag: @tag)
  end

  def add_note(content)
    @note = UserLinkNote.create(content: content, UserLink_id: self.id)
  end

  def all_notes
    @notes = UserLinkNote.find_by(UserLink_id: self.id)
  end

end
