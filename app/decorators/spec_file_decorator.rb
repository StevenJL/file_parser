require "csv"

class SpecFileParsingError < StandardError; end
class SpecFileWrongHeaderError < StandardError; end

# A class that wraps around a spec file providing convenience methods
class SpecFileDecorator
  include CommonMethods

  SPEC_FILE_HEADERS = ["column name", "width", "datatype"]
  attr_reader :spec_file_csv
  attr_reader :max_width

  def initialize(spec_file)
    @spec_file = spec_file
    parse!
  end

  def filename
    spec_file_name_stripped(@spec_file)
  end

  private

  def parse!
    parse_into_csv
    compute_max_width
  rescue StandardError
    raise SpecFileParsingError.new("Could not parse spec file: #{@spec_file}")
  end

  def compute_max_width
    @max_width = 0
    @spec_file_csv.each do |row|
      @max_width =+ row["width"].to_i
    end
  end

  def parse_into_csv
    @spec_file_csv ||= begin
      csv = CSV.parse(spec_file_str, headers: true)
      unless csv.headers == SPEC_FILE_HEADERS
        raise SpecFileWrongHeaderError.new("#{@spec_file} has wrong headers.")
      end
      csv
    end
  end

  def spec_file_str
    @spec_file_str ||= File.open(@spec_file, "rb").read
  end
end
