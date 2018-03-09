class DataImportService
  def initialize(data_file, spec_file)
    @data_file = data_file
    @spec_file = spec_file
  end

  def import!
    create_table!
    import_data!
  end

  private

  def create_table!
    data_file_decorator.validate!
    TableCreationService.new(spec_file_decorator).create!
  end

  def import_data!
    TableWriteService.new(data_file_decorator).write!
  end

  def data_file_decorator
    @data_file_decorator ||= ::DataFileDecorator.new(@data_file, spec_file_decorator)
  end

  def spec_file_decorator
    @spec_file_decorator ||= ::SpecFileDecorator.new(@spec_file)
  end
end
