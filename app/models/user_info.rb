class UserInfo < ApplicationRecord
  belongs_to :user

  validates :details, presence: true

  def description
    if self.details.blank?
      ""
    else
      detail = self.details
      ActionView::Base.full_sanitizer.sanitize(detail).truncate(100)
    end
  end
end
