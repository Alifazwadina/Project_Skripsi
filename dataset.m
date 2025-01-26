% Tentukan direktori file dan nama file
file_path = "C:\Users\LENOVO\OneDrive\Documents\MATLAB\drive01m.mat";

% Muat data dari file .mat
data = load(file_path);

% Asumsikan data terstruktur dalam variabel-variabel di file yang dimuat.
% Misalnya, 'val' adalah matriks data dengan sinyal yang berbeda di setiap baris.
ecg_signal = data.val(1, :);  % Baris pertama untuk sinyal ECG

% Sampling rate (Hz)
fs = 15.5;

% Waktu dalam detik berdasarkan jumlah sampel
time = (0:length(ecg_signal)-1) / fs;

% Interval garis vertikal (dalam detik)
vertical_line_interval = 60;

% Plot sinyal ECG
figure;
plot(time, ecg_signal);
xlabel('Time (s)');
ylabel('Amplitude (mV)');
grid on;

% Menambahkan garis vertikal setiap 60 detik
hold on;
for t = 0:vertical_line_interval:max(time)
    xline(t, 'r--', 'LineWidth', 1.5); % Garis vertikal merah putus-putus
end
hold off;

% Sesuaikan tampilan
sgtitle('ECG Signal from drive01m (1).mat');

% Menghitung dan menampilkan nilai sinyal ECG setiap 60 detik
fprintf('Time (s) | ECG (mV)\n');
fprintf('--------------------\n');
for t = 0:vertical_line_interval:max(time)
    % Temukan indeks yang paling mendekati waktu t
    [~, idx] = min(abs(time - t));
    
    % Ambil nilai sinyal pada indeks tersebut
    ecg_value = ecg_signal(idx);
    
    % Tampilkan hasil
    fprintf('%.2f    | %.2f\n', t, ecg_value);
end

% Deteksi puncak R dalam sinyal ECG
[~, locs_R] = findpeaks(ecg_signal, 'MinPeakHeight', 0.5, 'MinPeakDistance', fs*0.6);

% Interval R-R dalam detik
RR_intervals = diff(locs_R) / fs;

% Hitung HRV (Rata-rata interval R-R dalam detik dan BPM)
mean_RR = mean(RR_intervals);
mean_HR = 60 / mean_RR;

% Display HRV
fprintf('\nMean HRV (Heart Rate) in BPM: %.2f\n', mean_HR);

% Plot sinyal ECG dengan puncak R yang terdeteksi
figure;
plot(time, ecg_signal);
hold on;
plot(locs_R / fs, ecg_signal(locs_R), 'ro');
xlabel('Time (s)');
ylabel('Amplitude (mV)');
title('ECG Signal with R-peaks');
grid on;
legend('ECG Signal', 'R-peaks');

% Tambahkan perhitungan BPM per menit
fprintf('\nHeart Rate per Minute (BPM):\n');
fprintf('----------------------------\n');

for t = 0:vertical_line_interval:max(time)-vertical_line_interval
    % Temukan indeks untuk sinyal dalam interval waktu t sampai t+60
    idx_start = find(time >= t, 1);
    idx_end = find(time >= t + vertical_line_interval, 1) - 1;
    
    % Ambil sinyal ECG pada interval waktu ini
    ecg_segment = ecg_signal(idx_start:idx_end);
    
    % Deteksi puncak R pada interval waktu ini
    [~, locs_R_segment] = findpeaks(ecg_segment, 'MinPeakHeight', 0.5, 'MinPeakDistance', fs*0.6);
    
    % Hitung BPM berdasarkan jumlah puncak R
    num_beats = length(locs_R_segment);
    bpm = num_beats * (60 / vertical_line_interval);
    
    % Tampilkan hasil BPM per menit
    fprintf('Time %.2f - %.2f sec: BPM = %.2f\n', t, t + vertical_line_interval, bpm);
end