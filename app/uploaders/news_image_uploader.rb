class NewsImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*_args)
    ActionController::Base.helpers.asset_path('default_news_image.png')
  end

  version :big do
    process resize_to_fit: [600, 600]
  end
end
