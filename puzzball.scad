
//$fs = 1.5;
//$fa = 1;

$fs = 2;
$fa = 2;

outer_radius = 60 * 2/3;
outer_diameter = outer_radius * 2;
thickness = 6 * 2/3;
groove = thickness / 2;

arc();

module arc() {
    phi = 23.5;
    theta_0 = 10;
    theta_1 = 22.5;
    rotate([0,0,phi])
    rotate([90, 0, 0])
    rotate([0, 0, theta_1 - theta_0])
    rotate_extrude(angle = theta_0)
    translate ([outer_radius, 0, 0])
    square([groove, groove], center = true);
}

// phi --> longitude angle
// theta --> latitude angle

/* difference() {
    hemisphere();
    maze();
}
 */

module maze() {
    theta_arc(45, [0, 23.5]);
}

// an arc phi_0 to phi_1 at latitude theta
module theta_arc(theta, phi_interval) {
    z = cos(theta) * outer_radius;
    x = sin(theta) * outer_radius;
    phi_0 = phi_interval[0];
    phi_1 = phi_interval[1];
    rotate([0, 0, phi_0]) translate([0, 0, z])
        rotate_extrude(angle = phi_1 - phi_0)
            translate ([x, 0, 0])
                rotate(theta) square([groove, groove], center = true);
}

/*
// an arc theta_0 to theta_1 at longitude theta
module phi_arc(phi, theta_interval) {
    z = cos(phi) * outer_radius;
    x = sin(phi) * outer_radius;
    theta_0 = theta_interval[0];
    theta_1 = theta_interval[1];
    rotate([0, 0, theta_0]) translate([0, 0, z])
        rotate_extrude(angle = theta_1 - theta_0)
            translate ([x, 0, 0])
                rotate(theta) square([groove, groove], center = true);
}
*/

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