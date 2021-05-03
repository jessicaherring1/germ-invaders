class Player {
  //global vars
  int x; 
  int y; 
  int size; 
  int c; //color

  int runSpeed; 
  int jumpSpeed; 
  int fallSpeed; 

  int topBound;
  int bottomBound; 
  int leftBound; 
  int rightBound; 

  boolean movingLeft; 
  boolean movingRight; 

  boolean isJumping; 
  boolean isFalling; 

  int jumpHeight; 
  int peakY; // height of player after jump

  Player (int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY; 
    size = tempSize; 

    c = color (0, 0, 255);
    runSpeed = 5;
    jumpHeight = 60;
    jumpSpeed = 200;
    fallSpeed = 10;
    peakY = y + jumpHeight;
  }

  void render() {
    shot = loadImage("shot0.png");
    PImage covid = shot;
    image(covid, x, y);
  }

  void move() {
    if (movingRight == true) {
      x = x + runSpeed;
    }
    if (movingLeft == true) {
      x = x - runSpeed;
    }
  }



  void resetBoundaries() {
    topBound = y;
    bottomBound = y + size;
    leftBound = x; 
    rightBound = x + size;
  }
}
