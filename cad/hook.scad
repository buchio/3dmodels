$fn=100;


module hook(w, h, t, t1, r) {

    module base0() {
        difference() {
            hull() {
                translate([w,0,0]) cylinder(t, h/2, (h-1)/2);
                cylinder(t, h/2, (h-1)/2);
            }
            hull() {
                translate([w,0,2-t]) cylinder(t, (h-2)/2, (h-3)/2);
                translate([0,0,2-t]) cylinder(t, (h-2)/2, (h-3)/2);
            }
        }
        translate([w,0,0]) cylinder(5, 2.5, 5);
        translate([0,0,0]) cylinder(5, 2.5, 5);
    }
    
    module base() {
        difference() {
            base0();
            translate([w,0,-0.5]) cylinder(6, 1.1, 4);
            translate([0,0,-0.5]) cylinder(6, 1.1, 4);
        }
    }
    
    module poll() {
        translate([0, 0, t-0.5]) {
           translate([25, 0, 0]) cylinder(t1-(h-5)/2, (h-1)/2, (h-5)/2);
           translate([25, 0, t1-(h-5)/2]) sphere((h-5)/2);
        }
    }

    base();
    // 
    difference() {
        poll();
        translate([w/2, h, t+t1-r]) rotate([90, 0, 0]) cylinder(h*2, (r)/2, (r)/2, $fn=36);
    }
}


hook(50, 25, 5, 40, 13);
