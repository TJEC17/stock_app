# Create R theme - for dashboard
# https://dreamrs.github.io/fresh/articles/vars-shinydashboard.html

# Dark blue '#003B7F'
# mid blue '#1857F4'
# light blue '#7AD0FF'
# v light blue '#C0EAFE'
# green '#00C3A6'
# purple '#8F76FF'
# yellow "#FDBD13"
# grey '#D6D6CC' -> lighter version #F0F0ED -> darker #24241d
# white '#FFFFFF'
# Black '#000000'

library(fresh)

create_theme(
  # Can use bootstrap vars here too - search_vars_bs
  adminlte_vars(
   well_bg = '#F0F0ED', # sidebarpanel colour
   well_border = '#D6D6CC', # sidebarpanel colour
   link_color = '#003B7F',
   text_color = '#24241d', #dark grey
   font_family_base = "Arial",
   headings_color = "#003B7F", #dark blue # Heading on box text colour
   input_bg = "#FFFFFF", # Text box input background colour
   input_bg_disabled = "#FFFFFF", # File input background colour
   btn_success_border = '#C0EAFE', # hover border on success button
   btn_success_color = '#003B7F', # hover text on success button
   btn_primary_color = '#F0F0ED', # hover text on primary button
   btn_default_color = '#003B7F'
  ),
  
  adminlte_color(
    light_blue = '#003B7F', # equivalent to primary #dark blue
    red = "#8F76FF", # equivalent to danger #purple
    green = '#C0EAFE', # equivalent to success #v light blue
    aqua = "#00C3A6", # equivalent to info #green
    yellow = "#FDBD13", # equivalent to warning #yellow,
    gray_lte = "#D6D6CC"
  ),
  # change the default width of the sidebar as well as its color
  adminlte_sidebar(
    width = "250px",
    dark_bg = "#F0F0ED", # light grey
    dark_hover_bg = "#C0EAFE", # v light blue
    dark_color = "#003B7F", #dark blue
    light_color = "#003B7F", #dark blue
    dark_hover_color = "#003B7F",
    light_bg = "#003B7F",
    dark_submenu_color = "#003B7F",
    dark_submenu_hover_color = "#8F76FF"
  ),
  #  for changing background color of the body itself and boxes
  adminlte_global(
    content_bg = "#FFFFFF",
    box_bg = "#F9F9F7", 
    info_box_bg = "#F0F0ED"
  ),
  
  output_file = "www/dashboard_theme.css"
)

