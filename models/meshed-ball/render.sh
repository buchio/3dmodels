#!/bin/bash

mkdir -p stls
for d in 1 2 3
do
    for t in 1 2 3
    do
        for s in 1 15 20
        do
            if [ ! -e stls/isocahedron_mesh-$t-$d-$s.stl ]
            then
                (openscad -o stls/isocahedron_mesh-$t-$d-$s.stl --D type=$t --D depth=$d -D size=$s isocahedron_mesh.scad &)
            fi
        done
    done
done
