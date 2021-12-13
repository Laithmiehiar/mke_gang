import 'package:flutter/material.dart';
import 'package:mke_gang/constants/color_constants.dart';

class CardModel {
  String name;
  String type;
  String balance;
  String valid;
  String title;
  String moreIcon;
  String cardBackground;
  Color bgColor;
  Color firstColor;
  Color secondColor;

  CardModel(
      this.name,
      this.type,
      this.balance,
      this.valid,
      this.title,
      this.moreIcon,
      this.cardBackground,
      this.bgColor,
      this.firstColor,
      this.secondColor);
}

List<CardModel> cards = cardData
    .map((item) => CardModel(
        item['name'] as String,
        item['type'] as String,
        item['balance'] as String,
        item['valid'] as String,
        item['title'] as String,
        item['moreIcon'] as String,
        item['cardBackground'] as String,
        item['bgColor'] as Color,
        item['firstColor'] as Color,
        item['secondColor'] as Color))
    .toList();

var cardData = [
  {
    "name": "Prambors",
    "type": "assets/images/mastercard_logo.png",
    "balance": "6.352.251",
    "valid": "06/24",
    "title": "You Owe",
    "moreIcon": 'assets/icons/more_icon_grey.svg',
    "cardBackground": 'assets/icons/mastercard_bg.svg',
    "bgColor": kMasterCardColor,
    "firstColor": kGreyColor,
    "secondColor": kBlackColor
  },
  {
    "name": "Prambors",
    "type": "assets/images/jenius_logo.png",
    "balance": "20.528.337",
    "valid": "02/23",
    "title": "Your Balance",
    "moreIcon": 'assets/icons/more_icon_white.svg',
    "cardBackground": 'assets/svg/jenius_bg.svg',
    "bgColor": kJeniusCardColor,
    "firstColor": kWhiteColor,
    "secondColor": kWhiteColor
  }
];
