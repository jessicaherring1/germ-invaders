import processing.sound.*;

//sounds
SoundFile backgroundSong;
SoundFile cheer;
SoundFile boo;
SoundFile shotSound;


// images
PImage covid;
PImage shot;
PImage background;
PImage rulesBackground;
PImage win;
PImage dead;
PImage germsSpread;
PImage level;

//player 
Player p;

//buttons
Button rules;  // game rules/information
Button back;   // back button to start screen
Button levels; // button to levels screen 
Button level1; // button to level 1
Button level2; // button to level 2
Button level3; // button to level 3

//enemy variables 
int numEnemies = 15;
boolean isShooting;


//array of bullets and enemies
ArrayList<Bullet> bulletList; // bullets for the player 
ArrayList<Bullet> bulletList2; // bullets for the enemies 
ArrayList<Enemy> enemyList1; // enemies for level 1 and 2
ArrayList<Enemy> enemyList2; // enemies for level 3
Enemy[] enemyList = new Enemy[numEnemies];

//initializing animation variables 
Animation covidAnimation;
Animation shotAnimation;

// array to hold  images
PImage[] covidimages = new PImage[4];
PImage[] shotimages = new PImage[5];

// switchVal for changing states
int switchVal = 0;


void setup() {
  size(999, 800);

  backgroundSong = new SoundFile(this, "background.wav");
  cheer = new SoundFile(this, "cheer.wav");
  boo = new SoundFile(this, "boo.wav");
  shotSound = new SoundFile(this, "shot.wav");

  background = loadImage("welcome_screen4.jpg");
  rulesBackground = loadImage("rules.jpg");
  win = loadImage("win1.jpg");
  dead = loadImage("dead.jpg");
  germsSpread = loadImage("germsSpread.jpg");
  level = loadImage("levels2.jpg");

  p = new Player (width/2, 650, 50); 
  bulletList = new ArrayList<Bullet>();
  bulletList2 = new ArrayList<Bullet>();

  // load all the  images and put them in an array
  for (int i=0; i <covidimages.length; i++) {
    covidimages[i] = loadImage("covid"+i+".png");
  }

  for (int i = 0; i < enemyList.length; i++) {
    enemyList[i] = new Enemy(int (random (0, width)), 0);
  }

  covidAnimation = new Animation (covidimages, 0.1, 0.7);

  enemyList1 = new ArrayList<Enemy>();
  enemyList1.add(new Enemy (100, 0));
  enemyList1.add(new Enemy (200, 0));
  enemyList1.add(new Enemy (300, 0));
  enemyList1.add(new Enemy (400, 0));
  enemyList1.add(new Enemy (500, 0));
  enemyList1.add(new Enemy (600, 0));
  enemyList1.add(new Enemy (700, 0));
  enemyList1.add(new Enemy (800, 0));
  enemyList1.add(new Enemy (900, 0));

  enemyList2 = new ArrayList<Enemy>();
  // row 1
  enemyList2.add(new Enemy (100, 0));
  enemyList2.add(new Enemy (200, 0));
  enemyList2.add(new Enemy (300, 0));
  enemyList2.add(new Enemy (400, 0));
  enemyList2.add(new Enemy (500, 0));
  enemyList2.add(new Enemy (600, 0));
  enemyList2.add(new Enemy (700, 0));
  enemyList2.add(new Enemy (800, 0));
  enemyList2.add(new Enemy (900, 0));
  // row 2
  enemyList2.add(new Enemy (100, -60));
  enemyList2.add(new Enemy (200, -60));
  enemyList2.add(new Enemy (300, -60));
  enemyList2.add(new Enemy (400, -60));
  enemyList2.add(new Enemy (500, -60));
  enemyList2.add(new Enemy (600, -60));
  enemyList2.add(new Enemy (700, -60));
  enemyList2.add(new Enemy (800, -60));
  enemyList2.add(new Enemy (900, -60));
  // row 3
  enemyList2.add(new Enemy (100, -120));
  enemyList2.add(new Enemy (200, -120));
  enemyList2.add(new Enemy (300, -120));
  enemyList2.add(new Enemy (400, -120));
  enemyList2.add(new Enemy (500, -120));
  enemyList2.add(new Enemy (600, -120));
  enemyList2.add(new Enemy (700, -120));
  enemyList2.add(new Enemy (800, -120));
  enemyList2.add(new Enemy (900, -120)); 

  for (int i=0; i <shotimages.length; i++) {
    shotimages[i] = loadImage("shot"+i+".png");
  }

  shotAnimation = new Animation (shotimages, 0.4, 2);

  // buttons
  rules  = new Button (750, 650, 200, 100, color (#B3F0A0), "Rules");
  back   = new Button (750, 650, 200, 100, color (#B3F0A0), "Home");
  levels = new Button (50, 650, 200, 100, color (#B3F0A0), "Levels");
  level1 = new Button (150, 350, 200, 100, color (#B3F0A0), "1");
  level2 = new Button (400, 350, 200, 100, color (#B3F0A0), "2");
  level3 = new Button (650, 350, 200, 100, color (#B3F0A0), "3");
}

void draw() {
  background(42);



  switch(switchVal) {

    //start screen
  case 0:
    background(background);
    
    if (cheer.isPlaying()) {
      cheer.stop();
    }
    if (boo.isPlaying()) {
      boo.stop();
    }

    rules.render();
    levels.render();
    if (rules.isInButton() == true) {
      switchVal = 1;
    }
    if (levels.isInButton() == true) {
      switchVal = 8;
    }

    break;

    // rule screen 
  case 1:
    background (rulesBackground);

    textSize (40);
    textAlign (CENTER);
    fill (255, 255, 255);
    text ("The goal is to kill all germs before they\n reach the bottom.\n Use the arrow keys to move the vaccination\n from left to right.\n The space bar is used to shoot bullets.\n If the spore reaches the bottom or hits you,\n you lose.", 
      width/2, 250);

    back.render();
    if (back.isInButton() == true) {
      switchVal = 0;
    }
    break;

    //level 1
  case 2:

    covidAnimation.isAnimating = true;

    shotAnimation.display (p.x, p.y);

    for (int x = 0; x < width; x++) { 
      set (x, 700, color(255, 0, 255));
    }

    p.move();
    p.resetBoundaries();

    for (Enemy enemy1 : enemyList1) {
      enemy1.render();
      enemy1.move();
      enemy1.resetBoundaries();
      enemy1.hitBottom();
      enemy1.hitPlayer(p);
    }

    for (Bullet bullet1 : bulletList) {
      bullet1.render();
      bullet1.move();
      bullet1.resetBoundaries();

      //checking to see if enemy is hit
      for (Enemy enemy1 : enemyList1) {
        enemy1.isHit(bullet1);
        bullet1.isHit(enemy1);
      }

      for (int i = enemyList1.size()-1; i>=0; i--) {
        if (enemyList1.get(i).isDead == true) {
          enemyList1.remove(i);
        }
        if (enemyList1.size() == 0) {
          switchVal = 3;
          reinitialize();
        }
      }
    }
    break;

    //level 2
  case 3:

    covidAnimation.isAnimating = true;

    shotAnimation.display (p.x, p.y);

    for (int x = 0; x < width; x++) { 
      set (x, 700, color(255, 0, 255));
    }

    p.move();
    p.resetBoundaries();
    
    // player shots 
    for (Bullet bullet1 : bulletList) {
      bullet1.render();
      bullet1.move();
      bullet1.resetBoundaries();
      //checking to see if enemy is hit
      for (Enemy enemy1 : enemyList1) {
        enemy1.isHit(bullet1);
        bullet1.isHit(enemy1);
      }
      for (int i = enemyList1.size()-1; i>=0; i--) {
        if (enemyList1.get(i).isDead == true) {
          enemyList1.remove(i);
          // bulletList.remove(i);
        }
        if (enemyList1.size() == 0) {
          switchVal = 4; 
          reinitialize();
        }
      }
    }

    //enemy shots 
    for (Bullet bullet1 : bulletList2) {
      bullet1.render();
      bullet1.moveEnemy();
      bullet1.resetBoundaries();

      //checking to see if player is hit
      if ((bullet1.x >= p.leftBound - 10) && (bullet1.x <= p.rightBound - 40) && 
        (bullet1.y >= p.topBound - 25) && (bullet1.y <= p.bottomBound)) {
        switchVal = 6;
      }
    }

    for (Enemy enemy1 : enemyList1) {
      enemy1.render();
      enemy1.move();
      enemy1.resetBoundaries();
      enemy1.hitBottom();
      enemy1.hitPlayer(p);

      // shoot shots every 100 pixels 
      if (enemy1.y == 100) {
        bulletList2.add(new Bullet(enemy1.rightBound - 50, enemy1.bottomBound));
      }
      if (enemy1.y == 200) {
        bulletList2.add(new Bullet(enemy1.rightBound - 50, enemy1.bottomBound));
      }
      if (enemy1.y == 300) {
        bulletList2.add(new Bullet(enemy1.rightBound - 50, enemy1.bottomBound));
      }
      if (enemy1.y == 400) {
        bulletList2.add(new Bullet(enemy1.rightBound - 50, enemy1.bottomBound));
      }
    }

    break;

    //level 3
  case 4:
    covidAnimation.isAnimating = true;

    shotAnimation.display (p.x, p.y);

    for (int x = 0; x < width; x++) { 
      set (x, 700, color(255, 0, 255));
    }

    p.move();
    p.resetBoundaries();

    // player shots 
    for (Bullet bullet1 : bulletList) {
      bullet1.render();
      bullet1.move();
      bullet1.resetBoundaries();
      //checking to see if enemy is hit
      for (Enemy enemy1 : enemyList2) {
        enemy1.isHit(bullet1);
        bullet1.isHit(enemy1);
      }
      for (int i = enemyList2.size()-1; i>=0; i--) {
        if (enemyList2.get(i).isDead == true) {
          enemyList2.remove(i);
          // bulletList.remove(i);
        }
        if (enemyList2.size() == 0) {
          switchVal = 5; 
          reinitialize();
        }
      }
    }

    //enemy shots 
    for (Bullet bullet1 : bulletList2) {
      bullet1.render();
      bullet1.moveEnemy();
      bullet1.resetBoundaries();

      //checking to see if player is hit
      if ((bullet1.x >= p.leftBound - 10) && (bullet1.x <= p.rightBound - 40) && 
        (bullet1.y >= p.topBound - 25) && (bullet1.y <= p.bottomBound)) {
        switchVal = 6;
      }
    }

    for (Enemy enemy1 : enemyList2) {
      enemy1.render();
      enemy1.move();
      enemy1.resetBoundaries();
      enemy1.hitBottom();
      enemy1.hitPlayer(p);

      // shoot shots every 100 pixels 
      if (enemy1.y == 50) {
        bulletList2.add(new Bullet(enemy1.rightBound - 50, enemy1.bottomBound));
      }
      if (enemy1.y == 150) {
        bulletList2.add(new Bullet(enemy1.rightBound - 50, enemy1.bottomBound));
      }
      if (enemy1.y == 300) {
        bulletList2.add(new Bullet(enemy1.rightBound - 50, enemy1.bottomBound));
      }
    }


    break;

    //win screen
  case 5:
    background(win);

    if (!cheer.isPlaying()) {
      cheer.play();
    }

    break;

    //lose screen 1 (player hit by enemy or bullet)
  case 6:
    background(dead);

    if (!boo.isPlaying()) {
      boo.play();
    }

    break;

    //lose screen 2 (player does not kill germ and it reaches bottom of screen)
  case 7:
    background(germsSpread);

    if (!boo.isPlaying()) {
      boo.play();
    }

    break;

    //level screen
  case 8:
    background(level);

    level1.render();
    level2.render();
    level3.render();
    back.render();

    if (level1.isInButton() == true) {
      switchVal = 2;
    }
    if (level2.isInButton() == true) {
      switchVal = 3;
    }
    if (level3.isInButton() == true) {
      switchVal = 4;
    }
    if (back.isInButton() == true) {
      switchVal = 0;
    }

    break;
  }
}


void keyPressed() {
  if (key == CODED && keyCode == RIGHT) {
    p.movingRight = true;
  }
  if (key == CODED && keyCode == LEFT) {
    p.movingLeft = true;
  }
  if (key == ' ' && switchVal == 0) {
    switchVal = 2;
    // reinitialize();
  }
  if (keyCode == ENTER && switchVal == 5) {
    switchVal = 0;
    reinitialize();
  }
  if (keyCode == ENTER && switchVal == 6) {
    switchVal = 0;
    reinitialize();
  }
  if (keyCode == ENTER && switchVal == 7) {
    switchVal = 0;
    reinitialize();
  }

  if (key == ' ') {
    bulletList.add(new Bullet(p.rightBound - 50, p.topBound - 40));
    shotAnimation.isAnimating = true;
    shotSound.play();
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

void reinitialize() {
  //reinitiating the vars

  // load all the  images and put them in an array
  for (int i=0; i <covidimages.length; i++) {
    covidimages[i] = loadImage("covid"+i+".png");
  }
  p = new Player (width/2, 650, 50); 
  bulletList  = new ArrayList<Bullet>();
  bulletList2 = new ArrayList<Bullet>();
  covidAnimation = new Animation (covidimages, 0.1, 0.7);

  enemyList1 = new ArrayList<Enemy>();
  enemyList1 = new ArrayList<Enemy>();
  enemyList1.add(new Enemy (100, 0));
  enemyList1.add(new Enemy (200, 0));
  enemyList1.add(new Enemy (300, 0));
  enemyList1.add(new Enemy (400, 0));
  enemyList1.add(new Enemy (500, 0));
  enemyList1.add(new Enemy (600, 0));
  enemyList1.add(new Enemy (700, 0));
  enemyList1.add(new Enemy (800, 0));
  enemyList1.add(new Enemy (900, 0));

  enemyList2 = new ArrayList<Enemy>();

  // row 1
  enemyList2.add(new Enemy (100, 0));
  enemyList2.add(new Enemy (200, 0));
  enemyList2.add(new Enemy (300, 0));
  enemyList2.add(new Enemy (400, 0));
  enemyList2.add(new Enemy (500, 0));
  enemyList2.add(new Enemy (600, 0));
  enemyList2.add(new Enemy (700, 0));
  enemyList2.add(new Enemy (800, 0));
  enemyList2.add(new Enemy (900, 0));
  // row 2
  enemyList2.add(new Enemy (100, -60));
  enemyList2.add(new Enemy (200, -60));
  enemyList2.add(new Enemy (300, -60));
  enemyList2.add(new Enemy (400, -60));
  enemyList2.add(new Enemy (500, -60));
  enemyList2.add(new Enemy (600, -60));
  enemyList2.add(new Enemy (700, -60));
  enemyList2.add(new Enemy (800, -60));
  enemyList2.add(new Enemy (900, -60));
  // row 3
  enemyList2.add(new Enemy (100, -120));
  enemyList2.add(new Enemy (200, -120));
  enemyList2.add(new Enemy (300, -120));
  enemyList2.add(new Enemy (400, -120));
  enemyList2.add(new Enemy (500, -120));
  enemyList2.add(new Enemy (600, -120));
  enemyList2.add(new Enemy (700, -120));
  enemyList2.add(new Enemy (800, -120));
  enemyList2.add(new Enemy (900, -120));
}
