const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0c121a", /* black   */
  [1] = "#D3A979", /* red     */
  [2] = "#697988", /* green   */
  [3] = "#987780", /* yellow  */
  [4] = "#58949F", /* blue    */
  [5] = "#46A8AF", /* magenta */
  [6] = "#62B2B1", /* cyan    */
  [7] = "#d8c8bc", /* white   */

  /* 8 bright colors */
  [8]  = "#978c83",  /* black   */
  [9]  = "#D3A979",  /* red     */
  [10] = "#697988", /* green   */
  [11] = "#987780", /* yellow  */
  [12] = "#58949F", /* blue    */
  [13] = "#46A8AF", /* magenta */
  [14] = "#62B2B1", /* cyan    */
  [15] = "#d8c8bc", /* white   */

  /* special colors */
  [256] = "#0c121a", /* background */
  [257] = "#d8c8bc", /* foreground */
  [258] = "#d8c8bc",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
