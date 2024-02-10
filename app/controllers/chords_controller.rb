class ChordsController < ApplicationController
  before_action :load_chords

  def index
    response_data = []

    Constant::ChordCategory.includes(:chords).find_each do |category|
      chords = category.chords.map { |chord| serialize_chord_for_index(chord) }
      response_data << { category: category.name, chords: }
    end

    render json: response_data
  end

  private

  def load_chords
    @chords = Constant::Chord.all
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
end
