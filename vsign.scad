/*
A `sign` consists of two `side`s, each symmetrical about the `y` axis and therefore represented as `half` a `side` 

The `half` is mirrored and printed, creating one `side` of a `sign`.

At the top is the `handle`, below which is the `handle_opening`. At the base there is a `void` between the feet. The `handle_width` is less than the `foot_width`.

The edges of the `side`s, `handle_opening`, and `void` between the feet have a small raised `welt` for stiffness and esthetics.

Collectively, anything that makes a hole in the `side` are `holes`, which are a `union()` so they can be `difference()`'ed from the `side`.
*/

 $fs = 0.1;
 $fa = 1;


handle_width = 90 * 0.439 + (6.8045 * 2);
foot_width = 115 * 0.439;
handle_radius = 5.5 * 0.439;

height = 230 * 0.439;

handle_hole_width = (15.5 * 0.439 + 6.585) * 2;
handle_hole_height = 6.585;
void_width = (21.5 * 0.439 + 6.585) * 2;
void_height = 6.585;

swing_angle = 15;

/*

side();

module side() difference() {
    with_handle();
    handle_cutter();
}

module with_handle() union() {
    linear_extrude(height = 1.2, center = true) difference() {
        blank();
        holes();
    }
    rotate([0, 90, 0]) cylinder(h = handle_width, r = handle_radius, center = true);
}

module handle_cutter() rotate([-swing_angle, 0, 0]) {
    translate([0, 0, -handle_radius / 2])
        cube([handle_width * 1.1, handle_radius * 5, handle_radius], center = true);
}

module blank() {
    union() {
        half();
        mirror([1, 0, 0]) half();
    }
}

*/

// half();

half();

module half() {
    difference() {
        union() {
            blank();
            half_handle();
        }
        handle_cutter();
    }
}

module half_handle() {
    rotate([0, 90, 0]) cylinder(h = handle_width / 2, r = handle_radius);
}

module handle_cutter() rotate([-swing_angle, 0, 0]) {
    translate([0, 0, -handle_radius / 2])
        cube([handle_width * 1.1 / 2, handle_radius * 5, handle_radius]);
}

module blank() {
    linear_extrude(height = 1.2, center = true) difference() {
        polygon([
            [0, 0],
            [handle_width / 2, 0],
            [foot_width / 2, height],
            [0, height],
            [0, 0],
        ]);
        holes();
    }
}

module holes() {
    union() {
        quarter_rounded_half_slot(handle_hole_width / 2, handle_hole_height);
        translate([0, height, 0]) mirror([0, 1, 0])
            quarter_rounded_half_slot(void_width / 2, void_height);
    }
}

module quarter_rounded_half_slot(width, height) {
    union() {
        square([width - height, height]);
        translate([width - height, 0, 0]) circle(height);
    }
}