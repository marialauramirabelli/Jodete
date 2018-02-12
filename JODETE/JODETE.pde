int cardWidth = 168;
int cardHeight = 243;
//based on the dimensions of the images
int screenWidth = 1440;
int screenHeight = 1365;
//For cardWidth = 168 and cardHeight = 243

int buttonX = screenWidth-200;
int buttonY = 50;
int buttonWidth = 150;
int buttonHeight = 50;

int suits = 4;
int elements = 13;
int jokers = 2;

int[][] deck = new int[suits*elements+jokers][2];
int[] activeDeck = new int[suits*elements+jokers];
int[] pile = new int[suits*elements+jokers];
int[] user = new int[suits*elements+jokers];
int[] computer = new int[suits*elements+jokers];

PImage[] cards = new PImage[55];

int pileCard;

void setup() {
  size(1440, 1365);
  background(0, 51, 102);
  
  fill(255);
  stroke(0);
  rect(buttonX, buttonY, buttonWidth, buttonHeight);
  fill(0);
  textSize(30);
  text("RESTART",screenWidth-190,85); 

  //For suits = 4, elements = 13, and jokers = 2:
  //Initializes clubs (from A to K)
  cards[0] = loadImage("row-1-col-1.jpg");
  cards[1] = loadImage("row-1-col-2.jpg");
  cards[2] = loadImage("row-1-col-3.jpg");
  cards[3] = loadImage("row-1-col-4.jpg");
  cards[4] = loadImage("row-1-col-5.jpg");
  cards[5] = loadImage("row-1-col-6.jpg");
  cards[6] = loadImage("row-1-col-7.jpg");
  cards[7] = loadImage("row-1-col-8.jpg");
  cards[8] = loadImage("row-1-col-9.jpg");
  cards[9] = loadImage("row-1-col-10.jpg");
  cards[10] = loadImage("row-1-col-11.jpg");
  cards[11] = loadImage("row-1-col-12.jpg");
  cards[12] = loadImage("row-1-col-13.jpg");
  //Initializes diamonds (from A to K)
  cards[13] = loadImage("row-2-col-1.jpg");
  cards[14] = loadImage("row-2-col-2.jpg");
  cards[15] = loadImage("row-2-col-3.jpg");
  cards[16] = loadImage("row-2-col-4.jpg");
  cards[17] = loadImage("row-2-col-5.jpg");
  cards[18] = loadImage("row-2-col-6.jpg");
  cards[19] = loadImage("row-2-col-7.jpg");
  cards[20] = loadImage("row-2-col-8.jpg");
  cards[21] = loadImage("row-2-col-9.jpg");
  cards[22] = loadImage("row-2-col-10.jpg");
  cards[23] = loadImage("row-2-col-11.jpg");
  cards[24] = loadImage("row-2-col-12.jpg");
  cards[25] = loadImage("row-2-col-13.jpg");
  //Initializes hearts (from A to K)
  cards[26] = loadImage("row-3-col-1.jpg");
  cards[27] = loadImage("row-3-col-2.jpg");
  cards[28] = loadImage("row-3-col-3.jpg");
  cards[29] = loadImage("row-3-col-4.jpg");
  cards[30]= loadImage("row-3-col-5.jpg");
  cards[31] = loadImage("row-3-col-6.jpg");
  cards[32] = loadImage("row-3-col-7.jpg");
  cards[33] = loadImage("row-3-col-8.jpg");
  cards[34]= loadImage("row-3-col-9.jpg");
  cards[35] = loadImage("row-3-col-10.jpg");
  cards[36] = loadImage("row-3-col-11.jpg");
  cards[37] = loadImage("row-3-col-12.jpg");
  cards[38] = loadImage("row-3-col-13.jpg");
  //Initializes spades (from A to K)
  cards[39] = loadImage("row-4-col-1.jpg");
  cards[40] = loadImage("row-4-col-2.jpg");
  cards[41] = loadImage("row-4-col-3.jpg");
  cards[42] = loadImage("row-4-col-4.jpg");
  cards[43] = loadImage("row-4-col-5.jpg");
  cards[44] = loadImage("row-4-col-6.jpg");
  cards[45] = loadImage("row-4-col-7.jpg");
  cards[46] = loadImage("row-4-col-8.jpg");
  cards[47]= loadImage("row-4-col-9.jpg");
  cards[48] = loadImage("row-4-col-10.jpg");
  cards[49] = loadImage("row-4-col-11.jpg");
  cards[50] = loadImage("row-4-col-12.jpg");
  cards[51] = loadImage("row-4-col-13.jpg");
  //Initializes jokers (black and red) and card back
  cards[52] = loadImage("row-5-col-1.jpg");
  cards[53] = loadImage("row-5-col-2.jpg");
  cards[54] = loadImage("row-5-col-3.jpg");

  //Creates deck
  println("Deck:");
  for (int x=0; x<suits; x++) {
    for (int y=0; y<elements; y++) {
      deck[elements*x+y][0] = x+1;
      deck[elements*x+y][1] = y+1;
      println("Card "+(elements*x+y+1)+": "+"["+deck[elements*x+y][0]+"]["+deck[elements*x+y][1]+"]");
    }
  }
  for (int z=0; z<jokers; z++) {
    deck[suits*elements+z][0] = 0;
    deck[suits*elements+z][1] = z;
    println("Card "+(suits*elements+z+1)+": "+"["+deck[suits*elements+z][0]+"]["+deck[suits*elements+z][1]+"]");
  }
  
  //Creates active deck / Creates pile, user cards, and computer cards with -1 values ("control" method)
  for(int x=0; x<(suits*elements+jokers); x++){
    activeDeck[x] = x;
    pile[x] = -1;
    user[x] = -1;
    computer[x] = -1;
  }
  
  drawStartingCard();
  drawPlayerCards();
}

