// need help removing bullets

//  images
PImage covid;
PImage shot;

//player 
Player p;

//array of bullets and enemies
ArrayList<Bullet> bulletList;
ArrayList<Enemy> enemyList;

Animation covidAnimation;
Animation shotAnimation;

// array to hold  images

PImage[] covidimages = new PImage[4];
PImage[] shotimages = new PImage[5];

void setup() {
  size(1000, 800);

  p = new Player (width/2, 680, 50); 
  bulletList = new ArrayList<Bullet>();

  // load all the  images and put them in an array
  for (int i=0; i <covidimages.length; i++) {
    covidimages[i] = loadImage("covid"+i+".png");
  }

  covidAnimation = new Animation (covidimages, 0.1, 0.7);

  enemyList = new ArrayList<Enemy>();
  enemyList.add(new Enemy (400, 200));
  enemyList.add(new Enemy (600, 200));

  for (int i=0; i <shotimages.length; i++) {
    shotimages[i] = loadImage("shot"+i+".png");
  }

  shotAnimation = new Animation (shotimages, 0.4, 2);
}

void draw() {
  background(42);
  covidAnimation.isAnimating = true;

  shotAnimation.display (p.x, p.y);


  p.move();
  p.resetBoundaries();

  for (Enemy enemy1 : enemyList) {
    enemy1.render();
    enemy1.move(p);
    enemy1.resetBoundaries();
    enemy1.hitBottom();
    enemy1.hitPlayer(p);
  }

  for (Bullet bullet1 : bulletList) {
    bullet1.render();
    bullet1.move();
    bullet1.resetBoundaries();
    //checking to see if enemy is hit
    for (Enemy enemy1 : enemyList) {
      enemy1.isHit(bullet1);
    }

    for (int i = enemyList.size()-1; i>=0; i--) {
      if (enemyList.get(i).isDead == true) {
        enemyList.remove(i);
      }
    }
    //for (int i = bulletList.size()-1; i>=0; i--) {
    //  if (bulletList.get(i).removeBullet == true) {
    //    bulletList.remove(i);
    //  }
    //}
  }
}

void keyPressed() {
  if (key == CODED && keyCode == RIGHT) {
    p.movingRight = true;
  }
  if (key == CODED && keyCode == LEFT) {
    p.movingLeft = true;
  }
  if (key == ' ') {
    bulletList.add(new Bullet(p.rightBound - 50, p.topBound - 40));
    shotAnimation.isAnimating = true;
  }
}

void keyReleased() {
  if (key == CODED && keyCode == RIGHT) {
    p.movingRight = false;
  }
  if (key == CODED && keyCode == LEFT) {
    p.movingLeft = false;
  }
}
