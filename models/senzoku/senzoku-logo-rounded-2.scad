include <BOSL2/std.scad>

$fn=100;

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

senzoku_logo(20, 2, 10, .3);