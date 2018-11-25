%% Generate Test Data

% Seed RNG
rng(0, 'simdTwister');

% Generate series of various n, fixed k
k = 100;
p_n = 8:22;
for p=p_n
    n = 2^p;

    % Generate a signal name (x_n_2_to_8, x_n_2_to_20, etc.)
    signal_name = sprintf("x_n_2_to_%d", p);
    % Fill the signal as a column of zeros
    eval(sprintf("%s = zeros(%d, 1);", signal_name, n));

    % Randomly choose k frequencies and fill them with random values
    indices = randperm(n, k);
    for idx=indices
        % Random magnitude from 1 to 100
        eval(sprintf("%s(%d) = %d;", signal_name, idx, randi(100)));
    end

    % Note that the above random generation was in frequency domain
    % Get back to time domain
    eval(sprintf("%s = ifft(%s, n);", signal_name, signal_name));
end

% Generate series of various k, fixed n

n = 2^12;
p_k = 0:10;
for p=p_k
    k = 2^p;

    % Generate a signal name (x_k_2_to_0, k_n_2_to_10, etc.)
    signal_name = sprintf("x_k_2_to_%d", p);
    % Fill the signal as a column of zeros
    eval(sprintf("%s = zeros(%d, 1);", signal_name, n));

    % Randomly choose k frequencies and fill them with random values
    indices = randperm(n, k);
    for idx=indices
        % Random magnitude from 1 to 100
        eval(sprintf("%s(%d) = %d;", signal_name, idx, randi(100)));
    end

    % Note that the above random generation was in frequency domain
    % Get back to time domain
    eval(sprintf("%s = ifft(%s, n);", signal_name, signal_name));
end

%% Run SFFT and Builtin FFT

% time all executions of builtin FFT on fixed k
time_fft_n = zeros(size(p_n));
for i=length(p_n)
    tic;
    eval(sprintf("fft(x_n_2_to_%d, p_n(i));", p_n(i)));
    time_fft_n(i) = toc;
end


% time all executions of builtin FFT on fixed n
time_fft_k = zeros(size(p_k));
for i=length(p_k)
    tic;
    eval(sprintf("fft(x_k_2_to_%d, p_k(i));", p_k(i)));
    time_fft_k(i) = toc;
end

% TODO - enable the below code once the SFFT is ready

% time all executions of SFFT on fixed k
%time_sfft_n = zeros(size(p_n));
%for i=size(p_n)
%    tic;
%    eval(sprintf("noiseless_sparse_sfft(x_n_2_to_%d);", p_n(i)));
%    time_sfft_n(i) = toc;
%end

% time all executions of SFFT on fixed n
%time_sfft_k = zeros(size(p_k));
%for i=size(p_k)
%    tic;
%    eval(sprintf("noiseless_sparse_sfft(x_k_2_to_%d);", pkn(i)));
%    time_sfft_k(i) = toc;
%end

%% Plot runtime performance

figure;
plot(p_n, time_fft_n, 'k-');
% plot(p_n, time_fft_n, 'k-', p_n, time_sfft_n, 'b-'); % TODO - use this line
title("Execution Time vs. Signal Length for k = 100");
xlabel("Signal Length (log_2)");
ylabel("Time (s)");
legend('MATLAB FFT', 'SFFT');

figure;
plot(p_k, time_fft_k, 'k-');
% plot(p_k, time_fft_k, 'k-', p_k, time_sfft_k, 'b-'); % TODO - use this line
title("Execution Time vs. Frequency Components for n = 2^{12}");
xlabel("Frequency Components (log_2)");
ylabel("Time (s)");
legend('MATLAB FFT', 'SFFT');

%% Verify accuracy

% TODO - ensure that FFT and SFFT outputs match
% Do not expect an EXACT match, since the SFFT is approximate by nature

