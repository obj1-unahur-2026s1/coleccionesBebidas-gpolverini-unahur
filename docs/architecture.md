# Arquitectura del Sistema

## Visión General

El proyecto "Bebidas y Voluntarios" es un sistema orientado a objetos que modela el efecto de diferentes bebidas en el rendimiento de un deportista voluntario. El sistema está diseñado siguiendo principios de programación orientada a objetos y el paradigma de Wollok, con foco en polimorfismo y encapsulamiento.

## Diagrama de Componentes

```
┌────────────────────────────────────────────────┐
│                     BEBIDAS                    │
│  ┌───────────┐  ┌───────────┐  ┌──────────┐    │
│  │  Whisky   │  │  Tereré   │  │ Cianuro  │    │
│  │(0.9^dosis)│  │(0.1*dosis)│  │   (0)    │    │
│  └───────────┘  └───────────┘  └──────────┘    │
└────────────────────────────────────────────────┘
                         │
                         │ consume
                         ▼
┌────────────────────────────────────────────────┐
│                    VOLUNTARIO                  │
│  ┌──────────────────────────────────────────┐  │
│  │              Tito                        │  │
│  │  - peso: 70 kg                           │  │
│  │  - inercia: 490 kg*m/s                   │  │
│  │  - sustanciaEnSistema                    │  │
│  │  - dosisDeSustanciaEnSistema             │  │
│  └──────────────────────────────────────────┘  │
└────────────────────────────────────────────────┘
```

## Módulos del Sistema

### 1. Voluntario (`src/voluntarios.wlk`)

**Responsabilidad:** Modelar a Tito y calcular su velocidad según la sustancia consumida.

#### Tito
**Propiedades:**
- `peso = 70` - Peso en kg (privado)
- `inercia = 490` - Inercia base en kg*m/s (property pública)
- `sustanciaEnSistema = whisky` - Sustancia actual (privado)
- `dosisDeSustanciaEnSistema = 0` - Dosis consumida en cc (privado)

**Métodos:**
- `consumir(cantidad, sustancia)` - Consume una bebida (reemplaza la anterior)
- `velocidad()` - Retorna velocidad en m/s
- `sustanciaEnSistema()` - Getter de la sustancia actual
- `dosisDeSustanciaEnSistema()` - Getter de la dosis actual

**Comportamiento:**
- Cada bebida consumida reemplaza a la anterior
- La velocidad se calcula como: `rendimiento * inercia / peso`
- El rendimiento depende de la sustancia y la dosis

**Fórmula de la Velocidad:**
```
Velocidad (m/s) = Rendimiento × Inercia / Peso

Donde:
  Rendimiento = sustanciaEnSistema.rendimiento(dosisDeSustanciaEnSistema)
  Inercia = 490 kg*m/s (constante)
  Peso = 70 kg (constante)
```

**Ejemplo:**
```
Tito consume 10cc de whisky:
- Rendimiento: 0.9 ** 10 = 0.3487
- Velocidad: 0.3487 × 490 / 70 = 2.44 m/s
```

### 2. Bebidas (`src/bebidas.wlk`)

**Responsabilidad:** Modelar bebidas y calcular su rendimiento según la dosis.

#### Whisky
**Métodos:**
- `rendimiento(cantidad)` - Retorna 0.9 elevado a la cantidad

**Comportamiento:**
- Provoca sueño, mareo y jaquecas
- Rendimiento: 0.9 ^ cantidad
- A mayor dosis, menor rendimiento (exponencial decreciente)

**Ejemplo:**
```
Dosis 1cc: 0.9 ** 1 = 0.9
Dosis 5cc: 0.9 ** 5 = 0.59
Dosis 10cc: 0.9 ** 10 = 0.35
```

#### Tereré
**Métodos:**
- `rendimiento(cantidad)` - Retorna (0.1 × cantidad).max(1)

**Comportamiento:**
- Diurético, laxante y estimulante
- Rendimiento: 0.1 por cada cc, con mínimo de 1
- Nunca rinde menos que 1

**Ejemplo:**
```
Dosis 5cc: (0.1 × 5).max(1) = 0.5.max(1) = 1
Dosis 10cc: (0.1 × 10).max(1) = 1.max(1) = 1
Dosis 20cc: (0.1 × 20).max(1) = 2.max(1) = 2
```

#### Cianuro
**Métodos:**
- `rendimiento(cantidad)` - Retorna 0

**Comportamiento:**
- Produce abulia y marasmo
- Rendimiento: siempre 0
- El deportista queda "como muerto"
- La cantidad no afecta (siempre 0)

**Ejemplo:**
```
Cualquier dosis: 0
```

## Patrones de Diseño

### 1. Singleton Pattern
Todos los objetos son singletons (una única instancia):
- Voluntario: `tito`
- Bebidas: `whisky`, `terere`, `cianuro`

**Ventaja:** Simplifica el modelo y evita duplicación de estado

### 2. Polymorphism
**Bebidas** responden polimórficamente a:
- `rendimiento(cantidad)` - Cada bebida calcula su rendimiento de forma diferente

**Ventaja:** Tito puede consumir cualquier bebida sin modificar su lógica de cálculo de velocidad

**Ejemplo:**
```wollok
tito.consumir(10, whisky)
tito.velocidad()  // Usa whisky.rendimiento(10)

tito.consumir(10, terere)
tito.velocidad()  // Usa terere.rendimiento(10)

tito.consumir(10, cianuro)
tito.velocidad()  // Usa cianuro.rendimiento(10)
```

