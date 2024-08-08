require "test_helper"

class RoomMailerTest < ActionMailer::TestCase
  test "user_added_to_room" do
    mail = RoomMailer.user_added_to_room
    assert_equal "User added to room", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
