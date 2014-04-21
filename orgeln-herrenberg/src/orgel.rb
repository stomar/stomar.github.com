class Orgel

  attr_reader :id, :standort, :erbauer, :jahr, :klaviaturen, :koppeln,
              :bemerkungen, :quellen, :revisionen

  def initialize(data)
    @id = data["id"]
    @standort = data["Standort"]
    @erbauer = data["Erbauer"]
    @jahr = data["Jahr"]
    @klaviaturen = data["Klaviaturen"]
    @koppeln = data["Koppeln"]
    @bemerkungen = data["Bemerkungen"]
    @quellen = data["Quellen"]
    @revisionen = data["Revisionen"]
  end

  def to_s
    [id, standort, erbauer, jahr, klaviaturen, koppeln,
     bemerkungen, quellen, revisionen].join("\n")
  end

  def full_builder_info
    info = ""
    info << erbauer["Name"]
    info << ", #{erbauer["Ort"]}"  if erbauer["Ort"]
    info << ", opus #{erbauer["opus"]}"  if erbauer["opus"]
    info << ", #{jahr}"  if jahr

    info
  end
end


require "forwardable"

class OrgelSammlung
  extend Forwardable

  attr_accessor :records
  def_delegators :@records, :[], :each, :each_with_index, :size

  def self.yaml_load(filename)
    orgel_array = YAML.load File.read(filename)
    orgel_array.map! {|orgel_data| Orgel.new(orgel_data) }

    self.new(orgel_array)
  end

  def initialize(orgel_array)
    @records = orgel_array
  end

  def sort_by_location
    orgel_array = @records.sort_by {|orgel| [orgel.standort["Ort"], orgel.standort["Kirche"]] }

    self.class.new(orgel_array)
  end

  def sort_by_builder
    orgel_array = @records.sort_by {|orgel| [orgel.erbauer["sortkey"], orgel.standort["Ort"]] }

    self.class.new(orgel_array)
  end
end
