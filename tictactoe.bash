#!/bin/bash

# SIMPLE TIC-TAC-TOE GAME
# Two-player only

#=====================================Emil Moquete 22-0969==============================
# SISTEMA DE GESTIÓN DE JUEGOS TIC-TAC-TOE CON LOGS Y REPORTES
# Descripción: Este script implementa un sistema completo de gestión de juegos
# TicTacToe que incluye logging, generación de reportes, estadísticas de juego,
# y automatización de tareas relacionadas con el seguimiento de partidas.
#=====================================Emil Moquete 22-0969==============================

# Variables globales del sistema
GRUPO="ALEJANDRO GÓMEZ (23-0573), EMIL MOQUETE (22-0969), JAVIER JARP (23-0466), JEAN ROQUE (23-0812)"
DESCRIPCION="Sistema de gestión de juegos TicTacToe con logs y reportes"
DIRECTORIO_ACTUAL=$(pwd)
FECHA_EJECUCION=$(date +%F)
HORA_EJECUCION=$(date +%H:%M:%S)

# Configuración de archivos de reporte y logs
BACKUP_DIR="./backups"
REPORTE="$BACKUP_DIR/TicTacToe_Reporte_$(date +%F).txt"
LOG_FILE="$BACKUP_DIR/TicTacToe_Logs_$(date +%F).log"

#==============================Javier Jarp 23-0466===============================
# Game board (1-9 positions)
declare -a board=(" " " " " " " " " " " " " " " " " ")

# Game variables
current_player="X"
player1_name="Player 1"
player2_name="Player 2"

#=====================================Emil Moquete 22-0969==============================
# Función para mostrar información inicial del proyecto
mostrar_informacion_inicial() {
    clear
    echo "================================================================"
    echo "                    PROYECTO FINAL SHELL SCRIPTING"
    echo "================================================================"
    echo "Grupo: $GRUPO"
    echo "Descripción: $DESCRIPCION"
    echo "Directorio de ejecución: $DIRECTORIO_ACTUAL"
    echo "Fecha de ejecución: $FECHA_EJECUCION"
    echo "Hora de ejecución: $HORA_EJECUCION"
    echo "================================================================"
    echo
    
    # Crear directorio de backups si no existe
    if [[ ! -d "$BACKUP_DIR" ]]; then
        mkdir -p "$BACKUP_DIR"
    fi
    
    # Inicializar archivo de reporte
    echo "=== REPORTE DE EJECUCIÓN - GRUPO ===" > "$REPORTE"
    echo "Fecha: $FECHA_EJECUCION" >> "$REPORTE"
    echo "Hora: $HORA_EJECUCION" >> "$REPORTE"
    echo "Directorio: $DIRECTORIO_ACTUAL" >> "$REPORTE"
    echo "Grupo: $GRUPO" >> "$REPORTE"
    echo "=========================================" >> "$REPORTE"
    echo "" >> "$REPORTE"
    
    # Inicializar archivo de logs
    echo "[$HORA_EJECUCION] Iniciando sistema de gestión de juegos" > "$LOG_FILE"
    echo "[$HORA_EJECUCION] Grupo: $GRUPO" >> "$LOG_FILE"
    echo "[$HORA_EJECUCION] Directorio: $DIRECTORIO_ACTUAL" >> "$LOG_FILE"
    
    echo "Creando directorio de backups ----" >> "$REPORTE"
    echo "Inicializando sistema de reportes ----" >> "$REPORTE"
    echo "Sistema inicializado correctamente ----" >> "$REPORTE"
}

# Función para logging de eventos
log_event() {
    local mensaje="$1"
    local timestamp=$(date +%H:%M:%S)
    echo "[$timestamp] $mensaje" >> "$LOG_FILE"
}

# Función para agregar al reporte
agregar_reporte() {
    local mensaje="$1"
    echo "$mensaje" >> "$REPORTE"
}

#==============================Alejandro Gómez 23-0573===============================
# Función para mostrar el menú principal
mostrar_menu_principal() {
    clear
    echo "================================================================"
    echo "                    MENÚ PRINCIPAL - TIC TAC TOE"
    echo "================================================================"
    echo "Grupo: $GRUPO"
    echo "================================================================"
    echo ""
    echo "Seleccione una opción:"
    echo ""
    echo "1) Jugar Tic-Tac-Toe"
    echo "2) Ver reglas del juego"
    echo "3) Ver estadísticas de juegos"
    echo "4) Ver logs del sistema"
    echo "5) Ver reporte del sistema"
    echo "6) Limpiar logs y reportes"
    echo "7) Información del proyecto"
    echo "8) Salir del programa"
    echo ""
    echo "================================================================"
    echo -n "Ingrese su opción [1-8]: "
}

