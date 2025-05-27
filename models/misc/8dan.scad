$fn = 100;

module hex(r, h, t) {
    difference() {
        linear_extrude(h) circle(r, $fn=6);
        translate([0, 0, -0.5]) linear_extrude(h+1) circle(r-t,$fn=6);
    }
}

r=10;
h=5;
t=2;

rotate(90) {
translate([0, 0, 0]) hex(r, h, t);
//translate([0, r*2*sin(60)-t, 0]) hex(r, h, t);
//translate([r*1.5-t*cos(60),r*sin(60)-t/2, 0]) hex(r, h, t);
}
text("8");