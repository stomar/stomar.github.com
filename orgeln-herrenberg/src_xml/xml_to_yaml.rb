#!/usr/bin/env ruby

require "nokogiri"
require "yaml"

def retrieve(node, xpath)
  first_node = node.xpath(xpath).first

  first_node ? first_node.content : nil
end

def delete_if_nil(hash, key)
  hash.delete(key)  unless hash[key]
end


xml_content = File.read("orgeldb.xml")
organs = Nokogiri::XML(xml_content)

organ_hashes = []

organs.xpath("//Orgeldatenbank/Orgel").each do |organ|

  orgel = {}

  orgel["id"] = retrieve(organ, "attribute::id")

  standort = {}
  standort["Kirche"] = retrieve(organ, "Standort/Name")
  standort["Ort"]  = retrieve(organ, "Standort/Ort")
  orgel["Standort"] = standort

  orgelbauer = {}
  orgelbauer["sortkey"] = retrieve(organ, "Orgelbauer/attribute::sortkey")
  orgelbauer["Name"] = retrieve(organ, "Orgelbauer/Name")
  orgelbauer["Ort"] = retrieve(organ, "Orgelbauer/Ort")
  opus = retrieve(organ, "Orgelbauer/opus")
  orgelbauer["opus"] = (opus.nil? || opus.empty?) ? nil : opus.to_i
  orgelbauer.delete_if {|k,v| v.nil? }
  orgel["Erbauer"] = orgelbauer

  jahr = retrieve(organ, "Jahr")
  orgel["Jahr"] = (jahr.nil? || jahr.empty?) ? nil : jahr.to_i
  delete_if_nil(orgel, "Jahr")

  orgel["Klaviaturen"] = []

  organ.xpath("Klaviatur").each do |klav|
    klaviatur = {}

    klaviatur["order"] = retrieve(klav, "attribute::order")
    delete_if_nil(klaviatur, "order")
    klaviatur["Name"] = retrieve(klav, "Name")
    klaviatur["Umfang"] = retrieve(klav, "Umfang")

    klaviatur["Register"] = []
    klav.xpath("Reg").each do |reg|
      register = {}

      register["id"] = retrieve(reg, "attribute::order") || retrieve(reg, "attribute::id")
      register["Name"] = retrieve(reg, "Name")
      register["Lage"] = retrieve(reg, "Lage")
      register["label"] = retrieve(reg, "label")
      register["Choere"] = retrieve(reg, "Choere")
      register["Bemerkung"] = retrieve(reg, "Bemerkung")
      register["Vorabzug_von"] = retrieve(reg, "attribute::Vorabzug")
      register.delete_if {|k,v| v.nil? }

      klaviatur["Register"] << register
    end

    orgel["Klaviaturen"] << klaviatur
  end

  orgel["Koppeln"] = retrieve(organ, "Koppeln")

  orgel["Bemerkungen"] = []
  organ.xpath("Bemerkung").each do |bemerkung|
    orgel["Bemerkungen"] << bemerkung.inner_html.strip
  end

  orgel["Quellen"] = []
  organ.xpath("Quelle").each do |quelle|
    orgel["Quellen"] << quelle.content
  end

  orgel["Revisionen"] = []
  organ.xpath("Revision").each do |rev|
    revision = {}

    revision["Datum"] = retrieve(rev, "attribute::date")
    revision["Autor"] = retrieve(rev, "attribute::by")
    revision["Beschreibung"] = rev.content

    orgel["Revisionen"] << revision
  end

  organ_hashes << orgel
end

puts organ_hashes.to_yaml
