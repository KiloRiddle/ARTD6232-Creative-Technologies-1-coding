import processing.serial.*;

Serial myPort; // 创建Serial对象
PImage img1, img2; // 声明图片变量
String userInput = ""; // 存储用户输入
boolean showImage1 = false;
boolean showImage2 = false;

void setup() {
  size(1800, 1000);
  
  // 加载图片 - 确保路径正确
  img1 = loadImage("C:/Users/ASUS/Desktop/b01b14cdd10e095905d15d1d796ddf1.jpg");
  img2 = loadImage("C:/Users/ASUS/Desktop/0dc537771b684f2332168ecbe1cf779.jpg");
  
  // 初始化串口，连接到COM8（请确认你的Arduino使用的正确端口）
  myPort = new Serial(this, "COM8", 9600);
}

void draw() {
  background(255);
  
  // 根据条件显示不同的图片
  if (showImage1) {
    image(img1, 0, 0); // 显示第一张图片
  } else if (showImage2) {
    image(img2, 0, 0); // 显示第二张图片
  }

  // 显示当前输入
  fill(0);
  textSize(32);
  text("Current Input: " + userInput, 20, 50); // 显示输入内容
}

void keyPressed() {
  // 清空 input 存储
  if (key == BACKSPACE) {
    userInput = userInput.substring(0, userInput.length()-1);
  } else if (key == ENTER) {
    // 当按回车时，将完整的单词发送给Arduino
    myPort.write(userInput); // 发送给Arduino
    userInput = ""; // 发送后清空输入
  } else {
    userInput += key; // 收集输入
  }
  
  // 识别完整的单词并进行相应控制
  if (userInput.equals("love")) {
    showImage1 = true; // 显示图片1
    showImage2 = false; // 隐藏图片2
  } else if (userInput.equals("heart")) {
    showImage1 = true; // 隐藏图片1
    showImage2 = false; // 显示图片2
  } else if (userInput.equals("marry")) {
    showImage1 = true; // 隐藏图片1
    showImage2 = false; // 隐藏图片2
  } else if (userInput.equals("peace")) {
    showImage1 = false; // 隐藏图片1
    showImage2 = true; // 隐藏图片2
 
  } else if (userInput.equals("war")) {
    showImage1 = false; // 隐藏图片1
    showImage2 = true; // 隐藏图片2

  } else if (userInput.equals("soldier")) {
    showImage1 = false; // 隐藏图片1
    showImage2 = true; // 隐藏图片2

  }
}
