int potPin = A3;
int redPin = 9;
int grnPin = 10;
int bluPin = 11;

void setup() {
  Serial.begin(9600);
  pinMode(redPin, OUTPUT);
  pinMode(grnPin, OUTPUT);
  pinMode(bluPin, OUTPUT);
}

void loop() {
  int potVal = analogRead(potPin);
  Serial.println(potVal);  // For Processing
  
  // LED control code
  if (potVal < 341) {
    potVal = (potVal * 3) / 4;
    analogWrite(redPin, 256 - potVal);
    analogWrite(grnPin, potVal);
    analogWrite(bluPin, 1);
  }
  else if (potVal < 682) {
    potVal = ((potVal-341) * 3) / 4;
    analogWrite(redPin, 1);
    analogWrite(grnPin, 256 - potVal);
    analogWrite(bluPin, potVal);
  }
  else {
    potVal = ((potVal-683) * 3) / 4;
    analogWrite(redPin, potVal);
    analogWrite(grnPin, 1);
    analogWrite(bluPin, 256 - potVal);
  }
  delay(10);
}

