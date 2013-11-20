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

# Clase Matriz_Dispersa

require "./lib/matrix_expansion/matrix.rb"
require "./lib/matrix_expansion/matrix_densa.rb"

module MatrixExpansion
  class Matriz_Dispersa < Matriz  
    
        # Se crea un array de hashes en el que en cada fila i, por cada elemento no nulo hay un hash de clave j y valor no_nulo
        def initialize(n, m)
            super
            @matrix = Array.new(@fil)
            i = 0
            while(i < @fil)
                @matrix[i] = {}
                i += 1
            end
        end
        
        # Metodo de la clase que permite convertir una matriz densa en una dispersa 
        def self.densa_a_dispersa(matriz)
            raise ArgumentError, 'El parametro debe ser una matriz densa' unless matriz.is_a? MatrixExpansion::Matriz_Densa
            
            obj = new(matriz.fil, matriz.col)
            
            i = 0
            while(i < matriz.fil)
                j = 0
                while(j < matriz.col)
                    value = matriz.matrix[i][j]
              
                    if( value != 0)
                        obj.matrix[i][j] = value
                    end
                    j += 1
                end
                i += 1
            end
            obj
        end
        
        #Calcula el procentaje de nulos en la matriz dispersa
        def porcentaje_nulos
            total = @fil*@col
            no_nulos = 0
            
            i = 0
            while(i < @fil)
                # El tamaño de cada fila es el numero de elementos no nulos que hay en ellas
                no_nulos += @matrix[i].size
                i += 1
            end
            
            nulos = total - no_nulos
            nulos.to_f/total.to_f
        end
        
        # Metodo para asignar valores a la matriz dispersa que permite controlar que siga siendo dispersa en todo momento
        def set(i, j, valor)
            # Se accede dentro de los limites de la  matriz
            if( !(i.is_a? Fixnum) or i < 0 or i >=@fil or !(j.is_a? Fixnum) or j < 0 or j >= @col)
                return nil
            end
             # Borrar elemento si es un valor nulo. Si no, introducirlo
            if(valor == nil or valor == 0)
                @matrix[i].delete(j)
            else
                @matrix[i][j] = valor
            end
            # Si se ha sobrepasado el número de elementos nulos, borramos el último elemento modificado
            if(porcentaje_nulos < 0.6)
                @matrix[i].delete(j)
                puts "Borrado el elemento #{i},#{j} por sobrepasar el numero de elementos no nulos (Porcentaje actual: #{porcentaje_nulos}"
            end
          
        end
        
        # Metodo que muestra la matriz dispersa de la forma: (0,1)=>2  (0,2)=>3
        #                                                    (1,3)=>1
        def to_s
    
            i = 0
            salida = ""
            while(i < @fil)
                @matrix[i].sort.each{|k, v| salida += "(#{i},#{k.to_s})=>#{v.to_s} "}
                salida += "\n"
                i += 1
            end
            salida
        end
        
        # Metodo que devuelve el valor de la posicion dentro de la matriz si es no nulo, o 0 eoc
        def get(i, j)
            if( !(i.is_a? Fixnum) or i < 0 or i >=@fil or !(j.is_a? Fixnum) or j < 0 or j >= @col)
                return nil
            end
            
            if(@matrix[i][j] != nil)
                return @matrix[i][j]
            else
                return 0
            end
        end
    
        # Suma de matrices
        def +(other)
            raise ArgumentError , 'El argumento debe ser una matriz' unless other.is_a? Matriz
            raise ArgumentError , 'Las matrices deben ser del mismo tamano' unless @fil == other.fil and @col == other.col
            
            c = Matriz_Densa.new(@fil, @col)
            i = 0
            while(i < @fil)
                j = 0
                while(j < @col)
                    c.matrix[i][j] = get(i,j) + other.get(i,j)
                    j += 1
                end 
                i += 1
            end
            # Si el resultado es una matriz dispersa se convierte la densa
            if(c.porcentaje_nulos > 0.6)
                c = Matriz_Dispersa.densa_a_dispersa(c)
            end
            c
        end
            
        # Resta de matrices
        def -(other)
            raise ArgumentError , 'El argumento debe ser una matriz' unless other.is_a? Matriz
            raise ArgumentError , 'Las matrices deben ser del mismo tamano' unless @fil == other.fil and @col == other.col
            
            c = Matriz_Densa.new(@fil, @col)
            i = 0
            while(i < @fil)
                j = 0
                while(j < @col)
                    c.matrix[i][j] = get(i,j) - other.get(i,j)
                    j += 1
                end 
                i += 1
            end
            
            # Si el resultado es una matriz dispersa se convierte la densa
            if(c.porcentaje_nulos > 0.6)
                c = Matriz_Dispersa.densa_a_dispersa(c)
            end
            c
        end
            
        # Producto de matrices
        def *(other)
            raise ArgumentError , 'El argumento debe ser una matriz' unless other.is_a? Numeric or other.is_a? Matriz
    
            # Si el arguento es un numero
            if(other.is_a? Numeric)
                c = Matriz_Densa.new(@fil, @col)
                i = 0
                while(i < @fil)
                    j = 0
                    while(j < @col)
                        c.matrix[i][j] = get(i,j) * other
                        j += 1
                    end
                    i += 1
                end
            # Si el argumento es una matriz
            else
                raise ArgumentError , 'Matriz no compatible (A.fil == B.col)' unless @col == other.fil
                c = Matriz_Densa.new(@fil, other.col)
                i = 0
                while(i < @fil)
                    j = 0
                    while(j < other.fil)
                        k = 0
                        c.matrix[i][j] = 0
                        while(k < @col)
                            c.matrix[i][j] = c.matrix[i][j] + (get(i,j) * other.get(i,j))
                            k += 1
                        end
                        j += 1
                    end
                    i += 1
                end
            end
            
            # Si el resultado es una matriz dispersa se convierte la densa
            if(c.porcentaje_nulos > 0.6)
                c = Matriz_Dispersa.densa_a_dispersa(c)
            end  
            c
        end
          
        # Calcula el valor maximo de la matriz dispersa
        def max
            # Si toda la matriz es 0, el maximo sera 0
            if(porcentaje_nulos == 1.0)
                return 0
            end
                
            max = nil
            
            # Asignar al primer valor no-nulo de la matriz (el primero que encuentre hasta que deje de ser nil)
            i = 0
            while(max == nil)
                if(@matrix[i].size != 0)
                    max = @matrix[i].values[0]
                end
                i += 1
            end
            
            # Iterar por todos los elementos no nulos para encontrar el maximo
            i = 0
            while(i < @matrix.size)
                if(@matrix[i].values.max != nil and @matrix[i].values.max > max)
                    max = @matrix[i].values.max
                end
                i += 1
            end
            
            max
        end
        
        # Calcula el valor maximo de la matriz dispersa
        def min
            # Si toda la matriz es 0, el minimo sera 0
            if (porcentaje_nulos == 1.0)
                return 0
            end

            min = nil
            
            # Asignar al primer valor no-nulo de la matriz (el primero que encuentre hasta que deje de ser nil)
            i = 0
            while(min == nil)
                if(@matrix[i].size != 0)
                    min = @matrix[i].values[0]
                end
                i += 1
            end
            
            # Iterar por todos los elementos no nulos para encontrar el maximo
            i = 0
            while(i < @matrix.size)
                if(@matrix[i].values.min != nil and @matrix[i].values.min < min)
                    min = @matrix[i].values.min
                end
            i += 1
            end
            
            min
        end
    
    end
end
