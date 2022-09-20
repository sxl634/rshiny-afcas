time_series_graph <- function(data) {
  plot <- ggplot(data = data, mapping = aes(x = Year, y = est, group = Officer_or_Rank, col = Officer_or_Rank)) +
    geom_line(size = 1) + 
    scale_y_continuous(name = NULL, breaks = seq(0,100,10), limits = c(0,100), expand = c(0,0)) +
    scale_x_discrete(name = NULL, expand = c(0,0)) +
    expand_limits(y = 0) +
    scale_fill_discrete(guide="none") +
    theme(
      legend.position = "none",
      axis.text = element_text(colour = "grey", family = "Arial"),
      axis.line = element_line(colour = "grey"),
      axis.ticks = element_line(colour = "grey"),
      axis.title = element_blank(),
      plot.background = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_blank()
    )
  return(plot)
}
