#!/bin/bash

# SIMPLE TIC-TAC-TOE GAME
# Two-player only

#==============================Javier Jarp 23-0466===============================
# Game board (1-9 positions)
declare -a board=(" " " " " " " " " " " " " " " " " ")

# Game variables
current_player="X"
player1_name="Player 1"
player2_name="Player 2"

clear_screen() {
    clear
}

print_header() {
    clear_screen
    echo "=================================="
    echo "         TIC-TAC-TOE GAME         "
    echo "=================================="
    echo
}

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

show_current_player() {
    if [[ $current_player == "X" ]]; then
        echo "$player1_name's turn (X)"
    else
        echo "$player2_name's turn (O)"
    fi
    echo
}

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
#=====================================Javier Jarp 23-0466==============================
check_draw() {
    for cell in "${board[@]}"; do
        if [[ $cell == " " ]]; then
            return 1
        fi
    done
    return 0
}

make_move() {
    local position=$1
    local index=$((position - 1))
    
    # Check if position is valid
    if [[ $position -lt 1 || $position -gt 9 ]]; then
        return 1
    fi
    
    # Check if position is empty
    if [[ ${board[$index]} != " " ]]; then
        return 1
    fi
    
    # Make the move
    board[$index]=$current_player
    return 0
}

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
                ;;
        esac
    done
}

switch_player() {
    if [[ $current_player == "X" ]]; then
        current_player="O"
    else
        current_player="X"
    fi
}

reset_game() {
    board=(" " " " " " " " " " " " " " " " " ")
    current_player="X"
}

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
            else
                echo "🎉 $player2_name wins! 🎉"
            fi
            break
            
        elif check_draw; then
            print_header
            draw_board
            echo "🤝 It's a draw! Good game!"
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
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Main game loop
print_header
echo "Welcome to Tic-Tac-Toe!"
echo

setup_players

while true; do
    reset_game
    play_game
    
    if ! ask_play_again; then
        echo "Thanks for playing!"
        break
    fi
done
