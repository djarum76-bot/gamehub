import 'package:flutter/material.dart';
import 'package:gamehub/features/game/flappy/flappy_bird_game.dart';
import 'package:gamehub/features/game/flappy/utils/flappy_images.dart';
import 'package:gamehub/features/game/flappy/utils/flappy_routes.dart';

class MainMenuScreen extends StatelessWidget{
  const MainMenuScreen({super.key, required this.game});
  final FlappyBirdGame game;

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();

    return Scaffold(
      body: GestureDetector(
        onTap: (){
          game.overlays.remove(FlappyRoutes.mainMenu);
          game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(FlappyImages.menu),
                  fit: BoxFit.cover
              )
          ),
          child: Image.asset(FlappyImages.message),
        ),
      ),
    );
  }
}