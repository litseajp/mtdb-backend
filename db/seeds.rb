Constant::Interval.create!(
  [
    { id: 1, name: 'perfect1st', semitone_distance: 0, alphabet_distance: 0 },
    { id: 2, name: 'minor2nd', semitone_distance: 1, alphabet_distance: 1 },
    { id: 3, name: 'major2nd', semitone_distance: 2, alphabet_distance: 1 },
    { id: 4, name: 'minor3rd', semitone_distance: 3, alphabet_distance: 2 },
    { id: 5, name: 'major3rd', semitone_distance: 4, alphabet_distance: 2 },
    { id: 6, name: 'diminished4th', semitone_distance: 4, alphabet_distance: 3 },
    { id: 7, name: 'perfect4th', semitone_distance: 5, alphabet_distance: 3 },
    { id: 8, name: 'augmented4th', semitone_distance: 6, alphabet_distance: 3 },
    { id: 9, name: 'diminished5th', semitone_distance: 6, alphabet_distance: 4 },
    { id: 10, name: 'perfect5th', semitone_distance: 7, alphabet_distance: 4 },
    { id: 11, name: 'augmented5th', semitone_distance: 8, alphabet_distance: 4 },
    { id: 12, name: 'minor6th', semitone_distance: 8, alphabet_distance: 5 },
    { id: 13, name: 'major6th', semitone_distance: 9, alphabet_distance: 5 },
    { id: 14, name: 'diminished7th', semitone_distance: 9, alphabet_distance: 6 },
    { id: 15, name: 'minor7th', semitone_distance: 10, alphabet_distance: 6 },
    { id: 16, name: 'major7th', semitone_distance: 11, alphabet_distance: 6 },
    { id: 17, name: 'flat9th', semitone_distance: 1, alphabet_distance: 1 },
    { id: 18, name: '9th', semitone_distance: 2, alphabet_distance: 1 },
    { id: 19, name: 'sharp9th', semitone_distance: 3, alphabet_distance: 1 },
    { id: 20, name: '11th', semitone_distance: 5, alphabet_distance: 3 },
    { id: 21, name: 'sharp11th', semitone_distance: 6, alphabet_distance: 3 },
    { id: 22, name: 'flat13th', semitone_distance: 8, alphabet_distance: 5 },
    { id: 23, name: '13th', semitone_distance: 9, alphabet_distance: 5 }
  ]
)

Constant::ScaleCategory.create!(
  [
    { id: 1, name: '基本的なスケール' },
    { id: 2, name: 'モードスケール（メジャー/ナチュラルマイナー）' },
    { id: 3, name: 'モードスケール（ハーモニックマイナー）' },
    { id: 4, name: 'モードスケール（メロディックマイナー）' },
    { id: 5, name: 'ペンタトニック/ブルーススケール' },
    { id: 6, name: 'シンメトリカルスケール' },
    { id: 7, name: 'その他のスケール' }
  ]
)

Constant::ScaleTonetype.create!(
  [
    { id: 1, name: 'コードトーン' },
    { id: 2, name: 'テンションノート' },
    { id: 3, name: 'アボイドノート' },
    { id: 4, name: 'ブルーノート' },
    { id: 5, name: 'パッシングノート' }
  ]
)

