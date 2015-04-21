library ex09v2;

import 'dart:html';
import 'package:boarding/pieces.dart';
import 'package:boarding/util.dart';
import 'package:boarding/boarding.dart';

part 'view/board.dart';

onOff(end) {
}

//abstract class Car extends MovablePiece {
 abstract class Car extends Piece {
  static const num defaultWidth = 75;
  static const num defaultHeight = 30;

  //Car(int id) : super(id) {
  Car(int id) {
    this.id = id;
    shape = PieceShape.VEHICLE;
    width = defaultWidth;
    height = defaultHeight;
  }
}

class NonRedCar extends Car {

  //NonRedCar(int id) : super(id) {
  NonRedCar(int id) {
     this.id = id;
    dx = randomRangeNum(1, 3);
    dy = randomRangeNum(1, 3);
    color.border = '#3ADF00';
    line.width = 3;
    color.main = 'blue';
  }
}

class RedCar extends Car {
  static const num smallWidth = 35;
  static const num smallHeight = 14;
  static const num bigWidth = 75;
  static const num bigHeight = 30;
  static const String smallColorCode = '#FF00FF';
  static const String bigColorCode = '#E40000';


  bool isSmall = false;

  RedCar(int id) : super(id) {
    smaller();
  }

  bool get isBig => !isSmall;

  move([Direction direction]) {
    if (x > space.width - width) {
      x = space.width - width;
    }
    if (x < 0) {
      x = 0;
    }
    if (y > space.height - height) {
      y = space.height - height;
    }
    if (y < 0) {
      y = 0;
    }
  }

  bigger() {
    if (isSmall) {
      isSmall = false;
      width = bigWidth;
      height = bigHeight;
      color.main = bigColorCode;

    }
  }

  smaller() {
    if (isBig) {
      isSmall = true;
      width = smallWidth;
      height = smallHeight;
      color.main = smallColorCode;

    }
  }
}

//class Cars extends MovablePieces {
class Cars extends Pieces {
  RedCar redCar;

  //Cars(int count) : super(count) {
  Cars(int count) {
    create (count);
    redCar = new RedCar(0);
  }

  //createMovablePieces(int count) {
  create(int count) {
    for (var i = 0; i < count - 1; i++) {
      add(new NonRedCar(i + 1));
    }
  }
}
