# Guía de Instalación y Configuración

## Requisitos Previos

- **Visual Studio Code** con la extensión de Wollok instalada
- **Wollok** versión 4.2.3 o superior
- **Git** (opcional, para clonar el repositorio)

## Instalación

### 1. Instalar Visual Studio Code y Wollok

1. **Descarga e instala Visual Studio Code:**
   - [https://code.visualstudio.com/](https://code.visualstudio.com/)

2. **Instala la extensión de Wollok:**
   - Abre VS Code
   - Ve a Extensions (Ctrl+Shift+X o Cmd+Shift+X)
   - Busca "Wollok"
   - Instala la extensión oficial de Wollok

### 2. Clonar o Descargar el Proyecto

**Opción A: Con Git**
```bash
git clone <url-del-repositorio>
cd bebidas
```

**Opción B: Descarga directa**
- Descarga el archivo ZIP del proyecto
- Extrae el contenido en tu carpeta de trabajo

### 3. Abrir en VS Code

1. Abre Visual Studio Code
2. Ve a `File` → `Open Folder...`
3. Selecciona la carpeta del proyecto "bebidas"
4. VS Code detectará automáticamente los archivos de Wollok

## Estructura del Proyecto

```
bebidas/
├── src/                    # Código fuente
│   ├── voluntarios.wlk    # Definición de Tito
│   └── bebidas.wlk        # Definición de bebidas (whisky, tereré, cianuro)
├── tests/                  # Tests unitarios
│   ├── voluntarios.wtest  # Tests de Tito
│   └── bebidas.wtest      # Tests de bebidas
├── docs/                   # Documentación
├── log/                    # Archivos de log (ignorados)
├── README.md              # Especificación del ejercicio
├── CONTRIBUTING.md        # Guía de contribución
├── CODE_OF_CONDUCT.md     # Código de conducta
├── LICENSE                # Licencia del proyecto
├── CHANGELOG.md           # Registro de cambios
└── package.json           # Configuración del proyecto
```

## Ejecutar el Proyecto

### Ejecutar Tests Individuales

1. Abre cualquier archivo `.wtest` en el editor
2. Haz clic en el ícono "Run Test" que aparece sobre cada test
3. O click derecho en el archivo → "Run Wollok File"

### Ejecutar Todos los Tests

**Desde VS Code:**
- Abre la paleta de comandos (Ctrl+Shift+P o Cmd+Shift+P)
- Busca "Wollok: Run All Tests"
- Ejecuta el comando

**Desde la terminal (si tienes Wollok CLI instalado):**
```bash
wollok test
```

## Verificar la Instalación

Para verificar que todo está correctamente instalado:

1. Abre `tests/voluntarios.wtest`
2. Ejecuta los tests
3. Deberías ver todos los tests en verde ✓

## Troubleshooting

### Error: "Project not found" o "Cannot resolve dependencies"

**Solución:**
1. Asegúrate de tener la extensión de Wollok instalada en VS Code
2. Recarga la ventana de VS Code (Ctrl+Shift+P → "Reload Window")
3. Verifica que el archivo `package.json` esté presente
4. Intenta ejecutar los tests nuevamente

### Los tests no se ejecutan

**Solución:**
1. Verifica que los archivos `.wtest` estén en la carpeta `tests/`
2. Asegúrate de que la extensión de Wollok esté activa
3. Revisa la consola de salida de VS Code para ver errores
4. Recarga la ventana de VS Code

### Errores de sintaxis o compilación

**Solución:**
- Revisa que todos los archivos `.wlk` estén en la carpeta `src/`
- Verifica que no haya errores de sintaxis en el código
- Asegúrate de que las importaciones sean correctas
- Revisa el panel "Problems" de VS Code (Ctrl+Shift+M)

## Próximos Pasos

- Lee el [README.md](../README.md) para entender la especificación del ejercicio
- Revisa [CONTRIBUTING.md](../CONTRIBUTING.md) si quieres contribuir
- Consulta [architecture.md](architecture.md) para entender el diseño del sistema
- Lee [testing.md](testing.md) para aprender sobre las estrategias de testing
