import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/features/game/flappy/flappy_bird_game.dart';
import 'package:gamehub/features/game/flappy/presentation/pages/game_over_screen.dart';
import 'package:gamehub/features/game/flappy/presentation/pages/main_menu_screen.dart';
import 'package:gamehub/features/game/flappy/utils/flappy_routes.dart';

class FlappyBirdPage extends StatelessWidget{
  const FlappyBirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    final game = FlappyBirdGame();
    return GameWidget(
      game: game,
      initialActiveOverlays: const [FlappyRoutes.mainMenu],
      overlayBuilderMap: {
        FlappyRoutes.mainMenu : (context, _) => MainMenuScreen(game: game),
        FlappyRoutes.gameOver : (context, _) => GameOverScreen(game: game),
      },
    );
  }
}