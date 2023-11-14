
//$fs = 1.5;
//$fa = 1;

$fs = 2;
$fa = 2;

outer_radius = 60;
outer_diameter = outer_radius * 2;
thickness = 6;

difference() {
    difference() {
        sphere(r = outer_radius);
        sphere(r = outer_radius - thickness);
    }
    translate([0, 0, -outer_radius])
    cube([outer_diameter, outer_diameter, outer_diameter], center = true);
}
