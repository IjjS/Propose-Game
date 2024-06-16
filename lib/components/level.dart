import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:princess_advanture/components/collision/collision_block.dart';
import 'package:princess_advanture/components/collision/wall.dart';
import 'package:princess_advanture/player/Player.dart';

class Level extends World {
  final String name;
  final Player player;
  final List<CollisionBlock> collisionBlocks = [];

  Level({ required this.player, required this.name });

  late TiledComponent level;

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('$name.tmx', Vector2.all(16));

    add(level);

    final spawnLayers = level.tileMap.getLayer<ObjectGroup>('Spawn');

    spawnLayers?.objects.forEach((layer) {
      switch (layer.class_) {
        case 'Player':
          player.position =  Vector2(layer.x, layer.y);

          add(player);
          break;
        default:
          break;
      }
    });

    final collisionLayers = level.tileMap.getLayer<ObjectGroup>('Collisions');

    collisionLayers?.objects.forEach((layer) {
      switch (layer.class_) {
        case 'Wall':
          final wall = Wall(
            position: Vector2(layer.x, layer.y),
            size: Vector2(layer.width, layer.height)
          );

          collisionBlocks.add(wall);
          add(wall);
          break;
        default:
      }
    });

    return super.onLoad();
  }

  @override
  void update(double dt) {
    onCollision(dt);
    super.update(dt);
  }

  void onCollision(double dt) {
    for (final block in collisionBlocks) {
      if (block.isCollidingWith(player)) {
        if (block.isCollidingBottom(player)) {
          player.getStuckByBottomCollision(dt);
        }
        
        if (block.isCollidingSides(player)) {
          player.getStuckBySideCollision(dt);
        }
      }
    }
  }
}