# coding: utf-8
require "pstore"
require "json"

class JSON::Store < PStore

  def dump(table)
    JSON.pretty_generate(table)
  end

  def load(content)
    JSON.parse(content, symbolize_names: true)
  end

end

