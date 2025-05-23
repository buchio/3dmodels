include <BOSL2/std.scad>
//circle(r=44);

$fn=100;


translate([0, 0, 5]) {
    convex_offset_extrude(bottom=os_circle(r=-1),top=os_circle(r=1), height=5,steps=10) {
        circle(r=2.5);
    }
}
translate([0, 0, -5]) {
    convex_offset_extrude(bottom=os_circle(r=1),top=os_circle(r=-1), height=5,steps=10) {
        circle(r=2.5);
    }
}

difference() {
    convex_offset_extrude(bottom=os_circle(r=2.5),top=os_circle(r=2.5), height=5,steps=10) {
        circle(r=44);
    }
    translate([-6.5, 0, 2.5]) {
        union() {
            translate([-25, 2.5, -2.5]) rotate([90, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=50, r=.5);
            translate([-25, 2.5, 2.5]) rotate([0, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=50, r=.5);
            translate([-25, -2.5, -2.5]) rotate([180, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=50, r=.5);
            translate([-25, -2.5, 2.5]) rotate([-90, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=50, r=.5);
            translate([-25, 0, 0]) cube([50, 5, 5], center=true);
            right_half() {
                translate([0, 0, 2.5])rounding_hole_mask(r=2.5, rounding=.5);
                translate([0, 0, -2.5]) rotate([-180, 0, 0]) rounding_hole_mask(r=2.5, rounding=.5);
                cylinder(h=5, r=2.5, center=true);
            }
        }
    } 
}        

module hand_end() {
    right_half() {
        convex_offset_extrude(bottom=os_circle(r=.5),top=os_circle(r=.5), height=2,steps=10) {
            circle(r=2);
        }
    }
}

module hand() {
    difference() {
        linear_extrude(4) ring(r1=2.5,r2=4.5, angle=[60,300], n=$fn);
        union() {
            translate([0, 0, 4]) rounding_cylinder_mask(r=4.5, rounding=.5);
            rotate([180, 0, 0]) rounding_cylinder_mask(r=4.5, rounding=.5);
            translate([0, 0, 4]) rounding_hole_mask(r=2.5, rounding=.5);
            rotate([180, 0, 0]) rounding_hole_mask(r=2.5, rounding=.5);
        }
    }
    translate([1.24, -2.18, 2]) rotate([90, 0, 30]) hand_end();
    translate([1.24, 2.18, 2]) rotate([-90, 0, -30]) hand_end();
    difference() {
        translate([-23, -2.5, 0]) cube([20, 5, 4]);
        union() {
            translate([-13, 2.5, 0]) rotate([180, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=20, r=.5);
            translate([-13, 2.5, 4]) rotate([-90, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=20, r=.5);
            translate([-13, -2.5, 0]) rotate([90, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=20, r=.5);
            translate([-13, -2.5, 4]) rotate([0, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=20, r=.5);
        }
    }
}

translate([-48, 2.5, 2.5]) rotate([90, 0, 180]) hand();
translate([-48, -6.5, 2.5]) rotate([90, 0, 180]) hand();