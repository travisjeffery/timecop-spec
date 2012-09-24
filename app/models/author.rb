class Author < ActiveRecord::Base
  has_many :authorships
  has_many :books, through: :authorships

  def write_chapter!(book)
    true
  end
end
