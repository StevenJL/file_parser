# This service is responsible for importing the all in the data files
# into a database table in a format as specified by its corresponding spec file
class BatchDataImportService
  include CommonMethods

  def initialize(data_files, spec_files)
    @data_files = data_files
    @spec_files = spec_files
  end

  def import!
    @data_files.each do |data_file|
      begin
        spec_file = spec_file_for(data_file)
        DataImportService.new(data_file, spec_file).import!
      rescue
        # Display the error message
        next
      end
    end
  end

  private

  def spec_file_for(data_file)
    @spec_files.select do |spec_file|
      spec_file_name_stripped(spec_file) == data_file_name_stripped(data_file)
    end.first
  end
end
