// MLAB
//
// z endstop piezo
// GNU GPL v3
// Jan Chroust <jacho@mlab.cz>
// http://www.mlab.cz
$fn=100; // model faces resolution.
include <../include/polyScrewThread_r1.scad>

roztec_der=41;
vyska_gumove_nozicky=5;
mezera_mezi_deskama=16.5;
vyska_podlozky=mezera_mezi_deskama-vyska_gumove_nozicky;
vyska_rantlu=1;
sila_materialu=1.3;
prumer_piezo=36; //20 čistá + 1 rezerva
prekryv_piezo=2; //pro drzák
m3_prumer=3.2;
tolerance_zavitu=0.75; //tolerance s poloměru
material_za_zavitem=6;
m3_prumer_matky=10;


//pro tisk tělesa
z_endstop_piezo_print();

//náhled na složené těleso
//z_endstop_piezo_view();

//pro tisk tělesa
module z_endstop_piezo_print(){

difference(){
	z_endstop_piezo_bot_base();
    z_endstop_piezo_bot_cuts();
}  

translate([0,50,0])
difference(){
	z_endstop_piezo_top_base();
    z_endstop_piezo_top_cuts();
 }    
    }   
    


//náhled na celou konstrukci
module z_endstop_piezo_view(){
  difference(){ 
    union(){  
    difference(){
	z_endstop_piezo_bot_base();
    z_endstop_piezo_bot_cuts();
}


translate([0,0,vyska_podlozky+vyska_rantlu+1])
rotate([180, 0, 0])   
difference(){
	z_endstop_piezo_top_base();
    z_endstop_piezo_top_cuts();
}
   }
   
  cube(prumer_piezo+sila_materialu-2*tolerance_zavitu+material_za_zavitem,false);
    }
   }  


module z_endstop_piezo_bot_base(){
   
   //zakladni válec 
     cylinder(h=vyska_rantlu, r=prumer_piezo/2+sila_materialu, center=false);
	//závit
     screw_thread(prumer_piezo+sila_materialu-2*tolerance_zavitu+material_za_zavitem,4,55,vyska_podlozky+vyska_rantlu+5,PI/2,2);
   
    //spodni drzak
     translate([0,0,sila_materialu/2])
    cube([roztec_der+2*m3_prumer+4*sila_materialu,10,sila_materialu],center=true); 
    
    //valec drzaku
    cylinder(h=sila_materialu, r=(prumer_piezo+sila_materialu-2*tolerance_zavitu+material_za_zavitem)/2+sila_materialu, center=false);
}

module z_endstop_piezo_bot_cuts(){
   
   //otvor na piezo 
     translate([0,0,vyska_podlozky])
     cylinder(h=vyska_rantlu+0.1, r=prumer_piezo/2, center=false);
    
   //zkraceni zavitu kvuli lepsimu tisku 
     translate([0,0,vyska_podlozky+vyska_rantlu])
     cylinder(h=6, r=prumer_piezo+sila_materialu-2*tolerance_zavitu+material_za_zavitem, center=false); 
    	
    //otvory na srouby
    translate([roztec_der/2,0,-0.01])
     cylinder(h=sila_materialu+0.1, r=m3_prumer/2, center=false);
   
      translate([-roztec_der/2,0,-0.01])
     cylinder(h=sila_materialu+0.1, r=m3_prumer/2, center=false);  
   
   //otvory na dotažení pro velá pieza
   translate([roztec_der/2,0,sila_materialu])
     cylinder(h=mezera_mezi_deskama, r=m3_prumer_matky/2, center=false);
    
     translate([-roztec_der/2,0,sila_materialu])
     cylinder(h=mezera_mezi_deskama, r=m3_prumer_matky/2, center=false); 
   
    
  
    //otvor na kabel
     translate([0,(prumer_piezo+sila_materialu-2*tolerance_zavitu+material_za_zavitem)/4+sila_materialu/2,(vyska_podlozky+vyska_rantlu)/2])
    cube([4,(prumer_piezo+sila_materialu-2*tolerance_zavitu+material_za_zavitem)/2+sila_materialu,vyska_podlozky+vyska_rantlu+1],center=true); 
}






module z_endstop_piezo_top_base(){
   
   //zakladni válec 
     cylinder(h=vyska_rantlu+vyska_podlozky-1, r=prumer_piezo/2+sila_materialu+material_za_zavitem/2, center=false);
      
	
}

module z_endstop_piezo_top_cuts(){
   
   //otvor zvrchu 
     translate([0,0,0])
     cylinder(h=sila_materialu+0.1, r=prumer_piezo/2-prekryv_piezo, center=false);
    
    //závit
    translate([0,0,sila_materialu])
    difference(){
        translate([0,0,-5])
 screw_thread(prumer_piezo+sila_materialu+material_za_zavitem,4,55,vyska_rantlu+vyska_podlozky-1-sila_materialu+10,PI/2,2); 
       translate([0,0,-6]) 
     cylinder(h=6, r=(prumer_piezo+sila_materialu+material_za_zavitem)/2+5, center=false);     
}
    
    
   
}



