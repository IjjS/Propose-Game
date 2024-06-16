class Facing {
  bool isFacingRight;
  late Function turn;

  Facing({ required this.isFacingRight });

  void turnFacing() {
    if (turn == null) {
      throw Exception('The turn function is not set');
    }
    
    isFacingRight = !isFacingRight;
    turn();
  }

  Facing withFlip(Function turn) {
    this.turn = turn;
    return this;
  }

}