$fn=30;


module cyl(height, radius, thickness) {
    difference() {
        cylinder(height, r=radius);
        translate([0,0,-height*0.1]) 
            cylinder(height * 1.2, r=radius-thickness/2);
    }
}


h = 5;
r = 2;
t = 0.3;
c = 0.03;
translate([-5, 0, 0]) color("GREEN") cyl(h, r, t);
color("RED") {
    translate([0, 0, .5])
    difference() {
        union() {
            translate([0, 0, -c]) cyl(h+c*2, r-t/2-c, t);
            translate([0, 0, -.5]) cylinder(.5, r=r*1.1);
            intersection() {
                translate([0, 0, h+c]) 
                    difference() {
                        cylinder(t, r, r-t/2);
                        translate([0,0,-c]) cylinder(t*3, r=r-t-c);
                    }
                translate([-r/3/2, -r*2, 0]) cube([r/3, r*4, h*2]);
            }
        }
        union() {
            translate([-(r/3/2+t/2), -r*2, h*.75]) cube([t/2, r*4, h*2]);
            translate([(r/3/2), -r*2, h*.75]) cube([t/2, r*4, h*2]);
        }
    }
}