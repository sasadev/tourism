class Initializer < ActiveRecord::Migration[5.0]
  def change
    # 管理者テーブル
    create_table :admin_users do |t|
      t.string   :name, comment: '名前'
      t.string   :email, comment: 'メールアドレス'
      t.string   :hashed_password, comment: 'パスワード'
      t.string   :salt, comment: 'パスワードハッシュ化'
      t.integer :deleted, default: 0, null: false
      t.timestamps
    end


    # 検索履歴テーブル
    create_table :sql_conditions do |t|
      t.string  :code
      t.integer :admin_user_id
      t.text    :condition, default: '', null: false
      t.timestamps
    end


    # 管理画面設定テーブル
    create_table :system_configs, force: :cascade do |t|
      t.integer :available, default: 1, comment: '最新のレコードのフラグ'
      t.timestamps
    end


    # コンテンツ画像テーブル
    create_table :content_images do |t|
      t.string :image, comment: '画像'
      t.integer :deleted, default: 0, null: false
      t.timestamps
    end


    # コンテンツテーブル
    create_table :contents do |t|
      t.string :title, comment: 'コンテンツ名'
      t.string :main_image, comment: 'メイン画像'
      t.text :description, comment: '説明'
      t.string :time_required, comment: '所用時間'
      t.integer :activity, comment: '室内外'
      t.date :period_from, comment: '開催期間from'
      t.date :period_to, comment: '開催期間to'
      t.string :recommended, comment: 'おすすめポイント'
      t.integer :zip, comment: '郵便番号'
      t.string :address, comment: '住所'
      t.string :building, comment: '建物名'
      t.text :memo, comment: 'メモ'
      t.integer :amount, default: 0, null: false,comment: '価格'
      t.integer :prefecture_id, comment: '都道府県ID'
      t.integer :category_id, comment: 'カテゴリID'
      t.integer :genre_id, comment: 'ジャンルID'
      t.integer :content_image_id, comment: 'コンテンツ画像ID'
      t.integer :deleted, default: 0, null: false
      t.timestamps
    end
    add_index :contents, :prefecture_id
    add_index :contents, :category_id
    add_index :contents, :genre_id
    add_index :contents, :content_image_id


    # カテゴリテーブル
    create_table :categories do |t|
      t.string :title, comment: 'カテゴリ名'
      t.integer :sort_seq, default: 0, null: false, comment: '並び順'
      t.integer :deleted, default: 0, null: false
      t.timestamps
    end


    # ジャンルテーブル
    create_table :genres do |t|
      t.string :title, comment: 'ジャンル名'
      t.integer :sort_seq, default: 0, null: false, comment: '並び順'
      t.integer :category_id, comment: 'カテゴリID'
      t.integer :deleted, default: 0, null: false
      t.timestamps
    end
    add_index :genres, :category_id


    # コンテンツ設定中間テーブル
    create_table :content_preferences do |t|
      t.integer :content_id, comment: 'コンテンツID'
      t.integer :preference_id, default: 0, null: false, comment: '設定ID'
      t.timestamps
    end
    add_index :content_preferences, :content_id
    add_index :content_preferences, :preference_id


    # 都道府県テーブル
    create_table :prefectures do |t|
      t.string :name, comment: '都道府県名'
      t.integer :deleted, default: 0, null: false
      t.timestamps
    end
    [
        {id: 1,  name: '北海道' },
        {id: 2,  name: '青森県' },
        {id: 3,  name: '岩手県' },
        {id: 4,  name: '宮城県' },
        {id: 5,  name: '秋田県' },
        {id: 6,  name: '山形県' },
        {id: 7,  name: '福島県' },
        {id: 8,  name: '茨城県' },
        {id: 9,  name: '栃木県' },
        {id: 10, name: '群馬県' },
        {id: 11, name: '埼玉県' },
        {id: 12, name: '千葉県' },
        {id: 13, name: '東京都' },
        {id: 14, name: '神奈川県' },
        {id: 15, name: '新潟県' },
        {id: 16, name: '富山県' },
        {id: 17, name: '石川県' },
        {id: 18, name: '福井県' },
        {id: 19, name: '山梨県' },
        {id: 20, name: '長野県' },
        {id: 21, name: '岐阜県' },
        {id: 22, name: '静岡県' },
        {id: 23, name: '愛知県' },
        {id: 24, name: '三重県' },
        {id: 25, name: '滋賀県' },
        {id: 26, name: '京都府' },
        {id: 27, name: '大阪府' },
        {id: 28, name: '兵庫県' },
        {id: 29, name: '奈良県' },
        {id: 30, name: '和歌山県' },
        {id: 31, name: '鳥取県' },
        {id: 32, name: '島根県' },
        {id: 33, name: '岡山県' },
        {id: 34, name: '広島県' },
        {id: 35, name: '山口県' },
        {id: 36, name: '徳島県' },
        {id: 37, name: '香川県' },
        {id: 38, name: '愛媛県' },
        {id: 39, name: '高知県' },
        {id: 40, name: '福岡県' },
        {id: 41, name: '佐賀県' },
        {id: 42, name: '長崎県' },
        {id: 43, name: '熊本県' },
        {id: 44, name: '大分県' },
        {id: 45, name: '宮崎県' },
        {id: 46, name: '鹿児島県' },
        {id: 47, name: '沖縄県' },
    ].each do |opt|
      next if Prefecture.find_by(opt)
      Prefecture.create(opt)
    end


    # 住所取り込み用テーブル
    create_table :zip_lists, force: :cascade do |t|
      t.string :zip, comment: '郵便番号'
      t.string :pref, comment: '県'
      t.string :city, comment: '市'
      t.string :town, comment: '町'
      t.string :pref_kana, comment: '県カタカナ'
      t.string :city_kana, comment: '市カタカナ'
      t.string :town_kana, comment: '町カタカナ'
      t.timestamps
    end


    # 価格帯テーブル
    create_table :price_ranges do |t|
      t.string :title, comment: '価格帯名'
      t.integer :sort_seq, default: 0, null: false, comment: '並び順'
      t.integer :begining_price, default: 0, null: false, comment: '始まり価格'
      t.integer :end_price, default: 0, null: false, comment: '終わり価格'
      t.integer :deleted, default: 0, null: false
      t.timestamps
    end


    # 目的地テーブル
    create_table :destinations do |t|
      t.string :departure, comment: '出発地点'
      t.string :arrival, comment: '到着地点'
      t.date :departure_date, comment: '出発日'
      t.datetime :departure_time, comment: '出発時間'
      t.integer :visit, default: 0, null: false, comment: '訪問Enum'
      t.integer :stay, default: 0, null: false, comment: '滞在日数Enum'
      t.integer :sex, default: 0, null: false, comment: '性別Enum'
      t.integer :number_people, default: 0, null: false, comment: '人数'
      t.integer :age, default: 0, null: false, comment: '年齢層'
      t.text :memo, comment: 'メモ'
      t.integer :total_time, default: 0, null: false, comment: '合計移動時間'
      t.integer :total_destance, default: 0, null: false, comment: '合計移動距離'
      t.integer :total_amount, default: 0, null: false, comment: '合計金額'
      t.integer :country_id, comment: '国籍ID'
      t.integer :deleted, default: 0, null: false
      t.timestamps
    end
    add_index :destinations, :country_id


    # 目的地・コンテンツテーブル(中間)
    create_table :destination_contents do |t|
      t.integer :destination_id, comment: '目的地ID'
      t.integer :content_id, comment: 'コンテンツID'
      t.integer :like, default: 0, null: false, comment: 'お気に入り'
      t.timestamps
    end
    add_index :destination_contents, :destination_id
    add_index :destination_contents, :content_id


    # 国籍テーブル
    create_table :countries do |t|
      t.string :title, comment: '国籍名'
      t.integer :sort_seq, default: 0, null: false, comment: '並び順'
      t.integer :deleted, default: 0, null: false
      t.timestamps
    end


    # 移動手段テーブル
    create_table :transportations do |t|
      t.string :title, comment: '移動手段名'
      t.integer :sort_seq, default: 0, null: false, comment: '並び順'
      t.integer :deleted, default: 0, null: false
      t.timestamps
    end


    # 目的地・移動手段テーブル(中間)
    create_table :destination_transportations do |t|
      t.integer :destination_id, comment: '目的地ID'
      t.integer :transportation_id, comment: '移動手段ID'
      t.timestamps
    end
    add_index :destination_transportations, :destination_id
    add_index :destination_transportations, :transportation_id
  end
end
