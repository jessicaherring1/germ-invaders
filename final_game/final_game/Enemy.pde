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

  void move(Player player) {
    if (x > player.x) {
      x = x - ((x - player.x)/100);
      y = y + 1;
    } else if  (x < player.x) {
      x = x + ((player.x - x)/100);
      y = y + 1;
    }
  }

  void resetBoundaries() {
    topBound = y;
    bottomBound = y + h;
    leftBound = x - 20; 
    rightBound = x + w;
  }

  void hitBottom() {
    if (y >= height) {
      println("enemy hit bottom");
    }
  }

  void hitPlayer (Player player) {
    if ((player.x >= leftBound) && (player.x <= rightBound) && 
      (player.y >= topBound) && (player.y <= bottomBound)) {
      println("enemy hit player");
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
