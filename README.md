# Bebidas parte 2 (colecciones y bloques)

Tito ahora no sólo puede tomar las bebidas existentes, sino que hay nuevas bebidas y puede hacer mezclas con las bebidas existentes. 

- Licuado de frutas: está hecho por varias frutas que es imposible identificar, pero se conocen los nutrientes que aporta cada una. Cada litro que se consuma (1000 cm3) da un rendimiento igual a la suma de todos los nutrientes. Al licuado se le pueden agregan mas frutas, leche, hielo u otros ingrediente, pero sólo se registran los nutrientes correspondientes.
- Agua "saborizada". Se trata de una composicioń de ¾ de agua y ¼ de alguna de las otras bebidas. La parte de agua aporta una unidad de rendimiento más el proporcional de la bebida. Por ejemplo, 10 cm3 de agua con whisky otorga un rendimiento de 1 más lo que aporten los 2.5 cm3 de wisky. 
- Coctel: está compuesto por una serie de bebidas, todas en la misma proporción. El rendimiento es el producto de los rendimientos de las bebidas que lo componen. Por ejemplo, si hubiera cianuro en el coctel su rendimento va a ser 0 sin importar las otras bebidas. 

El requerimiento es el mismo que en la primera parte, hacer que Tito tome cierta cantidad de una bebida y pueda responder su velocidad. 
Para pensar:
- ¿Si se le agregan nuevos ingredientes al licuado luego que forme parte del coctel, afecta al rendimiento que otorta el coctel? 
- ¿Puede el coctel incluir a la vez whisky y agua saborizada con whisky?
- ¿Puede el coctel incluir el agua saborizada con coctel?


***************************************************
## Enunciado de la parte 1 (polimorfismo)

Tito es un voluntario que se ofreció para participar de un estudio en el que se plantea medir cómo afecta 
el consumo de algunas sustancias al rendimiento de los deportistas.

Tito pesa actualmente 70 kilos. Tiene la gran ventaja de que cada bebida que toma _reemplaza_ a la anterior. Hoy modelaremos tres bebidas:

* **Whisky**: el whisky provoca sueño, mareo y jaquecas. Un deportista con whisky en su sistema tiene un rendimiento de 0.9 elevado a la dosis consumida, en centímetros cúbicos.
* **Tereré**: el tereré es diurético, laxante y estimulante del rendimiento. Un deportista con tereré en su sistema tiene un rendimiento de 0.1 por cada centímetro cúbico de dosis. Sin embargo, nunca rinde menos que 1.
* **Cianuro**: el cianuro no favorece al rendimiento, sino que el deportista, luego de consumirlo queda como muerto, llenos de abulia y de marasmo. Con cianuro, el rendimiento es siempre 0.

> 1. Hacer que Tito tome cierta cantidad de una bebida, con el mensaje `consumir(cantidad, bebida)`
> 2. Conocer la velocidad de Tito, mediante el mensaje `velocidad()`.

La velocidad de Tito (en m/s) se calcula como el rendimiento de la sustancia por la inercia base de Tito (490 kg*m/s) dividido su peso.

**¡No vale guardarse la velocidad!**


## Pista
Para calcular la potencia los número entienden el mensaje `**`. Por ejemplo, '2 al cubo' se expresa `2 ** 3`

Además entienden los mensajes `min` y `max` que permiten hacer:

* `1.max(3)`  Retorna 3, por ser el máximo
* `1.min(3)`  Retorna 1, por ser el mínimo


## Conclusión

En este ejercicio el _polimorfismo_ aparece como `tito` utiliza las distintas sustancias para conocer su rendimiento.

Cabe destacar que para lograrlo, las sustancias deben entender el mismo mensaje, incluyendo nombre **y parámetros**. Esto significa que si para conocer el rendimiento que algunas sustancias es necesario pasar algún parámetro en el mensaje (como la cantidad de la dosis para el `whisky` y `terere`) entonces todas las sustancias (incluyendo el `cianuro`) lo deberían esperar.


También hay que diseñar qué datos son _atributos_ y cuáles _métodos de consulta_ de `tito`. El enunciado pide que `velocidad` **no** sea un atributo ya que se obtiene de un cálculo que involucra el rendimiento, inercia y peso de `tito`.
