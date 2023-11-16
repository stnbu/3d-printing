
$fs = 1.5;
$fa = 1;

//$fs = 2;
//$fa = 2;

outer_radius = 60 * 2/3;
outer_diameter = outer_radius * 2;
thickness = 6 * 2/3;
groove = thickness / 2;

difference() {
    hemisphere();
    maze();
}

// maze();
module maze() {
    arc([90, 0, 0]);
    arc([90, 0, 90]);    
}

module arc(a) {
    rotate(a)
    rotate_extrude(angle = 180)
    translate ([outer_radius, 0, 0]) square([groove, groove], center = true);
}

module hemisphere() {
    difference() {
        difference() {
            sphere(r = outer_radius);
            sphere(r = outer_radius - thickness);
        }
        translate([0, 0, -outer_radius])
            cube([outer_diameter, outer_diameter, outer_diameter], center = true);
    }
}