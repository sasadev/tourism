class ZipList < BasicRecord::Base001
  class << self
    def import_from_csv(file)
      Asnica::Base.long_transaction do
        ZipList.delete_all

        open(file.path, "rb:Shift_JIS:UTF-8", undef: :replace) do |f|
          CSV.new(f, col_sep: ",").each_slice(1000) do |patch|

            zip_lists = []

            patch.each do |row|
              attributes = { zip:  row[2],
                             pref_kana: row[3],
                             city_kana: row[4],
                             town_kana: row[5],
                             pref:      row[6],
                             city:      row[7],
                             town:      row[8],
              }

              zip_lists << new(attributes)
            end

            ZipList.import zip_lists

          end
        end
      end
    rescue => e
      p e
    end

    def zip_find(_query)

      zip_find = find_by(_query)

      if zip_find.present?

        if zip_find.town.include?("（")
          zip_find.town      = zip_find.town.gsub(/（.*/m, "")
          zip_find.pref   = zip_find.pref.gsub(/（.*/m, "")
          zip_find.town_kana = zip_find.town_kana.gsub(/\(.*/m, "")
        end

        if zip_find.town.include?("以下に掲載がない場合")
          zip_find.town      = zip_find.town.gsub(/以下.*/m, "")
          zip_find.town_kana = zip_find.town_kana.gsub(/ｲｶ.*/m, "")
          zip_find.pref   = zip_find.pref.gsub(/以下.*/m, "")
        end

        zip_find
      end
    end
  end
end
