# Guía para Desarrolladores

## Introducción

Esta guía está diseñada para ayudar a desarrolladores que quieran contribuir o extender el proyecto "Bebidas y Voluntarios". Aquí encontrarás información sobre el flujo de trabajo, convenciones de código y mejores prácticas.

## Configuración del Entorno de Desarrollo

### Requisitos
- Visual Studio Code con extensión de Wollok
- Wollok 4.2.3+
- Git

### Configuración Inicial
```bash
# Clonar el repositorio
git clone <url-del-repositorio>
cd bebidas

# Abrir en VS Code
code .
```

Ver [setup.md](setup.md) para instrucciones detalladas.

## Flujo de Trabajo

### 1. Antes de Empezar

1. **Actualiza tu rama local:**
   ```bash
   git checkout main
   git pull origin main
   ```

2. **Crea una nueva rama:**
   ```bash
   git checkout -b feature/nombre-descriptivo
   # o
   git checkout -b fix/nombre-del-bug
   ```

### 2. Durante el Desarrollo

1. **Escribe tests primero (TDD):**
   ```wollok
   describe "Tito | Nueva funcionalidad" {
       test "descripción del comportamiento esperado" {
           // Test que falla
           assert.equals(valorEsperado, tito.nuevoMetodo())
       }
   }
   ```

2. **Implementa la funcionalidad:**
   ```wollok
   object tito {
       method nuevoMetodo() {
           // Implementación mínima para pasar el test
       }
   }
   ```

3. **Ejecuta los tests frecuentemente:**
   - Después de cada cambio significativo
   - Antes de hacer commit

4. **Refactoriza:**
   - Mejora el código manteniendo los tests en verde
   - Elimina duplicación
   - Mejora nombres de variables/métodos

### 3. Antes de Hacer Commit

1. **Ejecuta TODOS los tests:**
   - Desde VS Code: Ctrl+Shift+P → "Wollok: Run All Tests"
   - O desde terminal: `wollok test` (si tienes Wollok CLI)

2. **Verifica que no haya errores de compilación:**
   - Revisa el panel "Problems" en VS Code (Ctrl+Shift+M)

3. **Revisa tus cambios:**
   ```bash
   git status
   git diff
   ```

### 4. Hacer Commit

```bash
# Agrega los archivos modificados
git add src/archivo.wlk tests/archivo.wtest

# Commit con mensaje descriptivo
git commit -m "Agrega nueva bebida energizante

- Implementa objeto energizante con rendimiento
- Agrega tests para diferentes dosis
- Fixes #123"
```

### 5. Push y Pull Request

```bash
# Push a tu rama
git push origin feature/nombre-descriptivo

# Crea un Pull Request en GitHub/GitLab
# Describe los cambios y referencia issues relacionados
```

## Convenciones de Código

### Nomenclatura

#### Objetos
```wollok
// Objetos singleton: camelCase
object tito { }
object whisky { }
object terere { }
object cianuro { }
```

#### Métodos
```wollok
// Métodos: camelCase
method velocidad() { }
method consumir(cantidad, sustancia) { }
method rendimiento(cantidad) { }
```

#### Variables
```wollok
// Variables: camelCase
var peso = 70
var sustanciaEnSistema = whisky
var dosisDeSustanciaEnSistema = 0
const property inercia = 490
```

### Estilo de Código

#### Indentación
- Usa **4 espacios** (no tabs)
- VS Code con la extensión de Wollok lo configura automáticamente

#### Llaves
```wollok
// ✓ Bueno: llave de apertura en la misma línea
method ejemplo() {
    // código
}

// ✗ Malo: llave de apertura en nueva línea
method ejemplo()
{
    // código
}
```

#### Espacios
```wollok
// ✓ Bueno: espacios alrededor de operadores
const resultado = 0.9 ** cantidad

// ✗ Malo: sin espacios
const resultado=0.9**cantidad

// ✓ Bueno: espacio después de comas
method consumir(cantidad, sustancia)

// ✗ Malo: sin espacios
method consumir(cantidad,sustancia)
```

#### Líneas en Blanco
```wollok
object tito {
    // Una línea en blanco entre métodos
    method velocidad() {
        // código
    }
    
    method consumir(cantidad, sustancia) {
        // código
    }
}
```

### Comentarios

