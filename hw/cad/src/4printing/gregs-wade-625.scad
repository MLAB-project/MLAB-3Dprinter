// Greg's Wade Extruder.
// It is licensed under the Creative Commons - GNU GPL license.
//  2010 by GregFrost
// Extruder based on prusa git repo.
// http://www.thingiverse.com/thing:6713
// modified for i3 by vlnofka <vlnofka@gmail.com>

include <../include/configuration.scad>
include <../include/functions.scad>

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Define the hotend_mounting style you want by specifying hotend_mount=style1+style2 etc.
//e.g. wade(hotend_mount=groovemount+peek_reprapsource_mount);
malcolm_hotend_mount=1;
groovemount=2;
peek_reprapsource_mount=4;
arcol_mount=8;
mendel_parts_v6_mount=16;
grrf_peek_mount=32;
wildseyed_mount=64;
geared_extruder_nozzle=128; // http://reprap.org/wiki/Geared_extruder_nozzle
jhead_mount=256;
geeksbase_mount=512;
malcolm_extrusion_mount=1024;	//broken

//default_extruder_mount=malcolm_extrusion_mount;
//default_extruder_mount=groovemount;
default_extruder_mount=2;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

mounting_holes_legacy=1;
mounting_holes_symmetrical=2;
default_mounting_holes=mounting_holes_symmetrical;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

wade(hotend_mount=default_extruder_mount,
	mounting_holes=default_mounting_holes);

////CarriageVisualisation
color("red")
//x-carriage v2
translate([24,-32.75,base_extra_depth+wade_block_depth])
  rotate([0,0,0])
    import("../include/x-carriage.stl");


//%translate([45.0, 55.50, 1]) //[46.78,55, 1]
//  rotate([0, 0, 0])
//    nema17(places=[0,1,1,1], holes=true, shadow=5);

/*
color("silver")
translate(large_wheel_translation) {
	translate([0,0,-15])import("../output/biggearmod_fixed.stl");
	rotate([0,0,29.5]) translate([gear_separation,0, 5]) {
		rotate([180,0,0]) import("../output/smallgearmod_fixed.stl");
		rotate([0,0,-29.5]) translate([0,0,-4]) {nema17(places=[0,1,1,1], holes=true, shadow=5, $fn=7, h=8);
		}
	}
}
*/
//translate([52,70,0]) bearing_washer();


////Place for assembly.
//translate([50,56,15.25]) // This is the translation for the 3mm version.
////translate([50,56,13.92]) // This is the translation for the 1.75mm version.
//rotate(180)
//Place for printing
//translate([-20,0,15.25])
//rotate([0,-90,0])
//wadeidler();

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Extruder
 * @name Extruder
 * @assembled
 * @using 1 small-gear
 * @id extruder
 * @using 1 idler
 * @using 1 extruder-body
 * @using 1 m3nut
 * @using 1 m3washer
 * @using 1 m3x25
 * @step Take idler and insert nut into small nut-trap inside the hinge.
 * @step While holding the nut in place, preprare M3x25 bolt with washer and screw it into the hinge just enough to hold the nut.
 * @step Now take the extruder body and idler. Place idler on the hinge counterpart and compleately screw the M3x25 bolt. This will create secured hinge.
 *
 * @using 2 m4nut
 * @step Place M4 nuts into their nut traps, secure them with piece of tape. We need them in place, since later they would be harder to access.
 *
 * @using 3 m3x10
 * @using 3 m3washer
 * @using 1 NEMA17
 * @step Prepare your NEMA17 stepper motor and three M3x10 screws with washers.
 * @step Hold motor on place and lightly tighten the screws. We need to adjust motor position later, no need to tighten it hard.
 *
 * @using 1 large-gear
 * @using 1 m8washer
 * @using 2 m8nut
 * @using 2 bearing-608
 * @step Place two skate bearings on ther position, they should snuggly fit in.
 * @step Insert prepared large gear into the body with mounted bearings.
 * @step Check if the alignment of hobbed part with the filament path. Adjust it accordingly with adding or removing M8 washers.
 * @step After adjusting, we need to fix the bolt in. So we place washer at the end of hobbed bolt and with two M8 nuts we will do locknut by tightening them against each other.
 * @step Check if large gear turns freely.
 *
 * @using 2 m3x40
 * @using 4 m3washer
 * @using 2 extruder-spring
 * @step Prepare two M3x40 screws with sandwitch of washer-spring-washer.
 * @step Insert two M3 nuts into nut traps on top of drive mechanism. [[extruder/top-nut-traps.png]]
 * @step Insert prepared screws into the holes on idler. Close the idler and tighten the screws into the trapped nuts. More you tighten those screws, more pressure will be on fillament.
 * @step Your extruder is done. [[extruder/assembled.jpg]]
 */

