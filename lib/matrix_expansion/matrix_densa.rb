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

# Clase Matriz_Densa

require "./lib/matrix_expansion/matrix.rb"

module MatrixExpansion

    include Enumerable
    class Matriz_Densa < Matriz
        
        # Crea una matriz anidando array e inicializa los valores a 0
        def initialize(n, m)
          super
          # Se crean el array de filas con collect
          @matrix = (0..(@fil-1)).collect {0}
          
          # Se crea un array para cada filas con el numero de columnas, con each y collect
          (0..(@col-1)).each { |i| @matrix[i] = (0..(@col-1)).collect{0}}
          
        end
        
        # Da valores numericos a la matriz densa
        def set_valores_num
            valor = 1
            i = 0
            while(i < @col)
                j = 0
                while(j < @fil)
                    @matrix[i][j] = valor
                    valor += 1
                    j += 1
                end
                i += 1
            end
        end
        
        # Da valores fraccionales a la matriz densa
        def set_valores_fracc
            a = 1
            b = 2
            i = 0
            while(i < @col)
                j = 0
                while(j < @fil)
                    @matrix[i][j] = Fraccion.new(a,b)
                    a += 1
                    b += 1
                    j += 1
                end
                i += 1
            end
        end

        #Comprueba que se accede dentro de la matriz y devuelve el valor
        def get(i,j)
            if( !(i.is_a? Fixnum) or i < 0 or i >=@fil or !(j.is_a? Fixnum) or j < 0 or j >= @col)
                return nil
            end
            
            return @matrix[i][j]
        end
        
        # Calcula el porcentaje de valores nulos
        def porcentaje_nulos
          total = @fil*@col
          no_nulos = 0
          
          i = 0
          while(i < @fil)
            j = 0
            while(j < @col)
              if(@matrix[i][j] != 0)
                no_nulos += 1
              end
              j += 1
            end
            i += 1
          end
          
          nulos = total - no_nulos
          nulos.to_f/total.to_f #/
        end
    
        # Muestra la matriz densa
        def to_s
          s = ""
          i = 0
          while(i < @col)
            j = 0
            while(j < @fil)
              s += "#{@matrix[i][j].to_s}\t"
              j += 1
            end
            s += "\n"
            i += 1
          end
          s
        end

        
        # Suma de matrices densas
        def +(other)
            raise ArgumentError , 'El argumento debe ser una matriz' unless other.is_a? Matriz
            raise ArgumentError , 'Las matrices deben ser del mismo tamano' unless @fil == other.fil and @col == other.col
            
            c = Matriz_Densa.new(@fil, @col)
            @fil.times do |i|
                @col.times do |j|
                    c.matrix[i][j] = @matrix[i][j] + other.get(i,j)
                end
            end
            c
        end
            
        # Resta de matrices densas
        def -(other)
            raise ArgumentError , 'El argumento debe ser una matriz' unless other.is_a? Matriz
            raise ArgumentError , 'Las matrices deben ser del mismo tamano' unless @fil == other.fil and @col == other.col
            
            c = Matriz_Densa.new(@fil, @col)
            @fil.times do |i|
                @col.times do |j|
                    c.matrix[i][j] = @matrix[i][j] - other.get(i,j)
                end
            end
            c
        end
            
            
        #Producto de matrices densas
        def *(other)
            raise ArgumentError , 'El argumento debe ser una matriz' unless other.is_a? Numeric or other.is_a? Matriz
            
            #Si el argumento es un numero
            if(other.is_a? Numeric)
                c = Matriz_Densa.new(@fil, @col)
                @fil.times do |i|
                    @col.times do |j|
                        c.matrix[i][j] = @matrix[i][j] * other
                    end
                end
            #Si el arguumento es una matriz
            else
                raise ArgumentError , 'Matriz no compatible (A.fil == B.col)' unless @col == other.fil
                
                c = Matriz_Densa.new(@fil, other.col)
                @fil.times do |i|
                    @col.times do |j|
                        (0..(@col-1)).inject(0) do |acc, k|
                            c.matrix[i][j] = acc + (@matrix[i][k] * other.get(k,j))
                        end
                    end
                end
            end
            
            c
        end
        
        
        # Calcula el minimo elemento de la matriz
        def min
            
            # Establecemos valor del primer elemento
            # Fila a fila actualizando el valor minimo
            @fil.times do |i|
                (0..(@col-1)).inject(@matrix[0][0]) do |acc , j|
                    acc > @matrix[i][j] ? acc : @matrix[i][j]
                    min = acc
                end
            end
            min
        end
        
        # Calcula el maximo elemento de la matriz
        def max
                
            # Establecemos valor del primer elemento
            #Fila a fila actualizando el valor maximo
             @fil.times do |i|
                (0..(@col-1)).inject(@matrix[0][0]) do |acc , j|
                    acc < @matrix[i][j] ? acc : @matrix[i][j]
                    max = acc
                end
            end
            max
        end
    end
end

m1 = MatrixExpansion::Matriz_Densa.new(2,2)
#m1.set_valores_num
puts m1.min


