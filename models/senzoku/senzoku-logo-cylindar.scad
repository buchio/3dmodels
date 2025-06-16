$fn=64;

module rounded_arc(r_maj, r_min, angle, round=[true, true]) {
    t0 = round[0] ? atan(r_min / r_maj) : 0;
    t1 = round[1] ? atan(r_min / r_maj) : 0;

    // 球の半径分の角度を計算（近似）
    theta = angle - (t0 + t1); // トーラス部分の角度

    // トーラスと球の結合
    rotate([0, 0, t0]) {
        union() {
            // 部分トーラス
            rotate_extrude(angle=theta)
            translate([r_maj, 0, 0])
            circle(r=r_min);
            
            // 開始点の球
            if( round[0] ) {
                translate([r_maj, 0, 0])
                sphere(r=r_min);
            }
            
            // 終了点の球
            if( round[1] ) {
                translate([r_maj * cos(theta), r_maj * sin(theta), 0])
                sphere(r=r_min);
            }
        }    
    }
}

module rounded_cyl(h, r, round=[true, true]) {
    h0 = round[0] ? r : 0;
    h1 = round[1] ? r : 0;
    translate([-h/2, 0, 0]) {
        rotate([0, 90, 0]) {
            translate([0, 0, h0]) {
                if(round[0]) sphere(r=r);
                cylinder(h-(h0+h1), r=r);
                if(round[1]) translate([0, 0, h-(h0+h1)]) sphere(r=r);
            }
        }
    }
}


rounded_arc(19, 2.5, 360, [false, false]);

//senzoku_logo_inner();

translate([0, -5, 0]) {
    rotate([0, 0, 25]) {
        rounded_arc(10, 2.5, 345, [true, true]);
    }
    translate([6, 0, 0] ) rounded_cyl(10, 2.5, [true, true]);
}
translate([-3, -1, 0]) rounded_arc(5.3, 2.5, 360, [false, false]);
translate([-3, 9.5, 0]) rounded_arc(5, 2.5, 290, [true, false]);
