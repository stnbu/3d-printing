
$fs = 1.5;
$fa = 1;

outer_radius = 60 * 2/3;
outer_diameter = outer_radius * 2;
thickness = 6 * 2/3;
groove = thickness / 2;

// phi --> longitude angle
// theta --> latitude angle

difference() {
    iball();
    maze();
}

module maze() {
    theta_arc(45, [0, 23.5]);
    phi_arc(23.5, [10, 43]);
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

module phi_arc(phi, theta_interval) {
    theta_0 = theta_interval[0];
    theta_1 = theta_interval[1];
    rotate([0, 0, phi])
        rotate([90, 0, 0])
            rotate([0, 0, theta_1 - theta_0])
                rotate_extrude(angle = theta_0)
                    translate ([outer_radius, 0, 0])
                        square([groove, groove], center = true);
}

module iball() {
    difference() {
        sphere(r = outer_radius);
        sphere(r = outer_radius - thickness);
    }
}