### 3. Encapsulation
**Atributos privados:**
- `peso`, `sustanciaEnSistema`, `dosisDeSustanciaEnSistema` son privados
- Solo modificables a través de métodos específicos

**Property pública:**
- `inercia` es una property (acceso público directo)

**Ventaja:** Control sobre cómo se modifican los atributos

### 4. Delegation
Tito delega el cálculo de rendimiento a:
- Sustancia → `sustanciaEnSistema.rendimiento(dosisDeSustanciaEnSistema)`

**Ventaja:** Separación de responsabilidades

## Decisiones de Diseño

### ¿Por qué cada bebida reemplaza a la anterior?

**Razón:** Simplifica el modelo. Tito solo tiene una sustancia en su sistema a la vez, evitando interacciones complejas entre sustancias.

### ¿Por qué velocidad es un método y no un atributo?

**Razón:** El enunciado explícitamente pide que "¡No vale guardarse la velocidad!". La velocidad debe calcularse cada vez que se consulta, basándose en el rendimiento actual.

### ¿Por qué todas las bebidas aceptan el parámetro cantidad?

**Razón:** Para lograr polimorfismo, todas las sustancias deben entender el mismo mensaje con los mismos parámetros. Aunque cianuro no use la cantidad, debe aceptarla para ser polimórfico con whisky y tereré.

### ¿Por qué tereré tiene un mínimo de 1?

**Razón:** El enunciado especifica que "nunca rinde menos que 1", simulando un efecto estimulante base.

### ¿Por qué usar 0.9 ** cantidad en whisky?

**Razón:** Simula un efecto exponencial decreciente: a mayor consumo, peor rendimiento (sueño, mareo, jaquecas).

## Extensibilidad

El sistema está diseñado para ser fácilmente extensible:

### Agregar nuevas bebidas
```wollok
object cafeina {
    method rendimiento(cantidad) = 1 + (cantidad * 0.05)
}

// Uso:
tito.consumir(20, cafeina)
tito.velocidad()
```

### Agregar nuevos voluntarios
```wollok
object maria {
    var peso = 60
    var sustanciaEnSistema = whisky
    var dosisDeSustanciaEnSistema = 0
    const property inercia = 450
    
    method consumir(cantidad, sustancia) {
        sustanciaEnSistema = sustancia
        dosisDeSustanciaEnSistema = cantidad
    }
    
    method velocidad() = 
        sustanciaEnSistema.rendimiento(dosisDeSustanciaEnSistema) * inercia / peso
}
```

## Flujo de Interacción Típico

1. **Estado inicial:**
   ```wollok
   // Tito tiene whisky en su sistema con dosis 0
   tito.sustanciaEnSistema()  // whisky
   tito.dosisDeSustanciaEnSistema()  // 0
   ```

2. **Consumir una bebida:**
   ```wollok
   tito.consumir(10, whisky)
   // Ahora tiene 10cc de whisky
   ```

3. **Consultar velocidad:**
   ```wollok
   tito.velocidad()
   // Calcula: whisky.rendimiento(10) * 490 / 70
   // = 0.3487 * 490 / 70
   // = 2.44 m/s
   ```

4. **Cambiar de bebida (reemplaza la anterior):**
   ```wollok
   tito.consumir(20, terere)
   tito.velocidad()
   // Calcula: terere.rendimiento(20) * 490 / 70
   // = 2 * 490 / 70
   // = 14 m/s
   ```

## Consideraciones de Testing

Cada módulo tiene su propia suite de tests:
- `tests/voluntarios.wtest` - Tests de Tito
- `tests/bebidas.wtest` - Tests de bebidas

Ver [testing.md](testing.md) para más detalles sobre estrategias de testing.

## Diagrama de Secuencia: Cálculo de Velocidad

```
Tito              Whisky
  │                 │
  ├─ velocidad()    │
  │                 │
  ├─ rendimiento(10)─►
  │◄────────────────┤
  │ retorna: 0.3487 │
  │                 │
  ├─ calcula: 0.3487 * 490 / 70
  │                 │
  ├─ retorna: 2.44  │
  │                 │
```

## Polimorfismo en Acción

### Bebidas
```wollok
// Tito puede consumir cualquier bebida sin cambiar su código
tito.consumir(10, whisky)
tito.velocidad()  // Usa whisky.rendimiento(10)

tito.consumir(10, terere)
tito.velocidad()  // Usa terere.rendimiento(10)

tito.consumir(10, cianuro)
tito.velocidad()  // Usa cianuro.rendimiento(10) = 0
```

### Todas las bebidas entienden el mismo mensaje
```wollok
// Todas responden a rendimiento(cantidad)
whisky.rendimiento(10)   // 0.3487
terere.rendimiento(10)   // 1
cianuro.rendimiento(10)  // 0

// Esto permite que Tito las use polimórficamente
```

## Cálculos de Ejemplo

### Whisky
```
Dosis 1cc:  velocidad = 0.9 * 490 / 70 = 6.3 m/s
Dosis 5cc:  velocidad = 0.59 * 490 / 70 = 4.13 m/s
Dosis 10cc: velocidad = 0.35 * 490 / 70 = 2.45 m/s
```

### Tereré
```
Dosis 5cc:  velocidad = 1 * 490 / 70 = 7 m/s (mínimo)
Dosis 10cc: velocidad = 1 * 490 / 70 = 7 m/s (mínimo)
Dosis 20cc: velocidad = 2 * 490 / 70 = 14 m/s
```

### Cianuro
```
Cualquier dosis: velocidad = 0 * 490 / 70 = 0 m/s
```
