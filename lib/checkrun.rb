# coding: utf-8

class Checkrun

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

  def initialize(data)
    @data[:id] ||= Time.now
    @data[:steps] = data[:steps]
  end

end

