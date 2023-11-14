// Declare pi constant
pi = 3.14159265359;

// Function to generate the nth point on a "chubby" curve between 0 and 1
function nth_point(i, n) = 
    let(t = i / n)
    let(dx = t)
    let(dy = 0.05 * sin(t * pi))
    [dx, dy];

// Generate curve between A and B
n = 50;
A = [0, 0];
B = [20, 0];
AB_diff = [B[0] - A[0], B[1] - A[1]];

// Looping to calculate the points along the curve
points = [ for(i = [0:n-1]) let(p = nth_point(i, n)) [A[0] + p[0] * AB_diff[0], A[1] + p[1] * AB_diff[1]] ];

echo(points);

// Generate curves for a chubby rectangle
top_points = [ for(i = [0:n-1]) let(p = nth_point(i, n)) [p[0] * 20, 10 + p[1]] ];

all_points = top_points;

// Draw the chubby rectangle
for(i = [1:len(all_points)-1])
{
    hull() {
        translate(all_points[i-1]) circle(0.1);
        translate(all_points[i]) circle(0.1);
    }
}
