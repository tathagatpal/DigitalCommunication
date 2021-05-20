%Dimension of the bit matrix is 1x301, i.e. it has 1 row, 301 columns.
%There are 301 entries because there are 100 intervals between 0 and 3.
%Hence, including the 0 and 3 along with the 100 divisions, total is 301.
%Length of the bitstream is 1204 (301*4).

%The bitstream obtained:

% 0000000100010010001000110011010001000101010101010110011001100111011110001
% 000100010011001100110011010101010101011101110111011110011001100110011001101
% 110111011101110111101110111011101110111011101110111111111111111111111111111
% 111111111111111111111111111111111111111111111111111111111111111111111111111
% 111111111111111111111111111111111111111111111111111111111111111111111011101
% 110111011101110111011101110111011101110110111011101110111011101110111011101
% 110111011100110011001100110011001100110011001100110010111011101110111011101
% 110111011101110111011101110111011101110111010101010101010101010101010101010
% 101010101010101010101010101010101010101010101010101010101010101010101010101
% 010101010101010101010101011101110111011101110111011101110111011101110111011
% 101110111011110011001100110011001100110011001100110011001100110111011101110
% 111011101110111011101110111101110111011101110111011101110111011101110111011
% 111111111111111111111111111111111111111111111111111111111111111111111111111
% 111111111111111111111111111111111111111111111111111111111111111111111111111
% 111111111111111111101110111011101110111011101110110111011101110111011100110
% 011001100110010111011101110111010101010101001100110011001100010001000011101
% 110111

%Code:

%Generating impulse train
f = 450;
fs = 5*f;   %sampling rate, multiplied with 5 to avoid aliasing
t = 0 : 0.01 : 3;
t1 = 0 : 0.1 : 3;

%Making impulse train
delta_func = zeros(size(t));
delta_func(1: fs/f : end) = 1;

%Generating the sampled signal by multiplying the original signal by
%impulse train (delta_func).
signal_1 = 5.*sin(t) + 4.*cos(t).*cos(t);
signal_1_s = 5.*sin(t1) + 4.*cos(t1).*cos(t1);
x1 = delta_func.*signal_1;

%Quantization using MATLAB function quantiz
%Partition is being done by 
partition = linspace(min(signal_1), max(signal_1), 16); 
codebook = 4: 0.09765625 :5.5625; % 16 values
[index,quants] = quantiz(signal_1,partition,codebook); % Quantiz(MATLAB fn)

%Quantization using the function that I made in Assignment 4
[q_level,q_val] = uniquant(signal_1,15);

%Output of sampled signal
%In the output, the impulse train is not completely discrete as it is not
%practically feasible. Completely discrete sampled signal have been 
%obtained using stem(t,singal_1) 
figure(1);
plot(t1,signal_1_s, 'linewidth', 2);
hold on;
stem(t1, signal_1_s,'LineWidth', 1);
xlabel('Time (s)'); ylabel('Amplitude'); 
title('1a) Sampled signal (with stem)');
legend('Original Signal','Sampled Signal', 'Location','northoutside');

figure(2);
plot(t, signal_1, t,x1, 'linewidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude'); 
title('1a) Sampled signal (without stem)');
legend('Original Signal','Sampled Signal', 'Location','northoutside');

