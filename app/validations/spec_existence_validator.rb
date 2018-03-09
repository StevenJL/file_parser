# Ensures that for each data file, there is a corresponding spec file
module Validations
  class MissingSpecError < StandardError; end
  class SpecExistenceValidator
    include ::CommonMethods

    # @param data_files [Array<String>] the files storing the data to be imported
    # @param spec_files [Array<String>] the files storing the specs of the data
    #   to be imported
    def initialize(data_files, spec_files)
      @data_files = data_files
      @spec_files = spec_files
      @errors = []
    end

    # @raise [MissingSpecError] raised if a data filel does not have a spec file
    def validate
      data_file_names = @data_files.map { |f| data_file_name_stripped(f) }
      spec_file_names = @spec_files.map { |f| spec_file_name_stripped(f) }
      missing_spec_files = (data_file_names - spec_file_names)
      return if missing_spec_files.empty?
      raise MissingSpecError.new("Missing specs files: #{missing_spec_files.join(",")}")
    end
  end
end
