# coding: utf-8

class Hash

  def change
    remap { |h, k, v| h[k] = yield v }
  end

  def remap(hash = self.class.new)
    each { |k, v| yield hash, k, v }
    hash
  end

  def only(*args)
    args.flatten!
    select { |k, v| args.include?(k) }
  end

  def except(*args)
    args.flatten!
    reject { |k, v| args.include?(k) }
  end

  def as_json
    remap { |h, k, v| h[k] = v.respond_to?(:as_json) ? v.as_json : v }
  end

end

module Enumerable

  def as_json
    map { |v| v.respond_to?(:as_json) ? v.as_json : v }
  end

end


