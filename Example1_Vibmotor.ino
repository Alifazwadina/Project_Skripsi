int motorPin = 3; // pin yang terhubung ke IN pada modul motor

void setup() {
  pinMode(motorPin, OUTPUT);
}

void loop() {
  digitalWrite(motorPin, HIGH); // Nyalakan motor
  delay(1000);
  digitalWrite(motorPin, LOW);  // Matikan motor
  delay(1000);
}
