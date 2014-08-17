# coding: utf-8
require "pstore"
require "securerandom"

class Checklist

  extend DataAccessor

  def self.pstore(id)
    pstore = JSON::Store.new("data/checklists/#{id}.json")
    block_given? ? pstore.transaction { yield(pstore) } : pstore
  end

  def self.find(id)
    pstore(id) do |db|
      data = Hash[db.roots.zip(db.roots.map { |field| db[field] })]
      new(data)
    end
  end

  def self.all
    Dir.glob("data/checklists/*.json").map do |path|
      find(File.basename(path, ".json"))
    end
  end

  data_reader :id, :name, :steps

  def initialize(data = nil)
    @data = data
    @data[:id] ||= SecureRandom.uuid
    @data[:steps] ||= []
  end

  def update(data)
    data.only("name").each { |field, value| @data[field.to_sym] = value }
  end

  def save
    self.class.pstore(id) do |db|
      @data.each { |field, value| db[field] = value }
    end
  end

  def checkrun
    Checkrun.new(steps: steps)
  end

end

