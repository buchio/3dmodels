$fn=100;

union() {
    cylinder(.5, r=40);
    difference() {
        cylinder(20, r=35);
        cylinder(30, r=34.75);
    }
}
