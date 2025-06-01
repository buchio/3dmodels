include <BOSL2/std.scad>
include <BOSL2/threading.scad>

include <senzoku-logo.scad>



$fn=64;

height = 5;
linear_extrude(height) senzoku_logo_inner();
difference() {
    cylinder(height, r=21);
    cylinder(height, r=16.9);
}
