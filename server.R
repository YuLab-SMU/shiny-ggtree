#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(ggplot2)
library(ggtree)
library(showtext)
library(RColorBrewer)
library(magrittr)
library(tidytree)
library(plotly)
shinyServer(function(input, output) {
   

height <- reactive({
   return(input$height)
  })
 height2 <- reactive({
   return(input$height2)
  }) 
shuru <- reactive({
   req(input$file1)
   df <- read.tree(input$file1$datapath)
   return(df)
  })
  
 #p <- reactive({
  # tree <- shuru()
   #p <- ggtree(tree, color=input$color, size=input$size,ladderize=input$ladderize)
   #return(p)
 #}) 
	output$treeplot_normal <- renderPlot({
      tree <- shuru()
      p <- ggtree(tree, color=input$color, size=input$size,ladderize=input$ladderize,layout = input$layout)
	 #p <- p()
	 if(input$point){
	   p <- p + geom_point(aes(shape=isTip, color=isTip), size=input$point_size)
	   print(p)
	 }
	 if(input$tiplab){
	   p <- p + geom_tiplab(size=input$tiplab_size, color=input$tiplab_color)
	   print(p)
	 }

	 
	 if(input$opentree1){
	   p <- open_tree(p, input$opentree)
	   print(p)
	 }
	 
	 if(input$rotate_tree1){
	   p <- rotate_tree(p, input$rotate_tree)
	   print(p)
	 }
	  if(input$node_label2){
	   p <- p + geom_text2(aes(subset=!isTip,label=node), size = 5)
	   print(p)
	 }
	 
	if(input$Collapsing_Clade1){

	  bb<-unlist(strsplit(input$Collapsing_Clade,","))
	  p2 <- p
	  for( i in 1:length(bb))
	   {
	     p2 <- collapse(p2,node=as.numeric(bb[i])) + 
               geom_point2(aes(subset=(node==as.numeric(bb[i]))), shape=as.numeric(bb[i]), size=5, fill='red')
		 print(p2)
	   }
	 }
	
	if(input$rotate_node1){
	  cc <- unlist(strsplit(input$rotate_node,","))
	  p3 <- p
	  for(i in 1:length(cc))
	  {
	    p3 <- rotate(p3, as.numeric(cc[i]))
	  }
	  print(p3)
	}
	
	if(input$flip_node1){
	  p4 <- flip(p, input$flip_node11, input$flip_node22)
	  print(p4)
	}
	if(input$viewClade1){
	 aa<-unlist(strsplit(input$viewClade,","))
     p <- viewClade(p, MRCA(p, aa[1], aa[2]))
	 print(p)
	 }
	if(input$search1){
	  p5 <- gzoom(shuru(), grep(input$search, shuru()$tip.label))
	}
	 
	},width = "auto", height = height)

	
	#treeplot_group2
	output$treeplot_group2 <- renderPlotly({
      tree <- shuru()
	  p <- ggtree(tree, color=input$color2, size=input$size2,ladderize=input$ladderize2,layout = input$layout2)
	 if(input$point2){
	   p <- p + geom_point(aes(shape=isTip, color=isTip), size=input$point_size2)
	 }

	if(input$viewClade1){
	 aa<-unlist(strsplit(input$viewClade,","))
     p <- viewClade(p, MRCA(p, aa[1], aa[2]))
	 }

	 if(input$node_label2){
	   p <- p + geom_text(aes(subset=!isTip,label=node), size = 5)
	 }
	 pp <- p
	if(input$Collapsing_Clade22){

	  bb<-unlist(strsplit(input$Collapsing_Clade2,","))
      ph <- p
	  for( i in 1:length(bb))
	   {
	     ph <- collapse(ph,node=as.numeric(bb[i])) + 
               geom_point2(aes(subset=(node==as.numeric(bb[i]))), shape=as.numeric(bb[i]), size=5, fill='red')
	   }
	   pp <- ph
	 }
	
	if(input$rotate_node1){
	  cc <- unlist(strsplit(input$rotate_node,","))
	  for(i in 1:length(cc))
	  {
	    pp <- rotate(p, as.numeric(cc[i]))
	  }
	}
	
	if(input$flip_node1_2){
	  pp <- flip(p, input$flip_node11_2, input$flip_node22_2)
	}
	
	ggplotly(pp) 
	})

	
	
	
	
	
	
	
})









