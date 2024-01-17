import 'dart:async';
import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamehub/features/game/brick/presentation/components/brick_components.dart';
import 'package:gamehub/features/game/brick/utils/brick_configuration.dart';

enum BrickBreakerState { welcome, playing, gameOver, won }

class BrickBreakerGame extends FlameGame with HasCollisionDetection, KeyboardEvents, TapDetector{
  BrickBreakerGame() : super(
    camera: CameraComponent.withFixedResolution(
        width: BrickConfiguration.gameWidth,
        height: BrickConfiguration.gameHeight
    )
  );

  final ValueNotifier<int> score = ValueNotifier(0);
  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  late BrickBreakerState _playState;
  BrickBreakerState get playState => _playState;
  set playState(BrickBreakerState playState){
    _playState = playState;
    switch(playState){
      case BrickBreakerState.welcome:
      case BrickBreakerState.gameOver:
      case BrickBreakerState.won:
        overlays.add(playState.name);
      case BrickBreakerState.playing:
        overlays.remove(BrickBreakerState.welcome.name);
        overlays.remove(BrickBreakerState.gameOver.name);
        overlays.remove(BrickBreakerState.won.name);
    }
  }

  @override
  FutureOr<void> onLoad()async{
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    playState = BrickBreakerState.welcome;
  }

  void startGame(){
    if(playState == BrickBreakerState.playing) return;

    world.removeAll(world.children.query<Ball>());
    world.removeAll(world.children.query<Bat>());
    world.removeAll(world.children.query<Brick>());

    playState = BrickBreakerState.playing;
    score.value = 0;

    world.add(
        Ball(
            difficultyModifier: BrickConfiguration.difficultyModifier,
            radius: BrickConfiguration.ballRadius,
            position: size / 2,
            velocity: Vector2((rand.nextDouble() - 0.5) * width, height * 0.2).normalized()
              ..scale(height / 4)
        )
    );

    world.add(
        Bat(
            cornerRadius: const Radius.circular(BrickConfiguration.ballRadius / 2),
            position: Vector2(width / 2, height * 0.95),
            size: Vector2(BrickConfiguration.batWidth, BrickConfiguration.batHeight)
        )
    );

    world.addAll([
      for(var i = 0; i < BrickConfiguration.brickColors.length; i++)
        for(var j = 1; j <= 5; j++)
          Brick(
              Vector2(
                  (i + 0.5) * BrickConfiguration.brickWidth + (i + 1) * BrickConfiguration.brickGutter,
                  (j + 2.0) * BrickConfiguration.brickHeight + j * BrickConfiguration.brickGutter
              ),
              BrickConfiguration.brickColors[i]
          )
    ]);
  }

  @override
  void onTap() {
    super.onTap();
    startGame();
  }

  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);

    switch(event.logicalKey){
      case LogicalKeyboardKey.arrowLeft:
        world.children.query<Bat>().first.moveBy(-BrickConfiguration.batStep);
      case LogicalKeyboardKey.arrowRight:
        world.children.query<Bat>().first.moveBy(BrickConfiguration.batStep);
      case LogicalKeyboardKey.space:
      case LogicalKeyboardKey.enter:
        startGame();
    }
    return KeyEventResult.handled;
  }

  @override
  Color backgroundColor() => const Color(0xfff2e8cf);
}