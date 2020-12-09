translate([15, 0, 0] ) {
    cube([105,7,5],false);
}
resize([15.2, 7, 5]) {
    translate([0, 2.5, 2.5] ) {
        rotate([0, 90, 0]) {
            rotate([0, 0, 45]) {
                cylinder(h=15, r1=0.5, r2=3.5, center=false, $fn=4);
            }
        }
    }
}

translate([120, 3.5, 1.5]) {
    cylinder(h=2, r=3);
}