%Quantized signal as calculated by the MATLAB function overlapped with the
%original waveform.
figure(3);
plot(t, signal_1, t, quants, 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude'); 
title('1a) Quantized signal');
legend('Original Signal','Quantized Signal_M_A_T_L_A_B', 'Location','northoutside');

%Making an empty string array of size of quants bits to assign bits to the 
%quantized values.
bits = strings([1,301]);
len_quants = length(quants);

%Making a matrix with the 16 unique values of the quantized levels.
quants_unique = unique(quants); 

%Since here the number of levels were less (16), I assigned the bits
%manually. Otherwise dec2bin() could have been in loop
%to assign the values to the quantized values. 
for i=1:len_quants
        if (quants(i) == quants_unique(1))
            bits(i) = "0000"; %Assign 0 to the 1st level
        end
        
        if (quants(i) == quants_unique(2))
            bits(i) = "0001"; %Assign 1 to the 2nd level
        end
        
        if (quants(i) == quants_unique(3))
            bits(i) = "0010"; %Assign 2 to the 3rd level
        end
        
        if (quants(i) == quants_unique(4))
            bits(i) = "0011"; %Assign 3 to the 4th level
        end
        
        if (quants(i) == quants_unique(5))
            bits(i) = "0100"; %Assign 4 to the 5th level
        end
        
        if (quants(i) == quants_unique(6))
            bits(i) = "0101"; %Assign 5 to the 6th level
        end
        
        if (quants(i) == quants_unique(7))
            bits(i) = "0110"; %Assign 6 to the 7th level
        end
        
        if (quants(i) == quants_unique(8))
            bits(i) = "0111"; %Assign 7 to the 8th level
        end
        
        if (quants(i) == quants_unique(9))
            bits(i) = "1000"; %Assign 8 to the 9th level
        end
        
        if (quants(i) == quants_unique(10))
            bits(i) = "1001"; %Assign 9 to the 10th level
        end
        
        if (quants(i) == quants_unique(11))
            bits(i) = "1010"; %Assign 10 to the 11th level
        end
        
        if (quants(i) == quants_unique(12))
            bits(i) = "1011"; %Assign 11 to the 12th level
        end
        
        if (quants(i) == quants_unique(13))
            bits(i) = "1100"; %Assign 12 to the 13th level
        end
        
        if (quants(i) == quants_unique(14))
            bits(i) = "1101"; %Assign 13 to the 14th level
        end
        
        if (quants(i) == quants_unique(15))
            bits(i) = "1110"; %Assign 14 to the 15th level
        end
        
        if (quants(i) == quants_unique(16))
            bits(i) = "1111"; %Assign 15 to the 16th level
        end
end

%Displaying the output of the quantizer:
disp("The quantization matrix is as follows: ");
display(quants);

%Displaying the bit matrix.
disp("The bit matrix is as follows: ");
display(bits);

%Dimension of the bit matrix (1 x 301 i.e. 1 row and 301 columns).
disp("Dimension of the bit matrix is: ");
disp(size(bits));

%Changing array of strings to cell, so that it becomes easy to print the
%bitstream by concatenation of elements of bit matrix.
bits_cell = cellstr(bits);
disp("Bitstream of the bit-matrix: ");
bitstream = horzcat(bits_cell{:}); %Concatenation

%Length of the bitstram = 4*301 = 1204
%Since the length is 1204, the output of bitstream is getting cropped
display(bitstream);

%Converting the character array bitstream into string to extract the first
%20 bits. It could also have been done using a for loop.
bit_string = convertCharsToStrings(bitstream);
bit_20 = extractBetween(bit_string,1,20); %Extracting first 20 bits

%Converting the string of first 20 bits into character and then into 
%cell in order to make it a matrix of 1x20.
B = convertStringsToChars(bit_20); 
first20=char(num2cell(B));
%unrz=reshape(str2num(unrz),1,[]);

%If bit = 1, the value should be 1, else bit = 0, value should be -1
unrz = [];
for i=1:20
    if(first20(i) == '0')
        unrz = [unrz -1];
    elseif(first20(i) == '1')
        unrz = [unrz 1];
    end
end

%1 represents bit 1, and -1 indicates bit 0. Plotting the unipolar 
%non-return zero line code. Hence, it could be plotted using stairs.
figure(4);
stairs(1:length(unrz), unrz, 'linewidth', 1.5);
xlabel('Time'); ylabel('Amplitude'); 
set(gca,'XTick',[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20] ); 
set(gca,'YTick',[-1 1] ); 
title('1b) Polar NRZ Encoding Line Code');
legend('Polar NRZ Line Code', 'Location','northoutside');

%Funtion for Quantization as made in the assignment 4.
function [q_level,q_val] = uniquant(sig_in, L)
    L_sig = length(sig_in);
    q_val = zeros(1,L_sig);
    q_level = zeros(1,L);
    sig_max = max(sig_in);
    sig_min = min(sig_in);
    delta = (sig_max-sig_min)/L;
    q_level = q_level+sig_min + delta/2 : delta : sig_max;
        for i=1:L_sig
            for j=1:L
                if (sig_in(i)<=q_level(j)+delta)
                    if(sig_in(i)>=q_level(j) - delta)
                        q_val(i)=q_level(j);
                    end
                end
            end
        end
end