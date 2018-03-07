#!/usr/bin/env rake

Dir[File.dirname(__FILE__) + "/app/**/*.rb"].each do |path|
  require path
end

Dir[File.dirname(__FILE__) + "/lib/tasks/*.rake"].sort.each do |path|
  import path
end
