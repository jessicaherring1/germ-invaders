class Enemy {
  //vars
  int x;
  int y;
  int w; // width
  int h; // height
  int c; // color

  int topBound;
  int bottomBound;
  int leftBound;
  int rightBound;

  boolean isDead;
  boolean hitPlayer;

  Enemy (int tempX, int tempY) {
    x = tempX;
    y = tempY;

    w = 50; 
    h = 30; 
    c = color (#B2CBB1);
  }

  void render() {
    covidAnimation.display(x, y);
  }

  void move() { 
      y = y + 1;
  }

  void resetBoundaries() {
    topBound = y;
    bottomBound = y + h;
    leftBound = x - 20; 
    rightBound = x + w;
  }

  void hitBottom() {
    if (y >= 730) {
      println("enemy hit bottom");
      switchVal = 7;
    }
  }

  void hitPlayer (Player player) {
    if ((player.x >= leftBound) && (player.x <= rightBound) && 
      (player.y >= topBound) && (player.y <= bottomBound)) {
      println("enemy hit player");
      switchVal = 6;
    }
  }

  void isHit(Bullet anyBullet) {
    if ((anyBullet.x >= leftBound) && (anyBullet.x <= rightBound) && 
      (anyBullet.y >= topBound) && (anyBullet.y <= bottomBound)) {
      isDead = true;
      anyBullet.removeBullet = true;
    }
  }
}