/**
 * Extruder body
 * @name Extruder body
 * @category Printed
 * @id extruder-body
 */

/**
 * Extruder idler
 * @name Extruder Idler
 * @id idler
 * @category Printed
 * @using 1 bearing-608
 * @using 1 idler-m8-piece
 * @step Insert piece of M8 rod into bearing.
 * @step Insert 608 bearing with rod into printed idler part.
 */

/**
 * Small M8 rod
 * @name Idler
 * @id idler-m8-piece
 * @category Rods and Bars
 */

/**
 * Spring used for idler on extruder.
 * @name Extruder spring
 * @id extruder-spring
 */

//===================================================
// Parameters defining the wade body:

wade_body_offset = 3;
elevation = 9; //zmeneno puvodne 15
wade_block_height=55+elevation;
wade_block_width=24 - wade_body_offset;
wade_block_depth=28;


//echo (m4_nut_diameter);
m3_diameter = 3.4;
m3_nut_diameter = 6.1+0.3;
m3_washer_diameter = 6.9;

m4_diameter = 4.8;
m4_nut_diameter = 8.3;

block_bevel_r=6;

base_thickness=10;
base_length=66;
base_leadout=22;
base_extra_depth=10; //zmeneno puvodne 0

nema17_hole_spacing=31;
nema17_width=1.7*25.4;
nema17_support_d=nema17_width-nema17_hole_spacing;

screw_head_recess_diameter=7.2;
screw_head_recess_depth=3;

motor_mount_rotation=0;
motor_mount_translation=[46.78,50.78+elevation,0];
//motor_mount_translation=[48,50+elevation,0];
//motor_mount_translation=[52.5,38,0]; //original
motor_mount_thickness=9;

large_wheel_translation=[50.5-(7.4444+32.0111+0.25),34+elevation,0];

m8_clearance_hole=12.6;
hole_for_625=16.3;
608_diameter=22;
625_height = 5;

block_top_right=[wade_block_width,wade_block_height];

layer_thickness=layer_height;
filament_diameter=2;
filament_feed_hole_d=(filament_diameter*1.1)/cos(180/8);
hobbing_depth=0.3;
echo ("filament_feed_hole_d", filament_feed_hole_d);

//This is the distance from the centre of the filament to the centre of the hobbed bolt.
filament_feed_hole_offset=8/2-hobbing_depth+filament_diameter/2;

echo ("filament_feed_hole_offset", filament_feed_hole_offset);

idler_nut_trap_depth=7.5;
idler_nut_thickness=4;

gear_separation=7.4444+32.0111+0.25;

function motor_hole(hole)=[
	motor_mount_translation[0],
	motor_mount_translation[1]]+
	rotated(45+motor_mount_rotation+hole*90)*nema17_hole_spacing/sqrt(2);

// Parameters defining the idler.

filament_pinch=[
	large_wheel_translation[0]-filament_feed_hole_offset-filament_diameter/2,
	large_wheel_translation[1],
	wade_block_depth/2];
