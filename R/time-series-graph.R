time_series_graph <- function(data, response, title) {
  plot <- ggplot(data = data, mapping = aes(x = Year, y = est, group = Officer_or_Rank, col = Officer_or_Rank)) +
    geom_line(linewidth = 1) + 
    scale_y_continuous(breaks = seq(0,100,10), limits = c(0,100), expand = c(0,0)) +
    scale_x_discrete(name = NULL, expand = c(0,0)) +
    expand_limits(y = 0) +
    ggtitle(paste0("% ", response, title)) +
    theme(
      axis.text = element_text(colour = "grey", family = "Arial"),
      axis.line = element_line(colour = "grey"),
      axis.ticks = element_line(colour = "grey"),
      axis.title = element_blank(),
      plot.background = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_blank(),
      plot.title = element_text(hjust = 0, size = 11, margin = margin(l= -1, unit = "cm"))
    )
  return(plot)
}
