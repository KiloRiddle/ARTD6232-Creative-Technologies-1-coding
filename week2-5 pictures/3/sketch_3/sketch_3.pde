int maxHeight = 40;
int minHeight = 20;
int letterHeight = maxHeight; // Height of the letters
int letterWidth = 20;          // Width of the letter

int x = -letterWidth;          // X position of the letters
int y = 0;                      // Y position of the letters

boolean newletter;              

int numChars = 26;      // There are 26 characters in the alphabet
color[] colors = new color[numChars];

void setup() {
  size(640, 360);
  noStroke();
  colorMode(HSB, numChars);
  // Create a gradient background
  for (int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, numChars);
    color c = color(inter, numChars, numChars);
    stroke(c);
    line(0, i, width, i);
  }
  
  // Set a hue value for each key
  for(int i = 0; i < numChars; i++) {
    colors[i] = color(i, numChars, numChars);    
  }
}

void draw() {
  if(newletter == true) {
    // Draw the "letter" with rounded corners
    int y_pos;
    fill(colors[(key >= 'a') ? key - 'a' : key - 'A']);
    int cornerRadius = 10;
    
    if (letterHeight == maxHeight) {
      y_pos = y;
      rect(x, y_pos, letterWidth, letterHeight, cornerRadius);
    } else {
      y_pos = y + minHeight;
      rect(x, y_pos, letterWidth, letterHeight, cornerRadius);
      fill(numChars / 2, 100); // Faded background
      rect(x, y_pos - minHeight, letterWidth, letterHeight, cornerRadius);
    }
    
    // Shadow effect
    fill(0, 50); // Black with transparency for shadow
    rect(x + 5, y_pos + 5, letterWidth, letterHeight, cornerRadius);
    
    newletter = false;
  }
}

void keyPressed() {
  // If the key is between 'A'(65) to 'Z' and 'a' to 'z'(122)
  if((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')) {
    int keyIndex;
    if(key <= 'Z') {
      keyIndex = key - 'A';
      letterHeight = maxHeight;
    } else {
      keyIndex = key - 'a';
      letterHeight = minHeight;
    }
  } else {
    fill(0);
    letterHeight = 10;
  }

  newletter = true;

  // Update the "letter" position
  x = ( x + letterWidth ); 

  // Wrap horizontally
  if (x > width - letterWidth) {
    x = 0;
    y += maxHeight + 10; // Add spacing between rows
  }

  // Wrap vertically
  if( y > height - letterHeight) {
    y = 0; // Reset y to 0
  }
}
