require "./matrix.rb"

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
    
   def null_percent
      total = @fil*@col
      no_nulos = 0
      
      i = 0
      while(i < @fil)
        j = 0
        while(j < @col)
          if(@matrix[i][j] != @matrix[i][j].class.null)
            no_nulos += 1
          end
          j += 1
        end
        i += 1
      end
      
      nulos = total - no_nulos
      nulos.to_f/total.to_f
    end #endmethod null_percent      

    def set(i, j, value)
      if( i < 0 or i >=@fil or j < 0 or j >= @col)
       return nil
      end
        
      if(!(value.class.respond_to? :null))
        puts "Se debe definir el metodo \"null\" que devuelva un elemento nulo para la clase #{value.class}"
        return nil
      end

      # Contar elementos nulos y comprobar si se hace una matriz dispersa
      # De momento, no dejamos añadir elementos nulos
      # ¿o si?
      #if(value != nil and value != value.class.null) # Y se puede comprobar para todos los tipos si es necesario. (con un método zero, por ejemplo)
        @matrix[i][j] = value
      #end
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
                      raise ArgumentError , 'Tipo invalido' unless other.is_a? Matriz
                      raise ArgumentError , 'Matriz no compatible' unless @fil == other.fil and @col == other.col
  
                      c = Matriz_Densa.new(@fil, @col)
                      i = 0
                while(i < @fil)
                        j = 0
                        while(j < @col)
                                      c.set(i, j, get(i,j) + other.get(i,j))
                                      j += 1
                            end 
                            i += 1
                      end
                      c
    end
        
    def -(other)
                      raise ArgumentError , 'Tipo invalido' unless other.is_a? Matriz
                      raise ArgumentError , 'Matriz no compatible' unless @fil == other.fil and @col == other.col
  
                      c = Matriz_Densa.new(@fil, @col)
                      i = 0
                      while(i < @fil)
                        j = 0
                        while(j < @col)
                                      c.set(i, j, get(i,j) - other.get(i,j))
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
                                         c.set(i, j, get(i,j)*other)
                                         j += 1
                                    end # while j
                                    i += 1
                              end # while i
                    else # Matriz * Matriz
                              raise ArgumentError , 'Matriz no compatible (A.N == B.M)' unless @col == other.fil
                              c = Matriz_Densa.new(@fil, other.col)
                              i = 0
                              while(i < @fil)
                                j = 0
                                while(j < other.col)
                                              k = 0
                                        #if (get(i,j).is_a? Fraccion)                                              
                                        #        c.set(i, j, Fraccion.null
                                        #else
                                        #        c.set(i, j, 0)
                                        #end
                                              while(k < @col)
                                                c.set(i, j, get(i, k) * other.get(k,j) + c.get(i,j))
                                                k += 1
                                              end # while k
                                          j += 1
                                end # while j
                                    i += 1
                              end # while i
                    end # while else
  
                    c
    end # *(other)
  end # Class
end # Module

m1 = MatrixExpansion::Matriz_Densa.new(3,3)
puts m1.to_s