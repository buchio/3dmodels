include <BOSL2/std.scad>
include <BOSL2/screws.scad>


use <perforated_sheet.scad>

$fn=20;


module pillar() {
    cube([8, 8, 3], center=true);
    translate([0, 0, 6]) screw(spec="M3", l=10, $slop=0.15, $fn=64);
    translate([0, 0, 3]) cylinder(6, r=3, center=true);
}

module single_relay_mount(relay_width=26,relay_height=50, thickness=3) {
//    difference(){
//        cube([relay_width, relay_height, thickness], center=true);
//        {
//            cube([relay_width-2, relay_height-13, thickness+.5], center=true);
//            cube([relay_width-12, relay_height-2, thickness+.5], center=true);
//        }
//    }
//    perforated_sheet(relay_width, relay_height, thickness, 1, 2.5, center=true);
    {
        translate([-(relay_width/2)+3, -(relay_height/2)+3, 0])
            pillar();
        translate([(relay_width/2)-3, -(relay_height/2)+3, 0])
            pillar();
        translate([(relay_width/2)-3, (relay_height/2)-3, 0])
            pillar();
        translate([-(relay_width/2)+3, (relay_height/2)-3, 0])
            pillar();
    }
}

//translate([-60, 0, 0]) single_relay_mount();
//translate([-20, 0, 0]) single_relay_mount();
//translate([20, 0, 0]) single_relay_mount();
//translate([60, 0, 0]) single_relay_mount();

thickness=.5;

difference() {
    union() {
            difference() {
                cube([160, 60, thickness], center=true);
                cube([155, 55, thickness*2], center=true);
            }
            perforated_sheet(160, 60, thickness, 2, 5.5, center=true);
    }
    union() {
        color("blue") {
            translate([0, 51.5/2, 0])    cube([8, 8, thickness*2], center=true);
            translate([-39, -51.5/2, 0]) cube([8, 8, thickness*2], center=true);
            translate([46.5, -51.5/2, 0])cube([8, 8, thickness*2], center=true);
        }
    }
}

color("red")
{
    translate([0, 51.5/2, 0]) 
        difference() {
            cube([8, 8, thickness], center=true);
            cylinder(h=thickness*2, r=1.5, center=true);
        }
    translate([-39, -51.5/2, 0]) 
        difference() {
            cube([8, 8, thickness], center=true);
            cylinder(h=thickness*2, r=1.5, center=true);
        }
    translate([46.5, -51.5/2, 0]) 
        difference() {
            cube([8, 8, thickness], center=true);
            cylinder(h=thickness*2, r=1.5, center=true);
        }
    
}