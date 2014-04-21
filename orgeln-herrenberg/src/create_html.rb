#!/usr/bin/env ruby

require "yaml"
require "erb"

require_relative "orgel"

OUTPUT_DIR = "db"
ORTE_TEMPLATE = "orte.html.erb"
PAGE_TEMPLATE = "layout.html.erb"
ERBAUER_TEMPLATE = "erbauer.html.erb"
ORGELDB_TEMPLATE = "orgeldb.html.erb"

orgel_sammlung = OrgelSammlung.yaml_load("orgeldb.yaml")

#####

if Dir.exist?(OUTPUT_DIR)
  warn "Output directory `#{OUTPUT_DIR}' already exists"
  exit
end

Dir.mkdir(OUTPUT_DIR)

#####

page_template = ERB.new(File.read(PAGE_TEMPLATE), 0, '%<>-')

# Orte

orgeln = orgel_sammlung.sort_by_location
page_title = "Orgeln in Herrenberg / Ortschaften"
page_content = ERB.new(File.read(ORTE_TEMPLATE), 0, '%<>-').result(binding)
page = page_template.result(binding)
page.gsub!(/ +$/, "")
page.gsub!(/^ +/, "")
File.open(OUTPUT_DIR + "/" + ORTE_TEMPLATE.gsub(/\.erb/, ""), "w") {|f| f.puts page }

# Erbauer

orgeln = orgel_sammlung.sort_by_builder
page_title = "Orgeln in Herrenberg / Orgelbauer"
page_content = ERB.new(File.read(ERBAUER_TEMPLATE), 0, '%<>-').result(binding)
page = page_template.result(binding)
page.gsub!(/ +$/, "")
page.gsub!(/^ +/, "")
File.open(OUTPUT_DIR + "/" + ERBAUER_TEMPLATE.gsub(/\.erb/, ""), "w") {|f| f.puts page }

# Dispositionen

orgeln = orgel_sammlung.sort_by_location
page_title = "Orgeln in Herrenberg"

orgel_template = ERB.new(File.read(ORGELDB_TEMPLATE), 0, '%<>-')

## alle

page_content = orgel_template.result(binding)
page = page_template.result(binding)
page.gsub!(/ +$/, "")
page.gsub!(/^ +/, "")
File.open(OUTPUT_DIR + "/" + ORGELDB_TEMPLATE.gsub(/\.erb/, ""), "w") {|f| f.puts page }

## einzeln

orgel_sammlung.each do |orgel|
  orgeln = OrgelSammlung.new([orgel])

  page_content = orgel_template.result(binding)
  page = page_template.result(binding)
  page.gsub!(/ +$/, "")
  page.gsub!(/^ +/, "")
  File.open(OUTPUT_DIR + "/#{orgel.id}.html", "w") {|f| f.puts page }
end
