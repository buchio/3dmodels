$fn=50;
use <modules/isocahedron.scad>

depth = 1;
type = 1;
size = 1;

scale(size) isocahedoron_mesh(depth=depth, type=type);
