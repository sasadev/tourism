class Prefecture < BasicRecord::Base001
  def show_name
    name.to_s.gsub('府','').gsub('県','').gsub('東京都','東京')
  end

  ##### クラスメソッドとして定義 ####
  class << self
    def select_lists
      all.order(:id)
    end
  end
end
