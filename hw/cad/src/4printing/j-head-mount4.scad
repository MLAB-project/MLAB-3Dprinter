// RebeliX
//
// j-head mount + fan 40mm
// GNU GPL v3
// Martin Neruda
// http://www.reprap4u.cz

fan_width = 40;
fan_diameter = 38;
fan_mount = 33;

spring_diameter=6.5;
spring_height=5;

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

mount_height = 8;

M3_vyska_matky=3;
M3_sirka_matky=6.7;




difference(){
	union(){
	  translate([0,0,mount_height/2])
        cube([cube_length,cube_width,mount_height],true);
	   
        translate([-fan_width/2,cube_width/2,0]) cube([fan_width,10,mount_height]); 
      
	}	

	
    
    // Vyrez pro ventilator
	translate([-fan_width/2-0.1,cube_width/2+3.5,0]) rotate([-45,0,0]) cube([fan_width+1,15,15]); 
	translate([0,cube_width/2+12,21]) rotate([-135,0,0]) cylinder(r=fan_diameter/2, h=cube_width/2);
	translate([0,cube_width/2+2,7.4]){
	 translate([fan_mount/2,0,0]) rotate([-135,0,0]) cylinder(r=1.1,h=30,$fn=20,center=true);
	 translate([-fan_mount/2,0,0]) rotate([-135,0,0]) cylinder(r=1.1,h=30,$fn=20,center=true);
	}
    
    
    
    //otvor na hotend
    translate([0,0,4.4]) cylinder(r=8.5,h=6,$fn=30);
	translate([-8.5,-cube_width/2-0.1,4.4]) cube([17,10,6]);
		
	translate([0,0,-0.1]) cylinder(r=6.1,h=10,$fn=30);
	translate([0-6.1,-cube_width/2-0.1,-0.1]) cube([12.2,10,10]);
    
       
	
	
	
	// Otvory pro prisroubovani
	translate([-holder_pitch/2,0,-0.1]) cylinder(r=holder_diameter/2,h=mount_height+1,$fn=30);
	
		
	translate([holder_pitch/2,0,-0.1]) cylinder(r=holder_diameter/2,h=mount_height+1,$fn=30);
	
	
	//otvory na šrouby
    translate([-cube_length/2+7,-5,-0.1]) cylinder(r=3.2/2,h=mount_height+1,$fn=30);
	
   
	
    
    translate([-cube_length/2+7,5,-0.1]) cylinder(r=3.2/2,h=mount_height+1,$fn=30);
	
   
    
        translate([cube_length/2-7,-5,-0.1]) cylinder(r=3.2/2,h=mount_height+1,$fn=30);
	
   
    translate([cube_length/2-7,5,-0.1]) cylinder(r=3.2/2,h=mount_height+1,$fn=30);
	
   
    
	   
      
    
    
    
	// Seriznute rohy
	translate([-cube_length/2+2.5,-cube_width/2,-0.1]) rotate([0,0,135]) cube([5,5,10]);
	translate([cube_length/2-2.5,-cube_width/2,-0.1]) rotate([0,0,-45]) cube([5,5,10]);
	translate([cube_length/2,cube_width/2-2.5,-0.1]) rotate([0,0,45]) cube([5,5,10]);
	translate([-cube_length/2+2.5,cube_width/2,-0.1]) rotate([0,0,135]) cube([5,5,10]);
}	





