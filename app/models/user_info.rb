class UserInfo < ApplicationRecord
  belongs_to :user

  def description
    if self.details.blank?
      ""
    else
      detail = self.details
      ActionView::Base.full_sanitizer.sanitize(detail).truncate(100)
    end
  end
end
