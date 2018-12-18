json.array!(@book_lends) do |book_lend|
  json.extract! book_lend, :id, :book_id, :student_id, :lendDateTime, :isReturned, :returnDateTime, :isDamaged, :notes
  json.url book_lend_url(book_lend, format: :json)
end
