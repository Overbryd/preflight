# coding: utf-8

module DataAccessor

  def data_reader(*symbols)
    symbols.each do |symbol|
      define_method(symbol) do
        @data[symbol]
      end
    end
  end

  def data_writer(*symbols)
    symbols.each do |symbol|
      define_method("#{symbol}=") do |value|
        @data[symbol] = value
      end
    end
  end

  def data_accessor(*symbols)
    data_reader(*symbols)
    data_writer(*symbols)
  end

end

