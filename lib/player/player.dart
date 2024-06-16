import 'dart:async';

import 'package:flame/components.dart';
import 'package:princess_advanture/player/facing.dart';
import 'package:princess_advanture/enums/player_direction.dart';
import 'package:princess_advanture/enums/player_state.dart';
import 'package:princess_advanture/pink_adventure.dart';

class Player extends SpriteAnimationGroupComponent with HasGameRef<PinkAdventure> {

  Player({ super.position });

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runAnimation;
  late final SpriteAnimation jumpAnimation;
  late final SpriteAnimation fallAnimation;
  final double stepTime = 0.05;
  final double moveSpeed = 150;
  final double virtualGravity = 9.81;
  final double jumpSpeed = -300;
  final double terminalVelocity = 300;
  bool hasJumped = false;
  Vector2 velocity = Vector2.zero();
  PlayerDirection direction = PlayerDirection.none;
  Facing facing = Facing(isFacingRight: true);

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMovement(dt, flipHorizontallyAroundCenter);
    _applyGravity(dt);

    if (hasJumped) {
      _jump(dt);
    }

    super.update(dt);
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation(PlayerState.idle.getState(), 11, stepTime);
    runAnimation = _spriteAnimation(PlayerState.run.getState(), 12, stepTime);
    jumpAnimation = _spriteAnimation(PlayerState.jump.getState(), 1, stepTime);
    fallAnimation = _spriteAnimation(PlayerState.fall.getState(), 1, stepTime);

    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.run: runAnimation,
      PlayerState.jump: jumpAnimation,
      PlayerState.fall: fallAnimation,
    };

    current = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount, double stepTime) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/Pink Man/$state (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  void _updatePlayerMovement(double dt, Function flip) {
    double velocityX = direction.move(0.0, moveSpeed, facing.withFlip(flip));
    current = direction.getState();
    velocity = Vector2(velocityX, velocity.y);
    velocity.x = velocityX;
    position.x += velocity.x * dt;
    current = _getMidairState();
  }

  void _applyGravity(double dt) {
    velocity.y += virtualGravity;
    velocity.y = velocity.y.clamp(jumpSpeed, terminalVelocity);
    position.y += velocity.y * dt;
  }

  void _jump(double dt) {
    velocity.y = jumpSpeed;
    position.y += velocity.y * dt;
    hasJumped = false;
  }

  PlayerState _getMidairState() {
    if (velocity.y < 0) {
      return PlayerState.jump;
    }

    if (velocity.y > 0) {
      return PlayerState.fall;
    }

    return current;
  }

  void getStuckBySideCollision(double dt) {
    position.x -= velocity.x * dt;
  }

  void getStuckByBottomCollision(double dt) {
    position.y -= velocity.y * dt;
    velocity.y = 0;
  }

}