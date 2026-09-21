# Custom visualization wrappers for Biology-Informed Multiomics Training

#' Create a custom EnrichedHeatmap with dynamic color scaling
#' This function includes `na.rm = TRUE` to allow ignore missing data, e.g., from WGBS matrices
#'
#' @param norm_mat A normalized matrix created by EnrichedHeatmap::normalizeToMatrix()
#' @param hm_name String, title of the heatmap
#' @param split_rows A vector or factor to split the rows of the heatmap
#' @param heatmap_cols A vector of colors for the color gradient (automatically handles 2, 3, or more colors)
#' @param col_fill String, background color for the column title
#' @param line_colors Vector of colors for the top annotation density lines
#' @param hm_width The physical or relative width of the heatmap (defaults to grid::unit(1, "null") for proportional layout)
#' @param hm_height The physical or relative height of the heatmap
#' @param top_anno_height Height of the top profile annotation block
custom_enrichedheatmap_plotting <- function(
  norm_mat, 
  hm_name, 
  split_rows = NULL,
  heatmap_cols = c("white", "red"), 
  col_fill = "white", 
  line_colors = NULL,
  hm_width = grid::unit(1, "null"), 
  hm_height = NULL, 
  top_anno_height = grid::unit(1.5, "cm")) {

  # Calculate the heavy math exactly ONCE (1st and 99th percentiles)
  vmin <- as.numeric(stats::quantile(norm_mat, c(0.01), na.rm = TRUE))
  vmax <- as.numeric(stats::quantile(norm_mat, c(0.99), na.rm = TRUE))
  
  # Calculate midpoint purely for the 3 visual legend ticks
  vmid <- (vmin + vmax) / 2
  legend_ticks <- c(vmin, vmid, vmax)

  # Dynamically generate exactly enough anchor points to match the palette size!
  color_breaks <- seq(from = vmin, to = vmax, length.out = length(heatmap_cols))

  # Feed the pre-calculated anchor points directly into the color scale
  col_fun <- circlize::colorRamp2(breaks = color_breaks, colors = heatmap_cols)

  # 4. Generate and return the heatmap
  EnrichedHeatmap::EnrichedHeatmap(
    mat = norm_mat, 
    name = hm_name, 
    width = hm_width, 
    height = hm_height, 
    row_split = split_rows, 
    row_title = NULL, 
    col = col_fun, 
    column_title = hm_name, 
    column_title_gp = grid::gpar(fontsize = 10, fill = col_fill), 
    axis_name = c("-1kb", "mid", "1kb"), 
    heatmap_legend_param = list(
      at = legend_ticks, 
      labels = round(legend_ticks, digits = 1), 
      title_gp = grid::gpar(fontsize = 8), 
      labels_gp = grid::gpar(fontsize = 7)
    ), 
    top_annotation = ComplexHeatmap::HeatmapAnnotation(
      lines = EnrichedHeatmap::anno_enriched(
        height = top_anno_height, 
        axis_param = list(facing = "inside"), 
        gp = grid::gpar(col = line_colors)
      )
    )
  )
}