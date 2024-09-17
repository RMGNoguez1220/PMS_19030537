// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Game {
  String name;
  String conName;
  String backgroundImage;
  String imageTop;
  String imageSmall;
  String imageBlur;
  String characterImage;
  String description;
  Color lightColor;
  Color darkColor;

  Game(
    this.name,
    this.conName,
    this.backgroundImage,
    this.imageTop,
    this.imageSmall,
    this.imageBlur,
    this.characterImage,
    this.description,
    this.lightColor,
    this.darkColor,
  );
}
