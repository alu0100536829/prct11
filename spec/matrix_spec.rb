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

# Pruebas rspec

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
        
        it " # Producto de matrices." do
            (@m1 * @m2).to_s.should == "7\t10\t\n15\t22\t\n"
            (@m3 * @m4).to_s.should == "3/4\t13/15\t\n39/40\t57/50\t\n"
        end
        
        it " # Suma de matrices de fracciones y numeros." do
            (@m1 + @m3).to_s.should == "3/2\t8/3\t\n15/4\t24/5\t\n"
        end
        
        it " # Resta de matrices de fracciones y numeros." do
            (@m1 - @m3).to_s.should == "1/2\t4/3\t\n9/4\t16/5\t\n"
        end
        
        it " # Producto de matrices de fracciones y numeros." do
            (@m1 * @m3).to_s.should == "2/1\t34/15\t\n9/2\t26/5\t\n"
        end
    end
    
    describe " # Otras operaciones. " do
        it " # Minimo de una matriz. " do
            @m1.min.should eq(1)
            @m3.min.to_s.should eq("1/2")
        end
        
        it " # Maximo de una matriz. " do
            @m1.max.should eq(4)
            @m3.max.to_s.should eq("4/5")
        end
    end
    
end


describe MatrixExpansion::Matriz_Densa do
    
    before :each do
        @mden = MatrixExpansion::Matriz_Densa.new(2,2)
        @mden.matrix[0][1] = 3
        
        @mdis1 = MatrixExpansion::Matriz_Dispersa.densa_a_dispersa(@mden)
        
        @mdis2 = MatrixExpansion::Matriz_Dispersa.new(2,2)
        @mdis2.set(1,1,2)
        
        @mdis3 = MatrixExpansion::Matriz_Dispersa.new(2,2)
        @mdis3.set(1,1,Fraccion.new(1,2))
        
    end
    describe " # Almacenamiento de matrices. " do
        it " # Se debe poder crear matrices dispersas vacias o a partir de matrices densas." do     
            MatrixExpansion::Matriz_Dispersa.new(5, 5)
            MatrixExpansion::Matriz_Dispersa.densa_a_dispersa(@mden)
        end
        it " # Se debe poder acceder a los datos almacenados en la matriz " do      
            @mdis1.get(0,1).should eq(3)
            @mdis2.get(1,1).should eq(2)
        end
        it " # Se deben poder modificar los datos almacenados en la matriz " do     
            @mdis1.set(0,1,5)
            @mdis1.get(0,1).should eq(5)
            
            @mdis2.set(1,1,8)
            @mdis2.get(1,1).should eq(8)
        end
    end

    describe " # Representacion de la matriz." do
        it " # Mostrar la matriz con numeros." do
            @mdis1.to_s.should == "(0,1)=>3 \n\n"
        end
        
        it " # Mostrar la matriz con fracciones. " do
            @mdis3.to_s.should == "\n(1,1)=>1/2 \n"
        end 
    end
    describe " # Operaciones con matrices. " do
        it " # Suma de matrices. " do
            (@mdis1 + @mdis2).to_s.should == "0\t3\t\n0\t2\t\n"
            (@mdis3 + @mdis3).to_s.should == "\n(1,1)=>1/1 \n"
        end
        
        it " # Resta de matrices." do
            (@mdis1 - @mdis2).to_s.should == "0\t3\t\n0\t-2\t\n"
            (@mdis3 - @mdis3).to_s.should == "\n\n"
        end
        
        it " # Producto de matrices." do
            (@mdis1 * @mdis1).to_s.should == "(0,1)=>18 \n\n"
            (@mdis3 * @mdis3).to_s.should == "\n(1,1)=>1/2 \n"
        end
        
        it " # Suma de matrices de fracciones y numeros." do
            (@mdis2 + @mdis3).to_s.should == "\n(1,1)=>5/2 \n"
        end
        
        it " # Resta de matrices de fracciones y numeros." do
            (@mdis2 - @mdis3).to_s.should == "\n(1,1)=>3/2 \n"
        end
        
        it " # Producto de matrices de fracciones y numeros." do
            (@mdis2 * @mdis3).to_s.should == "\n(1,1)=>2/1 \n"
        end
    end
    
    describe " # Otras operaciones. " do
        it " # Minimo de una matriz. " do
            @mdis1.min.should eq(3)
            @mdis3.min.to_s.should eq("1/2")
        end
        
        it " # Maximo de una matriz. " do
            @mdis1.max.should eq(3)
            @mdis3.max.to_s.should eq("1/2")
        end
    end
        
    
    

    
    
end
