static const char norm_fg[] = "#d8d5bf";
static const char norm_bg[] = "#0C1419";
static const char norm_border[] = "#979585";

static const char sel_fg[] = "#d8d5bf";
static const char sel_bg[] = "#CC6F36";
static const char sel_border[] = "#d8d5bf";

static const char urg_fg[] = "#d8d5bf";
static const char urg_bg[] = "#9E5531";
static const char urg_border[] = "#9E5531";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
