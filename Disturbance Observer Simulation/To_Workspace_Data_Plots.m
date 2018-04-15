close all;
figure;

ref_ang = zeros(length(position_deg.time),1);
ref_ang(:,:) = 40;
hold on
vars = 20;
plot(torqsens_nm.time, torqsens_nm.signals.values(:));
%plot(estimate_nm.time, estimate_nm.signals.values(:),'r');
%plot(DOB_noiseless.time, DOB_noiseless.signals(3).values);
%plot(disturb_est_nm.time, disturb_est_nm.signals.values(:));
plot([0.52,0.52], [-20,20],'--r');
plot([0.48,0.48], [-20,20],'--r');
plot([0.68,0.68], [-20,20],'--r');
plot([0.72,0.72], [-20,20],'--r');

lgd = legend('Torque Sensor Data');%, 'Estimated Torque [2]', 'Estimated Disturbance [2]-[1]');%,'Step Reference Position');
lgd.Location = 'southeast';
axis([0 2 -2 0]);
xlabel('Time [s]');
ylabel('Torque [Nm]');
title('Torque Sensor Datastream - [0.1, -0.1]Nm Collision Event at t=[0.5,0.7]s');
set(findall(gca, 'Type', 'Line'),'LineWidth',0.5);
