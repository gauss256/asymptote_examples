
// Create a connector between two paths based on centers
path connector(path path0, pair c0, path path1, pair c1) {
    path c0c1 = c0 -- c1;
    real [] i0 = intersect(path0, c0c1);
    real [] i1 = intersect(path1, c0c1);
    pair p0 = point(path0, i0[0]);
    pair p1 = point(path1, i1[0]);

    return p0 -- p1;
}
