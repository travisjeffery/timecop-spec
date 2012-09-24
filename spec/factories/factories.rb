FactoryGirl.define do

  factory :author do
    sequence(:name){|n|"Author#{n}"}
  end

  factory :authorship do
    author
    book
  end

  factory :book do
    sequence(:title){|n|"Book#{n}"}

    factory :published_book do

      ignore do
        days_ago 10
      end

      after :create do |book, evaluator|
        Timecop.travel(evaluator.days_ago) do
          book.update_attribute :created_at, Time.now
          2.times do
            authorship = book.authorships.create(FactoryGirl.build(:authorship, book: book, author: FactoryGirl.create(:author)).attributes.symbolize_keys)
            authorship.save!
          end
        end

        evaluator.days_ago.times.to_a.reverse.each do |i|
          Timecop.travel(i.days.ago) do
            book.authors.each do |author|
              author.write_chapter! book
            end
          end
        end
      end
    end

  end

end