void drawStartingCard(){
  //Takes card from active deck and places it on pile
  int deckCard = (int)random(suits*elements+1);
  while(activeDeck[deckCard] == -1){
    deckCard = (int)random(suits*elements+1);
  }
  activeDeck[deckCard] = -1;
  for(int x=0; x<(suits*elements+jokers); x++){
    if(pile[x] == -1){
      pile[x] = deckCard;
      pileCard = deckCard;
      break;
    }
  }
  println(pile);
  println("Active deck: ");
  println(activeDeck);
}

void drawPlayerCards(){
  //Takes 10 cards from active deck and gives them to players, five cards each
  for(int x=0; x<10; x++){
    int deckCard = (int)random(suits*elements+1);
    while(activeDeck[deckCard] == -1){
      deckCard = (int)random(suits*elements+1);
    }
    activeDeck[deckCard] = -1;
    for(int y=0; y<(suits*elements+jokers); y++){
      if(y < 5){
        if(user[y] == -1){
          user[y] = deckCard;
          break;
        }
      }
      else{
        if(computer[y-5] == -1){
          computer[y-5] = deckCard;
          break;
        }
      }
    }
  }
  println("User: ");
  println(user);
  println("Computer: ");
  println(computer);
}

void mousePressed(){
  if(mouseX>=buttonX && mouseX<=(buttonX+buttonWidth) && mouseY>=buttonY && mouseY<=(buttonY+buttonHeight)){
    setup();
  }
}


void draw() {
  int userCards = 0;
  int computerCards = 0;
  
  //Show active deck and pile cards
  image(cards[54], cardWidth*1 + 300, cardHeight*2+75);
  image(cards[pileCard], cardWidth*3 + 300, cardHeight*2+75);
  
  //Count how many cards each player has
  for(int x=0; x<(suits*elements+jokers); x++){
    if(user[x] != -1){
      userCards++;
    }
    if(computer[x] != -1){
      computerCards++;
    }
  }
  
  //Show player cards
  for(int y=0; y<userCards; y++){
    int positionX = 300+((screenWidth-600)/userCards)*y;
    image(cards[user[y]], positionX, cardHeight*4+75);
  }
  for(int z=0; z<computerCards; z++){
    int positionX = 300+((screenWidth-600)/computerCards)*z;
    image(cards[54], positionX, 75);
  }
}