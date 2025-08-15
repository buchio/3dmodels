module right_triangle(side1,side2,corner_radius,triangle_height){
    translate([corner_radius,corner_radius,0]){  
        hull(){  
        cylinder(r=corner_radius,h=triangle_height);
          translate([side1 - corner_radius * 2,0,0])cylinder(r=corner_radius,h=triangle_height);
              translate([0,side2 - corner_radius * 2,0])cylinder(r=corner_radius,h=triangle_height);  
        }
    }
}
$fn=20;
translate([0, 0, -7])
right_triangle(9, 18, .5, 1);
translate([0, 0, 7])
right_triangle(9, 18, .5, 1);