import 'package:princess_advanture/player/facing.dart';
import 'package:princess_advanture/enums/player_state.dart';

enum PlayerDirection {
  none(action: moveNone, state: PlayerState.idle),
  left(action: moveLeft, state: PlayerState.run),
  right(action: moveRight, state: PlayerState.run);

  final Function action;
  final PlayerState state;

  const PlayerDirection({ required this.action, required this.state });

  double move(double x, speed, Facing facing) {
    return action(x, speed, facing);
  }

  PlayerState getState() {
    return state;
  }

}

double moveLeft(double x, double speed, Facing facing) {
  if (facing.isFacingRight) {
    facing.turnFacing();
  }

  return x - speed;
}

double moveRight(double x, double speed, Facing facing) {
  if (!facing.isFacingRight) {
    facing.turnFacing();
  }

  return x + speed;
}

double moveNone(double x, double speed, Facing facing) {
  return x;
}
