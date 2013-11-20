require "./lib/matrix_expansion/matrix.rb"
require "./lib/matrix_expansion/matrix_densa.rb"

module MatrixExpansion
  class Matriz_Dispersa < Matriz  
    
    def initialize(n, m)
        super
        @matrix = Array.new(@fil) # Array con @fil filas y ninguna columna (vacio)
        i = 0
        while(i < @fil)
            @matrix[i] = {}
            i += 1
        end
    end
    
    # Metodo factoria
    def self.densa_a_dispersa(matriz)
      raise ArgumentError, 'Tipo invalido' unless matriz.is_a? MatrixExpansion::Matriz_Densa
      obj = new(matriz.fil, matriz.col)
    
      i = 0
      while(i < matriz.fil)
        j = 0
        while(j < matriz.col)
          value = matriz.matrix[i][j]
          
          if( value != 0)
            obj.matrix[i][j] = value
          end #endif
          j += 1
        end #endwhile j
        i += 1
      end #endwhile i
      obj
    end #endmethod copy
    
    def porcentaje_nulos
      total = @fil*@col
      no_nulos = 0
      
      i = 0
      while(i < @fil)
        no_nulos += @matrix[i].size # Nunca habra elementos nulos en alguna fila
        i += 1
      end
      
      nulos = total - no_nulos
      nulos.to_f/total.to_f
    end
    
    
    def set(i, j, value)
      if( !(i.is_a? Fixnum) or i < 0 or i >=@fil or !(j.is_a? Fixnum) or j < 0 or j >= @col)
        return nil
      end
      
      if(value == nil or value == 0)
        @matrix[i].delete(j) # Borrar elemento (valor nulo)
      else
        @matrix[i][j] = value
      end
      
      if(porcentaje_nulos < 0.6) # Si se ha sobrepasado el número de elementos nulos, borramos el último elemento modificado
          @matrix[i].delete(j)
          puts "Borrado el elemento #{i},#{j} por sobrepasar el numero de elementos no nulos (Porcentaje actual: #{porcentaje_nulos}"
      end
      
    end #endmethod set
    
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
    
    def get(i, j)
      if( !(i.is_a? Fixnum) or i < 0 or i >=@fil or !(j.is_a? Fixnum) or j < 0 or j >= @col)
        return nil
      end
        
      if(@matrix[i][j] != nil) # Elemento no nulo (esta en el hash)
        return @matrix[i][j]
      else # Elemento nulo (no esta en el Hash)
        return 0
      end
    end #endmethod get

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
        if(c.porcentaje_nulos > 0.6)
            c = Matriz_Dispersa.densa_a_dispersa(c)
        end
        c
    end
        
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
        if(c.porcentaje_nulos > 0.6)
            c = Matriz_Dispersa.densa_a_dispersa(c)
        end
        c
    end
        
    def *(other)
        raise ArgumentError , 'Parametro invalido' unless other.is_a? Numeric or other.is_a? Matriz

        if(other.is_a? Numeric) # Matriz * numero
            c = Matriz_Densa.new(@fil, @col)
            i = 0
            while(i < @fil)
                j = 0
                while(j < @col)
                    c.matrix[i][j] = get(i,j) * other
                    j += 1
                end # while j
                i += 1
            end # while i
        else # Matriz * Matriz
            raise ArgError , 'Matriz no compatible (A.fil == B.col)' unless @M == other.fil
            c = Matriz_Densa.new(@fil, other.col)
            i = 0
            while(i < @fil)
                j = 0
                while(j < other.fil)
                    k = 0
                    c.matrix[i][j] = 0
                    while(k < @col)
                        c.matrix[i][j] += get(i,j) * other.get(i,j)
                        k += 1
                    end # while k
                    j += 1
                end # while j
                i += 1
            end # while i
        end # while else
        if(c.porcentaje_nulos > 0.6)
            c = Matriz_Dispersa.densa_a_dispersa(c)
        end  
        c
    end # *(other)
        
        def max
          if(porcentaje_nulos == 1.0)
            return nil # o return 0
          end
                
          # Valor máximo: si todos los elementos son menores que el elemento nulo
          # Se devolverá el mayor elemento no nulo.
          max = nil
          
          # Asignar al primer valor no-nulo de la matriz
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
        
        def min
            if (porcentaje_nulos == 1.0)
            return 0
            end
                
            # Valor máximo: si todos los elementos son menores que el elemento nulo
            # Se devolverá el mayor elemento no nulo.
            min = nil
            
            # Asignar al primer valor no-nulo de la matriz
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
