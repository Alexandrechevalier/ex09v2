part of ex09v2;

class Board extends Surface {
  static const int carCount = 10; // including the red car

  int pt = 0;
  int nbHit = 0;
  Cars cars;
  RedCar redCar;
  Area space;
  bool isUp = true;
  bool isOp = true;
  bool end;
  num min = 50;
  num max = 125;
  num man = 25;
  num mix = 100;

  //Board(CanvasElement canvas) : super(canvas) {
  Board(CanvasElement canvas) {
    this.canvas = canvas;
    space = new Area.from(width, height);
    cars = new Cars(carCount);
    cars.forEach((Car car) {
      car.space = space;
    });
    redCar = cars.redCar;
    redCar.space = space;
    document.onMouseDown.listen((MouseEvent e) {
      if (redCar.isSmall) redCar.bigger();
    });
    document.onMouseMove.listen((MouseEvent e) {
      if (pt < 1) {
        redCar.x = e.offset.x - redCar.width / 2;
        redCar.y = e.offset.y - redCar.height / 2;
        if (redCar.isBig) {
          redCar.move();
        } else {
          redCar.x = canvas.width / 2.20;
          redCar.y = canvas.height * 0.1;
        }
      }
    });
  }

  draw() {
    clear();
    drawRect(canvas, 0, 0, width, height, color: '#D8D8D8', borderColor: 'black');
    drawSquare(canvas, 300, 470, 100, lineWidth: 1, color: '#E40000', borderColor: 'black');
    if (nbHit >= 3) {
      drawTag(canvas, 360, 250, 'GAME OVER!', size: 40);
      drawTag(canvas, 360, 300, 'F5 to try again', size: 30);
      return end;
    } else if (redCar.x > 300 && redCar.x < 350 && redCar.y > 450) {
      drawStar(canvas, 350, 250, 200, spikes: 5, lineWidth: 1, color: '#f8f800', borderColor: 'black');
      drawTag(canvas, 350, 250, 'YOU WIN!!!', size: 40);
      pt++; // 1ere facon de l'écrire
      return end;
    }
    bool isAccident = false;
    for (NonRedCar car in cars) {
      car.move();
      cars.avoidCollisions(car);
      cars.forEach((car) {
        if (redCar.isBig && redCar.hit(car)) {
          redCar.smaller();
          isAccident = true;
          nbHit == nbHit++; // 2e facon de l'écrire
        }
      });

      if (car.width > max) {
        car.width = max;
        isUp = false;
      } else if (car.width < min) {
        car.width = min;
        isUp = true;
      }
      if (isUp) {
        car.width = car.width + 2;
      } else {
        car.width = car.width - 2;
      }
      if (car.height > mix) {
        car.height = mix;
        isOp = false;
      } else if (car.height < man) {
        car.height = man;
        isOp = true;
      }
      if (isOp) {
        car.height = car.height + 2;
      } else {
        car.height = car.height - 2;
      }
      drawPiece(car);
    }
    if (isAccident) {
      var car = new NonRedCar(1);
      car.box.position = space.randomPosition();
      car.space = space;
      cars.add(car);
    }
    drawPiece(redCar);
  }
}
