import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/features/game/brick/brick_breaker_game.dart';
import 'package:gamehub/features/game/brick/presentation/components/brick_components.dart';
import 'package:gamehub/features/game/brick/utils/brick_configuration.dart';

class Brick extends RectangleComponent with CollisionCallbacks, HasGameReference<BrickBreakerGame>{
  Brick(Vector2 position, Color color) : super(
    position: position,
    size: Vector2(BrickConfiguration.brickWidth, BrickConfiguration.brickHeight),
    anchor: Anchor.center,
    paint: Paint()
      ..color = color
      ..style = PaintingStyle.fill,
    children: [RectangleHitbox()]
  );

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    removeFromParent();
    game.score.value++;

    if(game.world.children.query<Brick>().length == 1){
      game.playState = BrickBreakerState.won;
      game.world.removeAll(game.world.children.query<Ball>());
      game.world.removeAll(game.world.children.query<Bat>());
    }
  }
}