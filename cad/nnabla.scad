translate([0, 0, 0]);
$fn=20;

d1 = 2;
w = 30;
h = 5;

ww = w / 5;

module mask1(x, y) {
    translate([x+y, 0, 0]) rotate([0, 270, 0]) linear_extrude(y) polygon([[0, 0], [h, 0], [h/2, w], [0, w]]);
}

module mask2(x, y) {
    translate([x, w, 0]) rotate([180, 270, 0]) linear_extrude(y) polygon([[0, 0], [h, 0], [h/2, w], [0, w]]);
}

module logo1() {
    translate([d1, d1, 0]) {
        intersection() {
            linear_extrude(h) polygon([[0, 0], [ww, 0], [0, w/2]]);
            mask1(0, ww);
        }

        intersection() {
            linear_extrude(h) polygon([[ww*2, 0], [ww*3, 0], [ww, w], [0, w]]);
            mask2(0, ww*3);
        }
        linear_extrude(h/2) polygon([[ww*2, 0], [ww*3, 0], [ww*3, w], [ww*2, w]]);
        intersection() {
            linear_extrude(h) polygon([[ww*4, 0], [w, 0], [ww*3, w], [ww*2, w]]);
            mask1(ww*2, ww*3);
        }

        intersection() {
            linear_extrude(h) polygon([[ww*4, w], [w, w], [w, w/2]]);
            mask2(ww*4, ww);
        }

    }
}

logo1();

w0 = w+d1*2;
w1 = w+d1;

translate([0, 0, 0]) {
    linear_extrude(h) {
        polygon(points=[[0, 0], [w0, 0], [w0, w0], [0, w0], [d1, d1], [w1, d1], [w1, w1], [d1, w1]], paths=[[0, 1, 2, 3], [4, 5, 6, 7]]);
    }
}

