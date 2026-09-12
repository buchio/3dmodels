$fn = 40;

// --- ギア・機構パラメータ ---
z       = 16;            // 歯数（4の倍数にすると45度対角で完璧に噛み合う）
r_pitch = 33;            // ピッチ円半径（瞳のサイズに合わせた半径）
d       = r_pitch * 2;   // ギア同士の中心間距離
l       = sqrt(2) * d;   // 正方格子の1辺（対角距離が d になる間隔）

nx = 1;
ny = 1;

// 四隅グループ
for (x = [0:nx], y = [0:ny])
    translate([x, y] * l)
        synced_eye($t * 360 + 180 / z, 1);

// 中央グループ
for (x = [0:nx-1], y = [0:ny-1])
    translate([x + 0.5, y + 0.5] * l)
        synced_eye(-$t * 360, -1);

translate([(nx+1)*r_pitch*2+100, 0, 0]) {        

translate([-r_pitch, -r_pitch, 0])
                linear_extrude(height = 10, center = false, convexity = 10, twist = 0)
square([(nx+2)*r_pitch*2, (ny+2)*r_pitch*2]);

// 四隅グループ
for (x = [0:nx], y = [0:ny])
    translate([x, y] * l)
        cylinder(70, 9.5, 9.5);

// 中央グループ
for (x = [0:nx-1], y = [0:ny-1])
    translate([x + 0.5, y + 0.5] * l)
        cylinder(70, 9.5, 9.5);
}


// 歯車と瞳の一体モジュール
module synced_eye(angle = 0, t) {
    rotate(angle) {
        difference() {
            union() {
                linear_extrude(height = 10, center = false, convexity = 10, twist = 0)
                gear(z = z, r = r_pitch);
                translate([0, 0, 10])
                linear_extrude(height = 200, center = false, convexity = 10, twist = 360*t)
                scale([1.45, 1.2, 1])eye();
            }
            translate([0, 0, -10]) cylinder(100, 10, 10);
        }
    }
}

// 簡易平歯車（スパーギア）
module gear(z, r) {
    pitch_ang = 360 / z;
    m  = 2 * r / z;       // モジュール
    ra = r + 0.8 * m;     // 歯先円半径
    rf = r - 1.1 * m;     // 歯底円半径

    color([0.35, 0.38, 0.42])
    union() {
        circle(r = rf);
        for (i = [0 : z - 1]) {
            rotate(i * pitch_ang)
                polygon([
                    [rf * cos(pitch_ang * 0.28),  rf * sin(pitch_ang * 0.28)],
                    [ra * cos(pitch_ang * 0.14),  ra * sin(pitch_ang * 0.14)],
                    [ra * cos(-pitch_ang * 0.14), ra * sin(-pitch_ang * 0.14)],
                    [rf * cos(-pitch_ang * 0.28), rf * sin(-pitch_ang * 0.28)]
                ]);
        }
    }
}

// 瞳モジュール
module eye() {
    color("forestgreen")
    intersection() {
        translate([0, -25]) circle(40);
        translate([0,  25]) circle(40);
    }
}
