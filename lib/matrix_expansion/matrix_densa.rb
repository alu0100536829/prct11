require "./lib/matrix_expansion/matrix.rb"

module MatrixExpansion
    class Matriz_Densa < Matriz
        def initialize(n, m)
          super
          
          @matrix = Array.new(@fil,0)
          i = 0
          while i < @fil
            @matrix[i] = Array.new(@col,0)
            i += 1  
          end
        end
          
        def get_matrix(i, j)
          if( i < 0 or i >=@fil or j < 0 or j >= @col)
            return nil
          end
    
          @contenido[i][j]
        end
        
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
        
        def get(i,j)
            if( !(i.is_a? Fixnum) or i < 0 or i >=@fil or !(j.is_a? Fixnum) or j < 0 or j >= @col)
                return nil
            end
            
            return @matrix[i][j]
        end
        
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
          nulos.to_f/total.to_f
        end
    
        
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
        
        def +(other)
                          raise ArgumentError , 'El argumento debe ser una matriz' unless other.is_a? Matriz
                          raise ArgumentError , 'Las matrices deben ser del mismo tamano' unless @fil == other.fil and @col == other.col
      
                          c = Matriz_Densa.new(@fil, @col)
                          i = 0
                    while(i < @fil)
                            j = 0
                            while(j < @col)
                                          c.matrix[i][j] = @matrix[i][j] + other.matrix[i][j]
                                          j += 1
                                end 
                                i += 1
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
                                          c.matrix[i][j] = @matrix[i][j] - other.matrix[i][j]
                                          j += 1
                                end
                                i += 1
                          end
                          c
        end
            
        def *(other)
                        raise ArgumentError , 'Parametro invalido' unless other.is_a? Numeric or other.is_a? Matriz
    
                        if(other.is_a? Numeric) # Matriz * numero
                                  c = Matriz_Densa.new(@fil, @col)
                              i = 0
                                  while(i < @N)
                                    j = 0
                                    while(j < @M)
                                             c.matrix = @matrix[i][j] * other
                                             j += 1
                                        end # while j
                                        i += 1
                                  end # while i
                        else # Matriz * Matriz
                                raise ArgumentError , 'Matriz no compatible (A.fil == B.col)' unless @col == other.fil
                                c = Matriz_Densa.new(@fil, other.col)
                                i = 0
                                while(i < @fil)
                                    j = 0
                                    while(j < other.col)
                                        k = 0
                                        c.matrix[i][j] = 0
                                        while(k < @col)
                                            c.matrix[i][j] += @matrix[i][k] * other.matrix[k][j]
                                            k += 1
                                        end # while k
                                        j += 1
                                    end # while j
                                    i += 1
                                end # while i
                        end # while else
      
                        c
        end # *(other)
        
        def min
            if(porcentaje_nulos == 1.0)
                return 0
            end
                    
            min = @matrix[0][0]
            i = 0
            while (i < @fil)
                j = 0
                while (j < @col)
                    if (@matrix[i][j] < min)
                        min = @matrix[i][j]
                    end
                    j += 1
                end
                i += 1
            end
            min
        end
        
        def max
            if(porcentaje_nulos == 1.0)
                return 0
            end
                    
            max = @matrix[0][0]
            i = 0
            while (i < @fil)
                j = 0
                while (j < @col)
                    if (@matrix[i][j] > max)
                        max = @matrix[i][j]
                    end
                    j += 1
                end
                i += 1
            end
            max
        end
    end # Class
end # Module

