require "./lib/matrix_expansion.rb"
require "test/unit"
       
        

class Test_Matriz < Test::Unit::TestCase
        def test_simple
                @m1 = MatrixExpansion::Matriz_Densa.new(2,2)
                @m2 = MatrixExpansion::Matriz_Densa.new(2,2)
                @m3 = MatrixExpansion::Matriz_Densa.new(2,2)
        
                @m1.set_valores_num
                
                @m2.set_valores_num

                @m3.matrix[0][0] = 2
                @m3.matrix[0][1] = 4
                @m3.matrix[1][0] = 6
                @m3.matrix[1][1] = 8

                assert_equal(@m3.to_s,(@m1+@m2).to_s)
        end
        
        def test_simple2
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

                assert_equal(@md3.to_s,(@md1-@md2).to_s)


        end
        
        def test_typecheck
                @m1 = MatrixExpansion::Matriz_Densa.new(1,1)
                @m2 = MatrixExpansion::Matriz_Densa.new(1,1)
                @m1.set(0,0,5)
                @m2.set(0,0,"error")

                assert_raise(TypeError) {@m1+@m2}
        end
        
        def test_failure
                @m1 = MatrixExpansion::Matriz_Densa.new(1,1)
                @m2 = MatrixExpansion::Matriz_Densa.new(2,2)

                assert_raise(ArgumentError) {@m1*@m2}
        end
end