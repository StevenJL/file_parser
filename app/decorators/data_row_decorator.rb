class DataRowDecorator
  include CommonMethods

  def initialize(raw_row, spec_file_decorator)
    @raw_row = raw_row
    @spec_file_decorator = spec_file_decorator
  end

  def write_query
    "#{insert_into} #{columns_to_insert} #{values_to_insert};"
  end

  private

  def values_to_insert
    values = []
    indx = 0
    @spec_file_decorator.spec_file_csv.each do |row|
      width = row["width"].to_i
      value = @raw_row[indx..(indx + width - 1)]
      values << "'#{value.strip}'"
      indx = indx + width
    end
    "VALUES (#{values.join(",")})"
  end

  def insert_into
    "INSERT INTO #{@spec_file_decorator.filename} "
  end

  def columns_to_insert
    columns = []
    @spec_file_decorator.spec_file_csv.each do |row|
      columns << row["column name"]
    end
    "(#{columns.join(",")})"
  end
end
