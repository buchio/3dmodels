$fn=50;

pw = 25.4 * 3.05;
pt = 25.4 * .06;
ph = 25.4 * .7;
pg = 25.4 * .12;


b1w = 25.4 * 2.65;
b1h = ph;
b1d = pg * 57 + pt;


b2w = 25.4 * 3.3;
b2h = ph * .75;
b2d = 25.4 * 7.15;
b2r = 2.54;

echo(b2d);

difference() {
    translate([0, b2d/2-pt/2-25.4/4, -b2h*.3]) {
        minkowski() {
            cube([b2w-b2r*2, b2d-b2r*2, b2h-b2r], true);
            cylinder(r=b2r,h=b2r/2);
        }
    }

    {
        for(i = [0:pg:pg*56]) {
            translate([0, i, 0]) {
                cube([pw, pt, ph], true);
            }
        }
        translate([0, b1d/2 - pt*.75 - pg/2, 0]) {
            cube([b1w, b1d, b1h], true);
        }
     }
}