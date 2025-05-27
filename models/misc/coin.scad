$fn=100;

r1 = 100 / 2;
r2 = 26.6 / 2;
t = 1.85;

difference() {
    cylinder(h=t*22, r=r1-.25);


    translate([0, 0, t*2]) {
        translate([0, 0, t*15]) {
            rotate([0, 0, 112.5]) {
                translate([0, r2*1.5, 0]) {
                    cylinder(h=t*22, r=r2/2);
                }
                translate([0, -r2*1.5, 0]) {
                    cylinder(h=t*22, r=r2/2);
                }
            }
        }
        rotate([0, 0, 22.5]) {
            translate([0, r2, 0]) {
                cylinder(h=t*22, r=r2);
            }
            translate([0, -r2, 0]) {
                cylinder(h=t*22, r=r2);
            }
        }
        for(i=[0:45:360])
        {   rotate([0, 0, i]) {
                translate([r1-r2+2, 0, 0]) {
                    cylinder(h=t*22, r=r2);
                }
            }
        }
    }
}

