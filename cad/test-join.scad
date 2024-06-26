$fn=48;


module cyl(height, radius, thickness) {
    difference() {
        cylinder(height, r=radius);
        translate([0,0,-height*0.1]) 
            cylinder(height * 1.2, r=radius-thickness/2);
    }
}


h = 33;
r = 35;
t = 2;
c = 0.1;



module hontai() {
    translate([0, 0, t*2])
    difference() {
        union() {
            translate([0, 0, -c]) cyl(h+c*2, r-c, t);
            translate([0, 0, -t*2]) cylinder(t*2, r=r*1.1);
            intersection() {
                translate([0, 0, h+c]) 
                    difference() {
                        cylinder(t*1.3, r+t, r-t/3);
                        translate([0,0,-c]) cylinder(t*3, r=r-t/2-c);
                    }
                translate([-r/3/2, -r*2, 0]) cube([r/3, r*4, h*2]);
            }
        }
        union() {
            translate([-(r/3/2+t/2), -r*2, h*.5]) cube([t/2, r*4, h*2]);
            translate([(r/3/2), -r*2, h*.5]) cube([t/2, r*4, h*2]);
            translate([0, 0, -t*2-c]) cylinder(t*3, r=r-t/2-c);
        }
    }
}


hontai();

module leaf() {
    difference() {
        intersection() {
            translate([0, 0, t/2-c]) cylinder(t/2+c, r=r-t/2);
            union() {
                translate([r/2, r/2, 0]) cylinder(5, r=r/2);
                translate([0, r/2, 0]) cube([r, r, 5]);
                translate([r/2, 0, 0]) cube([r, r, 5]);
            }
        }
        union() {
            translate([0, r*.1, 0]) rotate([0, 0, -5]) translate([0, -r, 0]) cube([r*2, r, 10]);
            translate([r*.1, 0, 0]) rotate([0, 0, 5]) translate([-r, 0, 0]) cube([r, r*2, 10]);
        }
    }
}

rotate([0, 0, 90]) leaf();
rotate([0, 0, 180]) leaf();
rotate([0, 0, 270]) leaf();
rotate([0, 0, 0]) leaf();
