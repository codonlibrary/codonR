#' NHS Digital core colours
#'
#' A large selection of NHS digital core colours, selected from
#' https://digital.nhs.uk/about-nhs-digital/corporate-information-and-documents/nhs-digital-style-guidelines/how-we-look/colour-palette
#'
#' @export
nhsd_core_colours = c(
  "chart_grey_3" = "#F8F8F8",
  "white" = "#FFFFFF",
  "white_tints" = c("#F9FAFB", "#F3F5F6", "#EDEFF1", "#DEF2E5"),
  "nhs_blue" = "#005EB8",
  "blue_tints" = c("#337EC6", "#ACCAE8", "#D4E4F3", "#E6EFF8"),
  "nhs_dark_grey" = "#425563",
  "grey_tints" = c(
    "#687784",
    "#98A4AD",
    "#B3BBC1",
    "#DFE2E5",
    "#EDEFF1",
    "#F3F5F6",
    "#F9FAFB"
  ),
  "nhs_mild_grey" = "#768692",
  "nhs_warm_yellow" = "#FFB81C",
  "warm_yellow_tints" = c("#FFE8B4", "#FFF1CC", "#FFF8E8")
)


#' NHS Digital chart colours
#'
#' A list of chart colours constructed from the NHS colour palette.
#' Contains the values "light blue", "blue", "dark blue", "warm yellow", "light grey", "grey" and "dark grey".
#'
#' @export
nhsd_chart_colours = c(
  `light blue` = "#71CCEF",
  `blue` = "#005EB8",
  `dark blue` = "#003087",
  `warm yellow` = "#FFB81C",
  `light grey` = "#D0D5D6",
  `grey` = "#84919C",
  `dark grey` = "#425563"
)


nhsd_cols <- function(...) {
  cols <- c(...)
  if (is.null(cols)) {
    return (nhsd_chart_colours)
  }
  nhsd_chart_colours[cols]
}

nhsd_palettes <- list(
  `main` = nhsd_cols("warm yellow", "blue", "light blue", "dark blue"),

  `blue` = nhsd_cols("light blue", "blue", "dark blue"),

  `grey` = nhsd_cols("light grey", "grey", "dark grey")
)

nhsd_pal <- function(palette = "main", reverse = FALSE, ...) {
  pal <- nhsd_palettes[[palette]]
  if (reverse) {
    pal <- rev(pal)
  }
  grDevices::colorRampPalette(pal, ...)
}

#' NHSD colour scale
#'
#' A ggplot compatible colour palette for producing NHS digital graphs.
#'
#' @param pallette Which colour palette to use, can be "main", "blue", "grey" (default: "main")
#' @param discrete Whether this scale is discrete or continuous (default: TRUE)
#' @param reverse Whether to reverse the scale (default: FALSE)
#' @return A colour pallette, to be added to a ggplot plot object
#'
#' @examples
#' library(gapminder)
#'
#' countries <- c("United Kingdom", "China", "Gambia")
#'
#' gapminder %>%
#'   filter(country %in% countries) %>%
#'   ggplot(aes(year, lifeExp, colour=country)) +
#'   geom_smooth(se = FALSE) +
#'   labs(
#'     title = "Life expectancy",
#'     x = "Year",
#'     y = "Expectancy",
#'     caption = "Source: gapminder (2020)"
#'     ) +
#'   theme_minimal() +
#'   scale_colour_nhsd("blue") +
#'   ggsave("test.png",
#'          type = "cairo",
#'          width = 7,
#'          height = 4,
#'   )
#'
#' @aliases scale_color_nhsd
#' @export
scale_colour_nhsd <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- nhsd_pal(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("colour", paste0("nhsd_", palette), palette = pal, ...)
  } else {
    ggplot2::scale_color_gradientn(colours = pal(256), ...)
  }
}

#' @export
scale_color_nhsd <- scale_colour_nhsd

#' NHSD fill scale
#'
#' A ggplot compatible colour palette for producing NHS digital graphs.
#'
#' @param pallette Which colour palette to use, can be "main", "blue", "grey" (default: "main")
#' @param discrete Whether this scale is discrete or continuous (default: FALSE)
#' @param reverse Whether to reverse the scale (default: FALSE)
#' @return A colour pallette
#'
#' @examples
#' ggplot(faithfuld, aes(waiting, eruptions)) +
#'     geom_raster(aes(fill = density)) +
#'     theme_minimal() +
#'     scale_fill_nhsd(discrete=FALSE, reverse=TRUE)
#'
#' @export
scale_fill_nhsd <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- nhsd_pal(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("fill", paste0("nhsd_", palette), palette = pal, ...)
  } else {
    ggplot2::scale_fill_gradientn(colours = pal(256), ...)
  }
}