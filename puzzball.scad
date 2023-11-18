
$fs = 1.5;
$fa = 1;

//$fs = 2;
//$fa = 2;

outer_radius = 60 * 2/3;
outer_diameter = outer_radius * 2;
thickness = 6 * 2/3;
groove = thickness / 2;

// phi --> longitude angle
// theta --> latitude angle

difference() {
    hemisphere();
    maze();
}

module maze() {
    phi_arc(45);
}

module phi_arc(theta) {
    z = cos(theta) * outer_radius;
    x = sin(theta) * outer_radius;;
    translate([0, 0, z])
        rotate_extrude(angle = 360)
            translate ([x, 0, 0])
                rotate(theta) square([groove, groove], center = true);
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