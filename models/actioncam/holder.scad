include <BOSL2/std.scad>
include <BOSL2/threading.scad>

use <unc.scad>

$fn=64;

include <BOSL2/std.scad>

//color("red") rotate([90, 0, 0]) cuboid([24,47,72], rounding=12, edges=[FWD+RIGHT, FWD+LEFT, BACK+RIGHT, BACK+LEFT]);


difference() {
    difference() {
        translate([0, 5, 17]) cube([28, 90, 20], center=true);
        union() {
            rotate([90, 0, 0]) cuboid([24,47,72.2], rounding=12, edges=[FWD+RIGHT, FWD+LEFT, BACK+RIGHT, BACK+LEFT]);
            cube([24, 65, 80], center=true);
        }
    }
    union() {
        translate([0, 44, 22.6]) cube([9.5, 9.5, 100], center=true);
        translate([14.5, 33, 0]) cube([2, 5, 70], center=true);
        translate([-14.5, 33, 0]) cube([2, 5, 70], center=true);
        translate([14.5, -33, 0]) cube([2, 5, 70], center=true);
        translate([-14.5, -33, 0]) cube([2, 5, 70], center=true);
    }
}

translate([0, 44, 17]) unc(20);