Constant::Scale.create!(
  [
    # 基本的なスケール
    { id: 1, scale_category_id: 1, path: 'major', name: 'メジャースケール',
      description: '主音[0]から全音-全音-半音-全音-全音-全音-半音の間隔で並ぶスケール。' },
    { id: 2, scale_category_id: 1, path: 'natural-minor', name: 'ナチュラルマイナースケール',
      description: '主音[0]から全音-半音-全音-全音-半音-全音-全音の間隔で並ぶスケール。' },
    { id: 3, scale_category_id: 1, path: 'harmonic-minor', name: 'ハーモニックマイナースケール',
      description: '{tone_number:0,scale_id:2}の第７音を半音上げて作られるスケール。' },
    { id: 4, scale_category_id: 1, path: 'melodic-minor', name: 'メロディックマイナースケール',
      description: '{tone_number:0,scale_id:3}の第６音を半音上げて作られるスケール。' },
    # モードスケール（メジャー/ナチュラルマイナー）
    { id: 5, scale_category_id: 2, path: 'ionian', name: 'アイオニアンスケール',
      description: '{tone_number:0,scale_id:1}の主音、または{tone_number:5,scale_id:2}の第３音から始まるモードスケール。' },
    { id: 6, scale_category_id: 2, path: 'dorian', name: 'ドリアンスケール',
      description: '{tone_number:6,scale_id:1}の第２音、または{tone_number:4,scale_id:2}の第４音から始まるモードスケール。' },
    { id: 7, scale_category_id: 2, path: 'phrygian', name: 'フリジアンスケール',
      description: '{tone_number:5,scale_id:1}の第３音、または{tone_number:3,scale_id:2}の第５音から始まるモードスケール。' },
    { id: 8, scale_category_id: 2, path: 'lydian', name: 'リディアンスケール',
      description: '{tone_number:4,scale_id:1}の第４音、または{tone_number:2,scale_id:2}の第６音から始まるモードスケール。' },
    { id: 9, scale_category_id: 2, path: 'mixolydian', name: 'ミクソリディアンスケール',
      description: '{tone_number:3,scale_id:1}の第５音、または{tone_number:1,scale_id:2}の第７音から始まるモードスケール。' },
    { id: 10, scale_category_id: 2, path: 'aeolian', name: 'エオリアンスケール',
      description: '{tone_number:2,scale_id:1}の第６音、または{tone_number:0,scale_id:2}の主音から始まるモードスケール。' },
    { id: 11, scale_category_id: 2, path: 'locrian', name: 'ロクリアンスケール',
      description: '{tone_number:1,scale_id:1}の第７音、または{tone_number:6,scale_id:2}の第２音から始まるモードスケール。' },
    # モードスケール（ハーモニックマイナー）
    { id: 12, scale_category_id: 3, path: 'locrian-sharp6', name: 'ロクリアンsharp6スケール',
      description: '{tone_number:6,scale_id:3}の第２音から始まるモードスケール。' },
    { id: 13, scale_category_id: 3, path: 'ionian-sharp5', name: 'アイオニアンsharp5スケール',
      description: '{tone_number:5,scale_id:3}の第３音から始まるモードスケール。' },
    { id: 14, scale_category_id: 3, path: 'dorian-sharp4', name: 'ドリアンsharp4スケール',
      description: '{tone_number:4,scale_id:3}の第４音から始まるモードスケール。' },
    { id: 15, scale_category_id: 3, path: 'phrygian-dominant', name: 'フリジアンドミナントスケール',
      description: '{tone_number:3,scale_id:3}の第５音から始まるモードスケール。' },
    { id: 16, scale_category_id: 3, path: 'lydian-sharp2', name: 'リディアンsharp2スケール',
      description: '{tone_number:2,scale_id:3}の第６音から始まるモードスケール。' },
    { id: 17, scale_category_id: 3, path: 'super-locrian-flat7', name: 'スーパーロクリアンflat7スケール',
      description: '{tone_number:1,scale_id:3}の第７音から始まるモードスケール。' },
    # モードスケール（メロディックマイナー）
    { id: 18, scale_category_id: 4, path: 'phrygian-sharp6', name: 'フリジアンsharp6スケール',
      description: '{tone_number:6,scale_id:4}の第２音から始まるモードスケール。' },
    { id: 19, scale_category_id: 4, path: 'lydian-sharp5', name: 'リディアンsharp5スケール',
      description: '{tone_number:5,scale_id:4}の第３音から始まるモードスケール。' },
    { id: 20, scale_category_id: 4, path: 'mixolydian-sharp4', name: 'ミクソリディアンsharp4スケール',
      description: '{tone_number:4,scale_id:4}の第４音から始まるモードスケール。' },
    { id: 21, scale_category_id: 4, path: 'aeolian-dominant', name: 'エオリアンドミナントスケール',
      description: '{tone_number:3,scale_id:4}の第５音から始まるモードスケール。' },
    { id: 22, scale_category_id: 4, path: 'locrian-sharp2', name: 'ロクリアンsharp2スケール',
      description: '{tone_number:2,scale_id:4}の第６音から始まるモードスケール。' },
    { id: 23, scale_category_id: 4, path: 'super-locrian', name: 'スーパーロクリアンスケール',
      description: '{tone_number:1,scale_id:4}の第７音から始まるモードスケール。' },
    # ペンタトニック/ブルーススケール
    { id: 24, scale_category_id: 5, path: 'major-pentatonic', name: 'メジャーペンタトニックスケール',
      description: '{tone_number:0,scale_id:1}の第４音，第７音を省略したスケール。' },
    { id: 25, scale_category_id: 5, path: 'minor-pentatonic', name: 'マイナーペンタトニックスケール',
      description: '{tone_number:0,scale_id:2}の第２音，第６音を省略したスケール。' },
    { id: 26, scale_category_id: 5, path: 'major-blues', name: 'メジャーブルーススケール',
      description: '{tone_number:0,scale_id:24}に短３度の音を加えたスケール。' },
    { id: 27, scale_category_id: 5, path: 'minor-blues', name: 'マイナーブルーススケール',
      description: '{tone_number:0,scale_id:25}に減５度の音を加えたスケール。' },
    # シンメトリカルスケール
    { id: 28, scale_category_id: 6, path: 'whole-tone', name: 'ホールトーンスケール',
      description: '主音[0]から全音の間隔で均等に並ぶスケール。' },
    { id: 29, scale_category_id: 6, path: 'diminished', name: 'ディミニッシュスケール',
      description: '主音[0]から全音-半音-全音-半音-全音-半音-全音の間隔で並ぶスケール。' },
    { id: 30, scale_category_id: 6, path: 'dominant-diminished', name: 'ドミナントディミニッシュスケール',
      description: '主音[0]から半音-全音-半音-全音-半音-全音-半音の間隔で並ぶスケール。' },
    # その他のスケール
    { id: 31, scale_category_id: 7, path: 'altered', name: 'オルタードスケール',
      description: '主音[0]から半音-全音-半音-全音-全音-全音-全音の間隔で並ぶ、flat9，sharp9，sharp11，flat13が含まれたスケール。' },
    { id: 32, scale_category_id: 7, path: 'bebop-dominant', name: 'ビバップドミナントスケール',
      description: '{tone_number:0,scale_id:9}に長７度の音を加えたスケール。' }
  ]
)

