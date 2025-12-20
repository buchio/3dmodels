include <BOSL2/std.scad>

$fn=64;

module rounded_arc(r_maj, r_min, angle) {
    // 球の半径分の角度を計算（近似）
    theta = angle; // トーラス部分の角度

    // トーラスと球の結合
    union() {
        // 部分トーラス
        rotate_extrude(angle=theta)
        translate([r_maj, 0, 0])
        rect([r_min*2, r_min*2], rounding=r_min/2);
    }    
}

module rounded_cyl(h, r) {
    cuboid([h, r*2, r*2], rounding=r/2);
}


rounded_arc(19, 2.5, 360);

//senzoku_logo_inner();

translate([0, -5, 0]) {
    rotate([0, 0, 30]) {
        rounded_arc(10, 2.5, 330);
    }
    translate([6, 0, 0] ) rounded_cyl(13, 2.5);
}
translate([-3, -1, 0]) rounded_arc(5.3, 2.5, 360);
translate([-3, 9.5, 0]) rounded_arc(5, 2.5, 290);
