include <BOSL2/std.scad>

$fn=100;

module mask(size, rounding) {
    l0 = size[0]*1.05;
    l1 = size[1]*1.05;
    r = l0 * rounding;
    rounding_edge_mask(l=l1, r=r);
    translate([l0, 0, 0])
    rotate([0, 0, 90])
    rounding_edge_mask(l1, r=r);
    translate([l0/2, 0, l1/2])
    rotate([0, 90, 0])
    rounding_edge_mask(l0, r=r);
    translate([l0/2, 0, -l1/2])
    rotate([0, -90, 0])
    rounding_edge_mask(l=l0, r=r);
 
    translate([0, 0, -l1/2])
    rounding_corner_mask(r=r);
    translate([0, 0, l1/2])
    rotate([0, 90, 0])
    rounding_corner_mask(r=r);
    translate([l0, 0, l1/2])
    rotate([0, 90, 90])
    rounding_corner_mask(r=r);
    translate([l0, 0, -l1/2])
    rotate([0, -90, 0])
    rounding_corner_mask(r=r);
}

module rounded_arc(r, size, angle, rounding) {
    difference() {
        rotate_extrude(angle=angle) {
            translate([r, 0, 0]) {
                rect(size, rounding=size[0]*rounding);
            }
        }
        if ( angle != 360 ) {
            translate([r-(size[0]*1.05)/2, 0, 0]) {
                mask(size, rounding);
            }
        }
    }
}

module rounded_cyl(h, size, rounding) {
    cuboid([h, size[0], size[1]], rounding=size[0]*rounding);
}

module senzoku_logo(size, thickness, height, rounding) {
    t = thickness;
    h = height;
    r = rounding;

    r0 = size;
    r1 = (r0 * .65) - t/2;
    r2 = r1 * .6;
    r3 = r2 * .92;

    rounded_arc(r0, [t, h], 360, r);
    translate([0, -(r0-r1)+t, 0]) {
        rotate([0, 0, 30]) {
            rounded_arc(r1, [t, h], 330, r);
        }

        d1 = r1-r2;
        t1 = acos(d1*cos(30)/r2);
        p0 = r2*sin(t1)-d1*sin(30);
        p1 = r1+t/2;
        l = p1 - p0;
        translate([p0+l/2, 0, 0] ) {
            rounded_cyl(l, [t, h], r);
        }
        
        translate([-d1*sin(30), d1*cos(30), 0]) {
            rounded_arc(r2, [t, h], 360, r);
            translate([0, r2+r3, 0]) {
                rounded_arc(r3, [t, h], 270, r);
            }
        }
    }
    
}

senzoku_logo(20, 4, 10, .3);

