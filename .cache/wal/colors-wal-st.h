const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0A0101", /* black   */
  [1] = "#B32C2C", /* red     */
  [2] = "#CC0202", /* green   */
  [3] = "#F40301", /* yellow  */
  [4] = "#E62D1B", /* blue    */
  [5] = "#E65930", /* magenta */
  [6] = "#F7B242", /* cyan    */
  [7] = "#ddd2cb", /* white   */

  /* 8 bright colors */
  [8]  = "#9a938e",  /* black   */
  [9]  = "#B32C2C",  /* red     */
  [10] = "#CC0202", /* green   */
  [11] = "#F40301", /* yellow  */
  [12] = "#E62D1B", /* blue    */
  [13] = "#E65930", /* magenta */
  [14] = "#F7B242", /* cyan    */
  [15] = "#ddd2cb", /* white   */

  /* special colors */
  [256] = "#0A0101", /* background */
  [257] = "#ddd2cb", /* foreground */
  [258] = "#ddd2cb",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
