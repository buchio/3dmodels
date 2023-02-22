
union(){
    difference() {
        union() {
            translate([10.5, 0, 0]) {
                cube([4,18,20], center = true);
            }
            cylinder(h=20, r=14.5, center=true);
        }
        {
            translate([-10.5, 0, 0]) {
                cube([10, 4.8, 25], center = true);
            }
            cylinder(h=25, r=11, center=true);
        }
    }
    {
        translate([-12.5, 2.6, 0]) {
            cylinder($fn=20, h=20, r=1.8, center=true);
        }
        translate([-12.5, -2.6, 0]) {
            cylinder($fn=20, h=20, r=1.8, center=true);
        }
    }
}

translate([14, 0, 0]) {
    scale([1, 1.1, 1.1]) {
        rotate([0,90,0]) {
            translate([-8, 0, .5]) {
                difference() {
                    {
                        translate([6,0,0]) {
                            cylinder(h=4, r=13, center=true);
                        }
                    }
                    {
                        cylinder(h=6, r=12.5, center=true);
                        cube([10, 50, 20], center=true);
                    }
                }
                translate([5,12.15,0]) cylinder(h=4, r=.75, center=true, $fn=20);
                translate([5,-12.15,0]) cylinder(h=4, r=.75, center=true, $fn=20);
                
            }
        }
        rotate([45, 0, 0]) {
            difference() {
                cube([5,30,30], center = true);
                translate([4.8, 0, 0]) {
                    cube([6,28,28], center = true);
                }
            }
        }
    }
}