$fn = 50;

// --- ギア・機構パラメータ ---
z       = 16;            // 歯数（4の倍数にすると45度対角で完璧に噛み合う）
r_pitch = 33;            // ピッチ円半径（瞳のサイズに合わせた半径）
d       = r_pitch * 2;   // ギア同士の中心間距離
l       = sqrt(2) * d;   // 正方格子の1辺（対角距離が d になる間隔）

nx = 0;
ny = 0;

// 四隅グループ
for (x = [0:nx], y = [0:ny])
    translate([x, y] * l)
        synced_eye($t * 360 + 180 / z, 1);

// 中央グループ
for (x = [0:nx-1], y = [0:ny-1])
    translate([x + 0.5, y + 0.5] * l)
        synced_eye(-$t * 360, -1);

translate([(nx+1)*r_pitch*2+100, 0, 0]) {        

translate([-l/2, -l/2, 0])
                linear_extrude(height = 10, center = false, convexity = 10, twist = 0)
                square([(nx+1)*l, (ny+1)*l]);

// 四隅グループ
for (x = [0:nx], y = [0:ny])
    translate([x*l, y*l, 10]) {
        cylinder(10, 18, 9);
        cylinder(70, 9, 9);
    }

// 中央グループ
for (x = [0:nx-1], y = [0:ny-1])
    translate([(x+0.5)*l, (y+0.5)*l, 10]) {
        cylinder(10, 18, 9);
        cylinder(70, 9, 9);
    }
}


// 歯車と瞳の一体モジュール
module synced_eye(angle = 0, t) {
    rotate(angle) {
        difference() {
            union() {
                linear_extrude(height = 20, center = false, convexity = 10, twist = 0)
                gear(z = z, r = r_pitch);
                translate([0, 0, 19.9])
                linear_extrude(height = 200, center = false, convexity = 10, twist = 540*t)
                scale([1.45, 1.2, 1])eye();
            }
            union() {
                cylinder(10, 21, 11);
                cylinder(100, 11, 11);
            }
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
