PImage img;
int smallPoint, largePoint;

void setup() {
  size(640, 360);
  img = loadImage("moonwalk.jpg");
  smallPoint = 4;
  largePoint = 40;
  imageMode(CENTER);
  noStroke();
  background(0); // 背景改为黑色
}

void draw() {
  float pointillize = map(mouseX, 0, width, smallPoint, largePoint);
  int x = int(random(img.width));
  int y = int(random(img.height));
  color pix = img.get(x, y);
  fill(pix, 150); // 调整透明度为150，使颜色更加柔和
  ellipse(x, y, pointillize, pointillize);
}
