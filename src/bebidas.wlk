object whisky {
    method rendimiento(cantidad) = 0.9 ** cantidad
}

object terere {
    method rendimiento(cantidad) = 1.max(0.1 * cantidad)
}

object cianuro {
    method rendimiento(cantidad) = 0
}

object banana {
    method nutrientes() = 12
}

object frutilla {
    method nutrientes() = 8
}

object manzana {
    method nutrientes() = 10
}

object naranja {
    method nutrientes() = 5
}

object licuadoDeFruta {
    const composicion = []

    method agregarFruta(unaFruta) { composicion.add(unaFruta) }
    method rendimiento(cantidad) = cantidad.div(1000) * composicion.sum({fruta => fruta.nutrientes()})
}

object aguaSaborizada {
    var sabor = whisky

    method cambiarSabor(unaBebida) { sabor = unaBebida } 
    method rendimiento(cantidad) = 1 + sabor.rendimiento(cantidad * 0.25)
}

object coctel {
    const composicion = []

    method agregarBebida(unaBebida) { composicion.add(unaBebida) }
    method rendimiento(cantidad) = composicion.fold(1, {acumulado, bebida => acumulado * bebida.rendimiento(cantidad)})
}