%Initial Prompt
answer = questdlg('Should I create a [huge] simulation dataset?', ...
	'No', 'Yes');
% Handle response
switch answer
    case 'No'
        sim_run = 0;
    case 'Yes'
        sim_run = 1;
end

collapse = 1;
for collapse = 1;
%% Tasklist
% 1. Run the zero_disturbance_thresholding
% 2. Save to J1TT
% 3. Set collision_time + collision_torque to non-zero
% 4. Run this script to measure torque detection

model_name = 'X001_AL5D_Assemby_RR_013';
open_system(model_name); %open the Simulink model
%% Setpoint Reference
first_ref = 80;
second_ref = 0;%-first_ref - 40;
second_ref_time = 0;%1.5;
%% Joint 1 Torque Threshold
disturbance_torque = 0.1;%0.5;%1;%1; %s time at which step disturbance is at collision_torque
disturbance_time = 0.5;%0.3; %Nm step torque input magnitude
J1TT = 0.0061; %N*m as calculated by zero_disturbance_thresholding.m script (JOINT 1)
DST = 0.2; %s time that is ignored in the detection of disturbance
%% Sample Time
%For now assume 38.4k baudrate with information stored in one byte.
Ts = 0.0005; %[s] sample time
%% DC Motor Characteristics
%Base to Arm 1 Motor [SIMULATING TWO MOTORS]
L1 = 0.0011; %[H] armature inductance
ST1 = 2.42*2; % [Nm] stall torque
NLS1 = 7.48*2; %[rad/s] no-load speed
RV1 = 6*2; % [V] Rated DC Motor Supply Voltage
PWMV = 3.3; %[V] PWM Voltage Amplitude
NLC1 = 0.09; % [A] no-load current
%% Robot Joint Characteristics
JSS = 0.4;%0.15; %m*N/rad joint spring stiffness
JDC = 0.6; %m*s*N/rad joint damping coefficient + motor damping
CFT = 0;%0.6; %N*m Coulumb Friction Torque

GF1 = 0.3; %gear damping
GF2 = 0.3; %gear damping

%% Real Robot Joint Characteristics
perc_disc = 0.4; %parameter max error

JSSR = JSS+(JSS*perc_disc*normrnd(0,0.5)); %m*N/rad joint spring stiffness
JDCR = JDC+(JDC*perc_disc*normrnd(0,0.5)); %m*s*N/rad joint damping coefficient
CFTR = CFT+(CFT*perc_disc*normrnd(0,0.5)); %N*m Coulumb Friction Torque

GF1R = GF1+(GF1*perc_disc*normrnd(0,0.5)); %gear damping in reality
GF2R = GF2+(GF2*perc_disc*normrnd(0,0.5)); %gear damping in reality

BLD = 0.01*(0.01*perc_disc*normrnd(0,0.5)); %backlash damping effect
REE = 3*degtorad(normrnd(0,0.5)); %deg due to geometric misalignment

%% Modelling the Human Tissue (Collision Detection)
MM = 10^4; %Pa soft muscle tissue modulus
AA = 25*10^-6; %mm2 assumed area of contact
ML = 5*10^-3; %mm muscle tissue initial length
l1 = 0.31438; %m First Robot Link Length
l2 = 0.14628; %m Second Robot Link Length
L_0 = l1+l2; %m total end-effector length from origin
CA = 45; %deg angle at which contact occurs
CAr = degtorad(CA); %deg to rad conversion
SC = (MM*AA)/ML; %N/m Spring Constant
DC = 0.09; %N/m/s Damping Coefficient
VS = radtodeg(1); %rad speed at which collision starts to occur
end %initialise the simulation

clear previous_id LRC_dataset sample_id previous_id

disturbance_torque_array = [0.1, 0.2, 0.3, 0.5, 0.7, -0.1, -0.3, -0.5, -0.5, -0.7]; %Nm

first_ref_array = [-120 -100 -80 -60 -40 -20 20 40 80 100 120];

sample_rate = 0.01/Ts;
sample_size = 5;

%headers for the main simulation
headers = {'sample_no','current_a', 'voltage_v','position_deg','velocity_degs',...
    'setpoint_deg','torqsens_nm', 'disturbance_nm','class'};

options = simset('SrcWorkspace','current');
%set the simulation time
set_param(model_name, 'StopTime', '2');

sim_state = get_param(model_name, 'SimulationStatus');

LRC_dataset = [];
previous_id = 1;
if sim_run == 1
for t = 1:length(disturbance_torque_array)
    disturbance_torque = disturbance_torque_array(t);
