// RebeliX
//
// piezo holder
// GNU GPL v3
// jacho
// http://www.mlab.cz

fan_width = 40;
fan_diameter = 38;
fan_mount = 33;

spring_diameter=5;
spring_height=6.5;  //4,5mm zmáčklá koukat tak 1mm mezera
spring_hole=2.5;

hotend_diameter=16.2;
hotend_height=4.8;
hotend_height_tolerance=1;

piezo_diameter=36;
piezo_height=2.2;
piezo_height_tolerance=1.4;

cylinder_diameter=piezo_diameter+5;
cylinder_height= 1+hotend_height+piezo_height-hotend_height_tolerance-piezo_height_tolerance;
cylinder_hole= 1.1;

cube_length=80;
cube_width=20;

holder_pitch=48;
holder_diameter=7;

mount_height = 1+hotend_height+piezo_height-hotend_height_tolerance-piezo_height_tolerance-1;

M3_vyska_matky=3;
M3_sirka_matky=6.7;



difference(){
	union(){
	  translate([0,0,mount_height/2])
        cube([cube_length,cube_width,mount_height],true);
	   
	}	

	//otvor pro hotend
	translate([0,0,0.0]) cylinder(r=hotend_diameter/2,h=hotend_height-hotend_height_tolerance,$fn=30);
	
	//otvor pro piezo	
	translate([0,0,hotend_height-hotend_height_tolerance]) cylinder(r=piezo_diameter/2,h=piezo_height-piezo_height_tolerance,$fn=30);
	
	// Otvory pro prisroubovani
	translate([-holder_pitch/2,0,-0.1]) cylinder(r=holder_diameter/2,h=mount_height+1,$fn=30);
	
		
	translate([holder_pitch/2,0,-0.1]) cylinder(r=holder_diameter/2,h=mount_height+1,$fn=30);
	
	
	
	//otvory na šrouby
    translate([-cube_length/2+7,-5,-0.1]) cylinder(r=3.2/2,h=mount_height+1,$fn=30);
	
	
    
    translate([-cube_length/2+7,5,-0.1]) cylinder(r=3.2/2,h=mount_height+1,$fn=30);
	
	
    
    
        translate([cube_length/2-7,-5,-0.1]) cylinder(r=3.2/2,h=mount_height+1,$fn=30);
	
   	
    
    translate([cube_length/2-7,5,-0.1]) cylinder(r=3.2/2,h=mount_height+1,$fn=30);
	
    
	//otvory na pružiny
    translate([-cube_length/2+7,-5,mount_height-spring_hole]) cylinder(r=spring_diameter/2,h=spring_hole,$fn=30);
	
	
    
    translate([-cube_length/2+7,5,mount_height-spring_hole]) cylinder(r=spring_diameter/2,h=spring_hole,$fn=30);
	
	
    
    
        translate([cube_length/2-7,-5,mount_height-spring_hole]) cylinder(r=spring_diameter/2,h=spring_hole,$fn=30);
	
   	
    
    translate([cube_length/2-7,5,mount_height-spring_hole]) cylinder(r=spring_diameter/2,h=spring_hole,$fn=30);
	
	
	
	// Seriznute rohy
	translate([-cube_length/2+2.5,-cube_width/2,-0.1]) rotate([0,0,135]) cube([5,5,10]);
	translate([cube_length/2-2.5,-cube_width/2,-0.1]) rotate([0,0,-45]) cube([5,5,10]);
	translate([cube_length/2,cube_width/2-2.5,-0.1]) rotate([0,0,45]) cube([5,5,10]);
	translate([-cube_length/2+2.5,cube_width/2,-0.1]) rotate([0,0,135]) cube([5,5,10]);
}	