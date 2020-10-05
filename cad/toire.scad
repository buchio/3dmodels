$fn=50;

difference() {
//color("green") translate([17.3/2, 14.3/2, 0]) cylinder(r=13,h=7);
    color("yellow") translate([17.3/2, 14.3/2, 0]) { 
        cylinder(r=16,h=3);
        cylinder(r=14,h=3.2);
        cylinder(r=13,h=3.4);
        cylinder(r=12,h=3.6);
        cylinder(r=11,h=3.8);
        cylinder(r=10,h=7);
    }
    color("red") translate([5.1, 5.1, -1]) {
        intersection() {
            color("red") translate([3.6, 2.1, -5]) cylinder(r=8.6,h=30);
            minkowski() {
                cube([7.2,4.2,10]);
                cylinder(r=5,h=10);
            }
        }
    }
}


