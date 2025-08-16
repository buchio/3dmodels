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


t=5;
r=3;
h=45;
w=120;
s=100;

rotate([0, -90, 0]) {
    translate([0, 0, 0])
    right_triangle(h, w, r, t);
    translate([0, 0, s-t])
    right_triangle(h, w, r, t);

    translate([r, r, 0]) cylinder(h=s, r=r);
    translate([r, w/2, 0]) cylinder(h=s, r=r);
    translate([r, w-r, 0]) cylinder(h=s, r=r);

    translate([h-r, r, 0]) cylinder(h=s, r=r);
    difference() {
        translate([0, 0, 0]) cube([h-r, r*2, s]);
        translate([0, -r*.05, s/2]) 
            rotate([0, 90, 90]) cylinder(h=r*2.1, r=h-r*2);
    }

    translate([h/2, w/2, 0]) cylinder(h=s, r=r);
    difference()
    {
        translate([0, w/2-r, 0]) cube([h/2, r*2, s]);
        {
            translate([0, w/2-r*1.05, h/2+r/2]) 
                rotate([0, 90, 90]) cylinder(h=r*2.1, r=h/2-r);
            translate([0, w/2-r*1.05, h/2-r*2.25+w/2]) 
                rotate([0, 90, 90]) cylinder(h=r*2.1, r=h/2-r);
        }
    }

    translate([4, w-4.5, 0]) rotate([0, 0, 25]) cube([16, 4, s]);
}