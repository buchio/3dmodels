include <BOSL2/std.scad>

$fn=64;

module rounded_arc(r, size, angle, rounding) {
    rotate_extrude(angle=angle) {
        translate([r, 0, 0]) {
            rect(size, rounding=size[0]*rounding);
        }
    }
}

module rounded_cyl(h, size, rounding) {
    cuboid([h, size[0], size[1]], rounding=size[0]*rounding);
}

height = 10;
wall_thickness = 2;
thickness = 2;
rounding = .4;

size = 20;


rounded_arc(size-wall_thickness/2, [wall_thickness, height], 360, rounding);

r0 = size*.75-wall_thickness*2*.8;
r1 = r0 *.6;
translate([0, -r0/2, 0]) {
    rotate([0, 0, 30]) {
        rounded_arc(r0, [thickness, height], 330, rounding);
    }
    translate([r0/2+thickness, 0, 0] ) {
        rounded_cyl(r0-thickness, [thickness, height], rounding);
    }

    translate([-r0*.4*sin(30), r0*.4*cos(30), 0]) {
    rounded_arc(r1, [thickness, height], 360, rounding);
    translate([0, r1*1.9, 0]) {
        rounded_arc(r1*.9, [thickness, height], 270, rounding);
    }
}

    
}

//translate([(-r0/2)*.75, -size/20, 0]) 
//translate([(-r0/2)*.75, size*.56, 0]) rounded_arc(r0*.5, [thickness, height], 290, rounding);
