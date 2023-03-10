/*
  Collect Coins Lab:
  
  Coins are placed randomly on the screen. Player moves around and collect coins.
  The number of coins is updated and displayed on the screen.
  
  For more detail, see the tutorial: https://youtu.be/RMmo3SktDJo
   
   
  Complete the code as indicated by the comments.
  Do the following:
  1) In setup, initialize arraylist of coins. Then use a loop to create coin Sprites and placed them
  randomly on the screen. Add each coin to arraylist.
  2) In draw, for loop to display each coin. 
  3) Now, implement checkCollision and checkCollisionList. (in the video above, I wrote the code for these methods) 
  4) In draw, call checkCollisionList with parameters player and list of coins to get collision list.
  Loop through collision list and remove them and update score. 
  5) In draw, display score using textSize(), fill() and text().
  
  See the comments below for more details. 
 
*/

final static float MOVE_SPEED = 4;
final static float COIN_SCALE = 0.4;
final static float TANK_SCALE = 0.8;

PImage Coin;


Sprite player;
ArrayList<Sprite> coins;
int numCoins;

void setup(){
  size(1024, 768);
  imageMode(CENTER);
  player = new Sprite("tank.png", TANK_SCALE, width/2, height/2);

  // initialize score
  numCoins = 0;

  // initialize the arrayList coins
  coins = new ArrayList<Sprite>();
  Coin = loadImage("coin.png");
  
  
  // for loop to create coin Sprite and add to coins arraylist
  // randomize their center_x and center_y(use MATH.random() and cast to float)
  for(int i=0;i<=10;i++){
    Sprite c = new Sprite(Coin, COIN_SCALE); 
    c.center_x = (float) Math.random() * (1024 - 0 + 1) + 0; 
    c.center_y = (float) Math.random() * (768 - 0 + 1) + 0; 
    coins.add(c);
  } 
}

void draw(){
  background(255);
  player.display();
  player.update();
  
  // use for each loop to display coins
  for(Sprite coin: coins){
    coin.display();
  }

  // call checkCollisionList and 
  // store the returned collision list(arraylist) of coin Sprites that collide with player.
  // if collision list not empty
  //   for loop through collision list
  //     remove each coin, add 1 to score
  ArrayList<Sprite> coin_list = checkCollisionList(player, coins); 
  if(coin_list.size() > 0) {
    for(Sprite coin: coin_list) {
      numCoins++; 
      coins.remove(coin); 
    }
  }

  
  
  
  
  // call textSize(size), fill(r, g, b) and text(str, x, y) to display score. 
  textSize(32);
  fill(255, 0, 0);
  text("Coins:" + numCoins, 50, 50);
}

// returns whether the two Sprites s1 and s2 collide.
public boolean checkCollision(Sprite s1, Sprite s2){
  boolean noXOverlap = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
  boolean noYOverlap = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
  if(noXOverlap || noYOverlap)
    return false;
  else 
    return true;
}

/**
   This method accepts a Sprite s and an ArrayList of Sprites and returns
   the collision list(ArrayList) which consists of the Sprites that collide with the given Sprite. 
   MUST CALL THE METHOD checkCollision ABOVE!
*/ 
public ArrayList<Sprite> checkCollisionList(Sprite s, ArrayList<Sprite> list){
  ArrayList<Sprite> collision_list = new ArrayList<Sprite>();
  for(Sprite p: list){
    if(checkCollision(s, p))
      collision_list.add(p);
  }
  return collision_list;
}


  
void keyPressed(){
  if(keyCode == RIGHT)
    player.change_x = MOVE_SPEED;
  else if(keyCode == LEFT)
    player.change_x = -MOVE_SPEED;
  else if(keyCode == UP)
    player.change_y = -MOVE_SPEED;
  else if(keyCode == DOWN)
    player.change_y = MOVE_SPEED;
}

void keyReleased(){
  if(keyCode == RIGHT)
    player.change_x = 0;
  else if(keyCode == LEFT)
    player.change_x = 0;
  else if(keyCode == UP)
    player.change_y = 0;
  else if(keyCode == DOWN)
    player.change_y = 0;
    
}
