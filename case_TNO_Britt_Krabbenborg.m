clear; 
clc;

%% Input file radar data

% Radar data in binary form
radar_data = ['0001010';'0110011';'0100110';'0010000';'0011100';'0101101';'1111010';...
'1011101';'0110100';'1101011';'0010011';'0111000';'1101001';'0011101';'1000010';...
'1010000';'0011010';'0110000';'0010111';'0101001';'1001001';'0010100';'1101001';...
'1010110';'0101100';'0110011';'0011000';'1111101';'0001100';'0111110';'0011010';...
'0110110';'1011111';'0111011';'0100001';'1001100';'0010110';'0010011';'0100010';...
'0110111';'0101010';'0101110';'0000111';'0110111';'0110100';'1011111';'0101101';...
'1010111';'1101011';'0010001';'1011111';'1111010';'0100100';'1000110';'0101010';...
'0100100';'1111111';'1100010';'0111001';'0111000';'1010011';'1100001';'0010111';...
'0111001';'1000001';'0110101';'1110111';'0101010';'1010110';'0010100';'1111100';...
'1001000';'0000101';'1111010';'0001001';'1011111';'0010111';'0100101';'0101011';...
'0010001';'1101000';'1010010';'0101000';'0010010';'1001010';'1000011';'0010001';...
'1000111';'0010110';'1010111';'1011000';'0011101';'0100110';'1110001';'1001111';...
'1111111';'0101110';'0010010';'0001010';'0001010';'0001110';'1111100';'1001010';...
'1000110';'1110111';'1010110';'0101110';'1000100';'1010111';'0010100';'1101111';...
'1000000';'0101011';'1100011';'1001000';'0011010';'0101100';'1000111';'0100111';...
'0101010';'1010000';'1100011';'1011111';'1110100';'0101101';'0010011';'1110010';...
'0011110';'1000101';'0110101';'1011011';'1001000';'1110000';'0110011';'0011110';...
'1000000';'1001001';'0101010';'1101101';'0001111';'1010001';'1000101';'1011011';...
'0101010';'1000101';'0110100';'1000000';'0001101';'0001110';'1011101';'1001001';...
'0001010';'0101111';'1001100';'0011101';'1111011';'0000011';'0011101';'1011000';...
'1011110';'1111111';'1110010';'1001010';'0100110';'1001101';'0011100';'1011111';...
'0101110';'0011010';'0111001';'1100100';'0001111';'0000100';'0010111';'0111000';...
'1101110';'0110111';'1111110';'0011000';'1101011';'0001101';'1101000';'0011001';...
'1100111';'0101011';'0100111';'1010010';'0000010';'0110100';'1001100';'1111101';...
'1110010';'1110001';'1101001';'1100110';'1011110';'0010010';'1111101';'0010001';...
'0100100';'0100110';'0100001';'0001110';'1001100';'1001110';'0001111';'1100101';...
'0101111';'0110101';'0110101';'0100001';'0100100';'0111101';'1010111';'0111101';...
'0000111';'0001100';'1000101';'0100010';'1110010'];

%% Define simulation parameters and variables

Tend = 20;      % Simulation time
row = 11;       % Output row 
PK = 0.8;       % Probability of Kill (PK) ratio
 
%% Patriot Air Defense System Simulation

% Call the system simulation function
runSimulation(Tend, row, PK, radar_data);

function runSimulation(Tend, row, PK, radar_data)
    for timestep = 1:Tend
        radar_binary = extractRadarData(timestep, row, radar_data);
        checkAndLaunch(radar_binary, PK);
        disp(' ');
    end
end


%% Radar

% Scan for inbound threats and output a line from the radar data
function radar_binary = extractRadarData(timestep, row, radar_data)
    radar_binary = radar_data(1 + (timestep - 1) * row : timestep * row,:);
     
    % Display the radar output at each timestep
    disp(['Radar output at timestep ', num2str(timestep)]);
    disp(radar_binary);
end


%% IFF Module 

% Check if a hostile entity is detected
function hostile = isHostile(radar_binary)
    
    % Convert binary radar data to decimal representation
    radar_decimal = bin2dec(radar_binary);
    
    % Extract the odd and even value entries
    evens = radar_decimal(mod(radar_decimal, 2) == 0);
    odds = radar_decimal(mod(radar_decimal, 2) ~= 0);
    
    % Identify hostile entity by comparing odd and even value entries
    hostile = length(odds) > length(evens);
end

%% Firing Unit 

% Fire a missile as soon as a hostile entity is detected
function checkAndLaunch(radar_binary, PK)
    if isHostile(radar_binary)
        disp('Hostile entity identified');
        disp('Launch missile');
        if isTargetNeutralized(PK)
            disp('Target neutralized');
        else
            disp('Target not neutralized');
        end
    else
        disp('No hostile entity identified');
    end
end

% Check if target is neutralized
function neutralized = isTargetNeutralized(PK)
    
    % Random number between 0 and 1 with a uniform distribution
    RND = rand(); 
    
    % Compar random number with Probability of Kill (PK) ratio
    neutralized = RND <= PK;
end
