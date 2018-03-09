require "pry"

class FileParser
  include CommonMethods

  DATA_FILES = Dir[File.expand_path("../../data/*", __FILE__)]
  SPEC_FILES = Dir[File.expand_path("../../specs/*", __FILE__)]

  def self.import!
    new(DATA_FILES, SPEC_FILES).import!
  end

  # @param data_files [Array<String>] the files storing the data to be imported
  # @param spec_files [Array<String>] the files storing the specs of the data
  #   to be imported
  def initialize(data_files, spec_files)
    @data_files = data_files
    @spec_files = spec_files
    @errors = []
  end

  def import!
    check_specs_present!
    import_data!
  rescue MissingSpecError => error
    display_error(error.message)
  end

  private

  def import_data!
    BatchDataImportService.new(
      @data_files, @spec_files
    ).import!
  end

  def display_error(error_msg)
    $stdout.puts(error_msg)
  end

  # @raise [MissingSpecError] raised if there is a data file that does not have
  #   a corresponding spec file
  def check_specs_present!
    Validations::SpecExistenceValidator.new(@data_files, @spec_files).validate
  end
end