#### Cuándo Comentar
```wollok
// ✓ Bueno: comentar lógica compleja o no obvia
// Nunca rinde menos que 1 (efecto estimulante base)
method rendimiento(cantidad) = (0.1 * cantidad).max(1)

// ✗ Malo: comentar lo obvio
method velocidad() {
    return sustanciaEnSistema.rendimiento(dosisDeSustanciaEnSistema) * inercia / peso  // retorna velocidad
}
```

#### Comentarios TODO
```wollok
// TODO: Implementar validación de dosis negativa
// FIXME: Este método no maneja el caso de peso cero
// HACK: Solución temporal hasta refactorizar
```

## Mejores Prácticas

### 1. Principio de Responsabilidad Única
Cada objeto debe tener una sola responsabilidad:

```wollok
// ✓ Bueno: cada objeto tiene una responsabilidad clara
object tito {
    // Responsabilidad: gestionar consumo y calcular velocidad
}

object whisky {
    // Responsabilidad: calcular rendimiento del whisky
}

// ✗ Malo: objeto con múltiples responsabilidades
object sistema {
    // Gestiona tito, whisky, terere, cianuro
}
```

### 2. Encapsulamiento
No expongas detalles de implementación:

```wollok
// ✓ Bueno: encapsula el estado interno
object tito {
    var peso = 70  // privado
    var sustanciaEnSistema = whisky  // privado
    var dosisDeSustanciaEnSistema = 0  // privado
    const property inercia = 490  // público (constante)
    
    method consumir(cantidad, sustancia) {
        sustanciaEnSistema = sustancia
        dosisDeSustanciaEnSistema = cantidad
    }
}

// ✗ Malo: expone todo con property
object tito {
    var property peso = 70  // No debería ser público
    var property sustanciaEnSistema = whisky  // No debería ser público
}
```

### 3. Polimorfismo
Aprovecha el polimorfismo de Wollok:

```wollok
// ✓ Bueno: todas las bebidas responden a la misma interfaz
tito.consumir(10, whisky)
tito.velocidad()  // Usa whisky.rendimiento(10)

tito.consumir(10, terere)
tito.velocidad()  // Usa terere.rendimiento(10)

// ✗ Malo: usar condicionales para tipos
method velocidad() {
    if (sustanciaEnSistema == whisky) return 0.9 ** dosis * inercia / peso
    else if (sustanciaEnSistema == terere) return (0.1 * dosis).max(1) * inercia / peso
    // ...
}
```

### 4. Inmutabilidad Cuando Sea Posible
```wollok
// ✓ Bueno: usa const para valores que no cambian
object tito {
    const property inercia = 490
}

// ✗ Malo: usar var innecesariamente
object tito {
    var inercia = 490  // ¿realmente necesita cambiar?
}
```

### 5. Nombres Descriptivos
```wollok
// ✓ Bueno: nombres que expresan intención
method velocidad() = sustanciaEnSistema.rendimiento(dosisDeSustanciaEnSistema) * inercia / peso

// ✗ Malo: nombres crípticos
method v() = s.r(d) * i / p
```

## Patrones Comunes

### Pattern: Métodos de Consulta
```wollok
// Métodos que retornan información sin cambiar estado
method velocidad() = sustanciaEnSistema.rendimiento(dosisDeSustanciaEnSistema) * inercia / peso
method sustanciaEnSistema() = sustanciaEnSistema
method dosisDeSustanciaEnSistema() = dosisDeSustanciaEnSistema
method rendimiento(cantidad) = 0.9 ** cantidad
```

### Pattern: Métodos de Acción
```wollok
// Métodos que cambian el estado del objeto
method consumir(cantidad, sustancia) { 
    sustanciaEnSistema = sustancia
    dosisDeSustanciaEnSistema = cantidad
}
```

### Pattern: Delegation
```wollok
// Delegar a componentes
object tito {
    method velocidad() = 
        sustanciaEnSistema.rendimiento(dosisDeSustanciaEnSistema) * inercia / peso
        // Delega el cálculo de rendimiento a la sustancia
}
```

## Flujo del Sistema

El flujo típico del sistema es:

1. **Estado inicial:**
   - Tito tiene whisky en su sistema con dosis 0
   - Peso: 70 kg, Inercia: 490 kg*m/s

2. **Consumo de bebida:**
   - Tito invoca `consumir(cantidad, sustancia)`
   - La nueva sustancia reemplaza a la anterior
   - Se guarda la dosis consumida

3. **Cálculo de velocidad:**
   - Tito invoca `velocidad()`
   - Se consulta el rendimiento de la sustancia actual
   - Se calcula: rendimiento × inercia / peso

