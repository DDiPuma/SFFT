%% Generate Test Data

% Generate series of various lengths, fixed k
k = 100;
for p=8:20
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
    eval(sprintf("%s = ifft(%s);", signal_name, signal_name));
end

% Generate series of various ks, fixed length

n = 2^12;
for p=0:10
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
    eval(sprintf("%s = ifft(%s);", signal_name, signal_name));
end

%% Run SFFT and Builtin FFT

% TODO - time them

%% Plot runtime performance

% TODO - plot comparisons

%% Verify accuracy

% TODO - ensure that FFT and SFFT outputs match
% Do not expect an EXACT match, since the SFFT is approximate by nature

