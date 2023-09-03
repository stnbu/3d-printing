/*
A `sign` consists of two `side`s, each symmetrical about the `y` axis and therefore represented as `half` a `side` 

The `half` is mirrored and printed, creating one `side` of a `sign`.

At the top is the `handle`, below which is the `handle_opening`. At the base there is a `void` between the feet. The `handle_width` is less than the `foot_width`.

The edges of the `side`s, `handle_opening`, and `void` between the feet have a small raised `welt` for stiffness and esthetics.

Collectively, anything that makes a hole in the `side` are `holes`, which are a `union()` so they can be `difference()`'ed from the `side`.
*/

handle_width = 90;
height = 230;
foot_width = 115;

for (n = [1, -1]) {
    polygon([
        [0, 0],
        [n * handle_width / 2, 0],
        [n * foot_width / 2, height],
        [0, height],
    ]);
}