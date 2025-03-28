static const char norm_fg[] = "#ddd2cb";
static const char norm_bg[] = "#0A0101";
static const char norm_border[] = "#9a938e";

static const char sel_fg[] = "#ddd2cb";
static const char sel_bg[] = "#CC0202";
static const char sel_border[] = "#ddd2cb";

static const char urg_fg[] = "#ddd2cb";
static const char urg_bg[] = "#B32C2C";
static const char urg_border[] = "#B32C2C";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
