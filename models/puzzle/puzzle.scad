
width = 10;
length = 95;
t = 19;

rotate([0, 0, 0]) {
    color("navy", .3) translate([t, 0, 0]) cube([width, length, width], center=true);
    color("blue", .3) translate([-t, 0, 0]) cube([width, length, width], center=true);
}
rotate([0, 0, 60]) {
    color("darkred", .3) translate([t, 0, 0]) cube([width, length, width], center=true);
    color("red", .3) translate([-t, 0, 0]) cube([width, length, width], center=true);
}
rotate([0, 0, 120]) {
    color("darkgreen", .3) translate([t, 0, 0]) cube([width, length, width], center=true);
    color("green", .3) translate([-t, 0, 0]) cube([width, length, width], center=true);
}