idler_axis=filament_pinch-[608_diameter/2,0,0];
idler_fulcrum_offset=608_diameter/2+3.5+m3_diameter/2;
idler_fulcrum=idler_axis-[0,idler_fulcrum_offset,0];
idler_corners_radius=4;
idler_height=12;
idler_608_diameter=608_diameter+2;
idler_608_height=9;
idler_mounting_hole_across=8;
idler_mounting_hole_up=15;
idler_short_side=wade_block_depth-2;
idler_hinge_r=m3_diameter/2+3.5;
idler_hinge_width=6.5;
idler_end_length=(idler_height-2)+5;
idler_mounting_hole_diameter=m3_diameter+0.25;
idler_mounting_hole_elongation=1;
idler_long_top=idler_mounting_hole_up+idler_mounting_hole_diameter/2+idler_mounting_hole_elongation+2.5;
idler_long_bottom=idler_fulcrum_offset;
idler_long_side=idler_long_top+idler_long_bottom;

module bearing_washer()
{
	difference()
	{
		cylinder(r=hole_for_625/2-0.05,h=1);
		translate([0,0,-1])
		cylinder(r=8,h=3);
	}
}

module wade(
	hotend_mount=default_extruder_mount,
	mounting_holes=default_mounting_holes)
{
	difference ()
	{
		union()
		{
			// The wade block.
			translate([wade_body_offset,0,0])
			cube([wade_block_width,wade_block_height,wade_block_depth]);

			// Filler between wade block and motor mount.
			translate([10-2,0,0])
			cube([wade_block_width,
				wade_block_height,
				motor_mount_thickness]);

			// Round the ends of the base
			translate([base_length-base_leadout,0,0])
			cylinder(r=base_thickness/2,h=wade_block_depth+base_extra_depth,$fn=64);

			translate([-base_leadout,0,0])
			cylinder(r=base_thickness/2,h=wade_block_depth+base_extra_depth,$fn=64);

			//Provide the bevel betweeen the base and the wade block.
			render()
			difference()
			{
				translate([-block_bevel_r+wade_body_offset,0,0])
				cube([block_bevel_r*2+wade_block_width,
					base_thickness/2+block_bevel_r,wade_block_depth+base_extra_depth]);
				translate([-block_bevel_r+wade_body_offset,block_bevel_r+base_thickness/2])
				cylinder(r=block_bevel_r,h=wade_block_depth+base_extra_depth,$fn=60);
				translate([wade_block_width+block_bevel_r+wade_body_offset,
					block_bevel_r+base_thickness/2])
				cylinder(r=block_bevel_r,h=wade_block_depth+base_extra_depth,$fn=60);
			}
			// Uprava_3 - "Domecek" pro idler
			translate([wade_body_offset,0,0]) difference(){
				//#translate([-15,22,0]) cube([15,10,wade_block_depth]);
				translate([-18,21.8,0]) cube([18,10,wade_block_depth]);
				translate([-12,28,1.6]) cube([12,27,25]);
				translate([-18,12,-0.1]) rotate([0,0,45]) cube([10,10,30]);
			}

			//The base.
			translate([-base_leadout,-base_thickness/2,0])
			cube([base_length,base_thickness,wade_block_depth+base_extra_depth]);
			//Base aligement helper
			//translate([-base_leadout,-base_thickness/2,wade_block_depth+base_extra_depth])
			//cube([base_length,1,layer_thickness-0.35]);


			motor_mount ();
		}

		block_holes(mounting_holes=mounting_holes);
		motor_mount_holes ();

		translate([large_wheel_translation[0]-filament_feed_hole_offset,
			-base_thickness/2,wade_block_depth/2])
		rotate([-90,0,0])
		{
			if (in_mask (hotend_mount,malcolm_hotend_mount))
				malcolm_hotend_holes ();
			if (in_mask (hotend_mount,groovemount))
				groovemount_holes ();
			if (in_mask (hotend_mount,peek_reprapsource_mount))
				peek_reprapsource_holes ();
			if (in_mask (hotend_mount,arcol_mount))
				arcol_mount_holes ();
			if (in_mask (hotend_mount,mendel_parts_v6_mount))
				mendel_parts_v6_holes(insulator_d=12.7);
			if (in_mask(hotend_mount,grrf_peek_mount))
				grrf_peek_mount_holes();
			if (in_mask(hotend_mount,wildseyed_mount))
				wildseyed_mount_holes(insulator_d=12.7);
			if (in_mask(hotend_mount,geared_extruder_nozzle))
				mendel_parts_v6_holes(insulator_d=15);
			if (in_mask(hotend_mount,jhead_mount))
				wildseyed_mount_holes(insulator_d=16);
			if (in_mask (hotend_mount,geeksbase_mount))
				geeksbase_holes ();
			if (in_mask (hotend_mount,malcolm_extrusion_mount))
				malcolm_extrusion_holes ();
		}
	}
}

