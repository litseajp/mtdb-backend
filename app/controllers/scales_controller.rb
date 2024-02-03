class ScalesController < ApplicationController
  before_action :load_scales

  def index
    response_data = []

    Constant::ScaleCategory.includes(:scales).find_each do |category|
      scales = category.scales.map { |scale| serialize_scale(scale) }
      response_data << { category: category.name, scales: }
    end

    render json: response_data
  end

  private

  def load_scales
    @scales = Constant::Scale.all
  end

  def serialize_scale(scale)
    {
      'path' => scale.path,
      'name' => format_accidental(scale.name),
      'description' => format_description(scale.description)
    }
  end

  def format_accidental(string)
    string.gsub('sharp', '♯').gsub('flat', '♭')
  end

  def format_description(description)
    description = remove_tone_numbers(description)
    description = replace_related_scale_references_with_names(description)

    format_accidental(description)
  end

  def remove_tone_numbers(description)
    description.gsub(/\[\d\]/, '')
  end

  def replace_related_scale_references_with_names(description)
    description.gsub(/\{tone_number:(\d),scale_id:(\d+)\}/) do |_match|
      related_scale = @scales[$2.to_i - 1]
      related_scale.name
    end
  end
end
