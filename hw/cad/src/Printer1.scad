include <./MLAB-3Dprinter-lib.scad>

include <../NopSCADlib-master/lib.scad>

y_main_constr_translate = 35;  // Translate of vertical extrutions on the horizontal extrusion frame

extrusion_length1 = 360;
extrusion_length2 = 320;


////
//// Main construction (extrusions)
module main_contruction(){
rotate([0,0,90])
translate([y_main_constr_translate,0,0]){
    rotate([90,0,0])
    translate([extrusion_length2/2+15,-15,0])
        extrusion(E3030, extrusion_length1, true, false);

    rotate([90,0,0])
    translate([-extrusion_length2/2-15,-15,0])
        extrusion(E3030, extrusion_length1, true, false);

    rotate([0,90,0])
    translate([15,extrusion_length1/2-15,0])
        extrusion(E3030, extrusion_length2, true, false);

    rotate([0,90,0])
    translate([15,-extrusion_length1/2+15,0])
        extrusion(E3030, extrusion_length2, true, false);
}

translate([-extrusion_length1/2+15,-15,extrusion_length2/2])
    extrusion(E3030, extrusion_length2, true, false);

translate([extrusion_length1/2-15,-15,extrusion_length2/2])
    extrusion(E3030, extrusion_length2, true, false);

rotate([0,90,0])
translate([-extrusion_length2-15,-15,0])
    extrusion(E3030, extrusion_length1, true, false);
}

////
//// COUPLERS for extrusions
module horizontal_couplers(){
/// Couplers - horizontal frame, upper side
rotate([180,0,90])
translate([y_main_constr_translate-extrusion_length2/2-30,-extrusion_length1/2,-coupler_thickness])
corner_coupler();

mirror([1,0,0]){
rotate([180,0,90])
translate([y_main_constr_translate-extrusion_length2/2-30,-extrusion_length1/2,-coupler_thickness])
corner_coupler();
}

rotate([180,0,-90])
translate([-y_main_constr_translate-extrusion_length2/2-30,-extrusion_length1/2,-coupler_thickness])
corner_coupler();

mirror([1,0,0]){
rotate([180,0,-90])
translate([-y_main_constr_translate-extrusion_length2/2-30,-extrusion_length1/2,-coupler_thickness])
corner_coupler();
}

/// Bottom couplers 
translate([0,0,-30])
mirror([0,0,1]){
    rotate([180,0,90])
translate([y_main_constr_translate-extrusion_length2/2-30,-extrusion_length1/2,-coupler_thickness])
corner_coupler();

mirror([1,0,0]){
rotate([180,0,90])
translate([y_main_constr_translate-extrusion_length2/2-30,-extrusion_length1/2,-coupler_thickness])
corner_coupler();
}

rotate([180,0,-90])
translate([-y_main_constr_translate-extrusion_length2/2-30,-extrusion_length1/2,-coupler_thickness])
corner_coupler();

mirror([1,0,0]){
rotate([180,0,-90])
translate([-y_main_constr_translate-extrusion_length2/2-30,-extrusion_length1/2,-coupler_thickness])
corner_coupler();
}
    }
}

/// Couplers on the top (vertical couplers)

rotate([-90,90,0])
translate([-extrusion_length2-30,-extrusion_length1/2,-coupler_thickness-30])
corner_coupler();

mirror([1,0,0])
rotate([-90,90,0])
translate([-extrusion_length2-30,-extrusion_length1/2,-coupler_thickness-30])
corner_coupler();

main_contruction();
horizontal_couplers();