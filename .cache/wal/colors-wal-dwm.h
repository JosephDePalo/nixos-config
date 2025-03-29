static const char norm_fg[] = "#e8cac0";
static const char norm_bg[] = "#25243e";
static const char norm_border[] = "#a28d86";

static const char sel_fg[] = "#e8cac0";
static const char sel_bg[] = "#5566A5";
static const char sel_border[] = "#e8cac0";

static const char urg_fg[] = "#e8cac0";
static const char urg_bg[] = "#435BB1";
static const char urg_border[] = "#435BB1";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
