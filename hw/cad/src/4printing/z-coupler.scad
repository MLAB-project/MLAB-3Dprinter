// MLAB
//
// z endstop piezo
// GNU GPL v3
// Jan Chroust <jacho@mlab.cz>
// http://www.mlab.cz

use <inc/MLAB_logo.scad>
include <../configuration.scad>

sirka_profilu=30;
vyska_rantlu=1.5;
sirka_drazky=7.9;

//drazka();
z_coupler();
//segment();

module z_coupler()
{
difference(){
    union(){
        difference(){
    
           kriz();
//otvory osa X  
    for (i = [0 : 4]) {
        translate([-2*sirka_profilu+i*sirka_profilu,0,0])
        otvor(); 
}	

//otvory osa y  
    for (i = [0 : 3]) {
       translate([0,i*sirka_profilu,0])
       otvor(); 
        
}
		
	// Zalomene hrany osa y
	translate([sirka_profilu/2-0.01,sirka_profilu/2-0.01,-5]) rotate([0,-45,0]) cube([5,3*sirka_profilu,5]);

	translate([-sirka_profilu/2+0.01,sirka_profilu/2-0.01,-5]) rotate([0,-45,0]) cube([5,3*sirka_profilu,5]);

	//x
	translate([-2.5*sirka_profilu,-sirka_profilu/2,-5]) rotate([45,0,0]) cube([5*sirka_profilu,5,5]);

	translate([sirka_profilu/2,sirka_profilu/2,-5]) rotate([45,0,0]) cube([70,5,5]);

    //rohový kužel
    translate([sirka_profilu/2,sirka_profilu/2,0])  
    cylinder(h=4, r1=5, r2=0, center=true);

    translate([-3.5*sirka_profilu,sirka_profilu/2,-5])rotate([45,0,0]) cube([3*sirka_profilu,5,5]);

    //rohový kužel
    translate([-sirka_profilu/2,sirka_profilu/2,0])  
    cylinder(h=4, r1=5, r2=0, center=true);
}
    
//zadělání otvoru kvůli logu   
    translate([0,0,coupler_thickness/2])cylinder(h=coupler_thickness,r=M6_dia/2,$fn=32,center=true);
}

// MLAB logo
    translate ([0,0,0.8])  
            rotate ([0,180,0])
                scale(v = [0.2, 0.2, 0.2])
                    MLAB_logo_short();  

}
}


module kriz()
{
  union()
	{
        //kostka osa X
        translate([0,0,coupler_thickness/2])
	  cube([4*sirka_profilu,sirka_profilu,coupler_thickness], true);
        
        //kostka osa y
         translate([-sirka_profilu/2,0,0])
        cube([sirka_profilu,3*sirka_profilu,coupler_thickness]);
        
        //zakulacení osa X
          translate([-2*sirka_profilu,0,coupler_thickness/2])
       cylinder(r=sirka_profilu/2,h=coupler_thickness,$fn=100,center=true); 
        
        translate([2*sirka_profilu,0,coupler_thickness/2])
       cylinder(r=sirka_profilu/2,h=coupler_thickness,$fn=100,center=true); 
        
        //zakulacení osa y
          translate([0,3*sirka_profilu,coupler_thickness/2])
       cylinder(r=sirka_profilu/2,h=coupler_thickness,$fn=100,center=true); 
   
    //drazka osa X  
    for (i = [0 : 3]) {
     
    translate([-1.5*sirka_profilu+i*sirka_profilu,0,0])
    drazka();
  }    

  //drazka osa Y  
for (i = [0 : 1]) {
    
     
    translate([0,1.5*sirka_profilu+i*sirka_profilu,0])
    rotate([0,0,90])
    drazka();
  
}   
}
}

module otvor()
{
      // otvor na sroub
	translate([0,0,0])cylinder(h=20,r=M6_dia/2,$fn=32,center=true);    
}

module drazka()
{
        translate([0,0,(coupler_thickness+vyska_rantlu)/2])
	  cube([sirka_profilu-M6_dia-2-sirka_drazky,sirka_drazky,coupler_thickness+vyska_rantlu], true);
  
  //zakulacení
      translate([(sirka_profilu-M6_dia-2-sirka_drazky)/2,0,(coupler_thickness+vyska_rantlu)/2])
	  cylinder(r=sirka_drazky/2,h=coupler_thickness+vyska_rantlu,$fn=32,center=true); 
      
       translate([-(sirka_profilu-M6_dia-2-sirka_drazky)/2,0,(coupler_thickness+vyska_rantlu)/2])
	  cylinder(r=sirka_drazky/2,h=coupler_thickness+vyska_rantlu,$fn=32,center=true); 
  
    
}

