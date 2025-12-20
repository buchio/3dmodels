include <BOSL2/std.scad>
include <BOSL2/screws.scad>


$fn=20;


module punching_slate( plate_w, plate_h, thickness, hole_rad, pitch, center=false) {
    $fn = 10;         // 穴の滑らかさ（数を増やす場合は小さめが吉）
    tx = center?(-plate_w/2):0;
    ty = center?(-plate_h/2):0;
    tz = center?(-thickness/2):0;
    translate([tx, ty, tz]) {
        difference() {
            // ベースの板
            cube([plate_w, plate_h, thickness]);

            // 穴の配列
            for (y = [pitch/2 : pitch * sin(60) : plate_h]) {
                // y座標のインデックスによってxの開始位置をずらす
                let(row_index = floor(y / (pitch * sin(60))))
                for (x = [(row_index % 2 == 0 ? pitch/2 : pitch) : pitch : plate_w]) {
                    translate([x, y, -1])
                    cylinder(h = thickness + 2, r = hole_rad);
                }
            }

        }
    }
}
module pillar() {
    translate([0, 0, 6]) screw(spec="M3", l=10, slop=0.15, $fn=64);
    translate([0, 0, 3]) cylinder(6, r=3, center=true);
}

module single_relay_mount(relay_width=26,relay_height=50, thickness=1.5) {
    difference(){
        cube([relay_width, relay_height, thickness], center=true);
        {
            cube([relay_width-2, relay_height-13, thickness+.5], center=true);
            cube([relay_width-12, relay_height-2, thickness+.5], center=true);
        }
    }
    punching_slate(relay_width, relay_height, thickness, 1, 2.5, center=true);
    {
        translate([-(relay_width/2)+3, -(relay_height/2)+3, 0])
            pillar();
        translate([(relay_width/2)-3, -(relay_height/2)+3, 0])
            pillar();
        translate([(relay_width/2)-3, (relay_height/2)-3, 0])
            pillar();
        translate([-(relay_width/2)+3, (relay_height/2)-3, 0])
            pillar();
    }
}

single_relay_mount();
