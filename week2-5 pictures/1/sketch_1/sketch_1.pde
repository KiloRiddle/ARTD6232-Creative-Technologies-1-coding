void setup() {
  size(640, 360);
}

void draw() {
  background(255); // 白色背景
  
  // 绘制第一个星星
  pushMatrix();
  translate(width * 0.2, height * 0.5);
  rotate(frameCount / 200.0);
  fill(255, 182, 193); // 马卡龙粉色
  star(0, 0, 10, 30, 5); 
  popMatrix();
  
  // 绘制第二个星星
  pushMatrix();
  translate(width * 0.5, height * 0.5);
  rotate(frameCount / 400.0);
  fill(173, 216, 230); // 马卡龙蓝色
  star(0, 0, 20, 40, 8); 
  popMatrix();
  
  // 绘制第三个星星
  pushMatrix();
  translate(width * 0.8, height * 0.5);
  rotate(frameCount / -100.0);
  fill(255, 224, 102); // 马卡龙黄色
  star(0, 0, 15, 35, 6); 
  popMatrix();
  
  // 添加更多种类的星星
  pushMatrix();
  translate(width * 0.3, height * 0.8);
  rotate(frameCount / 300.0);
  fill(144, 238, 144); // 马卡龙绿色
  star(0, 0, 10, 25, 7); 
  popMatrix();

  pushMatrix();
  translate(width * 0.7, height * 0.8);
  rotate(frameCount / 500.0);
  fill(255, 153, 204); // 马卡龙紫色
  star(0, 0, 12, 30, 9); 
  popMatrix();

  pushMatrix();
  translate(width * 0.5, height * 0.2);
  rotate(frameCount / 800.0);
  fill(255, 178, 102); // 马卡龙橙色
  star(0, 0, 15, 35, 11); 
  popMatrix();
}

void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle / 2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a + halfAngle) * radius1;
    sy = y + sin(a + halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
