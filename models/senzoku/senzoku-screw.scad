include <BOSL2/std.scad>
include <BOSL2/threading.scad>

include <senzoku-logo.scad>



$fn=128;

height = 20;
spiral_height = 12;
linear_extrude(height, twist=height/spiral_height*360) senzoku_logo_inner();
translate([50, 0, 0]) {
    difference() {
        cylinder(height, r=21);
        linear_extrude(height, twist=height/spiral_height*360)senzoku_logo_silhouette(.8);
    }
}

