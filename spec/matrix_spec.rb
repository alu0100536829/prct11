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
        
        @m1.set_valores_num
        @m2.set_valores_num
        @m3.set_valores_fracc
        @m4.set_valores_fracc
        
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
            @m1.set_valores_num
        end
    end

    describe " # Representacion de la matriz." do
        it " # Mostrar la matriz con numeros." do
            @m1.to_s.should == "1\t2\t\n3\t4\t\n"
        end
        
        it " # Mostrar la matriz con fracciones. " do
            @m3.to_s.should == "1/2\t2/3\t\n3/4\t4/5\t\n"
        end 
    end
    
    describe " # Operaciones con matrices. " do
        it " # Suma de matrices. " do
            (@m1 + @m2).to_s.should == "2\t4\t\n6\t8\t\n"
            (@m3 + @m4).to_s.should == "1/1\t4/3\t\n3/2\t8/5\t\n"
        end
        
        it " # Resta de matrices." do
            (@m1 - @m2).to_s.should == "0\t0\t\n0\t0\t\n"
            (@m3 - @m4).to_s.should == "0/1\t0/1\t\n0/1\t0/1\t\n"
        end
        
        it " # Multiplicacion de matrices." do
            (@m1 * @m2).to_s.should == "7\t10\t\n15\t22\t\n"
            (@m3 * @m4).to_s.should == "3/4\t13/15\t\n39/40\t57/50\t\n"
        end
    end
    
end

