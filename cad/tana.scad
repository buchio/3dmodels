module dan() {
    difference() {
        cube([20, 150, 200]);
        translate([1, 1, -5]) cube([18, 148, 210]);
    }
}

dan();
translate([19, 0, 0]) dan();
translate([38, 0, 0]) dan();
translate([57, 0, 0]) dan();
translate([76, 0, 0]) dan();
translate([95, 0, 0]) dan();
