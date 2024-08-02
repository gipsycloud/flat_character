class UserInfo < ApplicationRecord
  belongs_to :user
  enum manner_categories_num: { relax: 1, roommates_belongings: 2, respect: 3, chores_equally: 4, pay_bill: 5, quiet_person: 6, messy_one: 7, serious_person: 8 }

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
