
//$fs = 1.5;
//$fa = 1;

$fs = 2;
$fa = 2;

outer_radius = 60;
thickness = 6;

difference() {
    sphere(r = outer_radius);
    sphere(r = outer_radius - thickness);
}
