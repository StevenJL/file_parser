class DataFileFormatError < StandardError; end
# A class that wraps around a data file to provide convenience methods
class DataFileDecorator
  attr_reader :spec_file_decorator

  def initialize(data_file, spec_file_decorator)
    @data_file = data_file
    @spec_file_decorator = spec_file_decorator
  end

  def validate!
    if data_file_rows.any? {|row| row.length < @spec_file_decorator.max_width }
      raise DataFileFormatError.new("#{@data_file} format does not match spec")
    end
  end

  def data_file_rows
    @data_file_rows ||= begin
      rows = []
      File.open(@data_file, "r") do |f|
        f.each_line do |line|
          rows << line
        end
      end
      rows
    end
  end
end
