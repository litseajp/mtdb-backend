class AvailableChordsController < ApplicationController
  def index
    response_data = []
  
    major_keys = generate_keys_data('major', ['', 'm', 'm', '', '', 'm', 'm-5'])
    response_data << { category: 'メジャーキー', keys: major_keys }
  
    minor_keys = generate_keys_data('minor', ['m', 'm-5', '', 'm', 'm', '', ''])
    response_data << { category: 'マイナーキー', keys: minor_keys }
  
    render json: response_data
  end
  
  private
  
  def generate_keys_data(majmin, diatonic_qualities)  
    path, keys, majmin_ja = majmin == 'major' ? ['major', MAJOR_KEYS, 'メジャー'] : ['natural-minor', MINOR_KEYS, 'マイナー']
  
    scale = Constant::Scale.find_by(path: path)
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
end
