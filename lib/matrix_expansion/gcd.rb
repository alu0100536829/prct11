#
# = matriz_densa.rb
#  
#    Autores::   Teno González Dos Santos,  Albano José Yanes Reyes
#    Fecha:: 27/11/2013 
#    Asignatura:: Lenguajes y Paradigmas de Programación
#    Curso:: Tercero de Grado en Ingeniería Informática
#    Universidad de la Laguna
#
#  == Practica 10: Matrices densas y dispersas
#     Considere la Gema para la representación de Matrices que ha desarrollado en prácticas 
#     anteriores. Los objetivos de esta práctica son dos:
#         Documentar la gema (utlizando RDOC).
#         Desarrollar métodos con la filosofía de la programación funcional.
#
#  === metodo gcd
#        Definicion del metodo gdc para el cálculo de mínimo común múltiplo
#
#
def gcd(u, v)
  u, v = u.abs, v.abs
  while v != 0 
    u, v = v, u % v
  end
  u
end