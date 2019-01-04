class InsertPreference < ActiveRecord::Migration[5.0]
  def change
    ['モダン', 'トラディショナル', '気軽に楽しみたい', 'じっくり楽しみたい', '穴場', '有名', '静けさ', '賑わい', '子供向け', '大人向け'].each.with_index(1) do |object, i|
      preference = Preference.find_or_initialize_by(title: object)
      preference.sort_seq = i

      preference.save!
    end
  end
end