# Función para mostrar las reglas del juego
mostrar_reglas() {
    clear
    echo "================================================================"
    echo "                    REGLAS DEL TIC-TAC-TOE"
    echo "================================================================"
    echo ""
    echo "OBJETIVO:"
    echo "El objetivo es conseguir tres símbolos iguales en línea"
    echo "(horizontal, vertical o diagonal)."
    echo ""
    echo "REGLAS:"
    echo "• El juego se desarrolla en un tablero de 3x3 casillas"
    echo "• Los jugadores se turnan para colocar sus símbolos (X y O)"
    echo "• El Jugador 1 siempre utiliza 'X' y comienza primero"
    echo "• El Jugador 2 utiliza 'O'"
    echo "• Para hacer un movimiento, ingrese un número del 1 al 9"
    echo "• Los números corresponden a las posiciones del tablero:"
    echo ""
    echo "     |     |     "
    echo "  1  |  2  |  3  "
    echo "_____|_____|_____"
    echo "     |     |     "
    echo "  4  |  5  |  6  "
    echo "_____|_____|_____"
    echo "     |     |     "
    echo "  7  |  8  |  9  "
    echo "     |     |     "
    echo ""
    echo "CONDICIONES DE VICTORIA:"
    echo "• Tres símbolos iguales en una fila horizontal"
    echo "• Tres símbolos iguales en una columna vertical"
    echo "• Tres símbolos iguales en una diagonal"
    echo ""
    echo "El juego termina en empate si se llenan todas las casillas"
    echo "sin que ningún jugador consiga tres en línea."
    echo ""
    echo "================================================================"
    echo "Presione ENTER para volver al menú principal..."
    read
    log_event "Usuario consultó las reglas del juego"
}

# Función para mostrar estadísticas básicas
mostrar_estadisticas() {
    clear
    echo "================================================================"
    echo "                   ESTADÍSTICAS DEL SISTEMA"
    echo "================================================================"
    echo ""
    
    if [[ -f "$LOG_FILE" ]]; then
        local total_juegos=$(grep -c "Configuración de jugadores" "$LOG_FILE" 2>/dev/null || echo "0")
        local victorias_x=$(grep -c "Victoria de.*X)" "$LOG_FILE" 2>/dev/null || echo "0")
        local victorias_o=$(grep -c "Victoria de.*O)" "$LOG_FILE" 2>/dev/null || echo "0")
        local empates=$(grep -c "Juego empatado" "$LOG_FILE" 2>/dev/null || echo "0")
        local movimientos_invalidos=$(grep -c "Movimiento inválido" "$LOG_FILE" 2>/dev/null || echo "0")
        
        echo "📊 ESTADÍSTICAS GENERALES:"
        echo "   • Total de juegos iniciados: $total_juegos"
        echo "   • Victorias del Jugador X: $victorias_x"
        echo "   • Victorias del Jugador O: $victorias_o"
        echo "   • Juegos empatados: $empates"
        echo "   • Movimientos inválidos: $movimientos_invalidos"
        echo ""
        
        if [[ $total_juegos -gt 0 ]]; then
            local juegos_completados=$((victorias_x + victorias_o + empates))
            echo "📈 ANÁLISIS:"
            echo "   • Juegos completados: $juegos_completados de $total_juegos"
            echo "   • Porcentaje de victorias X: $(( (victorias_x * 100) / (juegos_completados > 0 ? juegos_completados : 1) ))%"
            echo "   • Porcentaje de victorias O: $(( (victorias_o * 100) / (juegos_completados > 0 ? juegos_completados : 1) ))%"
            echo "   • Porcentaje de empates: $(( (empates * 100) / (juegos_completados > 0 ? juegos_completados : 1) ))%"
        fi
    else
        echo "❌ No se encontraron logs del sistema."
        echo "   Inicie al menos un juego para ver estadísticas."
    fi
    
    echo ""
    echo "================================================================"
    echo "Presione ENTER para volver al menú principal..."
    read
    log_event "Usuario consultó las estadísticas del sistema"
}

# Función para mostrar los logs del sistema
mostrar_logs() {
    clear
    echo "================================================================"
    echo "                     LOGS DEL SISTEMA"
    echo "================================================================"
    echo ""
    
    if [[ -f "$LOG_FILE" ]]; then
        echo "📄 Contenido del archivo de logs ($LOG_FILE):"
        echo ""
        cat "$LOG_FILE"
    else
        echo "❌ No se encontró el archivo de logs."
    fi
    
    echo ""
    echo "================================================================"
    echo "Presione ENTER para volver al menú principal..."
    read
    log_event "Usuario consultó los logs del sistema"
}

