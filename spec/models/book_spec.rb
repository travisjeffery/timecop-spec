require 'spec_helper'

describe Book do

  before do
    @book = FactoryGirl.create :published_book
  end

  specify {@book.created_at.should be_within(1.hour).of(10.days.ago)}
  specify {@book.authors.first.created_at.should be_within(1.hour).of(10.days.ago)}
end
