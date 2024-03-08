class RoomPhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
    
    # version :standard do 
    #     process resize_to_fill: [200,200, :north]
    # end
    
    # version :thumb do
    #     process resize_to_fit: [50,50]
    # end

    version :display do
      process :eager => true
      process :resize_to_fill => [200, 200, :north]
    end
  
    version :thumbnail do
      process :eager => true
      process :resize_to_fit => [50, 50]
    end

    CarrierWave.configure do |config|
      # For an application which utilizes multiple servers but does not need caches persisted across requests,
      # uncomment the line :file instead of the default :storage.  Otherwise, it will use the default storage as the temp cache store.
      config.cache_storage = :file
     end
end
