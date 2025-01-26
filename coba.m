% Nama file tanpa ekstensi
file_name = 'driver01';  % Ganti dengan nama file sesuai dengan data Anda

% Baca sinyal EKG dari file .dat dan .hea menggunakan fungsi rdsamp
[ekg_signal, fs, tm] = rdsamp(file_name, 1);  % Membaca kanal pertama, biasanya sinyal EKG
time_duration = length(ekg_signal) / fs;  % Durasi total sinyal dalam detik

% Deteksi puncak R dalam sinyal EKG menggunakan fungsi findpeaks
[~, R_locs] = findpeaks(ekg_signal, 'MinPeakHeight', 0.5, 'MinPeakDistance', fs*0.6);

% Hitung interval R-R (dalam detik)
RR_intervals = diff(R_locs) / fs;

% Buat jendela 60 detik
window_size = 60;  % Durasi jendela dalam detik
num_windows = floor(time_duration / window_size);  % Jumlah jendela 60 detik

% Inisialisasi variabel untuk menyimpan hasil HRV per menit
AVNN_per_min = zeros(1, num_windows);
SDNN_per_min = zeros(1, num_windows);
RMSSD_per_min = zeros(1, num_windows);
pNN50_per_min = zeros(1, num_windows);

for i = 1:num_windows
    % Tentukan rentang waktu untuk jendela 60 detik
    start_time = (i-1) * window_size;
    end_time = i * window_size;

    % Dapatkan interval R-R dalam jendela ini
    RR_in_window = RR_intervals(R_locs(1:end-1)/fs >= start_time & R_locs(2:end)/fs < end_time);

    % Hitung AVNN (rata-rata interval NN)
    AVNN_per_min(i) = mean(RR_in_window);

    % Hitung SDNN (standar deviasi dari interval NN)
    SDNN_per_min(i) = std(RR_in_window);

    % Hitung RMSSD (akar rata-rata kuadrat dari selisih interval RR yang berurutan)
    RMSSD_per_min(i) = sqrt(mean(diff(RR_in_window).^2));

    % Hitung pNN50 (persentase perbedaan R-R yang lebih dari 50 ms)
    NN50 = sum(abs(diff(RR_in_window)) > 0.05);  % Jumlah perbedaan R-R > 50 ms
    pNN50_per_min(i) = (NN50 / length(RR_in_window)) * 100;  % Persentase
end

% Tampilkan hasil HRV per menit
disp('AVNN per menit (dalam detik):');
disp(AVNN_per_min);

disp('SDNN per menit (dalam detik):');
disp(SDNN_per_min);

disp('RMSSD per menit (dalam detik):');
disp(RMSSD_per_min);

disp('pNN50 per menit (dalam persen):');
disp(pNN50_per_min);

