$fn=50;

pw = 25.4 * 3.05;
pt = 25.4 * .05;
ph = 25.4;
pg = 25.4 * .12;


b1w = 25.4 * 2.5;
b1h = ph;
b1d = pg * 57 + pt;


b2w = 25.4 * 3.5;
b2h = ph * .75;
b2d = 25.4 * 7.25 + pt;
b2r = 2.54;

difference() {
    translate([0, b2d/2-pt/2-25.4/4, -b2h*.25]) {
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
        translate([0, b1d/2 - pt/2 - pg/2, 0]) {
            cube([b1w, b1d, b1h], true);
        }
     }
}