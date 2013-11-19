require "./lib/matrix_expansion.rb"

describe MatrixExpansion::Matriz do
    before :each do
        @m1 = MatrixExpansion::Matriz.new(5, 5)
    end
    describe " # Almacenamiento de matrices. " do
        it " # Se debe almacenar el numero de filas." do
            @m1.fil
        end
        it " # Se debe almacenar el numero de columnas." do
            @m1.col
        end
        it " # Se debe almacenar un contenido." do
            @m1.matrix
        end
    end
end

describe MatrixExpansion::Matriz_Densa do
    
    before :each do
        @m1 = MatrixExpansion::Matriz_Densa.new(2,2)
        @m2 = MatrixExpansion::Matriz_Densa.new(2,2)
        @m3 = MatrixExpansion::Matriz_Densa.new(2,2)
        @m4 = MatrixExpansion::Matriz_Densa.new(2,2)
        
        @m1.set_valores_num(@m1.fil,@m1.col)
        @m2.set_valores_num(@m2.fil,@m2.col)
        @m3.set_valores_fracc(@m3.fil,@m3.col)
        @m4.set_valores_fracc(@m4.fil,@m4.col)
        
    end
    describe " # Almacenamiento de matrices. " do
        it " # Se debe poder acceder a los datos almacenados en la matriz " do      
            @m1.matrix[0][0].should eq(1)
            @m1.matrix[0][1].should eq(2)
        end
        it " # Se deben poder modificar los datos almacenados en la matriz " do     
            @m1.matrix[0][0] = 5
            @m1.matrix[0][0].should eq(5)
            
            @m1.matrix[0][1] = 8
            @m1.matrix[0][1].should eq(8)
        end
    end

end

