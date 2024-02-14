class ChordsController < ApplicationController
  before_action :load_chords
  before_action :validate_chord, only: [:show]
  before_action :validate_root, only: [:show]

  def index
    response_data = []

    Constant::ChordCategory.includes(:chords).find_each do |category|
      chords = category.chords.map { |chord| serialize_chord_for_index(chord) }
      response_data << { category: category.name, chords: }
    end

    render json: response_data
  end

  def show
    root = params[:root].to_s

    chord = Constant::Chord.find_by(path: params[:chord].to_s)

    notes = Constant::Interval.calculate_notes_from_intervals(root, chord.intervals)
    tones = chord.intervals.zip(notes).map { |interval, note| serialize_tone(interval, note) }

    enharmonic_root = Constant::Interval.normalize_enharmonic_note(root)
    positions = Constant::ChordPosition.where(chord_id: chord.id, root: enharmonic_root).map { |position| serialize_position(position) }

    response_data = serialize_chord_for_show(chord, root, tones, positions)

    render json: response_data
  end

  private

  def load_chords
    @chords = Constant::Chord.all
  end

  def validate_chord
    return if @chords.pluck(:path).include?(params[:chord].to_s)

    render status: :bad_request, json: { error: 'Invalid chord parameter detected.' }
  end

  def validate_root
    return if TONIC_NOTES.include?(params[:root].to_s)

    render status: :bad_request, json: { error: 'Invalid root parameter detected.' }
  end

  def serialize_chord_for_index(chord)
    {
      'path' => chord.path,
      'quality' => chord.quality,
      'name' => chord.name,
      'description' => replace_related_chord_references_with_names(chord.description)
    }
  end

  def replace_related_chord_references_with_names(description)
    description.gsub(/\{chord_id:(\d+)\}/) do |_match|
      related_chord = @chords[$1.to_i - 1]
      "#{related_chord.name}コード"
    end
  end

  def serialize_tone(interval, note)
    {
      'interval' => interval.name,
      'note' => note
    }
  end

  def serialize_position(position)
    {
      'string1' => position.string1,
      'string2' => position.string2,
      'string3' => position.string3,
      'string4' => position.string4,
      'string5' => position.string5,
      'string6' => position.string6
    }
  end

  def serialize_chord_for_show(chord, root, tones, positions)
    {
      'name' => generate_chord_name(chord, root),
      'description' => replace_related_chord_references_with_links(chord.description, root),
      'tones' => tones,
      'positions' => positions
    }
  end

  def generate_chord_name(chord, root)
    case chord.quality
    when 'Maj'
      "#{format_note(root)}（#{format_note(root) + chord.name}）コード"
    when 'min'
      "#{format_note(root)}m（#{format_note(root) + chord.name}）コード"
    else
      "#{format_note(root) + chord.quality}（#{format_note(root) + chord.name}）コード"
    end
  end

  def replace_related_chord_references_with_links(description, root)
    description.gsub(/\{chord_id:(\d+)\}/) do |_match|
      generate_related_chord_link($1.to_i, root)
    end
  end

  def generate_related_chord_link(chord_id, root)
    related_chord = @chords[chord_id - 1]

    "<a href=\"./#{related_chord.path}?root=#{root}\">" \
    "#{generate_chord_name(related_chord, root)}</a>".html_safe
  end
end
