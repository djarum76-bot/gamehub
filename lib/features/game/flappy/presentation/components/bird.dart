import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/features/game/flappy/flappy_bird_game.dart';
import 'package:gamehub/features/game/flappy/utils/bird_movement.dart';
import 'package:gamehub/features/game/flappy/utils/flappy_audios.dart';
import 'package:gamehub/features/game/flappy/utils/flappy_configuration.dart';
import 'package:gamehub/features/game/flappy/utils/flappy_images.dart';
import 'package:gamehub/features/game/flappy/utils/flappy_routes.dart';

class Bird extends SpriteGroupComponent<BirdMovement> with HasGameRef<FlappyBirdGame>, CollisionCallbacks{
  int score = 0;

  @override
  Future<void> onLoad()async{
    final birdMidFlap = await gameRef.loadSprite(FlappyImages.birdMidflap);
    final birdUpFlap = await gameRef.loadSprite(FlappyImages.birdUpflap);
    final birdDownFlap = await gameRef.loadSprite(FlappyImages.birdDownflap);

    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    current = BirdMovement.middle;
    sprites = {
      BirdMovement.middle : birdMidFlap,
      BirdMovement.up : birdUpFlap,
      BirdMovement.down : birdDownFlap,
    };

    add(CircleHitbox());
  }

  void fly() {
    add(
      MoveByEffect(
        Vector2(0, FlappyConfiguration.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down
      )
    );

    current = BirdMovement.up;
    FlameAudio.play(FlappyAudios.flying);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    gameOver();
  }

  void reset(){
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    score = 0;
  }

  void gameOver(){
    FlameAudio.play(FlappyAudios.collision);
    gameRef.overlays.add(FlappyRoutes.gameOver);
    gameRef.pauseEngine();
    game.isHit = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += FlappyConfiguration.birdVelocity * dt;
    if(position.y < 1) {
      gameOver();
    }
  }
}