import processing.serial.*;

Serial myPort;
float potValue = 0; // 电位计值
float moonSize = 200; // 月亮的大小
float prevPhase = 0; // 记录上一个相位，用于平滑过渡

// 流星参数
int meteorCount = 10; // 流星数量
float[] meteorX = new float[meteorCount];
float[] meteorY = new float[meteorCount];
float[] meteorSpeedX = new float[meteorCount]; // 每颗流星的X速度
float[] meteorSpeedY = new float[meteorCount]; // 每颗流星的Y速度
color[] meteorColors = new color[meteorCount];

// 流星尾部粒子系统
int trailLength = 10; // 流星尾尾粒子数量
float[][] meteorTrailX = new float[meteorCount][trailLength];
float[][] meteorTrailY = new float[meteorCount][trailLength];
float[][] meteorTrailAlpha = new float[meteorCount][trailLength];

void setup() {
  size(800, 400);
  myPort = new Serial(this, "COM3", 9600);
  myPort.bufferUntil('\n');
  background(0);

  // 初始化流星参数
  resetMeteors();
}

void serialEvent(Serial myPort) {
  String val = myPort.readStringUntil('\n');
  if (val != null) {
    potValue = float(trim(val)); // 从串口读取电位计值
  }
}

void draw() {
  background(0);

  // 月相计算
  float phase = map(potValue, 0, 1023, 0, TWO_PI); // 将电位计值映射到0到2π的范围
  float transitionSpeed = map(potValue, 0, 1023, 0.05, 0.3); // 指定平滑过渡速度
  phase = lerp(prevPhase, phase, transitionSpeed); // 平滑过渡
  prevPhase = phase;

  drawMoon(phase);  // 绘制月亮

  drawMeteors();    // 绘制流星
}

void drawMoon(float phase) {
  float x = width / 2;
  float y = height / 2;

  // 月亮的基本圆形（发光效果）
  noStroke();
  fill(255, 230, 150); // 柔和的黄色光
  ellipse(x, y, moonSize, moonSize);

  // 阴影的圆形计算
  float shadowOffset = cos(phase) * (moonSize * 2); // 增大偏移范围至2倍月亮直径
  fill(0); // 阴影颜色（黑色）

  if (shadowOffset > 0) {
    // 从右侧遮挡
    ellipse(x + shadowOffset / 2, y, moonSize, moonSize);
  } else {
    // 从左侧遮挡
    ellipse(x + shadowOffset / 2, y, moonSize, moonSize);
  }
}

void drawMeteors() {
  for (int i = 0; i < meteorCount; i++) {
    // 更新流星尾尾粒子的位置
    for (int j = trailLength - 1; j > 0; j--) {
      meteorTrailX[i][j] = meteorTrailX[i][j - 1];
      meteorTrailY[i][j] = meteorTrailY[i][j - 1];
      meteorTrailAlpha[i][j] = meteorTrailAlpha[i][j - 1];
    }

    // 将流星当前位置设置为尾尾的起始位置
    meteorTrailX[i][0] = meteorX[i];
    meteorTrailY[i][0] = meteorY[i];
    meteorTrailAlpha[i][0] = 255; // 尾部粒子最初为完全不透明

    // 绘制流星尾尾（通过小圆点模拟）
    for (int j = 0; j < trailLength; j++) {
      float alpha = map(j, 0, trailLength, 255, 0); // 尾尾粒子从不透明到透明
      noStroke();
      float particleSize = map(potValue, 0, 1023, 4, 8); // 随电位计值调整粒子大小
      fill(meteorColors[i], alpha); // 逐渐变透明的颜色
      ellipse(meteorTrailX[i][j], meteorTrailY[i][j], particleSize, particleSize); // 小圆点模拟粒子
    }

    // 绘制流星头部（保持不透明）
    color headColor = meteorColors[i]; // 头部保持不透明
    stroke(headColor);
    strokeWeight(3); // 流星头部的粗细
    point(meteorX[i], meteorY[i]);

    // 更新流星位置
    float speedFactor = map(potValue, 0, 1023, 1, 3); // 检测电位计值，检绘流星速度
    meteorX[i] += meteorSpeedX[i] * speedFactor;
    meteorY[i] += meteorSpeedY[i] * speedFactor;

    // 如果流星超出屏幕范围，重新生成
    if (meteorX[i] < -50 || meteorY[i] > height + 50) {
      resetMeteor(i);
    }
  }
}

void resetMeteors() {
  for (int i = 0; i < meteorCount; i++) {
    resetMeteor(i);
  }
}

void resetMeteor(int index) {
  // 随机生成流星起始位置，从右上部分开始，但覆盖整个屏幕
  meteorX[index] = random(-100, width + 100); // 从屏幕左边缘到右边缘外一点
  meteorY[index] = random(-150, height / 2);  // 从屏幕右上部分到整个上方随机出现

  // 固定角度和速度
  float angle = radians(135); // 流星从右上向左下划过
  float speed = random(3, 6); // 每颗流星的速度更小
  meteorSpeedX[index] = cos(angle) * speed;
  meteorSpeedY[index] = sin(angle) * speed;

  // 随机分配流星颜色
  if (potValue < 1023 / 3) {
    meteorColors[index] = color(255, 200, 200); // 柔和红色流星
  } else if (potValue < 1023 * 2 / 3) {
    meteorColors[index] = color(200, 255, 200); // 柔和绿色流星
  } else {
    meteorColors[index] = color(200, 200, 255); // 柔和蓝色流星
  }
}
