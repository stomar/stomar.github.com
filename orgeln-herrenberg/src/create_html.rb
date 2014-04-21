#!/usr/bin/env ruby

require "yaml"
require "erb"

require_relative "orgel"

OUTPUT_DIR = "db"
ORTE_TEMPLATE = "orte.html.erb"
ERBAUER_TEMPLATE = "erbauer.html.erb"
ORGELDB_TEMPLATE = "orgeldb.html.erb"

orgel_sammlung = OrgelSammlung.yaml_load("orgeldb.yaml")

#####

if Dir.exist?(OUTPUT_DIR)
  warn "Output directory `#{OUTPUT_DIR}' already exists"
  exit
end

Dir.mkdir(OUTPUT_DIR)

# Orte

orgeln = orgel_sammlung.sort_by_location

orte = ERB.new(File.read(ORTE_TEMPLATE), 0, '%<>-').result(binding)
orte.gsub!(/ +$/, "")
orte.gsub!(/^ +/, "")
File.open(OUTPUT_DIR + "/" + ORTE_TEMPLATE.gsub(/\.erb/, ""), "w") {|f| f.puts orte }

# Erbauer

orgeln = orgel_sammlung.sort_by_builder

erbauer = ERB.new(File.read(ERBAUER_TEMPLATE), 0, '%<>-').result(binding)
erbauer.gsub!(/ +$/, "")
erbauer.gsub!(/^ +/, "")
File.open(OUTPUT_DIR + "/" + ERBAUER_TEMPLATE.gsub(/\.erb/, ""), "w") {|f| f.puts erbauer }

# orgeldb

orgeln = orgel_sammlung.sort_by_location

orgeldb = ERB.new(File.read(ORGELDB_TEMPLATE), 0, '%<>-').result(binding)
orgeldb.gsub!(/ +$/, "")
orgeldb.gsub!(/^ +/, "")
File.open(OUTPUT_DIR + "/" + ORGELDB_TEMPLATE.gsub(/\.erb/, ""), "w") {|f| f.puts orgeldb }

# Orgeln einzeln

orgel_template = ERB.new(File.read(ORGELDB_TEMPLATE), 0, '%<>-')

orgel_sammlung.each do |orgel|
  orgeln = OrgelSammlung.new([orgel])

  orgel_html = orgel_template.result(binding)
  orgel_html.gsub!(/ +$/, "")
  orgel_html.gsub!(/^ +/, "")
  File.open(OUTPUT_DIR + "/#{orgel.id}.html", "w") {|f| f.puts orgel_html }
end
