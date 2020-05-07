// MLAB
//
// filament cleaner
// GNU GPL v3
// Jan Chroust <jacho@mlab.cz>
// http://www.mlab.cz

$fn=100; // model faces resolution.
include <inc/polyScrewThread_r1.scad>

vnitrni_prumer=15;
vnitrni_vyska=15;
sila_materialu=1.3;
vyska_matky=4;
tolerance_zavitu=0.75; //tolerance s poloměru
material_za_zavitem=6;

//pro tisk tělesa
filament_cleaner_bot_print();

//náhled na složené těleso
//filament_cleaner_view();

//pro tisk tělesa
module filament_cleaner_bot_print(){

difference(){
	filament_cleaner_bot_base();
    filament_cleaner_bot_cuts();
}  

translate([0,32,0])
difference(){
	filament_cleaner_top_base();
    filament_cleaner_top_cuts();
}  


    }   
    


//náhled na celou konstrukci
module filament_cleaner_view(){
  difference(){ 
    union(){  
    difference(){
	filament_cleaner_bot_base();
    filament_cleaner_bot_cuts();
}


translate([0,0,vnitrni_vyska+vyska_matky+sila_materialu+0.3])
rotate([180, 0, 0])   
difference(){
	filament_cleaner_top_base();
    filament_cleaner_top_cuts();
}
   }
   
  cube(3*vnitrni_prumer,false);
    }
   }
 
 
module filament_cleaner_top_base(){
   
   //zakladni válec 
     cylinder(h=vnitrni_vyska+sila_materialu, r=(vnitrni_prumer+2*sila_materialu+2*material_za_zavitem)/2,$fn=6,  center=false);
	
   
   
}  


module filament_cleaner_top_cuts(){
   
   //závit
     translate([0,0,sila_materialu])
     screw_thread(vnitrni_prumer+2*sila_materialu+material_za_zavitem,4,55,vnitrni_vyska+6,PI/2,2);
    
    //otvor na filament
     translate([-4/2,0,-vyska_matky])
  cube([4,vnitrni_prumer+2*sila_materialu+2*material_za_zavitem,2*vnitrni_vyska],center=false);
    
        translate([0,0,-vyska_matky])
     cylinder(h=vvnitrni_prumer+2*sila_materialu+2*material_za_zavitem,2*vnitrni_vyska, r=4/2,  center=true);
  
}



module filament_cleaner_bot_base(){
   
   //zakladni válec 
     cylinder(h=vyska_matky, r=(vnitrni_prumer+2*sila_materialu+2*material_za_zavitem)/2,$fn=6,  center=false);
	//závit
    translate([0,0,vyska_matky])
     screw_thread(vnitrni_prumer+2*sila_materialu-2*tolerance_zavitu+material_za_zavitem,4,55,vnitrni_vyska+5,PI/2,2);
   
   
}

module filament_cleaner_bot_cuts(){
   
   //zakladni válec 
    translate([0,0,vyska_matky])
     cylinder(h=vnitrni_vyska+1, r=vnitrni_prumer/2,  center=false);
    
    //otvor na filament
     translate([-4/2,0,-vyska_matky])
  cube([4,vnitrni_prumer+2*sila_materialu+2*material_za_zavitem,2*vnitrni_vyska],center=false);
    
        translate([0,0,-vyska_matky])
     cylinder(h=vvnitrni_prumer+2*sila_materialu+2*material_za_zavitem,2*vnitrni_vyska, r=4/2,  center=true);
    
    //odečet závitu kvůli tisku
    translate([0,0,vyska_matky+vnitrni_vyska])
     cylinder(h=vnitrni_vyska+1, r=vnitrni_prumer,  center=false);
  
}


   