function in_mask(mask,value)=(mask%(value*2))>(value-1);

//block_holes();

module block_holes(mounting_holes=default_mounting_holes)
{
echo("bhmh", mounting_holes)
	//Round off the top of the block.
	translate([0,wade_block_height-block_bevel_r,-1])
	render()
	difference()
	{
		translate([-1,0,0])
		cube([block_bevel_r+1,block_bevel_r+1,wade_block_depth+2]);
		translate([block_bevel_r,0,0])
		cylinder(r=block_bevel_r,h=wade_block_depth+2,$fn=40);
	}

	//carriage mountig holes
	translate([-24.5+64+4,-0.5,3]) {
		translate([-50,0,0]) {
			translate([0,0,(wade_block_depth+base_extra_depth)/2+6+layer_thickness]) cylinder(r=m3_diameter/2, h=wade_block_depth+base_extra_depth, center=true, $fn=20);
			translate([0, 0, 1]) cylinder(r=m3_washer_diameter/2, h=10.1, center=true, $fn=20);
		}

		translate([-20,0,0]) {
			translate([0,0,(wade_block_depth+base_extra_depth)/2+6+layer_thickness]) cylinder(r=m3_diameter/2, h=wade_block_depth+0.2+base_extra_depth, center=true, $fn=20);
			translate([0, 0, 1]) cylinder(r=m3_washer_diameter/2, h=10.1, center=true, $fn=20);
		}
	}

	//translate(motor_mount_translation)
	translate(large_wheel_translation)
	{

			// Open the top to remove overhangs and to provide access to the hobbing.
			translate([-wade_block_width-1,0,19])
			cube([wade_block_width,
				wade_block_height-large_wheel_translation[1]+1,
				wade_block_depth]);

			translate([0,0,-1])
			b608(h=625_height+1);

			// Uprava_1 - Vyrez pro lozisko
			translate([0,-hole_for_625/2,625_height]) rotate([0,180,0]) cube([30,hole_for_625,10]);

			translate([0,0,23])
			b608(h=625_height);

			translate([-11.5,1,625_height+3])
			b608(h=wade_block_depth);

			// Uprava_4 - Zkraceni dilu
			translate([-15,-22.3/2,-0.1]) cube([7,50,wade_block_depth+1]);
			translate([-10,-hole_for_625/2,23]) cube([10,10,9]);

			translate([0,0,625_height+2*layer_thickness])
			cylinder(r=m8_clearance_hole/2,h=wade_block_depth-(8+layer_thickness)+2,$fn=64);

			// Uprava_2 - Vyrez pro hnaci sroub
			translate([0,m8_clearance_hole/2,625_height+2*layer_thickness]) rotate([0,0,180])cube([15,m8_clearance_hole,5]);

			//opraveno r
			translate([0,0,20-2])
			cylinder(r=16/4,h=wade_block_depth-(8+layer_thickness)+2);

			// Filament feed.
			translate([-filament_feed_hole_offset,0,wade_block_depth/2])
			rotate([90,0,0])
			rotate(360/16)
			cylinder(r=filament_feed_hole_d/2,h=wade_block_depth*3+elevation,center=true,$fn=8);

					// Vetsi otvor pro vstup filamentu
			translate([-filament_feed_hole_offset,50,wade_block_depth/2])
			rotate([90,0,0])
			rotate(360/16)
			cylinder(r=(filament_feed_hole_d/2)+0.4,h=wade_block_depth*3+elevation,center=true,$fn=8);

			// Uprava_5 - Nabeh pro filament
			translate([-filament_feed_hole_offset,-9.5,wade_block_depth/2])
			rotate([90,0,0])
			cylinder(r1=filament_feed_hole_d/2+0.5,r2=filament_feed_hole_d/2,h=8,center=true,$fn=18);

			translate([-9,-m8_clearance_hole/2,625_height+2*layer_thickness])
			cube([9,m8_clearance_hole,20]);

			// Mounting holes on the base.
			//translate([0,-base_thickness/2,0])
			translate(
				(mounting_holes==mounting_holes_legacy)?[-3.4,0,-1]:[0,0,0])
			for (mount=[0:1])
			{
				translate([-filament_feed_hole_offset+25*((mount<1)?1:-1),
					-large_wheel_translation[1]-1-base_thickness/2,wade_block_depth/2])
				rotate([-90,0,0])
				rotate(360/16)
				cylinder(r=m4_diameter/2,h=base_thickness+2,$fn=8);
				// Posun hlavicky M4 sroubu o 2.1 mm
				translate([-filament_feed_hole_offset+25*((mount<1)?1:-1),
					-large_wheel_translation[1]+2.1,
					wade_block_depth/2])
				rotate([-90,0,0])
				// M4 na pridelani hotendu
				cylinder(r=m4_nut_diameter/2,h=10,$fn=6);
			}

	}

