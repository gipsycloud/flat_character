require "test_helper"

class CloudinaryDeleteSafetyTest < ActiveSupport::TestCase
  class FailingDeleteUploader < AvatarUploader
    def perform_delete!(_new_file = nil)
      raise Cloudinary::Api::Error, "Request forbidden due to missing permissions"
    end
  end

  test "delete! swallows Cloudinary permission errors" do
    uploader = FailingDeleteUploader.new

    assert_nothing_raised do
      assert uploader.delete!
    end
  end
end
