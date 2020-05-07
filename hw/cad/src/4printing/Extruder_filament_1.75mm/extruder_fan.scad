// MLAB
//
// extruder fan
// GNU GPL v3
// Jan Chroust <jacho@mlab.cz>
// http://www.mlab.cz


use <../inc/MLAB_logo.scad>

  $fn=50;
delka_uchytu=12;
vzdalenost_uchytu_od_okraje=4;
fan_width = 40;
fan_diameter = 38;
fan_mount = 33;
sila_materialu=1.3;

extruder_fan();
vyska=33;
vrchni_prumer=15;
sirka_matky=6.7;
m3_sroub_prumer=3.2;


module extruder_fan(){
 difference(){   
    extruder_fan_base();
    extruder_fan_cuts();
    }
        }


module extruder_fan_base(){
    


//základna 
translate([-fan_width/2+2,-(fan_width+delka_uchytu)/2+2,0])
minkowski()
{
  cube([fan_width-4,fan_width+delka_uchytu-4,sila_materialu]);
  cylinder(r=2,h=sila_materialu);
}

//kužel
translate([0,-(delka_uchytu)/2,0])
cylinder(h=vyska, r1=fan_diameter/2, r2=vrchni_prumer/2, center=false);

    
    }
    
 
 module extruder_fan_cuts(){
  //otvor na matici
     translate([-fan_mount/2,-(delka_uchytu+fan_width)/2+(fan_width-fan_mount)/2,0])

     otvor_matice();  
     
      translate([fan_mount/2,-(delka_uchytu+fan_width)/2+(fan_width-fan_mount)/2,0])

     otvor_matice();
     
     translate([fan_mount/2,-(delka_uchytu+fan_width)/2+(fan_width-fan_mount)/2+fan_mount,0])

     otvor_matice();
    
      translate([-fan_mount/2,-(delka_uchytu+fan_width)/2+(fan_width-fan_mount)/2+fan_mount,0])

     otvor_matice();
     
    //otvory na uchcení
   translate([-fan_mount/2,(delka_uchytu+fan_width)/2-vzdalenost_uchytu_od_okraje,-0.01])
  cylinder (h = sila_materialu*2+0.01, r= (m3_sroub_prumer)/2); 
     
     
       translate([fan_mount/2,(delka_uchytu+fan_width)/2-vzdalenost_uchytu_od_okraje,-0.01])
  cylinder (h = sila_materialu*2+0.01, r= (m3_sroub_prumer)/2); 
     
  //kužel
translate([0,-(delka_uchytu)/2,0])
cylinder(h=vyska, r1=fan_diameter/2-sila_materialu, r2=vrchni_prumer/2-sila_materialu, center=false);   
     
     // MLAB logo
    translate ([0,(delka_uchytu+fan_width)/2-5,0.5])  
            rotate ([0,180,0])
                scale(v = [0.1, 0.1, 0.15])
                    MLAB_logo_short();  
     
     
      }
      
      
 module otvor_matice(){    
translate([0,0,sila_materialu])
 cylinder (h = sila_materialu+0.01, r= (sirka_matky+0.2)/2, $fn=6);
 
translate([0,0,-0.1])
  cylinder (h = sila_materialu*2+0.01, r= (m3_sroub_prumer)/2);  
    } 