# Función para mostrar el reporte del sistema
mostrar_reporte() {
    clear
    echo "================================================================"
    echo "                   REPORTE DEL SISTEMA"
    echo "================================================================"
    echo ""
    
    if [[ -f "$REPORTE" ]]; then
        echo "📋 Contenido del reporte ($REPORTE):"
        echo ""
        cat "$REPORTE"
    else
        echo "❌ No se encontró el archivo de reporte."
    fi
    
    echo ""
    echo "================================================================"
    echo "Presione ENTER para volver al menú principal..."
    read
    log_event "Usuario consultó el reporte del sistema"
}

# Función para limpiar logs y reportes
limpiar_logs_reportes() {
    clear
    echo "================================================================"
    echo "                 LIMPIAR LOGS Y REPORTES"
    echo "================================================================"
    echo ""
    echo "⚠️  ADVERTENCIA:"
    echo "Esta acción eliminará todos los logs y reportes actuales."
    echo "Esta acción NO se puede deshacer."
    echo ""
    echo -n "¿Está seguro que desea continuar? (s/N): "
    read confirmacion
    
    case $confirmacion in
        "s"|"S"|"si"|"Si"|"SI")
            if [[ -f "$LOG_FILE" ]]; then
                rm "$LOG_FILE"
                echo "✅ Archivo de logs eliminado."
            fi
            
            if [[ -f "$REPORTE" ]]; then
                rm "$REPORTE"
                echo "✅ Archivo de reporte eliminado."
            fi
            
            # Reinicializar archivos
            echo "[$HORA_EJECUCION] Sistema reiniciado - Logs limpiados por el usuario" > "$LOG_FILE"
            echo "=== REPORTE DE EJECUCIÓN - GRUPO ===" > "$REPORTE"
            echo "Fecha: $FECHA_EJECUCION" >> "$REPORTE"
            echo "Sistema reiniciado - Logs limpiados ----" >> "$REPORTE"
            
            echo "✅ Logs y reportes limpiados exitosamente."
            echo "✅ Archivos reinicializados."
            log_event "Usuario limpió logs y reportes del sistema"
            ;;
        *)
            echo "❌ Operación cancelada."
            ;;
    esac
    
    echo ""
    echo "Presione ENTER para volver al menú principal..."
    read
}

# Función para mostrar información del proyecto
mostrar_info_proyecto() {
    clear
    echo "================================================================"
    echo "                 INFORMACIÓN DEL PROYECTO"
    echo "================================================================"
    echo ""
    echo "🎓 PROYECTO FINAL - SHELL SCRIPTING"
    echo ""
    echo "👥 INTEGRANTES DEL GRUPO:"
    echo "   • Alejandro Gómez (23-0573) - Menú Principal y Navegación"
    echo "   • Emil Moquete (22-0969) - Sistema de Logs y Reportes"
    echo "   • Javier Jarp (23-0466) - Lógica del Juego y Interfaz"
    echo "   • Jean Roque (23-0812) - Control de Jugadores y Movimientos"
    echo ""
    echo "📝 DESCRIPCIÓN:"
    echo "   Sistema completo de gestión de juegos Tic-Tac-Toe que incluye"
    echo "   logging detallado, generación de reportes, estadísticas de"
    echo "   juego y automatización de tareas relacionadas con el"
    echo "   seguimiento de partidas."
    echo ""
    echo "🛠️  CARACTERÍSTICAS:"
    echo "   • Juego interactivo de Tic-Tac-Toe para dos jugadores"
    echo "   • Sistema de logging automático de eventos"
    echo "   • Generación de reportes detallados"
    echo "   • Estadísticas de juegos y movimientos"
    echo "   • Interfaz de menú intuitiva"
    echo "   • Gestión de archivos de respaldo"
    echo ""
    echo "📂 ARCHIVOS GENERADOS:"
    echo "   • Logs: $LOG_FILE"
    echo "   • Reportes: $REPORTE"
    echo "   • Directorio: $BACKUP_DIR"
    echo ""
    echo "📅 FECHA DE EJECUCIÓN: $FECHA_EJECUCION"
    echo "🕐 HORA DE EJECUCIÓN: $HORA_EJECUCION"
    echo "📁 DIRECTORIO ACTUAL: $DIRECTORIO_ACTUAL"
    echo ""
    echo "================================================================"
    echo "Presione ENTER para volver al menú principal..."
    read
    log_event "Usuario consultó información del proyecto"
}

