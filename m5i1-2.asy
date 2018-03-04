// Draw th FSA graph m5i1.png for the ASR course

import arrows_more;
import connectors;
import pens_more;

int num_nodes = 5;  // number of nodes

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

// Draw the circles
path [] cirs;
pair [] ctrs;

ctrs[0] = (0,0);
for (int i = 1; i < num_nodes; ++i) {
    ctrs[i] = (2sep, 1.5sep - (i - 1) * sep);
}
for (int i = 0; i < num_nodes; ++i) {
    cirs[i] = circle(ctrs[i], rad);
    filldraw(cirs[i], fillpen=white, drawpen=pen_cir);
    label(format("$\textbf{%d}$", i), ctrs[i],
        p=Helvetica("m", "n")+fontsize(14pt));
}
draw(circle(ctrs[0], 0.9rad), p=pen_cir);

// Draw the arcs
void draw_arc_with_label(int idx0, real ang0, int idx1, real ang1, Label L) {
    path con = connector(
        cirs[idx0],
        angle2time(cirs[idx0], ang0),
        cirs[idx1],
        angle2time(cirs[idx1], ang1)
    );
    draw(con, arr, margin=marg, p=pen_arr);

    // Draw the label
    pair mid = point(con, 0.5);  // midpoint of connector
    pair tgt = dir(con, 0.5);  // tangent at midpoint
    real rot = Degrees(atan2(tgt.y, tgt.x));  // angle to rotate label
    rot = rot % 180;
    if (rot > 90) rot -= 180;
    pair nrm = rotate(-90) * tgt;  // normal at midpoint
    if (Degrees(atan2(nrm.y, nrm.x)) > 180) nrm = -nrm;
    label(rotate(rot) * L, position=shift(35px*nrm) * mid);
}

int num_arcs = 9;
real a0 = 180 / (num_arcs - 1);  // angle increment for node 0
real ai = 10;  // angle increment for node i (i > 0)
draw_arc_with_label(0,  90 + 0a0, 1, 180 - 1ai, "any");
draw_arc_with_label(1, 180 + 1ai, 0,  90 - 1a0, "thinking");
draw_arc_with_label(0,  90 - 2a0, 2, 180 - 1ai, "some");
draw_arc_with_label(2, 180 + 1ai, 0,  90 - 3a0, "thinking");
draw_arc_with_label(0,  90 - 4a0, 3, 180 - 1ai, "anything");
draw_arc_with_label(3, 180 + 1ai, 0,  90 - 5a0, "king");
draw_arc_with_label(0,  90 - 6a0, 4, 180 - 2ai, "something");
draw_arc_with_label(4, 180 - 0ai, 0,  90 - 7a0, "king");
draw_arc_with_label(0,  90 - 8a0, 4, 180 + 2ai, "thinking");

// Ship it
frame frame_out = bbox(20px, filltype=Fill, p=white);
shipout(frame_out);