for i = [1:1:30]; %run 5 reset iterations
    for parameter_reset = 1
        %% Real Robot Joint Characteristics
        %maximum deviation from the nominal parameter value
        perc_disc = 0.4; %parameter max error
        
        JSSR = JSS+(JSS*perc_disc*normrnd(0,0.5)); %m*N/rad joint spring stiffness
        JDCR = JDC+(JDC*perc_disc*normrnd(0,0.5)); %m*s*N/rad joint damping coefficient
        CFTR = CFT+(CFT*perc_disc*normrnd(0,0.5)); %N*m Coulumb Friction Torque
        
        GF1R = GF1+(GF1*perc_disc*normrnd(0,0.5)); %gear damping in reality
        GF2R = GF2+(GF2*perc_disc*normrnd(0,0.5)); %gear damping in reality
        
        BLD = 0.01*(0.01*perc_disc*normrnd(0,0.5)); %backlash damping effect
        REE = 3*degtorad(normrnd(0,0.5)); %deg due to geometric misalignment
    end %resets and generates new parameters of the Real Plant
    
    for f = [1:length(first_ref_array)]
        first_ref = first_ref_array(f);
        %check if the simulation is still running
            sim(model_name,[],options);
            while sim_state == 'running'
                sim_state = get_param(model_name, 'SimulationStatus');
            end
            
            %Determine when a collision has occured
            class = abs(disturbance_nm.signals.values) > 0;
            
            %store the relevant data
            store_array = [current_a.signals.values, voltage_v.signals.values,...
                position_deg.signals.values, velocity_degs.signals.values,...
                setpoint_deg.signals.values, torqsens_nm.signals.values(:),...
                disturbance_nm.signals.values, class];
            %% Remove First 0.2s of the Simulation For Cleanliness
            % and create unique identifiers for a vector of 5 samples
            b = current_a.time > 0.2;
            store_array = store_array(b,:);
            store_array = downsample(store_array, sample_rate);
            array_reminder = rem(length(store_array),sample_size) - 1;
            store_array(end-array_reminder:end,:) = [];
            sample_id = [previous_id:1:(previous_id+(length(store_array)/sample_size)-1)];
            sample_id = repelem(sample_id, sample_size);
            previous_id = max(sample_id);
            store_array = [sample_id' store_array];
            
            LRC_dataset = [LRC_dataset; store_array]; %store in the dataset
        end
        
end
    disturbance_torque %used to see how far is the simulation
end

%% Set The Collision Event
%Only the first occurence of step collision is +1, rest is 0.
prev_val = 0;

clear ii
for ii = 2:length(LRC_dataset)
    if LRC_dataset(ii,9) == 1 & prev_val == 0
        prev_val = LRC_dataset(ii,9);
        LRC_dataset(ii,9) = 1;
    else
        prev_val = LRC_dataset(ii,9);
        LRC_dataset(ii,9) = 0;
    end
end

%Convert collision class {+1,0} to {+1, -1}
no_collisions = LRC_dataset(:,9) == 0;
LRC_dataset(no_collisions,9) = -1;

%Save the initial feature
LRC_basic = LRC_dataset;

dev_headers = {'sample_no', 'current_a', 'voltage_v','position_deg','velocity_degs', 'setpoint_deg',...
         'torqsens_nm', 'disturbance_nm', 'collision', 'current_a_dev', 'voltage_v_dev',...
         'position_deg_dev', 'velocity_degs_dev', 'setpoint_deg_dev','torqsens_nm_dev', 'disturbance_nm_dev'};

%add new feature set -> value - mean of a 5 sample window
data_new = LRC_dataset;
data_new(:,10:16) = 0; %change to 10:16
unq_data = unique(data_new(:,1));

clear x f

for f = 2:8 %feature that are note the 'class' or 'sample_no'
    nfi = f + 8; %new column to store the modified feature
for x = 1:length(unq_data)
    
    indexer = (data_new(:,1)) == unq_data(x);
    mn = mean(data_new(indexer,f));
    data_new(indexer,nfi) = data_new(indexer,f) - mn;
end
end

%remove rows where disturbance > 0 but still non-collision event
indx = data_new(:,8) ~= 0 & data_new(:,9) == -1;
data_new(indx, :) = [];
LRC_basic(indx,:) = [];

csvwrite('LRC_dataset_010_Initial_Features.csv',LRC_basic);
fileID = fopen('LRC_dataset_Feature_Names.txt','w');
fprintf(fileID, strjoin(headers));
fclose(fileID);

%save the new feature set
csvwrite('LRC_dataset_011_Feature_Engineering.csv',data_new);
fileID2 = fopen('LRC_dataset_Feature_Engineering.txt','w');
fprintf(fileID2, strjoin(dev_headers));
fclose(fileID2);
end
