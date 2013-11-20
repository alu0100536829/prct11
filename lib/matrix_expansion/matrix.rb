=begin
*******************************************************************************************
* Autores: 
       Teno González Dos Santos
       Albano José Yanes Reyes
* Fecha: 19/11/2013 -
* Asignatura: Lenguujes y Paradigmas de Programación
* Tercero de Grado en Ingeniería Informática
* Universidad de la Laguna
*
* Practica 10: Matrices densas y dispersas
********************************************************************************************
=end

# Clase Matriz

require './lib/matrix_expansion/fraccion.rb'

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