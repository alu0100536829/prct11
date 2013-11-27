#
# = matrix.rb
#  
#    Autores::   Teno González Dos Santos,  Albano José Yanes Reyes
#    Fecha:: 27/11/2013 
#    Asignatura:: Lenguajes y Paradigmas de Programación
#    Curso:: Tercero de Grado en Ingeniería Informática
#    Universidad de la Laguna
#
#  == Practica 10: Matrices densas y dispersas
#     Considere la Gema para la representación de Matrices que ha desarrollado en prácticas 
#     anteriores. Los objetivos de esta práctica son dos:
#          <b>Documentar la gema \<em>(utlizando RDOC).</em></b>
#         <b>Desarrollar métodos con la filosofía de la <em>programación funcional.</em></b>
#
#  === Clase matriz Dispersa
#        Definicion de la clase Matriz compuesta por:
#          - metodo Initialize
#        
#

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