	// Idler mounting holes and nut traps.
	for (idle=[-1,1])
	{
		translate([wade_body_offset,
			idler_mounting_hole_up+large_wheel_translation[1],
			wade_block_depth/2+idler_mounting_hole_across*idle])
		rotate([0,90,0])
		{
			rotate([0,0,180/8])
			translate([0,0,-1])
			cylinder(r=(m3_diameter+0.6)/2,h=wade_block_depth,$fn=8);
			rotate([0,0,180/6])
			translate([0,0,wade_block_width-idler_nut_trap_depth])
			cylinder(r=m3_nut_diameter/2+0.1,h=idler_nut_thickness,$fn=6);

			translate([0,10/2,wade_block_width-idler_nut_trap_depth+idler_nut_thickness/2])
			cube([m3_nut_diameter*cos(30)+0.1,10,idler_nut_thickness],center=true);
		}
	}
}

module motor_mount()
{
	linear_extrude(height=motor_mount_thickness)
	{
		barbell (motor_hole(1),motor_hole(2),nema17_support_d/2, nema17_support_d/2,20,160);
		barbell (motor_hole(2),motor_hole(3),nema17_support_d/2, nema17_support_d/2,20,160);

		// Connect block to top of motor mount.
		barbell(block_top_right-[0,15],motor_hole(1),5,nema17_support_d/2,100,60);

		//Connect motor mount to base.
		barbell([base_length-base_leadout,
			0],motor_hole(3),base_thickness/2,
			nema17_support_d/2,100,60);
	}
}

module motor_mount_holes()
{
	radius=4/2;
	slot_left=1;
	slot_right=1;

	{
		translate([0,0,screw_head_recess_depth+layer_thickness])
		for (hole=[0:3])
		translate([motor_hole(hole)[0],motor_hole(hole)[1],0])
		rotate([0,0,25])
		{
			translate([-slot_left,0,0])
			cylinder(h=motor_mount_thickness-screw_head_recess_depth,r=radius,$fn=16);
			translate([slot_right,0,0])
			cylinder(h=motor_mount_thickness-screw_head_recess_depth,r=radius,$fn=16);

			translate([-slot_left,-radius,0])
			cube([slot_left+slot_right,radius*2,motor_mount_thickness-screw_head_recess_depth]);
		}

		translate([0,0,-1])
		for (hole=[0:3])
		translate([motor_hole(hole)[0],motor_hole(hole)[1],0])
		rotate([0,0,25])
		{
			translate([-slot_left,0,0])
			cylinder(h=screw_head_recess_depth+1,
				r=screw_head_recess_diameter/2,$fn=16);
			translate([slot_right,0,0])
			cylinder(h=screw_head_recess_depth+1,
				r=screw_head_recess_diameter/2,$fn=16);

			translate([-slot_left,-screw_head_recess_diameter/2,0])
			cube([slot_left+slot_right,
				screw_head_recess_diameter,
				screw_head_recess_depth+1]);
		}
	}
}

