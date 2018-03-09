# This module contains methods that are used in more than one class
module CommonMethods
  def data_file_name_stripped(file_path)
    file_path.split("/").last.split("_").first
  end

  def spec_file_name_stripped(file_path)
    file_path.split("/").last.gsub(".csv", "")
  end

  def display_error(error_msg)
    $stdout.puts(error_msg)
  end

  def db_client
    @db_client ||= ::Mysql2::Client.new(
      host: db_host,
      username: db_user,
      database: database,
      encoding: "utf8"
    )
  end

  def db_host
    ENV["DB_HOST"] || "localhost"
  end

  def db_user
    ENV["DB_USER"] || "root"
  end

  def database
    ENV["DB_NAME"] || "file_parser_development"
  end
end
