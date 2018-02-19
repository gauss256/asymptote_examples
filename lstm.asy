// Attempt to replicate drawing in Colah LSTM blog
// http://colah.github.io/posts/2015-08-Understanding-LSTMs/img/RNN-rolled.png

import roundedpath;

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

// Create a connector between two paths based on centers
path connector(path path0, pair c0, path path1, pair c1) {
    path c0c1 = c0 -- c1;
    real [] i0 = intersect(path0, c0c1);
    real [] i1 = intersect(path1, c0c1);
    pair p0 = point(path0, i0[0]);
    pair p1 = point(path1, i1[0]);

    return p0 -- p1;
}

// Fixed dimensions are in big points (1 bp = 1/72 inches)
settings.render = 300 / 72;  // 300 DPI
real px = 72 / 300;  // 72 bp = 300 px

pen pen_box = linewidth(4px);
pen pen_lin = linewidth(10px)+linecap(0);
pen pen_cir = linewidth(6px);

margin marg = TrueMargin(-4px, 8px);  // a bit empirical

pen pen_blu = rgb(162, 205, 236);
pen pen_grn = rgb(225, 247, 208);
pen pen_ppl = rgb(219, 172, 238);

// Neural network chunk
pair nnc_c = (0,0);
real w = 250px;
real h = 150px;
path nnc = box((-w/2, -h/2), (w/2, h/2));  // centered at origin

// Loopback
real lpb_w = 445px;
real lpb_h = 136px;
path lpb = roundedpath(box((0,0),(lpb_w,lpb_h)), 20px);
lpb = shift(-lpb_w/2,0) * lpb;

// Find the intersection points
real[][] ints = intersections(lpb, nnc);
real int_0 = ints[0][0];
real int_1 = ints[1][0];
path lpb_sub = subpath(lpb, int_0, int_1);

// Top circle
real all_rad = 124px / 2;
pair ctr_top = (0, 352px-all_rad);
path cir_top = circle(ctr_top, all_rad);

// Bottom circle
pair ctr_bot = (0, -352px+all_rad);
path cir_bot = circle(ctr_bot, all_rad);

// Connectors
path con_top = connector(nnc, nnc_c, cir_top, ctr_top);
path con_bot = connector(cir_bot, ctr_bot, nnc, nnc_c);

// Break in loopback to indicate it's behind
real brk_siz = 30px;
pair brk_sz2 = (brk_siz/2, brk_siz/2);
pair brk_ctr = intersectionpoint(lpb, con_top);
path brk_p = shift(brk_ctr-brk_sz2) * box((0,0), (brk_siz,brk_siz));

// Draw the paths and labels
filldraw(nnc, drawpen=pen_box, fillpen=pen_grn);
label("A",
      (0,0),
      p=Helvetica("m", "n")+fontsize(24pt));

draw(lpb_sub,
     Arrow(TriangleHead, angle=30, size=38px),
     p=pen_lin, margin=marg);
filldraw(brk_p, drawpen=nullpen, fillpen=white);

filldraw(cir_top, drawpen=pen_cir, fillpen=pen_ppl);
label("$\mathbf{h}_t$",
      ctr_top,
      p=fontsize(16pt));

filldraw(cir_bot, drawpen=pen_cir, fillpen=pen_blu);
label("$\mathbf{X}_t$",
      ctr_bot,
      p=fontsize(16pt));

draw(con_top,
     Arrow(TriangleHead, angle=30, size=38px),
     p=pen_lin, margin=marg);

draw(con_bot,
     Arrow(TriangleHead, angle=30, size=38px),
     p=pen_lin, margin=marg);

frame frame_out = bbox(20px, filltype=Fill, p=rgb(255, 255, 255));
shipout(frame_out);
