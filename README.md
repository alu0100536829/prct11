# MatrixExpansion

## Introducción
    
Gema que permite el uso de matrices densas y dispersas a través de la herencia de una matriz simple. Todas las operaciones con números y fracciones incluidas.

## Instalación

Add this line to your application's Gemfile:

    gem 'matrix_expansion'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install matrix_expansion

## Diseño

A la hora de realizar las matrices densas se ha realizado de forma natural (como para cualquier matriz simple). El planteamiento importante es para la representación de las matrices dispersas. Hemos decidido finalmente, tras haber pensado en implementarlo con varios vectores, en que era más sencillo, tanto para el acceso como para las operaciones, implementarlo con un array de hash. Cada fila es un array que contiene hashes, donde la clave es la columna del elemento no nulo y el valor es el propio valor del elemento no nulo. De esta  forma, solamente se almacenan los valores nulos. Si se accediera a otra posición se devolvería 0 (aunque este no este almacenado en la matriz dispersa para ahorrar memoria).
