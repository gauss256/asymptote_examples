// Attempt to replicate drawing in Colah LSTM blog
// http://colah.github.io/posts/2015-08-Understanding-LSTMs/img/RNN-rolled.png

import roundedpath;

import arrows_more;
import connectors;
import pens_more;

// Fixed dimensions are in big points (1 bp = 1/72 inches)
settings.render = 300 / 72;  // 300 DPI
real px = 72 / 300;  // 72 bp = 300 px
real u = 2px;  // user units, let's us change scale

// Create a box centred at the origin
path cbox(real w, real h) {
    return box((-w/2, -h/2), (w/2, h/2));
}

// ------------------
// Define the objects
// ------------------

// Big box
pen pen_bbf = rgb256(225, 247, 208);  // fill
pen pen_bbd = rgb256(109, 134,  90);  // draw
pen pen_bbl = linewidth(5u);  // linewidth
real bbw = 328u;  // width
real bbh = 205u;  // height
pair bbs = (bbw, bbh);  // size
real bbr = 20u;  // radius of rounded corners
path bbp = roundedpath(box((0,0), (bbw, bbh)), bbr);  // path

// Sigma box
pen pen_sbf = rgb256(245, 238, 156);  // fill
pen pen_sbd = rgb256(0, 0, 0);  // draw
real bsw = 36u;  // width
real bsh = 21u;  // height
pair bsc = (27u, 52u);  // corner
pen pen_bsl = linewidth(5u);  // linewidth
path sbp = shift(bsc) * box((0,0), (bsw, bsh));

// ----------------
// Draw the objects
// ----------------

filldraw(bbp, drawpen=pen_bbd, fillpen=pen_bbf);
filldraw(sbp, drawpen=pen_sbd, fillpen=pen_sbf);
label("$\sigma$", bsc + (bsw, bsh) / 2);

// pen pen_box = linewidth(5px);
// pen pen_lin = linewidth(10px)+linecap(0)+linejoin(0);
// pen pen_cir = linewidth(6px);

// margin marg = TrueMargin(-4px, 12px);  // a bit empirical

// pen pen_blu = rgb256(162, 205, 236);
// pen pen_grn = rgb256(225, 247, 208);
// pen pen_ppl = rgb256(219, 172, 238);

// arrowbar arr = Arrow(TriangleHead, angle=30, size=30px);

// // Neural network chunk
// pair nnc_c = (0,0);
// real w = 250px;
// real h = 150px;
// path nnc = box((-w/2, -h/2), (w/2, h/2));  // centered at origin

// // Loopback
// real lpb_w = 445px;
// real lpb_h = 136px;
// path lpb = roundedpath(box((0,0),(lpb_w,lpb_h)), 20px);
// lpb = shift(-lpb_w/2,0) * lpb;

// // Find the intersection points
// real[][] ints = intersections(lpb, nnc);
// real int_0 = ints[0][0];
// real int_1 = ints[1][0];
// path lpb_sub = subpath(lpb, int_0, int_1);

// // Top circle
// real all_rad = 124px / 2;
// pair ctr_top = (0, 352px-all_rad);
// path cir_top = circle(ctr_top, all_rad);

// // Bottom circle
// pair ctr_bot = (0, -352px+all_rad);
// path cir_bot = circle(ctr_bot, all_rad);

// // Connectors
// path con_top = connector(nnc, nnc_c, cir_top, ctr_top);
// path con_bot = connector(cir_bot, ctr_bot, nnc, nnc_c);

// // Break in loopback to indicate it's behind
// real brk_siz = 30px;
// pair brk_sz2 = (brk_siz/2, brk_siz/2);
// pair brk_ctr = intersectionpoint(lpb, con_top);
// path brk_p = shift(brk_ctr-brk_sz2) * box((0,0), (brk_siz,brk_siz));

// // Draw the paths and labels
// filldraw(nnc, drawpen=pen_box, fillpen=pen_grn);
// label("A", (0,0), p=Helvetica("m", "n")+fontsize(25pt));

// draw(lpb_sub, arr, p=pen_lin, margin=marg);
// filldraw(brk_p, drawpen=nullpen, fillpen=white);

// filldraw(cir_top, drawpen=pen_cir, fillpen=pen_ppl);
// label("$\mathbf{h}_t$", ctr_top, p=fontsize(16pt));

// filldraw(cir_bot, drawpen=pen_cir, fillpen=pen_blu);
// label("$\mathbf{X}_t$", ctr_bot, p=fontsize(16pt));

// draw(con_top, arr, p=pen_lin, margin=marg);

// draw(con_bot, arr, p=pen_lin, margin=marg);

frame frame_out = bbox(20px, filltype=Fill, p=rgb(255, 255, 255));
shipout(frame_out);
