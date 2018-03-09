require "mysql2"

class TableWriteService
  include CommonMethods

  def initialize(data_file_decorator)
    @data_file_decorator = data_file_decorator
  end

  def write!
    rows.each do |row|
      db_client.query(row.write_query)
    end
  end

  private

  def rows
    @data_file_decorator.data_file_rows.map do |row|
      DataRowDecorator.new(row, @data_file_decorator.spec_file_decorator)
    end
  end
end