# Función principal del menú
ejecutar_menu_principal() {
    while true; do
        mostrar_menu_principal
        read opcion
        
        case $opcion in
            1)
                log_event "Usuario seleccionó opción 1: Jugar Tic-Tac-Toe"
                iniciar_juego
                ;;
            2)
                log_event "Usuario seleccionó opción 2: Ver reglas"
                mostrar_reglas
                ;;
            3)
                log_event "Usuario seleccionó opción 3: Ver estadísticas"
                mostrar_estadisticas
                ;;
            4)
                log_event "Usuario seleccionó opción 4: Ver logs"
                mostrar_logs
                ;;
            5)
                log_event "Usuario seleccionó opción 5: Ver reporte"
                mostrar_reporte
                ;;
            6)
                log_event "Usuario seleccionó opción 6: Limpiar logs"
                limpiar_logs_reportes
                ;;
            7)
                log_event "Usuario seleccionó opción 7: Información del proyecto"
                mostrar_info_proyecto
                ;;
            8)
                log_event "Usuario seleccionó opción 8: Salir del programa"
                clear
                echo "================================================================"
                echo "                    GRACIAS POR USAR EL SISTEMA"
                echo "================================================================"
                echo ""
                echo "🎮 Gracias por jugar Tic-Tac-Toe!"
                echo "📊 Los logs y reportes han sido guardados en: $BACKUP_DIR"
                echo ""
                echo "👥 Desarrollado por: $GRUPO"
                echo ""
                echo "¡Hasta la próxima! 👋"
                echo ""
                agregar_reporte "Sistema finalizado desde el menú principal ----"
                log_event "Sistema finalizado desde el menú principal"
                exit 0
                ;;
            *)
                clear
                echo "❌ Opción inválida. Por favor seleccione una opción del 1 al 8."
                echo "Presione ENTER para continuar..."
                read
                log_event "Usuario ingresó opción inválida: $opcion"
                ;;
        esac
    done
}
#==============================Alejandro Gómez 23-0573===============================

#==============================Javier Jarp 23-0466===============================
clear_screen() {
    clear
}
#==============================Javier Jarp 23-0466===============================
print_header() {
    clear_screen
    echo "=================================="
    echo "         TIC-TAC-TOE GAME         "
    echo "=================================="
    echo
}
#==============================Javier Jarp 23-0466===============================
draw_board() {
    echo "     |     |     "
    echo "  ${board[0]}  |  ${board[1]}  |  ${board[2]}  "
    echo "_____|_____|_____"
    echo "     |     |     "
    echo "  ${board[3]}  |  ${board[4]}  |  ${board[5]}  "
    echo "_____|_____|_____"
    echo "     |     |     "
    echo "  ${board[6]}  |  ${board[7]}  |  ${board[8]}  "
    echo "     |     |     "
    echo
}
#==============================Javier Jarp 23-0466===============================
draw_reference_board() {
    echo "Position numbers:"
    echo "     |     |     "
    echo "  1  |  2  |  3  "
    echo "_____|_____|_____"
    echo "     |     |     "
    echo "  4  |  5  |  6  "
    echo "_____|_____|_____"
    echo "     |     |     "
    echo "  7  |  8  |  9  "
    echo "     |     |     "
    echo
}
#==============================Javier Jarp 23-0466===============================
show_current_player() {
    if [[ $current_player == "X" ]]; then
        echo "$player1_name's turn (X)"
    else
        echo "$player2_name's turn (O)"
    fi
    echo
}
#==============================Javier Jarp 23-0466===============================
check_winner() {
    # Check rows
    for i in 0 3 6; do
        if [[ ${board[$i]} != " " && ${board[$i]} == ${board[$((i+1))]} && ${board[$i]} == ${board[$((i+2))]} ]]; then
            return 0
        fi
    done
    
    # Check columns
    for i in 0 1 2; do
        if [[ ${board[$i]} != " " && ${board[$i]} == ${board[$((i+3))]} && ${board[$i]} == ${board[$((i+6))]} ]]; then
            return 0
        fi
    done
    
    # Check diagonals
    if [[ ${board[0]} != " " && ${board[0]} == ${board[4]} && ${board[0]} == ${board[8]} ]]; then
        return 0
    fi
    
    if [[ ${board[2]} != " " && ${board[2]} == ${board[4]} && ${board[2]} == ${board[6]} ]]; then
        return 0
    fi
    
    return 1
}
#==============================Javier Jarp 23-0466===============================
check_draw() {
    for cell in "${board[@]}"; do
        if [[ $cell == " " ]]; then
            return 1
        fi
    done
    return 0
}

