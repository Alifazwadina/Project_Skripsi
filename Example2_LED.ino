int redLedPin = 3;    // Pin untuk LED merah
int yellowLedPin = 8; // Pin untuk LED kuning

void setup() {
  pinMode(redLedPin, OUTPUT);    // Set pin LED merah sebagai output
  pinMode(yellowLedPin, OUTPUT); // Set pin LED kuning sebagai output
}

void loop() {
  digitalWrite(redLedPin, HIGH);   // Nyalakan LED merah
  digitalWrite(yellowLedPin, LOW); // Matikan LED kuning
  delay(1000);                     // Tunggu 1 detik

  digitalWrite(redLedPin, LOW);    // Matikan LED merah
  digitalWrite(yellowLedPin, HIGH);// Nyalakan LED kuning
  delay(1000);                     // Tunggu 1 detik
}
