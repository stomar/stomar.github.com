#!/usr/bin/env ruby

require "yaml"
require "erb"

require_relative "orgel"

OUTPUT_DIR = "../db"
orte_template = ERB.new(File.read("orte.md.erb"), 0, '%<>-')
orte_outfile  = "orte.md"
erbauer_template = ERB.new(File.read("erbauer.md.erb"), 0, '%<>-')
erbauer_outfile  = "erbauer.md"
orgel_template = ERB.new(File.read("disposition.html.erb"), 0, '%<>-')
orgeln_template = ERB.new(File.read("dispositionen.html.erb"), 0, '%<>-')
orgeln_outfile  = "orgeldb.html"

orgel_sammlung = OrgelSammlung.yaml_load("orgeldb.yaml")

#####

def render_and_save(template, outer_binding, outfile:)
  page = template.result(outer_binding).gsub(/ +$/, "").gsub(/^ +/, "")

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

orgeln = orgel_sammlung.sort_by_location
last_modified = nil

render_and_save(orte_template, binding, outfile: orte_outfile)

# Erbauer

orgeln = orgel_sammlung.sort_by_builder
last_modified = nil

render_and_save(erbauer_template, binding, outfile: erbauer_outfile)

# Dispositionen

orgeln = orgel_sammlung.sort_by_location
last_modified = nil

## alle

render_and_save(orgeln_template, binding, outfile: orgeln_outfile)

## einzeln

orgel_sammlung.each do |orgel|
  last_modified = orgel.last_modified
  outfile = "#{orgel.id}.html"

  render_and_save(orgel_template, binding, outfile: outfile)
end
