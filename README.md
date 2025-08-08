# 🎮 Proyecto Final - Sistema de Gestión de Juegos TicTacToe

## 📋 Descripción del Proyecto

Este proyecto implementa un **sistema completo de gestión de juegos TicTacToe** que cumple con todos los requerimientos del proyecto final de Shell Scripting. El sistema incluye:

- ✅ **Juego TicTacToe funcional** (trabajo base de Javier Jarp)
- ✅ **Sistema de logs y reportes** (contribución de Emil Moquete)
- ✅ **Información inicial del grupo**
- ✅ **Generación automática de reportes**
- ✅ **Logging de eventos del sistema**
- ✅ **Menu Principal** (contribución de Alejandro Gómez)
- 
## 👥 Integrantes del Grupo

| Estudiante | Matrícula | Contribución |
|------------|-----------|--------------|
| **Alejandro Gómez** | 23-0573 | Menu Principal |
| **Emil Moquete** | 22-0969 | Sistema de logs y reportes |
| **Javier Jarp** | 23-0466 | Juego TicTacToe base |
| **Jean Roque** | 23-0812 | Funciones de los jugadores |

## 🚀 Funcionalidades Implementadas

### ✅ **Requerimientos Cumplidos**

1. **Información inicial del estudiante/grupo**
2. **Descripción del proyecto**
3. **Directorio de ejecución**
4. **Reporte con formato requerido** (`$(date +%F)`)
5. **Mensajes con `----`**
6. **Comentarios con nombre del estudiante**
7. **Variables, estructuras de control, tuberías, archivos, comandos**

### 🔧 **Elementos Técnicos**

- **Variables**: Globales del sistema, configuración de archivos
- **Estructuras de Control**: if/else, case, while, for
- **Tuberías y Redireccionamientos**: `>>`, `>`, `|`
- **Archivos de Entrada y Salida**: Reportes, logs, estadísticas
- **Comandos**: date, mkdir, echo, pwd, etc.

## 📁 Estructura del Proyecto

```
TicTacToe/
├── tictactoe.bash              # Script principal
├── CONTRIBUCION_EMIL_MOQUETE.md # Documentación de contribuciones
├── README.md                    # Este archivo
└── backups/                     # Archivos generados automáticamente
    ├── TicTacToe_Reporte_YYYY-MM-DD.txt
    └── TicTacToe_Logs_YYYY-MM-DD.log
```

## 🎯 Cómo Ejecutar

### Prerrequisitos
- Bash shell (Git Bash, WSL, Linux, macOS)
- Permisos de ejecución

### Instalación y Ejecución

```bash
# 1. Clonar o descargar el repositorio
git clone <url-del-repositorio>
cd TicTacToe

# 2. Dar permisos de ejecución
chmod +x tictactoe.bash

# 3. Ejecutar el script
./tictactoe.bash
```

## 📊 Funcionalidades del Sistema

### 🎮 **Juego TicTacToe**
- Juego de dos jugadores
- Validación de movimientos
- Detección de victoria y empate
- Interfaz clara con tablero visual

### 📝 **Sistema de Reportes**
- Genera reportes con fecha automática
- Formato: `TicTacToe_Reporte_YYYY-MM-DD.txt`
- Incluye información del grupo y eventos del juego

### 📋 **Sistema de Logs**
- Registra todos los eventos del sistema
- Formato: `TicTacToe_Logs_YYYY-MM-DD.log`
- Timestamps en cada evento

### 🔍 **Información Inicial**
Al ejecutar el script, se muestra:
- Nombre del grupo con matrículas
- Descripción del proyecto
- Directorio de ejecución
- Fecha y hora de ejecución

## 📈 Archivos Generados

El sistema crea automáticamente:

### 📄 **Reporte de Ejecución**
```
=== REPORTE DE EJECUCIÓN - GRUPO ===
Fecha: 2024-01-15
Hora: 14:30:25
Directorio: /ruta/actual
Grupo: ALEJANDRO GÓMEZ (23-0573), EMIL MOQUETE (22-0969), JAVIER JARP (23-0466), JEAN ROQUE (23-0812)
=========================================

Creando directorio de backups ----
Inicializando sistema de reportes ----
Sistema inicializado correctamente ----
Configurando jugadores del juego ----
Juego terminado - Victoria de Emil ----
Sistema finalizado por el usuario ----
```

### 📋 **Logs del Sistema**
```
[14:30:25] Iniciando sistema de gestión de juegos
[14:30:25] Grupo: ALEJANDRO GÓMEZ (23-0573), EMIL MOQUETE (22-0969), JAVIER JARP (23-0466), JEAN ROQUE (23-0812)
[14:30:25] Directorio: /ruta/actual
[14:30:30] Configuración de jugadores: Emil vs Juan
[14:30:35] Jugador X movió a posición 5
[14:30:40] Cambio de turno a jugador O
[14:30:45] Victoria de Emil (X)
[14:30:50] Usuario eligió terminar el juego
[14:30:50] Sistema finalizado por el usuario
```

## 🛠️ Contribuciones por Estudiante

### Emil Moquete (22-0969)
- ✅ Sistema de información inicial
- ✅ Variables globales del sistema
- ✅ Sistema de reportes con formato requerido
- ✅ Sistema de logs con timestamps
- ✅ Logging en funciones existentes
- ✅ Modificación de función principal

### Javier Jarp (23-0466)
- ✅ Juego TicTacToe base
- ✅ Lógica del juego (check_winner, check_draw)
- ✅ Funciones de dibujo del tablero
- ✅ Sistema de turnos

### Alejandro Gómez (23-0573)
- ✅ Menu Principal

### Jean Roque (23-0812)
- ✅ Funcionalidad de preguntar el movimiento del jugador
- ✅ Mecanismo de cambio del jugador actual
- ✅ Función de reseteo del juego

## 📋 Requerimientos del Proyecto Final

### ✅ **Cumplidos**
- [x] Mostrar información del estudiante/grupo
- [x] Descripción del proyecto
- [x] Directorio de ejecución
- [x] Reporte con formato requerido
- [x] Uso de `$(date +%F)`
- [x] Mensajes con `----`
- [x] Comentarios con nombre del estudiante
- [x] Variables
- [x] Estructuras de control
- [x] Tuberías y redireccionamientos
- [x] Archivos de entrada y salida
- [x] Comandos

## 🎯 Próximos Pasos

El proyecto está listo.

Las contribuciones correspondientes de cada estudiante está marcada dentro del código con el comentario:
```bash
#=====================================NOMBRE_ESTUDIANTE MATRÍCULA==============================
```

