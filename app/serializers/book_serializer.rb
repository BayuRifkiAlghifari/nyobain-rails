class BookSerializer
  include JSONAPI::Serializer
	
	attributes :title, :price, :desc, :author, :image 
end