module wadeidler()
{
	guide_height=12.3;
	guide_length=10;

	difference()
	{
		union()
		{
			//The idler block.
			translate(idler_axis+[-idler_height/2+2,+idler_long_side/2-idler_long_bottom,0])
			{
			cube([idler_height,idler_long_side,idler_short_side],center=true);

			//Filament Guide.
			translate([guide_height/2+idler_height/2-1,idler_long_side/2-guide_length/2,0])
			cube([guide_height+1,guide_length,8],center=true);
			}

			// The fulcrum Hinge
			translate(idler_fulcrum)
			rotate([0,0,-30])
			{
				cylinder(h=idler_short_side,r=idler_hinge_r,center=true,$fn=60);
				translate([-idler_end_length/2,0,0])
				cube([idler_end_length,idler_hinge_r*2,idler_short_side],center=true);
			}
		}

		//Filament Path
		translate(idler_axis+[2+guide_height,+idler_long_side-idler_long_bottom-guide_length/2,0])
		{
		cube([7,guide_length+2,filament_diameter+0.5],center=true);
		translate([-7/2,0,0])
		rotate([90,0,0])
		cylinder(h=guide_length+4,r=(filament_diameter+0.5)/2,center=true,$fn=16);
		}

		//Back of idler.
		translate(idler_axis+[-idler_height/2+2-idler_height,
			idler_long_side/2-idler_long_bottom-10,0])
		cube([idler_height,idler_long_side,idler_short_side+2],center=true);

		//Slot for idler fulcrum mount.
		translate(idler_fulcrum)
		{
			cylinder(h=idler_short_side-2*idler_hinge_width,
				r=idler_hinge_r+0.5,center=true,$fn=60);
			rotate(-30)
			translate([0,-idler_hinge_r-0.5,0])
			cube([idler_hinge_r*2+1,idler_hinge_r*2+1,
				idler_short_side-2*idler_hinge_width],center=true);
		}

		//Bearing cutout.
		translate(idler_axis)
		{
			difference()
			{
				cylinder(h=idler_608_height,r=idler_608_diameter/2,
					center=true,$fn=60);
				for (i=[0,1])
				rotate([180*i,0,0])
				translate([0,0,6.9/2])
				cylinder(r1=12/2,r2=16/2,h=2);
			}
			cylinder(h=idler_short_side-6,r=m8_diameter/2-0.25/*Tight*/,
				center=true,$fn=20);
		}

		//Fulcrum hole.
		translate(idler_fulcrum)
		rotate(180/8)
		cylinder(h=idler_short_side+2,r=m3_diameter/2-0.1,center=true,$fn=8);

		//Nut trap for fulcrum screw.
		translate(idler_fulcrum+[0,0,idler_short_side/2-idler_hinge_width-1])
		rotate(360/16)
		cylinder(h=3,r=m3_nut_diameter/2,$fn=6);

		for(idler_screw_hole=[-1,1])
		translate(idler_axis+[2-idler_height,0,0])
		{
			//Screw Holes.
			translate([-1,idler_mounting_hole_up,
				idler_screw_hole*idler_mounting_hole_across])
			rotate([0,90,0])
			{
				cylinder(r=idler_mounting_hole_diameter/2,h=idler_height+2,$fn=16);
				translate([0,idler_mounting_hole_elongation,0])
				cylinder(r=idler_mounting_hole_diameter/2,h=idler_height+2,$fn=16);
				translate([-idler_mounting_hole_diameter/2,0,0])
				cube([idler_mounting_hole_diameter,idler_mounting_hole_elongation,
					idler_height+2]);
			}

			// Rounded corners.
			render()
			translate([idler_height/2,idler_long_top,
				idler_screw_hole*(idler_short_side/2)])
			difference()
			{
				translate([0,-idler_corners_radius/2+0.5,-idler_screw_hole*(idler_corners_radius/2-0.5)])
				cube([idler_height+2,idler_corners_radius+1,idler_corners_radius+1],
					center=true);
				rotate([0,90,0])
				translate([idler_screw_hole*idler_corners_radius,-idler_corners_radius,0])
				cylinder(h=idler_height+4,r=idler_corners_radius,center=true,$fn=40);
			}
		}
	}
}