4. **Recálculo:**
   - Cada vez que se consulta la velocidad, se recalcula con los valores actuales
   - No se guarda la velocidad (como pide el enunciado)

## Testing

### Test-Driven Development (TDD)

1. **Red:** Escribe un test que falle
2. **Green:** Implementa lo mínimo para que pase
3. **Refactor:** Mejora el código

```wollok
// 1. RED: Test que falla
describe "Tito | Nueva funcionalidad" {
    test "descripción del comportamiento" {
        assert.equals(valorEsperado, tito.nuevoMetodo())
    }
}

// 2. GREEN: Implementación mínima
object tito {
    method nuevoMetodo() = valorEsperado
}

// 3. REFACTOR: (si es necesario)
```

Ver [testing.md](testing.md) para más detalles.

## Debugging

### Técnicas de Debugging

#### 1. Console.println()
```wollok
method velocidad() {
    const rendimiento = sustanciaEnSistema.rendimiento(dosisDeSustanciaEnSistema)
    console.println("Rendimiento: " + rendimiento)
    console.println("Inercia: " + inercia)
    console.println("Peso: " + peso)
    return rendimiento * inercia / peso
}
```

#### 2. Breakpoints
- Click en el margen izquierdo del editor en VS Code
- Ejecuta en modo Debug (F5)
- Inspecciona variables en el panel de Debug

#### 3. Tests Específicos
```wollok
test "debug: verificar cálculo de velocidad con whisky" {
    tito.consumir(10, whisky)
    console.println("Velocidad: " + tito.velocidad())
    console.println("Esperado: ~2.44")
    assert.that(tito.velocidad() > 2.4 && tito.velocidad() < 2.5)
}
```

## Errores Comunes

### 1. Olvidar el `self`
```wollok
// ✗ Malo
object tito {
    method velocidad() {
        return sustanciaEnSistema.rendimiento(dosisDeSustanciaEnSistema) * inercia / peso  // OK en este caso
    }
}

// ✓ Bueno (cuando se necesita)
object tito {
    method ejemplo() {
        return self.velocidad()  // Necesita self para llamar a otro método
    }
}
```

### 2. No Inicializar Variables
```wollok
// ✗ Malo
object tito {
    var peso  // Error: no inicializada
}

// ✓ Bueno
object tito {
    var peso = 70
}
```

### 3. Confundir min() y max()
```wollok
// ✗ Malo: usa min() cuando debería ser max()
method rendimiento(cantidad) = (0.1 * cantidad).min(1)  // Siempre <= 1

// ✓ Bueno: usa max() para establecer mínimo
method rendimiento(cantidad) = (0.1 * cantidad).max(1)  // Mínimo 1
```

### 4. Olvidar que cada bebida reemplaza a la anterior
```wollok
// ✗ Malo: asumir que las bebidas se acumulan
tito.consumir(10, whisky)
tito.consumir(5, terere)
// Ahora solo tiene tereré, no whisky + tereré

// ✓ Bueno: entender el reemplazo
tito.consumir(10, whisky)  // Tiene whisky
tito.consumir(5, terere)   // Ahora tiene tereré (reemplazó al whisky)
```

## Preguntas Frecuentes

### ¿Cómo agrego una nueva bebida?

1. Crea un nuevo objeto en `src/bebidas.wlk`
2. Implementa el método `rendimiento(cantidad)`
3. Agrega tests en `tests/bebidas.wtest`
4. Úsalo en `tito.consumir(cantidad, nuevaBebida)`

Ejemplo:
```wollok
object cafeina {
    method rendimiento(cantidad) = 1 + (cantidad * 0.05)
}
```

### ¿Cómo agrego un nuevo voluntario?

1. Crea un nuevo objeto en `src/voluntarios.wlk`
2. Implementa los métodos necesarios (`consumir`, `velocidad`)
3. Agrega tests en `tests/voluntarios.wtest`

### ¿Puedo modificar el README.md?

No, el README.md contiene la especificación del ejercicio y no debe modificarse.

### ¿Dónde reporto bugs?

Crea un issue en el repositorio con:
- Descripción del bug
- Pasos para reproducir
- Comportamiento esperado vs actual
- Versión de Wollok

## Contacto

Si tienes preguntas o necesitas ayuda:
- Crea un issue con la etiqueta "question"
- Revisa la [Guía de Contribución](../CONTRIBUTING.md)
- Consulta el [Código de Conducta](../CODE_OF_CONDUCT.md)
