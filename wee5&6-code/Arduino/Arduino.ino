#include <Servo.h>

Servo servo1; // 创建舵机对象1
Servo servo2; // 创建舵机对象2

void setup() {
  servo1.attach(9);  // 舵机1连接到D9引脚
  servo2.attach(10); // 舵机2连接到D10引脚
  Serial.begin(9600); // 初始化串口通信
  
  // 初始位置
  servo1.write(0);   // 舵机1回到初始位置
  servo2.write(180); // 舵机2回到初始位置
  Serial.println("Setup complete. Ready to receive commands.");
}

void loop() {
  if (Serial.available()) {
    String input = Serial.readStringUntil('\n');
    input.trim(); // 去掉空白字符
    input.toLowerCase(); // 转换为小写

    Serial.println("Received: " + input); // 打印接收的输入

    if (input == "love" || input == "heart" || input == "marry") {
      Serial.println("Command: Moving to love position.");
      servo1.write(180); // 舵机1旋转到180度
      servo2.write(0);   // 舵机2旋转到0度
      delay(500);        // 等待动作完成
    } 
    else if (input == "peace" || input == "war" || input == "soldier") {
      Serial.println("Command: Returning to initial position.");
      servo1.write(0);   // 舵机1回到初始位置
      servo2.write(180); // 舵机2回到初始位置
      delay(500);        // 等待动作完成
    } 
    else {
      Serial.println("Unknown command.");
    }
  }
}