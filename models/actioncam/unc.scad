include <BOSL2/std.scad>
include <BOSL2/threading.scad>


module unc(length=10) {
    threaded_nut(shape="square",
        nutwidth=10,
        id=1/4 * INCH,
        h=length,
        pitch=1/20 * INCH,
        bevel=false,
        $slop=0.1,
        $fa=1,
        $fs=1,
        $fn=64);
}
unc();