[
  { scale_id: 1, intervals: [1, 18, 5, 20, 10, 13, 16], tone_types: [1, 2, 1, 3, 1, 1, 1] },
  { scale_id: 2, intervals: [1, 18, 4, 20, 10, 22, 15], tone_types: [1, 2, 1, 2, 1, 3, 1] },
  { scale_id: 3, intervals: [1, 18, 4, 20, 10, 22, 16], tone_types: [1, 2, 1, 2, 1, 3, 1] },
  { scale_id: 4, intervals: [1, 18, 4, 20, 10, 13, 16], tone_types: [1, 2, 1, 2, 1, 1, 1] },
  { scale_id: 5, intervals: [1, 18, 5, 20, 10, 13, 16], tone_types: [1, 2, 1, 3, 1, 1, 1] },
  { scale_id: 6, intervals: [1, 18, 4, 20, 10, 23, 15], tone_types: [1, 2, 1, 2, 1, 3, 1] },
  { scale_id: 7, intervals: [1, 17, 4, 20, 10, 22, 15], tone_types: [1, 3, 1, 2, 1, 3, 1] },
  { scale_id: 8, intervals: [1, 18, 5, 21, 10, 13, 16], tone_types: [1, 2, 1, 2, 1, 1, 1] },
  { scale_id: 9, intervals: [1, 18, 5, 20, 10, 23, 15], tone_types: [1, 2, 1, 3, 1, 2, 1] },
  { scale_id: 10, intervals: [1, 18, 4, 20, 10, 22, 15], tone_types: [1, 2, 1, 2, 1, 3, 1] },
  { scale_id: 11, intervals: [1, 17, 4, 20, 9, 22, 15], tone_types: [1, 3, 1, 2, 1, 2, 1] },
  { scale_id: 12, intervals: [1, 17, 4, 20, 9, 23, 15], tone_types: [1, 3, 1, 2, 1, 2, 1] },
  { scale_id: 13, intervals: [1, 18, 5, 20, 11, 13, 16], tone_types: [1, 2, 1, 3, 1, 1, 1] },
  { scale_id: 14, intervals: [1, 18, 4, 21, 10, 23, 15], tone_types: [1, 2, 1, 2, 1, 1, 1] },
  { scale_id: 15, intervals: [1, 17, 5, 20, 10, 22, 15], tone_types: [1, 2, 1, 3, 1, 2, 1] },
  { scale_id: 16, intervals: [1, 19, 5, 21, 10, 13, 16], tone_types: [1, 2, 1, 2, 1, 1, 1] },
  { scale_id: 17, intervals: [1, 17, 4, 6, 9, 22, 14], tone_types: [1, 3, 1, 3, 1, 2, 1] },
  { scale_id: 18, intervals: [1, 17, 4, 20, 10, 23, 15], tone_types: [1, 3, 1, 2, 1, 2, 1] },
  { scale_id: 19, intervals: [1, 18, 5, 21, 11, 13, 16], tone_types: [1, 2, 1, 2, 1, 1, 1] },
  { scale_id: 20, intervals: [1, 18, 5, 21, 10, 23, 15], tone_types: [1, 2, 1, 2, 1, 2, 1] },
  { scale_id: 21, intervals: [1, 18, 5, 20, 10, 22, 15], tone_types: [1, 2, 1, 3, 1, 2, 1] },
  { scale_id: 22, intervals: [1, 18, 4, 20, 9, 22, 15], tone_types: [1, 2, 1, 2, 1, 2, 1] },
  { scale_id: 23, intervals: [1, 17, 4, 6, 9, 22, 15], tone_types: [1, 3, 1, 3, 1, 2, 1] },
  { scale_id: 24, intervals: [1, 18, 5, 10, 13], tone_types: [1, 2, 1, 1, 1] },
  { scale_id: 25, intervals: [1, 4, 20, 10, 15], tone_types: [1, 1, 2, 1, 1] },
  { scale_id: 26, intervals: [1, 18, 4, 5, 10, 13], tone_types: [1, 2, 4, 1, 1, 1] },
  { scale_id: 27, intervals: [1, 4, 20, 9, 10, 15], tone_types: [1, 1, 2, 4, 1, 1] },
  { scale_id: 28, intervals: [1, 18, 5, 21, 22, 15], tone_types: [1, 2, 1, 2, 2, 1] },
  { scale_id: 29, intervals: [1, 18, 4, 20, 9, 22, 14, 16], tone_types: [1, 2, 1, 2, 1, 2, 1, 2] },
  { scale_id: 30, intervals: [1, 17, 19, 5, 21, 10, 23, 15], tone_types: [1, 2, 2, 1, 2, 1, 2, 1] },
  { scale_id: 31, intervals: [1, 17, 19, 5, 21, 22, 15], tone_types: [1, 2, 2, 1, 2, 2, 1] },
  { scale_id: 32, intervals: [1, 18, 5, 20, 10, 23, 15, 16], tone_types: [1, 2, 1, 3, 1, 2, 1, 5] }
].each do |tones_hash|
  tones_hash[:intervals].zip(tones_hash[:tone_types]) do |interval_id, tonetype_id|
    Constant::MidScaleInterval.create!({ scale_id: tones_hash[:scale_id], interval_id:, tonetype_id: })
  end
end
