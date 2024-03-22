module Constant
  class Interval < ApplicationRecord
    def self.calculate_notes_from_intervals(tonic, intervals)
      notes = []

      reference_chromatic_notes = generate_reference_chromatic_notes(tonic)
      reference_alphabetical_notes = generate_reference_alphabetical_notes(tonic)

      intervals.each do |interval|
        notes <<
          if interval.semitone_distance.zero?
            tonic
          else
            calculate_note_from_interval(reference_chromatic_notes, reference_alphabetical_notes, interval)
          end
      end

      notes
    end

    def self.generate_reference_chromatic_notes(tonic)
      if CHROMATIC_NOTES_SHARP.include?(tonic)
        rotate_notes_to_start_with_target_note(CHROMATIC_NOTES_SHARP, tonic)
      elsif %w[dflat eflat gflat aflat bflat].include?(tonic)
        rotate_notes_to_start_with_target_note(CHROMATIC_NOTES_FLAT, tonic)
      elsif tonic == 'esharp'
        chromatic_notes = CHROMATIC_NOTES_SHARP.map { |note| note == 'f' ? 'esharp' : note }
        rotate_notes_to_start_with_target_note(chromatic_notes, tonic)
      elsif tonic == 'bsharp'
        chromatic_notes = CHROMATIC_NOTES_SHARP.map { |note| note == 'c' ? 'bsharp' : note }
        rotate_notes_to_start_with_target_note(chromatic_notes, tonic)
      elsif tonic == 'fflat'
        chromatic_notes = CHROMATIC_NOTES_FLAT.map { |note| note == 'e' ? 'fflat' : note }
        rotate_notes_to_start_with_target_note(chromatic_notes, tonic)
      else
        chromatic_notes = CHROMATIC_NOTES_FLAT.map { |note| note == 'b' ? 'cflat' : note }
        rotate_notes_to_start_with_target_note(chromatic_notes, tonic)
      end
    end

    def self.rotate_notes_to_start_with_target_note(notes, target_note)
      index = notes.index(target_note)
      notes.slice(index..-1) + notes.slice(0, index)
    end

    def self.generate_reference_alphabetical_notes(tonic)
      alphabets = %w[c d e f g a b]
      rotate_notes_to_start_with_target_note(alphabets, tonic[0])
    end

    def self.calculate_note_from_interval(reference_chromatic_notes, reference_alphabetical_notes, interval)
      base_note = reference_chromatic_notes[interval.semitone_distance]
      target_alphabet = reference_alphabetical_notes[interval.alphabet_distance]

      calculate_enharmonic_note_with_target_alphabet(base_note, target_alphabet)
    end

    def self.calculate_enharmonic_note_with_target_alphabet(base_note, target_alphabet)
      enharmonic_base_note = normalize_enharmonic_note(base_note)
      rotated_chromatic_notes = rotate_notes_to_start_with_target_note(CHROMATIC_NOTES_SHARP, enharmonic_base_note)
      rotated_chromatic_notes.unshift(*rotated_chromatic_notes.pop(2))

      semitone_distance = rotated_chromatic_notes.index(target_alphabet) - rotated_chromatic_notes.index(enharmonic_base_note)
      determine_enharmonic_note_with_target_alphabet(base_note, target_alphabet, semitone_distance)
    end

    def self.determine_enharmonic_note_with_target_alphabet(base_note, target_alphabet, semitone_distance)
      case semitone_distance
      when 0
        target_alphabet
      when -1
        "#{target_alphabet}sharp"
      when -2
        "#{target_alphabet}doublesharp"
      when 1
        "#{target_alphabet}flat"
      when 2
        "#{target_alphabet}doubleflat"
      else
        base_note
      end
    end

    def self.normalize_enharmonic_note(note)
      if note.include?('doublesharp')
        note[0] == 'b' ? 'csharp' : CHROMATIC_NOTES_SHARP[CHROMATIC_NOTES_SHARP.index(note[0]) + 2]
      elsif note.include?('doubleflat')
        note[0] == 'c' ? 'asharp' : CHROMATIC_NOTES_SHARP[CHROMATIC_NOTES_SHARP.index(note[0]) - 2]
      elsif note.include?('flat')
        note[0] == 'c' ? 'b' : CHROMATIC_NOTES_SHARP[CHROMATIC_NOTES_SHARP.index(note[0]) - 1]
      elsif note == 'esharp'
        'f'
      elsif note == 'bsharp'
        'c'
      else
        note
      end
    end
  end
end
