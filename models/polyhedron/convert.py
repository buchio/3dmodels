#!/usr/bin/env python3

import sys

with open(sys.argv[1], 'r') as f:
    data = {}
    step = 0
    for l in f.readlines():
        ls = l.split()
        if len(ls) == 1:
            num_of_lines = int(ls[0])
            step += 1
        else:
            if step == 1:
                if 'AdjacencyVertices' not in data:
                    data['AdjacencyVertices'] = []
                data['AdjacencyVertices'].append([int(x)-1 for x in ls][2:])
            if step == 2:
                if 'AroundFaces' not in data:
                    data['AroundFaces'] = []
                data['AroundFaces'].append([int(x)-1 for x in ls][2:])
            if step == 3:
                if 'FaceVertices' not in data:
                    data['FaceVertices'] = []
                data['FaceVertices'].append([int(x)-1 for x in ls][2:])
            if step == 4:
                if 'Coordinates' not in data:
                    data['Coordinates'] = []
                data['Coordinates'].append([float(x) for x in ls][1:])
    print(f"polyhedron( points = {data['Coordinates']}, faces = {data['FaceVertices']});")
