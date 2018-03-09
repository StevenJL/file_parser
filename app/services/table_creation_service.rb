require "mysql2"

class ColumnNameMissingError < StandardError; end
class ColumnDataTypeMissingError < StandardError; end

class TableCreationService
  include CommonMethods

  DATA_TYPES_MAP = {
    "BOOLEAN" => "TINYINT",
    "INTEGER" => "INT",
    "TEXT" => "TEXT",
  }

  def initialize(spec_file_decorator)
    @spec_file_decorator = spec_file_decorator
  end

  def create!
    return if table_already_exists?
    puts create_table_query_str
    db_client.query(create_table_query_str)
  end

  private

  def table_already_exists?
    result = db_client.query("SHOW TABLES LIKE '#{@spec_file_decorator.filename}'")
    !result.to_a.empty?
  end

  def create_table_query_str
    @create_table_query_str ||= begin
      query_str = <<-EOS
        create table #{@spec_file_decorator.filename} (#{create_table_columns});
      EOS
      db_client.escape(query_str.strip)
    end
  end

  def create_table_columns
    columns_to_create = []
    @spec_file_decorator.spec_file_csv.each do |col|
      col_name = col["column name"]
      unless col_name
        raise ColumnNameMissingError.new("#{@file_decorator.file} missing column name field")
      end
      data_type = DATA_TYPES_MAP[col["datatype"]]
      unless data_type
        raise ColumnDataTypeMissingError.new("#{@file_decorator.file} missing column datatype field")
      end
      columns_to_create << "#{col_name} #{data_type}"
    end
    columns_to_create.join(", ")
  end
end
