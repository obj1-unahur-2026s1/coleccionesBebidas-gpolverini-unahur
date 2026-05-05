# Guía de Contribución

¡Gracias por tu interés en contribuir a este proyecto! Este documento proporciona pautas para contribuir al sistema de modelado de bebidas y voluntarios.

## Código de Conducta

Este proyecto se adhiere a un Código de Conducta. Al participar, se espera que respetes este código. Por favor lee [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) para más detalles.

## ¿Cómo puedo contribuir?

### Reportar Bugs

Si encuentras un bug, por favor crea un issue incluyendo:

- Una descripción clara del problema
- Pasos para reproducir el comportamiento
- Comportamiento esperado vs. comportamiento actual
- Capturas de pantalla si son relevantes
- Versión de Wollok que estás usando

### Sugerir Mejoras

Las sugerencias de mejoras son bienvenidas. Por favor crea un issue describiendo:

- La mejora propuesta
- Por qué sería útil
- Ejemplos de uso si es aplicable

### Pull Requests

1. **Fork el repositorio** y crea tu rama desde `main`
2. **Escribe código claro** siguiendo las convenciones del proyecto
3. **Agrega tests** si es aplicable
4. **Asegúrate de que los tests pasen** antes de enviar el PR
5. **Actualiza la documentación** si es necesario
6. **Escribe mensajes de commit claros** y descriptivos

#### Proceso de Pull Request

1. Asegúrate de que tu código sigue las convenciones de estilo de Wollok
2. Actualiza el README.md si agregas funcionalidad que lo requiera
3. Los tests deben pasar exitosamente
4. El PR será revisado por los mantenedores del proyecto

### Convenciones de Código

- Usa nombres descriptivos para variables y métodos
- Escribe comentarios cuando el código no sea auto-explicativo
- Sigue las convenciones de nomenclatura de Wollok
- Mantén los métodos pequeños y enfocados en una sola responsabilidad
- Respeta el polimorfismo: todas las bebidas deben responder a `rendimiento(cantidad)`

### Estructura del Proyecto

```
.
├── src/                    # Código fuente
│   ├── voluntarios.wlk     # Definición del voluntario (Tito)
│   └── bebidas.wlk         # Objetos de bebidas (whisky, tereré, cianuro)
├── tests/                  # Tests unitarios
│   ├── voluntarios.wtest   # Tests del voluntario
│   └── bebidas.wtest       # Tests de bebidas
├── log/                    # Archivos de log (ignorados en git)
├── docs/                   # Documentación adicional
└── README.md               # Documentación del proyecto
```

### Tests

Todos los cambios deben incluir tests apropiados. Para ejecutar los tests:

```bash
# Ejecuta los tests desde Wollok IDE o usando el comando apropiado
```

### Mensajes de Commit

- Usa el tiempo presente ("Agrega feature" no "Agregado feature")
- Usa el modo imperativo ("Mueve cursor a..." no "Mueve cursor a...")
- Limita la primera línea a 72 caracteres o menos
- Referencia issues y pull requests cuando sea relevante

Ejemplo:
```
Agrega nueva bebida energizante

- Implementa objeto energizante con su método rendimiento
- Agrega tests para diferentes dosis
- Fixes #123
```

## Preguntas

Si tienes preguntas sobre cómo contribuir, no dudes en crear un issue con la etiqueta "question".

## Licencia

Al contribuir a este proyecto, aceptas que tus contribuciones serán licenciadas bajo la licencia ISC del proyecto.
