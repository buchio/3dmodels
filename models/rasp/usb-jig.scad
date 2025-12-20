// --- パラメータ（ここを調整してください） ---

// [1] 治具の差し込み部分の長さ (mm)
plug_depth = 15;

// [2] 嵌め合いのきつさ調整（クリアランス）
// 0 = ポート内寸とほぼ同じサイズ
// プラスの値 = 小さくなる（緩くなる）
// マイナスの値 = 大きくなる（きつくなる）
// まずは 0.2 くらいからお試しください。
clearance = 0.2;


// --- ここから下は基本的には変更不要です ---

// USB-Aポートの公称内寸 (mm)
port_width = 12.0;
port_height = 4.5;

// シェルや内部ブロックの概算寸法
shell_thickness = 0.4;
internal_block_height = 2.4;


/**
 * USB-A オス形状の治具を生成するモジュール
 */
module usb_a_male_jig() {
    
    // クリアランスを考慮した治具の寸法
    jig_width = port_width - clearance;
    jig_height = port_height - clearance;

    // 治具本体を生成
    union() {
        // 1. 外殻（U字型のシェル部分）
        difference() {
            // 全体の直方体
            cube([jig_width, jig_height, plug_depth]);
            
            // 内部をくり抜く（下側は開いている形状）
            translate([shell_thickness, shell_thickness, -1]) {
                cube([
                    jig_width - shell_thickness * 2,
                    jig_height, // 高さいっぱいにくり抜く
                    plug_depth + 2
                ]);
            }
        }
        
        // 2. 内部の接点がある部分（単純なブロックで表現）
        translate([shell_thickness, shell_thickness, 0]) {
             cube([
                 jig_width - shell_thickness * 2,
                 internal_block_height,
                 plug_depth
             ]);
        }
    }
}


/**
 * 治具全体のデザイン例
 * 持ちやすいように円柱の土台を追加
 */
// USBプラグ部分の呼び出し
usb_a_male_jig();
