% Simscape(TM) Multibody(TM) version: 4.8

% This is a model data file derived from a Simscape Multibody Import XML file using the smimport function.
% The data in this file sets the block parameter values in an imported Simscape Multibody model.
% For more information on this file, see the smimport function help page in the Simscape Multibody documentation.
% You can modify numerical values, but avoid any other changes to this file.
% Do not add code to this file. Do not edit the physical units shown in comments.

%%%VariableName:smiData


%============= RigidTransform =============%

%Initialize the RigidTransform structure array by filling in null values.
smiData.RigidTransform(8).translation = [0.0 0.0 0.0];
smiData.RigidTransform(8).angle = 0.0;
smiData.RigidTransform(8).axis = [0.0 0.0 0.0];
smiData.RigidTransform(8).ID = '';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(1).translation = [0 0 0];  % mm
smiData.RigidTransform(1).angle = 0;  % rad
smiData.RigidTransform(1).axis = [0 0 0];
smiData.RigidTransform(1).ID = 'B[X001_AL5D_Base_Subassy-1:-:]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(2).translation = [0 0 0];  % mm
smiData.RigidTransform(2).angle = 0;  % rad
smiData.RigidTransform(2).axis = [0 0 0];
smiData.RigidTransform(2).ID = 'F[X001_AL5D_Base_Subassy-1:-:]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(3).translation = [-30.794664114754198 11.869101648562266 71.259999999999962];  % mm
smiData.RigidTransform(3).angle = 2.0943953414621155;  % rad
smiData.RigidTransform(3).axis = [-0.57735010981035662 -0.57735034887924386 0.57735034887924386];
smiData.RigidTransform(3).ID = 'B[X001_AL5D_Base_Subassy-1:-:003_Arm1_Subassy-2]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(4).translation = [-4.2632564145606011e-14 -35.989999999999931 -63.971862790000237];  % mm
smiData.RigidTransform(4).angle = 2.0943951023931957;  % rad
smiData.RigidTransform(4).axis = [0.57735026918962584 -0.57735026918962595 0.57735026918962551];
smiData.RigidTransform(4).ID = 'F[X001_AL5D_Base_Subassy-1:-:003_Arm1_Subassy-2]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(5).translation = [-18.45875011571237 120.11150616432248 380.33289813233853];  % mm
smiData.RigidTransform(5).angle = 2.094395341462115;  % rad
smiData.RigidTransform(5).axis = [-0.5773501098103565 -0.57735034887924364 0.57735034887924419];
smiData.RigidTransform(5).ID = 'B[:-:]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(6).translation = [-18.45875011571237 120.11150616432248 380.33289813233853];  % mm
smiData.RigidTransform(6).angle = 2.094395341462115;  % rad
smiData.RigidTransform(6).axis = [-0.5773501098103565 -0.57735034887924364 0.57735034887924419];
smiData.RigidTransform(6).ID = 'F[:-:]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(7).translation = [0 16.878152849999996 30.75];  % mm
smiData.RigidTransform(7).angle = 9.9127069060495328e-16;  % rad
smiData.RigidTransform(7).axis = [1 0 0];
smiData.RigidTransform(7).ID = 'B[End_effector_subassy-1:-:003_Arm1_Subassy-2]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(8).translation = [9.2370555648813024e-14 -30.734099999999991 82.305552864000063];  % mm
smiData.RigidTransform(8).angle = 2.0943951023931957;  % rad
smiData.RigidTransform(8).axis = [0.57735026918962573 -0.57735026918962584 0.57735026918962573];
smiData.RigidTransform(8).ID = 'F[End_effector_subassy-1:-:003_Arm1_Subassy-2]';


%============= Solid =============%
%Center of Mass (CoM) %Moments of Inertia (MoI) %Product of Inertia (PoI)

%Initialize the Solid structure array by filling in null values.
smiData.Solid(3).mass = 0.0;
smiData.Solid(3).CoM = [0.0 0.0 0.0];
smiData.Solid(3).MoI = [0.0 0.0 0.0];
smiData.Solid(3).PoI = [0.0 0.0 0.0];
smiData.Solid(3).color = [0.0 0.0 0.0];
smiData.Solid(3).opacity = 0.0;
smiData.Solid(3).ID = '';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(1).mass = 0.25;%0.38752093812315025;  % kg
smiData.Solid(1).CoM = [6.1005926359036433 101.29604632199512 -1.5781323874364308];  % mm
smiData.Solid(1).MoI = [4444.2097954746141 107.86562237375799 4401.8328953823657];  % kg*mm^2
smiData.Solid(1).PoI = [-35.630553137053504 1.6942763174746036 -44.551613059161618];  % kg*mm^2
smiData.Solid(1).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(1).opacity = 1;
smiData.Solid(1).ID = 'End_effector_subassy*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(2).mass = 0.36004514715649838;  % kg
smiData.Solid(2).CoM = [4.9420392912218336 -4.5171858149592596 55.776003223860705];  % mm
smiData.Solid(2).MoI = [315.71478018884761 311.43021714903625 374.29998068498799];  % kg*mm^2
smiData.Solid(2).PoI = [13.499974819952557 -12.897057113993942 5.5420595007607227];  % kg*mm^2
smiData.Solid(2).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(2).opacity = 1;
smiData.Solid(2).ID = 'X001_AL5D_Base_Subassy*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(3).mass = 0.25; %0.059740567623313104;  % kg
smiData.Solid(3).CoM = [-6.4391819400643719e-10 -2.9259342489989586 0.27263193124710783];  % mm
smiData.Solid(3).MoI = [224.02999692560982 163.93737892191376 66.709268847109229];  % kg*mm^2
smiData.Solid(3).PoI = [-19.000294404613683 2.6110871561676611e-09 1.5251402076774756e-09];  % kg*mm^2
smiData.Solid(3).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(3).opacity = 1;
smiData.Solid(3).ID = '003_Arm1_Subassy*:*Default';


%============= Joint =============%
%X Revolute Primitive (Rx) %Y Revolute Primitive (Ry) %Z Revolute Primitive (Rz)
%X Prismatic Primitive (Px) %Y Prismatic Primitive (Py) %Z Prismatic Primitive (Pz) %Spherical Primitive (S)
%Constant Velocity Primitive (CV) %Lead Screw Primitive (LS)
%Position Target (Pos)

%Initialize the RevoluteJoint structure array by filling in null values.
smiData.RevoluteJoint(2).Rz.Pos = 0.0;
smiData.RevoluteJoint(2).ID = '';

smiData.RevoluteJoint(1).Rz.Pos = -70.124298554136615;  % deg
smiData.RevoluteJoint(1).ID = '[X001_AL5D_Base_Subassy-1:-:003_Arm1_Subassy-2]';

smiData.RevoluteJoint(2).Rz.Pos = 64.70355577359895;  % deg
smiData.RevoluteJoint(2).ID = '[End_effector_subassy-1:-:003_Arm1_Subassy-2]';

