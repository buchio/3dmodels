pw = 25.4 * 3.05;
pt = 25.4 * .05;
ph = 25.4;
pg = 25.4 * .12;


b1w = 25.4 * 2.5;
b1h = ph;
b1d = pg * 50 + pt;


b2w = 25.4 * 4;
b2h = ph * .75;
b2d = pg * 49 + pt + 25.4;

echo(b2d);

difference() {
translate([0, b2d/2-pt/2-25.4/2, -b2h*.25]) {
    cube([b2w, b2d, b2h], true);
}

{
    for(i = [0:pg:pg*49]) {
        translate([0, i, 0]) {
            cube([pw, pt, ph], true);
        }
    }
    translate([0, b1d/2 - pt/2 - pg/2, 0]) {
        cube([b1w, b1d, b1h], true);
    }
 }

}