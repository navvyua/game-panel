class BugImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def default_url(*_args)
    ActionController::Base.helpers.asset_path('default_news_image.jpg')
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :middle do
    process resize_to_fit: [300, 300]
  end
end
