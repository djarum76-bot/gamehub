import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/features/game/brick/brick_breaker_game.dart';
import 'package:gamehub/features/game/brick/presentation/widgets/score_card.dart';
import 'package:gamehub/features/game/brick/utils/brick_configuration.dart';

class BrickPage extends StatefulWidget{
  const BrickPage({super.key});

  @override
  State<BrickPage> createState() => _BrickPageState();
}

class _BrickPageState extends State<BrickPage> {
  late final BrickBreakerGame _game;

  @override
  void initState() {
    super.initState();
    _game = BrickBreakerGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffa9d6e5),
              Color(0xfff2e8cf),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  ScoreCard(score: _game.score),
                  Expanded(
                    child: FittedBox(
                      child: SizedBox(
                        width: BrickConfiguration.gameWidth,
                        height: BrickConfiguration.gameHeight,
                        child: GameWidget(
                          game: _game,
                          overlayBuilderMap: {
                            BrickBreakerState.welcome.name: (context, game) => Center(
                              child: Text(
                                'TAP TO PLAY',
                                style:
                                Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                            BrickBreakerState.gameOver.name: (context, game) => Center(
                              child: Text(
                                'G A M E   O V E R',
                                style:
                                Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                            BrickBreakerState.won.name: (context, game) => Center(
                              child: Text(
                                'Y O U   W O N ! ! !',
                                style:
                                Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}