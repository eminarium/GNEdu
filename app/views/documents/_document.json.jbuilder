json.extract! document, :id, :student_id, :doc_url, :created_at, :updated_at
json.url document_url(document, format: :json)
