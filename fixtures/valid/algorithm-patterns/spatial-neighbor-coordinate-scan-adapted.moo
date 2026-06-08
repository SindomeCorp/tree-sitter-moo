":neighbor_offsets_3d(LIST coords, INT radius) => LIST";
"Called by spatial helpers to produce nearby coordinate offsets before resolving them to rooms.";
{coords, radius} = args;
neighbors = {};
for axis in [1..3]
  for offset in [0 - radius..radius]
    if (offset == 0)
      continue;
    endif
    candidate = coords;
    candidate[axis] = coords[axis] + offset;
    neighbors = setadd(neighbors, candidate);
  endfor
endfor
return neighbors;
