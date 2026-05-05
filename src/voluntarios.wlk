import src.bebidas.*

object tito {
    const peso = 70
    var sustanciaEnSistema = whisky
    var dosisDeSustanciaEnSistema = 0
    const property inercia = 490

    method sustanciaEnSistema() = sustanciaEnSistema
    method dosisDeSustanciaEnSistema() = dosisDeSustanciaEnSistema
    method consumir(cantidad, sustancia) {
        sustanciaEnSistema = sustancia
        dosisDeSustanciaEnSistema = cantidad
    }
    method velocidad() = sustanciaEnSistema.rendimiento(dosisDeSustanciaEnSistema) * inercia / peso
}
