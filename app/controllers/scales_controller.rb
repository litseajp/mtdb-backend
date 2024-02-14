class ScalesController < ApplicationController
  before_action :load_scales
  before_action :validate_scale, only: [:show]
  before_action :validate_tonic, only: [:show]

  def index
    response_data = []

    Constant::ScaleCategory.includes(:scales).find_each do |category|
      scales = category.scales.map { |scale| serialize_scale_for_index(scale) }
      response_data << { category: category.name, scales: }
    end

    render json: response_data
  end

  def show
    tonic = params[:tonic].to_s

    scale = @scales.find_by(path: params[:scale].to_s)
    mid_records = Constant::MidScaleInterval.where(scale_id: scale.id).includes(:interval, :tonetype)

    notes = Constant::Interval.calculate_notes_from_intervals(tonic, mid_records.map(&:interval))
    tones = mid_records.map.with_index { |mid_record, index| serialize_tone(mid_record, notes[index]) }

    response_data = serialize_scale_for_show(scale, tonic, tones)

    render json: response_data
  end

  private

  def load_scales
    @scales = Constant::Scale.all
  end

  def validate_scale
    return if @scales.pluck(:path).include?(params[:scale].to_s)

    render status: :bad_request, json: { error: 'Invalid scale parameter detected.' }
  end

  def validate_tonic
    return if TONIC_NOTES.include?(params[:tonic].to_s)

    render status: :bad_request, json: { error: 'Invalid tonic parameter detected.' }
  end

  def serialize_scale_for_index(scale)
    {
      'path' => scale.path,
      'name' => format_accidental(scale.name),
      'description' => format_description_for_index(scale.description)
    }
  end

  def format_accidental(string)
    string.gsub('sharp', '♯').gsub('flat', '♭')
  end

  def format_description_for_index(description)
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

  def serialize_tone(mid_record, note)
    {
      'interval' => mid_record.interval.name,
      'note' => note,
      'tonetype' => mid_record.tonetype.name
    }
  end

  def serialize_scale_for_show(scale, tonic, tones)
    {
      'name' => format_note(tonic) + format_accidental(scale.name),
      'description' => format_description_for_show(scale.description, tones),
      'tones' => tones
    }
  end

  def format_description_for_show(description, tones)
    description = format_accidental(description)
    description = replace_tone_numbers_with_notes(description, tones)
    replace_related_scale_references_with_links(description, tones)
  end

  def replace_tone_numbers_with_notes(description, tones)
    description.gsub(/\[(\d)\]/) do |_match|
      format_note(tones[$1.to_i]['note'])
    end
  end

  def replace_related_scale_references_with_links(description, tones)
    description.gsub(/\{tone_number:(\d),scale_id:(\d+)\}/) do |_match|
      generate_related_scale_link($1.to_i, $2.to_i, tones)
    end
  end

  def generate_related_scale_link(tone_number, scale_id, tones)
    related_scale_tonic = tones[tone_number]['note']
    related_scale = @scales[scale_id - 1]

    if TONIC_NOTES.include?(related_scale_tonic)
      "<a href=\"./#{related_scale.path}?tonic=#{related_scale_tonic}\">" \
      "#{format_note(related_scale_tonic)}#{format_accidental(related_scale.name)}</a>".html_safe
    else
      "#{format_note(related_scale_tonic)}#{format_accidental(related_scale.name)}"
    end
  end
end
