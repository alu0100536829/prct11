require './fraccion.rb'

module MatrixExpansion
  class Matriz
    attr_reader :fil, :col
    attr_accessor :matrix
    
    def initialize(n, m)
      raise ArgumentError, 'Valores para filas y columnas incorrectas' unless n.is_a? Fixnum and n > 0 and m.is_a? Fixnum and m > 0
    
      @fil, @col= n, m
    end

  end
end