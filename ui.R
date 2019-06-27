library(shiny)
library(shinydashboard)
library(plotly)


box1 <-   box(width = 4,
       radioButtons("layout","layout:",
	               list("rectangular" = "rectangular",
				        "slanted" = "slanted",
				        "equal_angle" = "equal_angle",
						"daylight" = "daylight",
						"circular" = "circular",
						"fan" = "fan"),selected = "rectangular"
	  ),
	  sliderInput("height", "height：", 0, 5000, 1000),
	  textInput("color","color：", value = "black"),
	  sliderInput("size", "size：", 0, 10, 1,step=0.1),
	  checkboxInput("ladderize", "ladderize", FALSE),
	  checkboxInput("point", "point", FALSE),
	  sliderInput("point_size", "point_size：", 0, 10, 0,step=0.1),
	  checkboxInput("opentree1", "opentree:", FALSE),
	  sliderInput("opentree", "opentree：", 0, 360, 100),
	  checkboxInput("rotate_tree1", "rotate_tree:", FALSE),
	 sliderInput("rotate_tree", "rotate_tree：", 0, 360, 100),
	   checkboxInput("Collapsing_Clade1", "Collapsing_Clade", FALSE),
  textInput("Collapsing_Clade","Collapsing_Clade：", value = "none"),
	 checkboxInput("tiplab", "tiplab", TRUE),
	 sliderInput("tiplab_size", "tiplab_size：", 0, 10, 3,step=0.1),
	 textInput("tiplab_color","tiplab_color：", value = "blue"),
	 checkboxInput("search1", "search:", FALSE),
     textInput("search","search：", value = "Plecotus")
  )
  
box2 <-   box(width = 4,

	  radioButtons("layout2","layout:",
	               list("rectangular" = "rectangular",
				        "slanted" = "slanted",
				        "equal_angle" = "equal_angle",
						"daylight" = "daylight"),selected = "rectangular"
	  ),
	  textInput("color2","color：", value = "black"),
	  sliderInput("size2", "size：", 0, 10, 1,step=0.1),
	  checkboxInput("Collapsing_Clade22", "Collapsing_Clade", FALSE),
      textInput("Collapsing_Clade2","Collapsing_Clade：", value = "none"),
	   checkboxInput("flip_node1_2", "flip_node:", FALSE),
      numericInput("flip_node11_2", "flip_node1:", 17),
      numericInput("flip_node22_2", "flip_node2:", 21),
	  checkboxInput("ladderize2", "ladderize", FALSE),
	  checkboxInput("point2", "point", FALSE),
	  sliderInput("point_size2", "point_size：", 0, 10, 0,step=0.1)
  )
 
sidebar <- dashboardSidebar(
  fileInput('file1', 'Choose File',
              accept=c('text/csv', 'text/comma-separated-values,text/plain')),
  checkboxInput("node_label2", "node_label:", FALSE),
  #checkboxInput("Collapsing_Clade1", "Collapsing_Clade", FALSE),
  #textInput("Collapsing_Clade","Collapsing_Clade：", value = "none"),
  checkboxInput("viewClade1", "viewClade", FALSE),
  textInput("viewClade","viewClade：", value = "all"),
  checkboxInput("rotate_node1", "rotate_node", FALSE),
  textInput("rotate_node","rotate_node：", value = "none"),
  checkboxInput("flip_node1", "flip_node:", FALSE),
  numericInput("flip_node11", "flip_node1:", 17),
  numericInput("flip_node22", "flip_node2:", 21),
  p("output_method"),
  sidebarMenu(
    menuItem(text = "renderPlot",
	         tabName = "tab_normal",
			 badgeLabel = "default",
			 icon = icon("images")
	),
	menuItem(text = "renderPlotly",
	         tabName = "tab_layout_group2",
			 icon = icon("boxes")
	)
	
  )
)


tab_normal <- fluidRow(
  box(plotOutput("treeplot_normal"), width = 8),
  #box(plotOutput("treeplot_search",width=NULL)),
  box1
)

tab_layout_group2 <- fluidRow(
  box(plotlyOutput("treeplot_group2"), width = 8),
  box2
)


body <- dashboardBody(
  tabItems(
    tabItem(tabName  = "tab_normal", tab_normal),
	tabItem(tabName = "tab_layout_group2", tab_layout_group2)
  )
  
)

dashboardPage(skin = "green",
  dashboardHeader(title = "iggtree"),
  sidebar,
  body
)