module b608(h=8)
{
	translate([0,0,h/2]) cylinder(r=hole_for_625/2,h=h,center=true,$fn=60);
}

module barbell (x1,x2,r1,r2,r3,r4)
{
	x3=triangulate (x1,x2,r1+r3,r2+r3);
	x4=triangulate (x2,x1,r2+r4,r1+r4);
	render()
	difference ()
	{
		union()
		{
			translate(x1)
			circle (r=r1);
			translate(x2)
			circle(r=r2);
			polygon (points=[x1,x3,x2,x4]);
		}

		translate(x3)
		circle(r=r3,$fa=5);
		translate(x4)
		circle(r=r4,$fa=5);
	}
}

function triangulate (point1, point2, length1, length2) =
point1 +
length1*rotated(
atan2(point2[1]-point1[1],point2[0]-point1[0])+
angle(distance(point1,point2),length1,length2));

function distance(point1,point2)=
sqrt((point1[0]-point2[0])*(point1[0]-point2[0])+
(point1[1]-point2[1])*(point1[1]-point2[1]));

function angle(a,b,c) = acos((a*a+b*b-c*c)/(2*a*b));

function rotated(a)=[cos(a),sin(a),0];

//========================================================
// Modules for defining holes for hotend mounts:
// These assume the extruder is verical with the bottom filament exit hole at [0,0,0].

//malcolm_hotend_holes ();
module malcolm_hotend_holes ()
{
	extruder_recess_d=16;
	extruder_recess_h=3.5;

	// Recess in base
	translate([0,0,-1])
	cylinder(r=extruder_recess_d/2,h=extruder_recess_h+1);
}

//groovemount_holes ();
module groovemount_holes ()
{
	extruder_recess_d=16.4;
	extruder_recess_h=5.5;

	// Recess in base
	translate([0,0,-1])
	cylinder(r=extruder_recess_d/2,h=extruder_recess_h+1);
}

//peek_reprapsource_holes ();
module peek_reprapsource_holes ()
{
	extruder_recess_d=11;
	extruder_recess_h=19;

	// Recess in base
	translate([0,0,-1])
	cylinder(r=extruder_recess_d/2,h=extruder_recess_h+1);

	// Mounting holes to affix the extruder into the recess.
	translate([0,0,min(extruder_recess_h/2, base_thickness/2)])
	rotate([-90,0,0])
	cylinder(r=m4_diameter/2-0.5/* tight */,h=wade_block_depth+2,center=true);
}

//arcol_mount_holes();
module arcol_mount_holes()
{
	hole_axis_rotation=42.5;
	hole_separation=30;
	hole_slot_height=4;
	for(mount=[-1,1])
	translate([hole_separation/2*mount,-7,0])
	{
		translate([0,0,-1])
		cylinder(r=m4_diameter/2,h=base_thickness+2,$fn=8);

		translate([0,0,base_thickness/2])
		//rotate(hole_axis_rotation)
		{
			cylinder(r=m4_nut_diameter/2,h=base_thickness/2+hole_slot_height,$fn=6);
			translate([0,-m4_nut_diameter,hole_slot_height/2+base_thickness/2])
			cube([m4_nut_diameter,m4_nut_diameter*2,hole_slot_height],
			center=true);
		}
	}
}

//mendel_parts_v6_holes ();
module mendel_parts_v6_holes (insulator_d=12.7)
{
	extruder_recess_d=insulator_d+0.7;
	extruder_recess_h=10;
	hole_axis_rotation=42.5;
	hole_separation=30;
	hole_slot_height=5;

