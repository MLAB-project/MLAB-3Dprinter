// Layer high for the printing [mm]
layer_height = 0.20; //Slic3r->Print Settings->Layers and perimeters->Layer height

// Spare for the screws heads [mm]
spare = 0.75;
// M6 screw diameter [mm]
M6_head_diameter = 13.6+spare;
//M6_head_diameter = 10.6+spare;
//M6_head_diameter = 12+spare;

// M6 head high (for hiding it) [mm]
//M6_head_height = 4;
M6_head_height = 3.6;
//M6_head_height = 4.5;

// Screws and rods diameters
M8_smooth_rod_diameter = 8.3;
M8_smooth_rod_diameter_catch = 8.4;
// Prumer 8mm tyce
rod_8mm_d = 8.2; //pro dil z-top
M6_diameter = 6.6;
M6_dia=M6_diameter; //pro dil z-top
M6_diamater_horizontal = 6.5;
M3_diameter = 3.7;
M3_diameter_horizontal = 3.5;

//matice trapézové tyče
TRAP_diameter_externa=22; //průmer vnější 


// Nuts diameters
M3_nut_diameter = 7.0;
M3_nut_diameter_horizontal = 6.7;

// ALU profile parameters
ALU_cut_width = 7.9;
ALU_cut_width_horizontal = 7.7;

// Sirka matky do profilu (pokud neni pouzita, tak 0)
//profile_nut_width = 9.5;
profile_nut_width = 0; //pro z-top

// Motors length/depth (for axes Z and Y)
//SX17-1003LQFE (recommended for the Z axis)
motor_length = 29.5;
//SX17-1003 (recommended for the Z axis)
//motor_length = 34;
//SX17-1005
//motor_length = 40;
//SX17-0905 - this motor is too high - the Z end stop holder has to be adjusted
//motor_length = 48;

// Extrusion width [mm]
extrusion_width = 0.66; //Slic3r->Print Settings->Advanced->Default extrusion width

/// Belt type ******************************************************

// GT2 
/*belt_tooth_distance = 2;
belt_tooth_ratio = 0.5;
belt_tooth_height = 1.4;
belt_thickness = 2.3;
*/

// T2.5
belt_tooth_distance = 2.5;
belt_tooth_ratio = 0.45;


// Tloustka rohovych spojek
// 5 mm => sroub M6x14 s podlozkou
// 3 mm => sroub M6x12 s podlozkou
coupler_thickness = 3;
