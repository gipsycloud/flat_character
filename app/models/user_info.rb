class UserInfo < ApplicationRecord
  belongs_to :user
  MANNER_CATEGORIES = {
    relax: "relax",
    roommates_belongings: "roommates_belongings",
    respect: "respect",
    chores_equally: "chores_equally",
    pay_bill: "pay_bill",
    quiet_person: "quiet_person",
    messy_one: "messy_one",
    serious_person: "serious_person"
  }.freeze

  # Compatibility name used by the profile form. The persisted attribute is
  # the string array `manner_categories`, not an enum column.
  def self.manner_categories_nums
    MANNER_CATEGORIES
  end

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