	// Recess in base
	translate([0,0,-1])
	cylinder(r=extruder_recess_d/2,h=extruder_recess_h+1);

	for(mount=[-1,1])
	rotate([0,0,hole_axis_rotation+90+90*mount])
	translate([hole_separation/2,0,0])
	{
		translate([0,0,-1])
		cylinder(r=m4_diameter/2,h=base_thickness+2,$fn=8);

		translate([0,0,base_thickness/2])
		rotate(-hole_axis_rotation+180)
		{
//			rotate(30)
			cylinder(r=m4_nut_diameter/2,h=base_thickness/2+hole_slot_height,$fn=6);
			translate([0,-m4_nut_diameter,hole_slot_height/2+base_thickness/2])
			cube([m4_nut_diameter,m4_nut_diameter*2,hole_slot_height],
					center=true);
		}
	}
}

//grrf_peek_mount_holes();
module grrf_peek_mount_holes()
{
	extruder_recess_d=16.5;
	extruder_recess_h=10;

	// Recess in base
	translate([0,0,-1])
	cylinder(r=extruder_recess_d/2,h=extruder_recess_h+1);

	for (hole=[-1,1])
	rotate(90,[1,0,0])
	translate([hole*(extruder_recess_d/2-1.5),3+1.5,-wade_block_depth/2-1])
	cylinder(r=1.5,h=wade_block_depth+2,$fn=10);
}

//wildseyed_mount_holes(insulator_d=16);
module wildseyed_mount_holes(insulator_d=12.7)
{
	extruder_recess_d=insulator_d+0.2;
	extruder_recess_h=10;

	// Recess in base
	translate([0,0,-1])
	cylinder(r=extruder_recess_d/2,h=extruder_recess_h+1);

	for (hole=[-1,1])
	rotate(90,[1,0,0])
	translate([hole*(extruder_recess_d/2-1.5),3+1.5,-wade_block_depth/2-1])
	cylinder(r=1.5,h=wade_block_depth+2,$fn=10);
}

module geeksbase_holes ()
{
	extruder_recess_d=10.8;
	extruder_recess_h=20;

	// Recess in base
	translate([0,0,-1])
	cylinder(r=extruder_recess_d/2,h=extruder_recess_h+1);

	// Mounting holes to affix the extruder into the recess.
	translate([5,0,min(extruder_recess_h/2, base_thickness/2-2)])
	rotate([-90,0,0])
	cylinder(r=m3_diameter/2-0.5,/*tight*/,h=wade_block_depth+2,center=true);
	translate([-5,0,min(extruder_recess_h/2, base_thickness/2-2)])
	rotate([-90,0,0])
	cylinder(r=m3_diameter/2-0.5,/*tight*/,h=wade_block_depth+2,center=true);

	//cylinder(r=m4_diameter/2-0.5/* tight */,h=wade_block_depth+2,center=true);
}

module malcolm_extrusion_holes ()
{
	extruder_recess_d=16;
	extruder_recess_h=4;
	hole_axis_rotation=22;
	hole_separation=33.2;
	hole_slot_height=5;

	// Recess in base
	translate([0,0,-1])
	cylinder(r=extruder_recess_d/2,h=extruder_recess_h+1);

	for(mount=[-1,1])
	rotate([0,0,hole_axis_rotation-90+90*mount])
	translate([hole_separation/2,0,0])
	{
		translate([0,0,-1])
		cylinder(r=m3_diameter/2,h=base_thickness+2,$fn=8);

		translate([0,0,base_thickness-2])
		rotate(-hole_axis_rotation+180)
		{
			cylinder(r=m3_nut_diameter/2,h=base_thickness/2+hole_slot_height,$fn=6);
			translate([0,-m3_nut_diameter,hole_slot_height/2+base_thickness/2])
			cube([m3_nut_diameter,m3_nut_diameter*2,hole_slot_height],
					center=true);
		}
	}
}
