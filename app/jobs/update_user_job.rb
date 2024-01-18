class UpdateUserJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Do something later
    return unless user.email.blank?
    user.update_column(:verified, true)
  end
end
