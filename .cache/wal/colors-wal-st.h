const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0C1419", /* black   */
  [1] = "#9E5531", /* red     */
  [2] = "#CC6F36", /* green   */
  [3] = "#9E6D4C", /* yellow  */
  [4] = "#678E78", /* blue    */
  [5] = "#E1A35A", /* magenta */
  [6] = "#D5B064", /* cyan    */
  [7] = "#d8d5bf", /* white   */

  /* 8 bright colors */
  [8]  = "#979585",  /* black   */
  [9]  = "#9E5531",  /* red     */
  [10] = "#CC6F36", /* green   */
  [11] = "#9E6D4C", /* yellow  */
  [12] = "#678E78", /* blue    */
  [13] = "#E1A35A", /* magenta */
  [14] = "#D5B064", /* cyan    */
  [15] = "#d8d5bf", /* white   */

  /* special colors */
  [256] = "#0C1419", /* background */
  [257] = "#d8d5bf", /* foreground */
  [258] = "#d8d5bf",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
