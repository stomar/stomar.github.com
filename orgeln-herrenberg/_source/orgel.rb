class Register

  attr_reader :id, :name, :lage, :choere, :bemerkung, :vorabzug_von

  def initialize(data)
    @id = data["id"]
    @name = data["Name"]
    @lage = data["Lage"]
    @label = data["label"]
    @choere = data["Choere"]
    @bemerkung = data["Bemerkung"]
    @vorabzug_von = data["Vorabzug_von"]
  end

  def tremulant?
    name == "Tremulant"
  end

  def info
    info = name.dup
    info << " " << choere << "f."  if choere
    info << " (Vorabzug)"  if vorabzug_von

    info
  end

  def lage_mit_fuss
    lage ? (lage + "'") : ""
  end
end

class Klaviatur

  attr_reader :order, :name, :umfang, :register

  def initialize(data)
    @order = data["order"]
    @name = data["Name"]
    @umfang = data["Umfang"]
    @register = []

    data["Register"].each do |register_data|
      @register << Register.new(register_data)
    end
  end

  def info
    umfang ? "#{name} (#{umfang})" : name
  end
end


class Orgel

  attr_reader :id, :standort, :erbauer, :jahr, :klaviaturen, :koppeln,
              :bemerkungen, :quellen, :revisionen

  def initialize(data)
    @id = data["id"]
    @standort = data["Standort"]
    @erbauer = data["Erbauer"]
    @jahr = data["Jahr"]
    @klaviaturen = []
    @koppeln = data["Koppeln"]
    @bemerkungen = data["Bemerkungen"]
    @quellen = data["Quellen"]
    @revisionen = data["Revisionen"]

    data["Klaviaturen"].each do |klaviatur_data|
      @klaviaturen << Klaviatur.new(klaviatur_data)
    end
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

  def last_modified
    return  if (revisionen.nil? || revisionen.empty?)

    dates = revisionen.map {|rev| rev["Datum"] }

    dates.sort.last
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
