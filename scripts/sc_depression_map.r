depression = system.file('extdata/Depression.csv',package = 'gdverse') |>
  readr::read_csv() |>
  sf::st_as_sf(coords = c('X','Y'), crs = 4269)
sc = sf::read_sf('./data/sc.gpkg')

library(tmap)

windowsFonts(SimSun = windowsFont("SimSun"))

d_map = tm_shape(sc) +
  tm_tiles("Esri.WorldTopoMap",zoom = 9) +
  tm_borders(col = "grey50",
             col.legend = tm_legend(title = "Legend",show = TRUE)) +
  tm_shape(depression) +
  tm_dots(fill = "red", size = 0.25) +
  tm_add_legend(title = "县边界",type = 'lines', col = 'grey50', size = 1.25) +
  tm_add_legend(type = "symbols", col = "red", fill = "red",
                title = "抽样调查样本点", size = 0.5) +
  tm_compass(type = 'arrow', position = c("right", "top")) +
  tm_scalebar(position = c(0.75,0.1),lwd = 1.5,text.size = 0.8) +
  tm_layout(legend.stack = 'vertical',
            legend.position = c("left","bottom"),
            legend.title.fontfamily = "SimSun",
            legend.frame = TRUE,
            legend.bg.color = "white",
            legend.bg.alpha = 0.65,
            main.title.position = 'center')
# tmap_save(d_map,'./figure/depression_map.pdf',device = cairo_pdf)
tmap_save(d_map,'./figure/depression_map.jpg',dpi = 300)
