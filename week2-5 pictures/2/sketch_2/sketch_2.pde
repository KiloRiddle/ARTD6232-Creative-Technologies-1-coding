int angle = 0;

void setup() {
  size(640, 360);
  background(102, 204, 102); // 设置背景为绿色
  noStroke();
}

void draw() {
  // 只有在鼠标按下时绘制
  if (mousePressed) {
    angle += 5;
    float val = cos(radians(angle)) * 12.0;

    for (int a = 0; a < 360; a += 75) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;

      // 设置花瓣为粉色
      fill(255, 182, 193); // 浅粉色
      ellipse(mouseX + xoff, mouseY + yoff, val, val);
    }
    
    // 设置花蕊为白色
    fill(255); // 白色
    ellipse(mouseX, mouseY, 6, 6); // 中心稍大一点
  }
}
