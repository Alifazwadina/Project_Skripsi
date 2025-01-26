#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

// Definisikan ukuran layar OLED
#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64

// Inisialisasi objek untuk OLED
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, -1);

// Fungsi setup
void setup() {
  // Memulai komunikasi serial
  Serial.begin(115200);

  // Memulai OLED dengan alamat I2C (0x3C adalah alamat umum untuk OLED)
  if (!display.begin(SSD1306_SWITCHCAPVCC, 0x3C)) {
    Serial.println(F("SSD1306 allocation failed"));
    while (true); // Berhenti jika gagal
  }

  // Bersihkan layar OLED
  display.clearDisplay();

  // Menampilkan pesan awal
  display.setTextSize(1); // Ukuran teks
  display.setTextColor(WHITE); // Warna teks
  display.setCursor(0, 0); // Posisi kursor
  display.println(F("OLED Initialized"));
  display.display(); // Menampilkan teks di layar OLED
  delay(2000); // Tunggu 2 detik sebelum melanjutkan
}

// Fungsi loop untuk terus membaca dan menampilkan data
void loop() {
  // Bersihkan layar sebelum menampilkan data baru
  display.clearDisplay();

  // Menampilkan teks dinamis, misalnya data dari sensor atau variabel
  display.setTextSize(2); // Ukuran teks lebih besar
  display.setTextColor(WHITE);
  display.setCursor(0, 0);

  // Contoh: menampilkan nilai sensor analog dari pin A0
  int sensorValue = analogRead(A0);
  display.print("Value: ");
  display.println(sensorValue);

  // Tampilkan data di layar
  display.display();

  // Tampilkan data yang sama di Serial Monitor
  Serial.print("Sensor Value: ");
  Serial.println(sensorValue);

  // Tunggu 1 detik sebelum update
  delay(1000);
}


