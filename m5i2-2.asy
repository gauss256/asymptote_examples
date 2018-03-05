// Draw the FST graph m5i2.png for the ASR course

import arrows_more;
import connectors;
import pens_more;

int num_nodes = 12;  // number of nodes

// Figure parameters
settings.render = 300 / 72;  // 300 DPI
real px = 72 / 300;  // 72 bp = 300 px

pen pen_arr = linewidth(4px) + linejoin(0);
pen pen_cir = linewidth(4px);

real mar = (linewidth(pen_arr) + linewidth(pen_cir)) / 2;
margin marg = TrueMargin(mar, mar);  // = (pen_arr + pen_cir) / 2

arrowbar arr = Arrow(TriangleHead, angle=30, size=25px);
arrowbar arrs = Arrows(TriangleHead, angle=30, size=25px);

// Drawing parameters
real rad = 100px;
real sep = 4 * rad;
real sep_col = 6 * rad;
real sep_row = 3 * rad;

// Lay out the nodes on an {x, y} grid
pair[] nods;
nods[0]  = (0,  0);
nods[4]  = (1,  2);
nods[8]  = (2,  2);
nods[11] = (3,  2);
nods[1]  = (1,  1);
nods[5]  = (2,  1);
nods[9]  = (3,  1);
nods[3]  = (4,  0);
nods[2]  = (1, -1);
nods[6]  = (2, -1);
nods[10] = (3, -1);
nods[7]  = (5, -2);

// Draw the circles
path [] cirs;
pair [] ctrs;
for (int i = 0; i < num_nodes; ++i) {
    real ctr_x = nods[i].x * sep_col;
    real ctr_y = nods[i].y * sep_row;
    ctrs[i] = (ctr_x, ctr_y);
    cirs[i] = circle(ctrs[i], rad);
    filldraw(cirs[i], fillpen=white, drawpen=pen_cir);
    label(format("$\textbf{%d}$", i), ctrs[i],
        p=Helvetica("m", "n")+fontsize(14pt));
}
draw(circle(ctrs[0], 0.9rad), p=pen_cir);

// Draw arc with label
void drawl(int idx0, real ang0, int idx1, real ang1, Label L, bool rev=false) {
    if (rev) {
        int temp_i = idx1;
        idx1 = idx0;
        idx0 = temp_i;
        real temp_a = ang1;
        ang1 = ang0;
        ang0 = temp_a;
    }
    path con = connector(
        cirs[idx0],
        angle2time(cirs[idx0], ang0),
        cirs[idx1],
        angle2time(cirs[idx1], ang1)
    );
    draw(con, arr, margin=marg, p=pen_arr);

    // Draw the label
    real aln = arclength(con);
    real time_mid = arctime(con, aln / 2);
    pair mid = point(con, time_mid);  // midpoint of connector
    pair tgt = dir(con, time_mid);  // tangent at midpoint
    real rot = Degrees(atan2(tgt.y, tgt.x));  // angle to rotate label
    rot = rot % 180;
    if (rot > 90) rot -= 180;
    pair nrm = rotate(-90) * tgt;  // normal at midpoint
    if (Degrees(atan2(nrm.y, nrm.x)) > 180) nrm = -nrm;
    label(
        rotate(rot) * L,
        position=shift(40px * nrm) * mid,
        p=Helvetica("m", "n")+fontsize(12pt));
}

int num_arcs = 7;
real a0 = 180 / (num_arcs - 1);  // angle increment for node 0
string eps_pre(string s) {
    return "$<$eps$>$:" + s;
}
string eps_pst(string s) {
    return s + ":$<$eps$>$";
}
drawl( 0, 90 - 0a0, 11, 135, eps_pre("any"), rev=true);
drawl( 0, 90 - 1a0,  4, 225, eps_pst("EH"));
drawl( 0, 90 - 2a0,  1, 225, "TH:thinking");
drawl( 0, 90 - 3a0,  3, 180, "K:king");
drawl( 0, 90 - 4a0,  2, 135, eps_pst("S"));
drawl( 0, 90 - 5a0, 10, 225, eps_pre("some"), rev=true);
drawl( 0, 90 - 6a0,  7, 180, eps_pst("NG"), rev=true);
drawl( 4, 0,  8, 180, eps_pst("N"));
drawl( 1, 0,  5, 180, eps_pst("IH"));
drawl( 2, 0,  6, 180, eps_pst("AH"));
drawl( 8, 0, 11, 180, eps_pst("IY"));
drawl( 5, 0,  9, 180, eps_pst("NG"));
drawl( 6, 0, 10, 180, eps_pst("M"));
drawl(11, 0,  3,  90, "TH:anything");
drawl( 9, 0,  3, 135, eps_pst("K"));
drawl(10, 0,  3, 225, "TH:something");
drawl( 3, 315, 7, 135, eps_pst("IH"));

// Ship it
frame frame_out = bbox(20px, filltype=Fill, p=white);
shipout(frame_out);
