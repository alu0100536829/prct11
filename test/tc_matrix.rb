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

# Clase Test_Matriz

require "./lib/matrix_expansion.rb"
require "test/unit"
       
        

class Test_Matriz < Test::Unit::TestCase
        def setup
            
            #matrices densas
            @m1 = MatrixExpansion::Matriz_Densa.new(2,2)
            @m2 = MatrixExpansion::Matriz_Densa.new(2,2)
            @m3 = MatrixExpansion::Matriz_Densa.new(2,2)
    
            @m1.set_valores_num
            
            @m2.set_valores_num

            @m3.matrix[0][0] = 2
            @m3.matrix[0][1] = 4
            @m3.matrix[1][0] = 6
            @m3.matrix[1][1] = 8
            
            #matrices dispersas
            @md1 = MatrixExpansion::Matriz_Dispersa.new(2,2)
            @md2 = MatrixExpansion::Matriz_Dispersa.new(2,2)
            @md3 = MatrixExpansion::Matriz_Dispersa.new(2,2)

            @md1.set(0,0,0)
            @md1.set(0,1,0)
            @md1.set(1,0,5)
            @md1.set(1,1,0)

            @md2.set(0,0,0)
            @md2.set(0,1,0)
            @md2.set(1,0,3)
            @md2.set(1,1,0)

            @md3.set(0,0,0)
            @md3.set(0,1,0)
            @md3.set(1,0,2)
            @md3.set(1,1,0)
            
            #matrices densas para provocar fallo typecheck
            @merr1 = MatrixExpansion::Matriz_Densa.new(1,1)
            @merr2 = MatrixExpansion::Matriz_Densa.new(1,1)
            @merr1.matrix[0][0] = 5
            @merr2.matrix[0][0] ="error"
            
            
            #matrices densas para provocar error en valor de argumentos
            @mfail1 = MatrixExpansion::Matriz_Densa.new(1,1)
            @mfail2 = MatrixExpansion::Matriz_Densa.new(2,2)
            
        end
    
        def test_simple
            assert_equal(@m3.to_s,(@m1+@m2).to_s)
        end
        
        def test_simple2
            assert_equal(@md3.to_s,(@md1-@md2).to_s)
        end
        
        def test_typecheck
            assert_raise(TypeError) {@merr1+@merr2}
        end
        
        def test_failure
            assert_raise(ArgumentError) {@mfail1*@mfail2}
        end
end