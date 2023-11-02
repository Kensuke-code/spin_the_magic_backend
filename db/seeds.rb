require "csv"

pattern = "db/seeds/*.csv"

Dir.glob(Rails.root.join(pattern)).each do |path|
  filename = File.basename(path, ".csv")
  klass = Module.const_get(filename.classify)
  data = CSV.read(path, headers: true).map(&:to_h)
  klass.insert_all(data) if data.present?
  puts "DONE. file: #{filename}, class: #{klass}"
end