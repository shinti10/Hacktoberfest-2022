import random


class TicTacToe:

    def __init__(self):
        self.board = []

    def create_board(self):
        for i in range(3):
            row = []
            for j in range(3):
                row.append('-')
            self.board.append(row)

    def random_starting_player(self):
        return random.randint(0, 1)

    def mark(self, row, col, player):
        self.board[row][col] = player

    def has_won(self, player):
        win = None

        n = len(self.board)

        # Rows
        for i in range(n):
            win = True
            for j in range(n):
                if self.board[i][j] != player:
                    win = False
                    break
            if win:
                return win

        # Columns
        for i in range(n):
            win = True
            for j in range(n):
                if self.board[j][i] != player:
                    win = False
                    break
            if win:
                return win

        # Diagonals
        win = True
        for i in range(n):
            if self.board[i][i] != player:
                win = False
                break
        if win:
            return win

        win = True
        for i in range(n):
            if self.board[i][n - 1 - i] != player:
                win = False
                break
        if win:
            return win
        return False

    def is_board_filled(self):
        for row in self.board:
            for item in row:
                if item == '-':
                    return False
        return True

    def swap(self, player):
        return 'X' if player == 'O' else 'O'

    def show_board(self):
        for row in self.board:
            for item in row:
                print(item, end=" ")
            print()

    def start(self):
        self.create_board()

        player = 'X' if self.random_starting_player() == 1 else 'O'
        while True:
            print(f"Player {player} turn")

            self.show_board()

            # Get the user input
            row, col = list(
                map(int, input("Enter row and column numbers to mark: ").split()))
            print()

            # Mark the position on the board
            self.mark(row - 1, col - 1, player)

            # Check if the current player has won
            if self.has_won(player):
                print(f"Player {player} wins the game!")
                break

            # Check if the board is full and the match has drawn
            if self.is_board_filled():
                print("Match Draw!")
                break

            # Swap turns
            player = self.swap(player)

        # Show the board
        print()
        self.show_board()


# starting the game
tic_tac_toe = TicTacToe()
tic_tac_toe.start()
