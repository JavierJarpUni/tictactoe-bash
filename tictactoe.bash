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

#=====================================Alejandro Gomez 23-0573==============================
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

#=====================================Alejandro Gomez 23-0573==============================
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

#=====================================Emil Moquete 22-0969==============================
# Función principal del programa
main() {
    mostrar_informacion_inicial
    
    echo ""
    echo "Presiona ENTER para continuar al juego..."
    read
    
    print_header
    echo "Welcome to Tic-Tac-Toe!"
    echo
    
    setup_players
    
    while true; do
        reset_game
        play_game
        
        if ! ask_play_again; then
            echo "Thanks for playing!"
            agregar_reporte "Sistema finalizado por el usuario ----"
            log_event "Sistema finalizado por el usuario"
            break
        fi
    done
}

# Ejecutar programa principal
main