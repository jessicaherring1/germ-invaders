class Bullet {
  //global vars
  int x;
  int y;
  int d;
  int c; //color
  int speed;

  int topBound; 
  int bottomBound;
  int leftBound;
  int rightBound; 
  
  boolean removeBullet;

  Bullet (int tempX, int tempY) {
    x = tempX;
    y = tempY;

    d = 5;
    c = color (255, 255, 255);
  }

  void render() {
    fill (c);
    circle (x, y, d);
  }

  void move() {
    y = y - 10;
  }
  
  void moveEnemy(){
    y += 5;
  }

  void resetBoundaries() {
    topBound = y - d/2;
    bottomBound = y + d/2;
    leftBound = x - d/2; 
    rightBound = x + d/2;
  }
  
  void isHit(Enemy anyEnemy) {
    if ((anyEnemy.x >= leftBound) && (anyEnemy.x <= rightBound) && 
      (anyEnemy.y >= topBound) && (anyEnemy.y <= bottomBound)) {
      removeBullet = true;
    }
  }
}
