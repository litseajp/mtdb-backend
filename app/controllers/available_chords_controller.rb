class AvailableChordsController < ApplicationController
  before_action :validate_key, only: [:show]

  def index
    response_data = []

    major_keys = generate_keys_data('major', ['', 'm', 'm', '', '', 'm', 'm-5'])
    response_data << { category: 'メジャーキー', keys: major_keys }

    minor_keys = generate_keys_data('minor', ['m', 'm-5', '', 'm', 'm', '', ''])
    response_data << { category: 'マイナーキー', keys: minor_keys }

    render json: response_data
  end

  def show
    tonic, majmin = params[:key].to_s.split('-')
    available_chord_categories = []

    reference_chromatic_notes = Constant::Interval.generate_reference_chromatic_notes(tonic)
    reference_alphabetical_notes = Constant::Interval.generate_reference_alphabetical_notes(tonic)

    Constant::AvailableChordCategory.where(majmin:)
                                    .eager_load(available_chord_groups: [:degree, { degree: :interval }])
                                    .preload(:available_chord_groups, available_chord_groups: :chords)
                                    .find_each do |category|
      available_chord_categories << generate_category_hash(category, reference_chromatic_notes, reference_alphabetical_notes)
    end

    response_data = serialize_available_chords(tonic, majmin, available_chord_categories)

    render json: response_data
  end

  private

  def validate_key
    root, majmin = params[:key].to_s.split('-')

    return if (MAJOR_KEYS.include?(root) && majmin == 'major') || (MINOR_KEYS.include?(root) && majmin == 'minor')

    render status: :bad_request, json: { error: 'Invalid key detected.' }
  end

  def generate_keys_data(majmin, diatonic_qualities)
    path, keys, majmin_ja = majmin == 'major' ? ['major', MAJOR_KEYS, 'メジャー'] : ['natural-minor', MINOR_KEYS, 'マイナー']

    scale = Constant::Scale.find_by(path:)
    mid_records = Constant::MidScaleInterval.where(scale_id: scale.id).includes(:interval)

    keys.map do |key|
      notes = Constant::Interval.calculate_notes_from_intervals(key, mid_records.map(&:interval))
      {
        path: "#{key}-#{majmin}",
        name: format_note(key) + majmin_ja,
        diatonic: generate_diatonic_sequence(notes, diatonic_qualities)
      }
    end
  end

  def generate_diatonic_sequence(notes, diatonic_qualities)
    notes.map.with_index do |note, index|
      format_note(note) + diatonic_qualities[index]
    end
  end

  def generate_category_hash(category, reference_chromatic_notes, reference_alphabetical_notes)
    degrees = []

    category.available_chord_groups.each do |group|
      degrees << generate_degree_hash(group, reference_chromatic_notes, reference_alphabetical_notes)
    end

    { name: category.name, degrees: }
  end

  def generate_degree_hash(group, reference_chromatic_notes, reference_alphabetical_notes)
    root = Constant::Interval.calculate_note_from_interval(reference_chromatic_notes, reference_alphabetical_notes, group.degree.interval)
    root = normalize_note_with_double_symbols(root, group.degree.name)

    chords = group.chords.map do |chord|
      { path: chord.path, name: chord.quality }
    end

    { degree: group.degree.name, function: group.function, root:, chords: }
  end

  def normalize_note_with_double_symbols(note, degree)
    return note unless note.include?('double')

    enharmonic_note = Constant::Interval.normalize_enharmonic_note(note)
    index = CHROMATIC_NOTES_SHARP.index(enharmonic_note)

    if degree.include?('♯')
      enharmonic_note
    elsif degree.include?('♭')
      CHROMATIC_NOTES_FLAT[index]
    else
      CHROMATIC_NOTES_CO5[index]
    end
  end

  def format_quality(quality)
    case quality
    when 'Maj'
      ''
    when 'min'
      'm'
    else
      quality
    end
  end

  def serialize_available_chords(tonic, majmin, categories)
    key = "#{format_note(tonic)}#{majmin == 'major' ? 'メジャー' : 'マイナー'}キー"

    { key:, categories: }
  end
end
