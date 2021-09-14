class BookDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "Book.id", cond: :eq },
      title: { source: "Book.title", cond: :like },
      desc: { source: "Book.desc", cond: :like },
      price: { source: "Book.price", cond: :like },
      author: { source: "Book.author", cond: :like }
    }
  end

  def data
    records.map do |record|
      {
        # example:
        id: record.id,
        title: record.title,
        desc: record.desc,
        price: record.price,
        author: record.author,
      }
    end
  end

  def get_raw_records
    # insert query here
    Book.all
  end

end
