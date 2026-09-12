$fn = 100;

eye_radius = 33;
margin     = 1;
r = (eye_radius + margin) * 2; // 未使用だった margin を反映

nx = 2;
ny = 2;

for (x = [0:nx], y = [0:ny]) {
    // 正方格子上の瞳
    translate([x, y] * r)
        rotate($t * 720) eye();

    // 中間に挟む直交した瞳
    if (x < nx && y < ny)
        translate([x + 0.5, y + 0.5] * r)
            rotate($t * 720 + 90) eye();
}

module eye() {
    color("green")
    intersection() {
        translate([0, -25]) circle(40);
        translate([0,  25]) circle(40);
    }
    color("black") circle(7);
}
