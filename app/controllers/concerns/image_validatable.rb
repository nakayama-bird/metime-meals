module ImageValidatable
  extend ActiveSupport::Concern

  def validate_images(images)
    return true if images.blank? || images.all?(&:blank?)

    inappropriate_images = identify_inappropriate_images(images)
    inappropriate_images.empty?
  end

  private

  def identify_inappropriate_images(images)
    images.reject do |image|
      Vision.image_analysis(image)
    end
  end
end
