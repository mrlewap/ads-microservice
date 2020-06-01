class Ad < Sequel::Model
  class << self
    def paginate(page_no, page_size)
      ds = DB[:ads]
      ds.extension(:pagination).paginate(page_no, page_size)
    end
  end
end
