#!/usr/bin/env ruby

require "yaml"
require "erb"

require_relative "orgel"

OUTPUT_DIR = "../db"
PAGE_TEMPLATE = ERB.new(File.read("layout.html.erb"), 0, '%<>-')
orte_template = ERB.new(File.read("orte.html.erb"), 0, '%<>-')
orte_outfile  = "orte.html"
erbauer_template = ERB.new(File.read("erbauer.html.erb"), 0, '%<>-')
erbauer_outfile  = "erbauer.html"
orgeln_template = ERB.new(File.read("dispositionen.html.erb"), 0, '%<>-')
orgeln_outfile  = "orgeldb.html"

orgel_sammlung = OrgelSammlung.yaml_load("orgeldb.yaml")

#####

def render_and_save(template, outer_binding, title:, outfile:)
  page_content = template.result(outer_binding)

  page_title = title    # used in PAGE_TEMPLATE
  page = PAGE_TEMPLATE.result(binding).gsub(/ +$/, "").gsub(/^ +/, "")

  File.open(OUTPUT_DIR + "/" + outfile, "w") {|f| f.puts page }
end

#####

if Dir.exist?(OUTPUT_DIR)
  warn "Output directory `#{OUTPUT_DIR}' already exists"
  exit
end

Dir.mkdir(OUTPUT_DIR)

#####

# Orte

title = "Orgeln in Herrenberg / Ortschaften"
orgeln = orgel_sammlung.sort_by_location

render_and_save(orte_template, binding, title: title, outfile: orte_outfile)

# Erbauer

title = "Orgeln in Herrenberg / Orgelbauer"
orgeln = orgel_sammlung.sort_by_builder

render_and_save(erbauer_template, binding, title: title, outfile: erbauer_outfile)

# Dispositionen

title = "Orgeln in Herrenberg"
orgeln = orgel_sammlung.sort_by_location

## alle

render_and_save(orgeln_template, binding, title: title, outfile: orgeln_outfile)

## einzeln

orgel_sammlung.each do |orgel|
  orgeln  = OrgelSammlung.new([orgel])
  outfile = "#{orgel.id}.html"

  render_and_save(orgeln_template, binding, title: title, outfile: outfile)
end
