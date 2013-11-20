require "./lib/matrix_expansion/gcd.rb"

class Fraccion
        include Comparable
        attr_reader :a, :b #a: numerador, b: denominador
        def initialize(a,b)
                #comprobamos que los datos de entradas sean numericos
                raise unless a.is_a?(Numeric)
                raise unless b.is_a?(Numeric)
                #comprobamos que el dominador no sea cero 
                raise unless (b != 0)
                #inicializamos las variables
                 @a, @b = a, b
        end
        #formateo de la salida (a/b)
        def to_s
                "#{@a}/#{@b}"
        end

        #metodo que retorna el numerador 
        def num
                return @a
        end
        #metedo que retorna el denominador 
        def denom
                return @b
        end
        #Fraccion en modo flotante
        def to_f
                @a.to_f / @b.to_f #conversion de tipo a flotante mediante to_f
        end
        
        #Fracción pasada a float. (ej: 1.25)
        def abs
                 f= Fraccion.new(@a.abs, @b.abs)
        end

        #Fracción reciproca o inversa (a/b -> b/a)
        def reciprocal
                f= Fraccion.new(@b, @a)
        end
        
        #Suma de fracciones
        def + (other)
                comun = @b * other.denom
                a1 = @a * other.denom
                a2 = other.num * @b
                a3 = a1 + a2
                k = gcd(a3,comun)
                a3 /= k
                comun /= k
                Fraccion.new(a3,comun)
        end
        
        #Resta de fracciones
        def - (other)
                comun = @b * other.denom
                a1 = @a * other.denom
                a2 = other.num * @b
                a3 = a1 - a2
                k = gcd(a3,comun)
                a3 /= k
                comun /= k
                Fraccion.new(a3,comun)
        end

        #Opuesto de fracción. La suma de una fracción y su opuesto debe ser 0. 
        def -@
                k = gcd(@a, @b)
        a = @a / k
        b = @b / k
        if (b < 0)  #Si el denominador es negativo
                        return Fraccion.new(a,-b)
                else 
                        return Fraccion.new(-a,b)
                end
        end

        #Producto de fracciones
        def * (other)
                a = @a * other.num
                b = @b * other.denom
                k = gcd(a,b)
                a /= k
                b /= k
                Fraccion.new(a,b)
        end

        #División de fracciones
        def / (other)
                a = @a * other.denom
                b = @b * other.num
                k = gcd(a,b)
                a /= k
                b /= k
                Fraccion.new(a,b)
        end
        
        #Resto de fracciones
        def % (other)
                r = Fraccion.new(0,1) #Inicializa objeto
                r = self
                while (r.to_f >= other.to_f) do   #Hasta que no se pueda restar más. Queda en r el resto.
                        r = r - other
                end
                return r        
        end
        

        def <=> (other)
                self.to_f <=> other.to_f
        end
        
        def coerce (other)
            [Fraccion.new(other,1),self]
        end
        
end