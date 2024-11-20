import 'package:flutter/material.dart';
import 'package:pmsn2024b/game.dart';
import 'dart:math' as math;

import 'package:pmsn2024b/settings/colors_settings.dart';

class gameCard extends StatelessWidget {
  Game game;
  double pageOffset;
  late double animation;
  double animate = 0;
  double rotate = 0;
  double columnAnimation = 0;
  int index;
  gameCard(this.game, this.pageOffset, this.index);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardWidth = size.width - 60;
    double cardHeight = size.height * .54;
    double count = 0;
    double page;
    rotate = index - pageOffset;
    for (page = pageOffset; page > 1;) {
      page --;
      count ++;
    }
    animation = Curves.easeOutBack.transform(page);
    animate = 100*(count+animation);
    columnAnimation = 50*(count+animation);
    for (int i = 0; i < index; i++) {
      animate-= 100;
      columnAnimation-= 50;
    }

    return Container(
      child: Stack(
        children: <Widget>[
          buildTopText(),
          buildBackgroundImage(cardWidth, cardHeight, size),
          buildAboveCard(cardWidth, cardHeight, size),
          buildCharacterImage(size),
          buildBlurImage(cardWidth, size),
          buildSmallImage(size),
          buildTopImage(cardWidth, size, cardHeight),
        ],
      ),
    );
  }

  Widget buildTopText() {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          Text(
            game.name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: game.lightColor),
          ),
          Text(
            game.conName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: game.lightColor),
          ),
        ],
      ),
    );
  }

  Widget buildBackgroundImage(double cardWidth, double cardHeight, Size size) {
    return Positioned(
        width: cardWidth,
        height: cardHeight,
        bottom: size.height * .12,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              game.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
        ));
  }

  Widget buildAboveCard(double cardWidth, double cardHeight, Size size) {
    return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height * .12,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            color: game.darkColor.withOpacity(.50),
            borderRadius: BorderRadius.circular(25)),
        padding: const EdgeInsets.all(30),
        child: Transform.translate(
          offset: Offset(-columnAnimation, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Acerca de...',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(game.description, style: const TextStyle(color: Colors.white70, fontSize: 14)),
              const Spacer(),
              
              const SizedBox(height: 15),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    color: ColorsSettings.bottomColor, borderRadius: BorderRadius.circular(20)),
                child: const Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Text('\$',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      SizedBox(width: 10),
                      Text('39.',
                          style: TextStyle(fontSize: 19, color: Colors.white)),
                      Text('99',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCharacterImage(Size size) {
    return Positioned(
      bottom: 50,
      right: -size.width * .4 / 2 + 65,
      child: Transform.rotate(
        angle: -math.pi/14*rotate,
        child: Image.asset(
          game.characterImage,
          height: size.height * .34 - 15,
        ),
      ),
    );
  }

  Widget buildBlurImage(double cardWidth, Size size) {
    return Positioned(
      right: cardWidth / 2 - 60+animate,
      bottom: size.height * .001,
      child: Image.asset(game.imageBlur, height: 80,),
    );
  }

  Widget buildSmallImage(Size size) {
    return Positioned(
      right: -5,
      top: size.height * .01,
      child: Image.asset(game.imageSmall, height: 120,),
    );
  }

  Widget buildTopImage(double cardWidth, Size size, double cardHeight) {
    return Positioned(
      left: cardWidth / 4-animate,
      bottom: size.height * .15 + cardHeight - 25,
      child: Image.asset(game.imageTop),
    );
  }
}