#=====================================Emil Moquete 22-0969==============================
# Función para realizar movimiento con logging
make_move() {
    local position=$1
    local index=$((position - 1))
    
    # Check if position is valid
    if [[ $position -lt 1 || $position -gt 9 ]]; then
        log_event "Movimiento inválido: posición $position fuera de rango"
        return 1
    fi
    
    # Check if position is empty
    if [[ ${board[$index]} != " " ]]; then
        log_event "Movimiento inválido: posición $position ya ocupada"
        return 1
    fi
    
    # Make the move
    board[$index]=$current_player
    log_event "Jugador $current_player movió a posición $position"
    return 0
}

#==============================Jean Roque 23-0812===============================
get_player_move() {
    while true; do
        echo -n "Enter position (1-9): "
        read input
        
        case $input in
            [1-9])
                if make_move "$input"; then
                    return 0
                else
                    echo "Position $input is already taken! Try again."
                fi
                ;;
            *)
                echo "Invalid input! Enter a number 1-9."
                log_event "Entrada inválida del usuario: $input"
                ;;
        esac
    done
}

#==============================Jean Roque 23-0812===============================
switch_player() {
    if [[ $current_player == "X" ]]; then
        current_player="O"
    else
        current_player="X"
    fi
    log_event "Cambio de turno a jugador $current_player"
}

#==============================Jean Roque 23-0812===============================
reset_game() {
    board=(" " " " " " " " " " " " " " " " " ")
    current_player="X"
    log_event "Juego reiniciado"
}

#=====================================Emil Moquete 22-0969==============================
# Función para configurar jugadores con logging
setup_players() {
    echo -n "Enter Player 1 name (X): "
    read player1_name
    if [[ -z "$player1_name" ]]; then
        player1_name="Player 1"
    fi
    
    echo -n "Enter Player 2 name (O): "
    read player2_name
    if [[ -z "$player2_name" ]]; then
        player2_name="Player 2"
    fi
    
    echo
    echo "Game setup: $player1_name (X) vs $player2_name (O)"
    echo "Press ENTER to start..."
    read
    
    log_event "Configuración de jugadores: $player1_name vs $player2_name"
    agregar_reporte "Configurando jugadores del juego ----"
}

play_game() {
    while true; do
        print_header
        echo "$player1_name (X) vs $player2_name (O)"
        echo
        
        draw_board
        show_current_player
        draw_reference_board
        
        get_player_move
        
        # Check for winner
        if check_winner; then
            print_header
            draw_board
            
            if [[ $current_player == "X" ]]; then
                echo "🎉 $player1_name wins! 🎉"
                log_event "Victoria de $player1_name (X)"
                agregar_reporte "Juego terminado - Victoria de $player1_name ----"
            else
                echo "🎉 $player2_name wins! 🎉"
                log_event "Victoria de $player2_name (O)"
                agregar_reporte "Juego terminado - Victoria de $player2_name ----"
            fi
            break
            
        elif check_draw; then
            print_header
            draw_board
            echo "🤝 It's a draw! Good game!"
            log_event "Juego empatado"
            agregar_reporte "Juego terminado - Empate ----"
            break
        else
            switch_player
        fi
    done
}

ask_play_again() {
    echo
    echo -n "Play again? (y/n): "
    read answer
    
    case $answer in
        "y"|"Y"|"yes"|"Yes")
            log_event "Usuario eligió jugar otra partida"
            return 0
            ;;
        *)
            log_event "Usuario eligió terminar el juego"
            return 1
            ;;
    esac
}

#==============================Alejandro Gómez 23-0573===============================
# Función para iniciar el juego desde el menú
iniciar_juego() {
    print_header
    echo "Welcome to Tic-Tac-Toe!"
    echo
    
    setup_players
    
    while true; do
        reset_game
        play_game
        
        if ! ask_play_again; then
            echo "Thanks for playing!"
            echo "Returning to main menu..."
            agregar_reporte "Regresando al menú principal ----"
            log_event "Regresando al menú principal desde el juego"
            sleep 2
            break
        fi
    done
}
#==============================Alejandro Gómez 23-0573===============================

#=====================================Emil Moquete 22-0969==============================
# Función principal del programa - MODIFICADA para integrar el menú
main() {
    mostrar_informacion_inicial
    
    echo ""
    echo "Presiona ENTER para continuar al menú principal..."
    read
    
    # Ejecutar el menú principal en lugar de ir directo al juego
    ejecutar_menu_principal
}

# Ejecutar programa principal
main
