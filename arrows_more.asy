// Adapted from SimpleHead
arrowhead TriangleHead;
TriangleHead.head=new path(path g, position position=EndPoint,
                           pen p=currentpen, real size=0,
                           real angle=arrowangle) {
    if (size == 0) {
        size = TriangleHead.size(p);
    }
    bool relative = position.relative;
    real position = position.position.x;
    if (relative) {
        position = reltime(g, position);
    }
    path r = subpath(g, position, 0);
    // r = shift(-linewidth()*4,0) * r;  //??? why 4 and not 2?
    pair x = point(r, 0);
    real t = arctime(r, size);
    path left = rotate(-angle, x) * r;
    path right = rotate(angle, x) * r;
    return subpath(left,t,0)--subpath(right,0,t)--cycle;
};
