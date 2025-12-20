

module perforated_sheet( plate_w, plate_h, thickness, hole_rad, pitch, center=false) {
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
