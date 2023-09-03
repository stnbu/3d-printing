/*
A `sign` consists of two `side`s, each symmetrical about the `y` axis and therefore represented as `half` a `side` 

The `half` is mirrored and printed, creating one `side` of a `sign`.

At the top is the `handle`, below which is the `handle_opening`. At the base there is a `void` between the feet. The `handle_width` is less than the `foot_width`.

The edges of the `side`s, `handle_opening`, and `void` between the feet have a small raised `welt` for stiffness and esthetics.

Collectively, anything that makes a hole in the `side` are `holes`, which are a `union()` so they can be `difference()`'ed from the `side`.
*/

s = 5;
handle_width = 18 * s;
height = 46 * s;
foot_width = 23 * s;

handle_radius = s * 1.1;

difference() {
    with_handle();
    handle_cutter();
}

module with_handle() union() {
    linear_extrude(height = s, center = true) difference() {
        blank();
        holes();
    }
    rotate([0, 90, 0]) cylinder(h = handle_width, r = handle_radius, center = true);
}

module handle_cutter() rotate([-22, 0, 0]) {
    translate([0, 0, -handle_radius / 2])
        cube([handle_width * 1.1, handle_radius * 5, handle_radius], center = true);
}

module blank() {
    for (n = [1, -1]) {
        polygon([
            [0, 0],
            [n * handle_width / 2, 0],
            [n * foot_width / 2, height],
            [0, height],
        ]);
    }
}

module holes() difference() {
    union() {
        hull() for (n = [1, -1]) {
            translate([n * s * 3.1, 0, 0]) circle(s * 3);
        }
        hull() for (n = [1, -1]) {
            translate([n * s * 4.3, height, 0]) circle(s * 3);
        }
    }
}