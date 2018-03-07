desc "Import from /data into database"
task :import do
  FileParser.import!
end
