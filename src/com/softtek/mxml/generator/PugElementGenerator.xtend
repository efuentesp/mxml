package com.softtek.mxml.generator

import com.softtek.mxml.mxml.Node
import com.softtek.mxml.utils.Util
import java.util.LinkedHashMap
import com.softtek.mxml.utils.NodeOverride

class PugElementGenerator {
	
	Util util = new Util()
	var i18nextScripts = "link(rel='stylesheet' href='../assets/css/common.css')\n"
					   + "script(src=\'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js\')\n"
                       + "script(src=\'https://cdnjs.cloudflare.com/ajax/libs/jquery-i18next/1.2.0/jquery-i18next.min.js')\n"
                       + "script(src=\'https://unpkg.com/i18next/i18next.js')\n"
                       + "script(src=\'https://unpkg.com/i18next-xhr-backend/i18nextXHRBackend.js')\n"
                       + "script(src=\'../assets/i18n/i18nextScript.js')\n"
                       + "script(src='../assets/states/states.js')"
                       
	
	def CharSequence getNodeType(int indentation, Node n, NodeOverride no, LinkedHashMap<String, String> nsl, String fname)'''	
		«IF n !== null»
			«getNode(indentation, n, nsl, fname)»
		«ELSEIF no !== null»
			«getNodeOverride(indentation, no, nsl, fname)»
		«ENDIF»
	'''	
	
	def CharSequence getNode(int indentation, Node n, LinkedHashMap<String, String> nsl, String fname)'''
		«IF n.prefix.equals('mx') » 
			«IF n.name.equals("Application")»
				«this.genApp(util.removeNameDecorator(fname))»
			«ELSEIF n.name.equals('Button')» 
				«this.genButton(indentation, n, null)»
			«ELSEIF n.name.equals('LinkButton')»	
				«this.genLinkButton(indentation, n, null)»
			«ELSEIF n.name.equals('RadioButton')»	
				«this.genRadioButton(indentation, n, null)»
			«ELSEIF n.name.equals('CheckBox')»	
				«this.genCheckBoxButton(indentation, n, null)»
			«ELSEIF n.name.equals('HBox')»	
				«this.genHBox(indentation, n, null)»
			«ELSEIF n.name.equals('VBox')»	
				«this.genVBox(indentation, n, null)»
			«ELSEIF n.name.equals('Canvas')»
				«this.genCanvas(indentation, n, null)»
			«ELSEIF n.name.equals('VDividedBox')»	
				«this.genVDividedBox(indentation, n, null)»
			«ELSEIF n.name.equals('HDividedBox')»	
				«this.genHDividedBox(indentation, n, null)»
			«ELSEIF n.name.equals('Panel')»	
				«this.genPanel(indentation, n, null)»
			«ELSEIF n.name.equals('Tile')»	
				«this.genTile(indentation, n, null)»
			«ELSEIF n.name.equals('Form')»	
				«this.genForm(indentation, n, null)»
			«ELSEIF n.name.equals('List')»	
				«this.genList(indentation, n, null)»
			«ELSEIF n.name.equals('ComboBox')»	
				«this.genComboBox(indentation, n, null)»
			«ELSEIF n.name.equals('DataGrid')»	
				«this.genDataGrid(indentation, n, null)»
			«ELSEIF n.name.equals('TileList')»	
				«this.genTileList(indentation, n, null)»
			«ELSEIF n.name.equals('HorizontalList')»	
				«this.genHorizontalList(indentation, n, null)»
			«ELSEIF n.name.equals('Tree')»	
				«this.genTree(indentation, n, null)»
			«ELSEIF n.name.equals('Image')»	
				«this.genImage(indentation, n, null)»
			«ELSEIF n.name.equals('SWFLoader')»	
				«this.genSWFLoader(indentation, n, null)»
			«ELSEIF n.name.equals('Accordion')»	
				«this.genAccordion(indentation, n, null)»
			«ELSEIF n.name.equals('TabNavigator')»	
				«this.genTabNavigator(indentation, n, null)»
			«ELSEIF n.name.equals('PopUpButton')»	
				«this.genPopUpButton(indentation, n, null)»
			«ELSEIF n.name.equals('TitleWindow')»	
				«this.genTitleWindow(indentation, n, null)»
			«ELSEIF n.name.equals('Label')»	
				«this.genLabel(indentation, n, null)»
			«ELSEIF n.name.equals('Text')»	
				«this.genText(indentation, n, null)»
			«ELSEIF n.name.equals('TextInput')»	
				«this.genTextInput(indentation, n, null)»
			«ELSEIF n.name.equals('TextArea')»	
				«this.genTextArea(indentation, n, null)»
			«ELSEIF n.name.equals('HSlider')»	
				«this.genHSLider(indentation, n, null)»
			«ELSEIF n.name.equals('VSlider')»	
				«this.genVSLider(indentation, n, null)»
			«ELSEIF n.name.equals('NumericStepper')»	
				«this.genNumericStepper(indentation, n, null)»
			«ELSEIF n.name.equals('ColorPicker')»	
				«this.genColorPicker(indentation, n, null)»
			«ELSEIF n.name.equals('DateField')»	
				«this.genDateField(indentation, n, null)»
			«ELSEIF n.name.equals('DateChooser')»	
				«this.genDateChooser(indentation, n, null)»
			«ELSEIF n.name.equals("FormItem")»
				«this.genFormItem(indentation, n, null)»
			«ELSEIF n.name.equals("AdvancedDataGridColumn")»
				«this.genAdvancedDataGridColumn(indentation, n, null)»
		    «ELSE» 				
				«util.getIndentation(indentation)».«util.getNodeClass(n)»
			«ENDIF»
		«ELSEIF n.prefix.equals('managers')»
			«this.genManager(indentation, n, null)»
		«ELSEIF n.prefix !== null && !n.prefix.equals("filename")»
			«this.genIncludeComponent(indentation, n, null, nsl)»
		«ENDIF»
	'''
	
	def CharSequence getNodeOverride(int indentation, NodeOverride n, LinkedHashMap<String, String> nsl, String fname)'''
	«IF n.prefix.equals('mx') » 
		«IF n.name.equals("Application")»
			«this.genApp(util.removeNameDecorator(fname))»
		«ELSEIF n.name.equals('Button')» 
			«this.genButton(indentation, null, n)»
		«ELSEIF n.name.equals('LinkButton')»	
			«this.genLinkButton(indentation, null, n)»
		«ELSEIF n.name.equals('RadioButton')»	
			«this.genRadioButton(indentation, null, n)»
		«ELSEIF n.name.equals('CheckBox')»	
			«this.genCheckBoxButton(indentation, null, n)»
		«ELSEIF n.name.equals('HBox')»	
			«this.genHBox(indentation, null, n)»
		«ELSEIF n.name.equals('VBox')»	
			«this.genVBox(indentation, null, n)»
		«ELSEIF n.name.equals('Canvas')»
			«this.genCanvas(indentation, null, n)»
		«ELSEIF n.name.equals('VDividedBox')»	
			«this.genVDividedBox(indentation, null, n)»
		«ELSEIF n.name.equals('HDividedBox')»	
			«this.genHDividedBox(indentation, null, n)»
		«ELSEIF n.name.equals('Panel')»	
			«this.genPanel(indentation, null, n)»
		«ELSEIF n.name.equals('Tile')»	
			«this.genTile(indentation, null, n)»
		«ELSEIF n.name.equals('Form')»	
			«this.genForm(indentation, null, n)»
		«ELSEIF n.name.equals('List')»	
			«this.genList(indentation, null, n)»
		«ELSEIF n.name.equals('ComboBox')»	
			«this.genComboBox(indentation, null, n)»
		«ELSEIF n.name.equals('DataGrid')»	
			«this.genDataGrid(indentation, null, n)»
		«ELSEIF n.name.equals('TileList')»	
			«this.genTileList(indentation, null, n)»
		«ELSEIF n.name.equals('HorizontalList')»	
			«this.genHorizontalList(indentation, null, n)»
		«ELSEIF n.name.equals('Tree')»	
			«this.genTree(indentation, null, n)»
		«ELSEIF n.name.equals('Image')»	
			«this.genImage(indentation, null, n)»
		«ELSEIF n.name.equals('SWFLoader')»	
			«this.genSWFLoader(indentation, null, n)»
		«ELSEIF n.name.equals('Accordion')»	
			«this.genAccordion(indentation, null, n)»
		«ELSEIF n.name.equals('TabNavigator')»	
			«this.genTabNavigator(indentation, null, n)»
		«ELSEIF n.name.equals('PopUpButton')»	
			«this.genPopUpButton(indentation, null, n)»
		«ELSEIF n.name.equals('TitleWindow')»	
			«this.genTitleWindow(indentation, null, n)»
		«ELSEIF n.name.equals('Label')»	
			«this.genLabel(indentation, null, n)»
		«ELSEIF n.name.equals('Text')»	
			«this.genText(indentation, null, n)»
		«ELSEIF n.name.equals('TextInput')»	
			«this.genTextInput(indentation, null, n)»
		«ELSEIF n.name.equals('TextArea')»	
			«this.genTextArea(indentation, null, n)»
		«ELSEIF n.name.equals('HSlider')»	
			«this.genHSLider(indentation, null, n)»
		«ELSEIF n.name.equals('VSlider')»	
			«this.genVSLider(indentation, null, n)»
		«ELSEIF n.name.equals('NumericStepper')»	
			«this.genNumericStepper(indentation, null, n)»
		«ELSEIF n.name.equals('ColorPicker')»	
			«this.genColorPicker(indentation, null, n)»
		«ELSEIF n.name.equals('DateField')»	
			«this.genDateField(indentation, null, n)»
		«ELSEIF n.name.equals('DateChooser')»	
			«this.genDateChooser(indentation, null, n)»
		«ELSEIF n.name.equals("FormItem")»
			«this.genFormItem(indentation, null, n)»
		«ELSEIF n.name.equals("AdvancedDataGridColumn")»
			«this.genAdvancedDataGridColumn(indentation, null, n)»
	    «ELSE» 				
			«util.getIndentation(indentation)».«n.name»
		«ENDIF»
	«ELSEIF n.prefix.equals('managers')»
		«this.genManager(indentation, null, n)»
	«ELSEIF n.prefix !==  null && !n.prefix.equals("filename")»
		«this.genIncludeComponent(indentation, null, n, nsl)»
	«ENDIF»
	'''
	
	def CharSequence genApp(String fname)'''
	doctype html
	html(lang="en")
	   head
	      «i18nextScripts»
	      title «fname»
	   body''' 
	 
	 
		   
	//Text	
	def String genLabel(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»label(«util.getConcatAttrs(n, null)»)
		«ELSEIF no !== null»			
			«util.getIndentation(indentation)»label(«NodeOverride.getConcatAttrs(no, null)»)
		«ENDIF»		
	'''
	
	def String genText(int indentation, Node n, NodeOverride no)'''		
		«IF n !== null»		
			«util.getIndentation(indentation)»label(«util.getConcatAttrs(n, null)»)
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»label(«NodeOverride.getConcatAttrs(no, null)»)
		«ENDIF»
	'''
		
	def String genTextInput(int indentation, Node n, NodeOverride no)'''		
		«IF n !== null»		
			«util.getIndentation(indentation)»input(type="text" «util.getConcatAttrs(n, null)»)
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»input(type="text" «NodeOverride.getConcatAttrs(no, null)»)
		«ENDIF»
	'''
	
	def String genTextArea(int indentation, Node n, NodeOverride no)'''		
		«IF n !== null»		
			«util.getIndentation(indentation)»textarea( «util.getConcatAttrs(n, null)»)
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»textarea( «NodeOverride.getConcatAttrs(no, null)»)
		«ENDIF»
	'''
	
	//Buttons
	
	def String genButton(int indentation, Node n, NodeOverride no)'''		
		«IF n !== null»		
			«util.getIndentation(indentation)»button(«util.getConcatAttrs(n, null)»)
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»button( «NodeOverride.getConcatAttrs(no, null)»)
		«ENDIF»
	'''
	
	def String genLinkButton(int indentation, Node n, NodeOverride no)'''		
		«IF n !== null»		
			«util.getIndentation(indentation)»a(href="#"): button(class="linkButton" type="button")«IF !this.getLabel(n, null).equalsIgnoreCase("")» «this.getLabel(n, null)»«ENDIF»
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»a(href="#"): button(class="linkButton«getOverride(no, "OnlyClass")»" type="button")«IF !this.getLabel(null, no).equalsIgnoreCase("")» «this.getLabel(null, no)»«ENDIF»
		«ENDIF»
	'''
	
	def String genRadioButton(int indentation, Node n, NodeOverride no)'''		
		«IF n !== null»		
			«util.getIndentation(indentation)»input(type="radio" «util.getConcatAttrs(n, null)» )
			«util.getIndentation(indentation)»| «IF !this.getLabel(n, null).equalsIgnoreCase("")» «this.getLabel(n, null)»«ENDIF»
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»input(type="radio" «NodeOverride.getConcatAttrs(no, null)»)
			«util.getIndentation(indentation)»| «IF !this.getLabel(n, null).equalsIgnoreCase("")» «this.getLabel(n, null)»«ENDIF»
		«ENDIF»
		
	'''
	
	def String genCheckBoxButton(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»input(type="checkbox" «util.getConcatAttrs(n, null)» ) 
			«util.getIndentation(indentation)»| «IF !this.getLabel(n, null).equalsIgnoreCase("")» «this.getLabel(n, null)»«ENDIF»
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»input(type="checkbox" «NodeOverride.getConcatAttrs(no, null)») 
			«util.getIndentation(indentation)»| «IF !this.getLabel(n, null).equalsIgnoreCase("")» «this.getLabel(n, null)»«ENDIF»
		«ENDIF»		
    '''
	
	// Value Selectors
	
	def String genHSLider(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»input(type="range" class="hSlider" «util.getConcatAttrs(n, null)»)
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»input(type="range" class="hSlider«getOverride(no, "OnlyClass")»")
		«ENDIF»				
	'''
	
	def String genVSLider(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»input(type="range" class="vSlider" «util.getConcatAttrs(n, null)»)
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»input(type="range" class="vSlider«getOverride(no, "OnlyClass")»")
		«ENDIF»		
	'''
	
	def String genNumericStepper(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»input(type="number" «util.getConcatAttrs(n, null)»)
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»input(type="number" «NodeOverride.getConcatAttrs(no, null)»)
		«ENDIF»			
	'''
	
	def String genColorPicker(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»input(type="color" «util.getConcatAttrs(n, null)»)
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»input(type="color" «NodeOverride.getConcatAttrs(no, null)»)
		«ENDIF»		
	'''
	
	def String genDateField(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»input(type="date" «util.getConcatAttrs(n, null)»)
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»input(type="date" «NodeOverride.getConcatAttrs(no, null)»)
		«ENDIF»			
	'''
	
	def String genDateChooser(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»input(type="date" «util.getConcatAttrs(n, null)»)
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»input(type="date" «NodeOverride.getConcatAttrs(no, null)»)
		«ENDIF»		
	'''
	
 
	 // Lists
	 
	def String genList(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»select(size="3" «util.getConcatAttrs(n, null)»)
			«util.getIndentation(indentation+1)»option(value="A") A
			«util.getIndentation(indentation+1)»option(value="B") B
			«util.getIndentation(indentation+1)»option(value="C") C
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»select(size="3" «NodeOverride.getConcatAttrs(no, null)»)
			«util.getIndentation(indentation+1)»option(value="A") A
			«util.getIndentation(indentation+1)»option(value="B") B
			«util.getIndentation(indentation+1)»option(value="C") C
		«ENDIF»				
	'''
	 
	def String genComboBox(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»select(«util.getConcatAttrs(n, null)»)
			«util.getIndentation(indentation+1)»option(value="A") A
			«util.getIndentation(indentation+1)»option(value="B") B
			«util.getIndentation(indentation+1)»option(value="C") C
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»select(«NodeOverride.getConcatAttrs(no, null)»)
			«util.getIndentation(indentation+1)»option(value="A") A
			«util.getIndentation(indentation+1)»option(value="B") B
			«util.getIndentation(indentation+1)»option(value="C") C
		«ENDIF»			
	'''
	 
	def String genDataGrid(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
		«util.getIndentation(indentation)»table(class="dataGrid" «util.getConcatAttrs(n, null)»)
		«util.getIndentation(indentation+1)»thead
		«util.getIndentation(indentation+2)»tr(class="gridRow")
		«util.getIndentation(indentation+3)»th(class="dataGridHeader"): span City
		«util.getIndentation(indentation+1)»tbody
		«util.getIndentation(indentation+2)»tr(class="gridRow")
		«util.getIndentation(indentation+3)»td(class="gridItem"): span Los Angeles
		«ELSEIF no !== null»
		«util.getIndentation(indentation)»table(class="dataGrid" «NodeOverride.getConcatAttrs(no, null)»)
		«util.getIndentation(indentation+1)»thead
		«util.getIndentation(indentation+2)»tr(class="gridRow")
		«util.getIndentation(indentation+3)»th(class="dataGridHeader"): span City
		«util.getIndentation(indentation+1)»tbody
		«util.getIndentation(indentation+2)»tr(class="gridRow")
		«util.getIndentation(indentation+3)»td(class="gridItem"): span Los Angeles
		«ENDIF»			
	'''
	 
	def genAdvancedDataGridColumn(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»
			«util.getIndentation(indentation)»div(class="AdvancedDataGridColumn"«util.getConcatAttrs(n, null)»)
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(class="AdvancedDataGridColumn"«NodeOverride.getConcatAttrs(no, null)»)
		«ENDIF»
	''' 
	 
	def String genTileList(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»select(size="3" «util.getConcatAttrs(n, null)»)
			«util.getIndentation(indentation+1)»option(value="A") A
			«util.getIndentation(indentation+1)»option(value="B") B
			«util.getIndentation(indentation+1)»option(value="C") C
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»select(size="3" «NodeOverride.getConcatAttrs(no, null)»)
			«util.getIndentation(indentation+1)»option(value="A") A
			«util.getIndentation(indentation+1)»option(value="B") B
			«util.getIndentation(indentation+1)»option(value="C") C
		«ENDIF»			
	'''
	 
	def String genHorizontalList(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»select(class="hList" size="3" «util.getConcatAttrs(n, null)»)
			«util.getIndentation(indentation+1)»option(value="A") A
			«util.getIndentation(indentation+1)»option(value="B") B
			«util.getIndentation(indentation+1)»option(value="C") C
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»select(class="hList" size="3" «NodeOverride.getConcatAttrs(no, null)»)
			«util.getIndentation(indentation+1)»option(value="A") A
			«util.getIndentation(indentation+1)»option(value="B") B
			«util.getIndentation(indentation+1)»option(value="C") C
		«ENDIF»			
	'''
	 
	def String genTree(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»ul(class="treeView" «util.getConcatAttrs(n, null)»)
			«util.getIndentation(indentation+1)»li: span(class="caret") Beverages
			«util.getIndentation(indentation+2)»ul(class="nested")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»ul(class="treeView" «NodeOverride.getConcatAttrs(no, null)»)
			«util.getIndentation(indentation+1)»li: span(class="caret") Beverages
			«util.getIndentation(indentation+2)»ul(class="nested")
		«ENDIF»			
	'''
	 
	 
	// Advanced 
	
	def String genAdvancedDataGrid(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»table(class="dataGrid" «util.getConcatAttrs(n, null)»)
			«util.getIndentation(indentation+1)»thead
			«util.getIndentation(indentation+2)»tr(class="gridRow")
			«util.getIndentation(indentation+3)»th(class="dataGridHeader"): span City
			«util.getIndentation(indentation+1)»tbody
			«util.getIndentation(indentation+2)»tr(class="gridRow")
			«util.getIndentation(indentation+3)»td(class="gridItem"): span Los Angeles
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»table(class="dataGrid" «NodeOverride.getConcatAttrs(no, null)»)
			«util.getIndentation(indentation+1)»thead
			«util.getIndentation(indentation+2)»tr(class="gridRow")
			«util.getIndentation(indentation+3)»th(class="dataGridHeader"): span City
			«util.getIndentation(indentation+1)»tbody
			«util.getIndentation(indentation+2)»tr(class="gridRow")
			«util.getIndentation(indentation+3)»td(class="gridItem"): span Los Angeles
		«ENDIF»	
	'''
	

	
	// Media and Progress
	
	def String genImage(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»div(class="image")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(class="image«getOverride(no, "OnlyClass")»")
		«ENDIF»			
	'''
	
	def String genSWFLoader(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»div(class="sWFLoader")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(class="sWFLoader«getOverride(no, "OnlyClass")»")
		«ENDIF»			
	'''
	
	// Control Bar
	
	def String genControlBar(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»div(class="controlBar")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(class="controlBar«getOverride(no, "OnlyClass")»")
		«ENDIF»	
		
	'''
	
	def String genApplicationControlBar(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»div(class="applicationControlBar")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(class="applicationControlBar«getOverride(no, "OnlyClass")»")
		«ENDIF»		
	'''
	
	// Navigators
	
	def String genAccordion(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»button(class="accordion") Section 1
			«util.getIndentation(indentation)»div(class="accordion-panel")
			«util.getIndentation(indentation)»p contents
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»button(class="accordion«getOverride(no, "OnlyClass")»") Section 1
			«util.getIndentation(indentation)»div(class="accordion-panel")
			«util.getIndentation(indentation)»p contents
		«ENDIF»		
	'''
	
	def String genToggleButtonBar(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»div(class="toggleButtonBar")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(class="toggleButtonBar«getOverride(no, "OnlyClass")»")
		«ENDIF»			
	'''
	
	def String genMenuBar(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»div(class="menuBar")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(class="menuBar«getOverride(no, "OnlyClass")»")
		«ENDIF»			
	'''
	
	def String genTabNavigator(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»ul(class="tabs")
			«util.getIndentation(indentation+1)»li: a(href="#tab1") Nunc tincidunt
			«util.getIndentation(indentation)»div(class="tab_container")
			«util.getIndentation(indentation+1)»div(class="tab_content" id="tab1")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»ul(class="tabs«getOverride(no, "OnlyClass")»")
			«util.getIndentation(indentation+1)»li: a(href="#tab1") Nunc tincidunt
			«util.getIndentation(indentation)»div(class="tab_container")
			«util.getIndentation(indentation+1)»div(class="tab_content" id="tab1")
		«ENDIF»	
		
	'''
	
	// Pop ups
	
	def String genPopUpButton(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»button(type="button" id="open") Nombre PopUpButton
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»button(type="button" id="open"«getOverride(no, "ClassDeclaration")») Nombre PopUpButton
		«ENDIF»	      
	'''
	
	def String genTitleWindow(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»div(id="popup" style="display: none;")
			«util.getIndentation(indentation+1)»div(class="content-popup")
			«util.getIndentation(indentation+2)»div(class="close"): a(href="#" id="close") X
			«util.getIndentation(indentation+2)»div
			«util.getIndentation(indentation+3)»contents
			«util.getIndentation(indentation+3)»contents
			«util.getIndentation(indentation+3)»div(style="float:left; width:100%;")
			«util.getIndentation(indentation)»div(class="popup-overlay")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(id="popup«getOverride(no, "ClassDeclaration")»" style="display: none;")
			«util.getIndentation(indentation+1)»div(class="content-popup")
			«util.getIndentation(indentation+2)»div(class="close"): a(href="#" id="close") X
			«util.getIndentation(indentation+2)»div
			«util.getIndentation(indentation+3)»contents
			«util.getIndentation(indentation+3)»contents
			«util.getIndentation(indentation+3)»div(style="float:left; width:100%;")
			«util.getIndentation(indentation)»div(class="popup-overlay")
		«ENDIF»	 
	'''
	
	def String genPopUpMenuButton(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»div(class="popUpMenuButton")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(class="popUpMenuButton«getOverride(no, "OnlyClass")»")
		«ENDIF»		
	'''
	
	// Containers
	
	def String genHBox(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»div(class="hBox")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(class="hBox«getOverride(no, "OnlyClass")»")
		«ENDIF»		
	'''
	
	def String genVBox(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»div(class="vBox")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(class="vBox«getOverride(no, "OnlyClass")»")
		«ENDIF»		
	'''
	
	def String genCanvas(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»div(class="canvas")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(class="canvas«getOverride(no, "OnlyClass")»")
		«ENDIF»		
	'''
	
	def String genVDividedBox(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»div(class="vDividedBox")
			«util.getIndentation(indentation+1)»div(class="vDivider")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(class="vDividedBox«getOverride(no, "OnlyClass")»")
			«util.getIndentation(indentation+1)»div(class="vDivider")
		«ENDIF»		
	'''
	
	def String genHDividedBox(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»div(class="hDividedBox")
			«util.getIndentation(indentation+1)»div(class="hDivider")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(class="hDividedBox«getOverride(no, "OnlyClass")»")
			«util.getIndentation(indentation+1)»div(class="hDivider")
		«ENDIF»			
	'''
	
	def String genPanel(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»div(class="panel")
«««			«util.getIndentation(indentation+1)»div(class="panelTitle")
«««			«util.getIndentation(indentation+2)»p Panel Title
			«util.getIndentation(indentation+1)»div(class="panelContent")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(class="panel«getOverride(no, "OnlyClass")»")
«««			«util.getIndentation(indentation+1)»div(class="panelTitle")
«««			«util.getIndentation(indentation+2)»p Panel Title
			«util.getIndentation(indentation+1)»div(class="panelContent")
		«ENDIF»			
	'''
	
	def String genTile(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»div(class="tile")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(class="tile«getOverride(no, "OnlyClass")»")
		«ENDIF»			
	'''
	
	def String genForm(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)»div(class="form")
			«util.getIndentation(indentation+1)»form(id="id")
			«util.getIndentation(indentation+2)»div(class="formTitle")
			«util.getIndentation(indentation+3)»p Form Title
			«util.getIndentation(indentation+2)»div(class="formContent")
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(class="form«getOverride(no, "OnlyClass")»")
			«util.getIndentation(indentation+1)»form(id="id")
			«util.getIndentation(indentation+2)»div(class="formTitle")
			«util.getIndentation(indentation+3)»p Form Title
			«util.getIndentation(indentation+2)»div(class="formContent")
		«ENDIF»		
	'''
	
	def String genFormItem(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»
			«util.getIndentation(indentation)»div(class="formItem"«util.getConcatAttrs(n, null)»)
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»div(class="formItem"«NodeOverride.getConcatAttrs(no, null)»)
		«ENDIF»
	'''
	
	// Other
	
	def String genRemoteObject(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)».RemoteObject
		«ELSEIF no !== null»
			«util.getIndentation(indentation)».RemoteObject «getOverride(no, "FullDeclaration")»
		«ENDIF»			
	'''
	
	def String genMethod(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)».method
		«ELSEIF no !== null»
			«util.getIndentation(indentation)».method «getOverride(no, "FullDeclaration")»
		«ENDIF»			
	'''
	
	def String genManager(int indentation, Node n, NodeOverride no)'''
		«IF n !== null»		
			«util.getIndentation(indentation)».manager
		«ELSEIF no !== null»
			«util.getIndentation(indentation)».manager «getOverride(no, "FullDeclaration")»
		«ENDIF»			
	'''
	

	def String genIncludeComponent(int indentation, Node n, NodeOverride no, LinkedHashMap<String, String> nsl)'''
		«IF n !== null»
			«util.getIndentation(indentation)»include /«IF nsl.get(n.prefix) !== null»«nsl.get(n.prefix).replace("*", n.name)»«ENDIF».pug
		«ELSEIF no !== null»
			«util.getIndentation(indentation)»include /«IF nsl.get(no.prefix) !== null»«nsl.get(no.prefix).replace("*", no.name)»«ENDIF».pug
		«ENDIF»	
	'''
	
	/* ++++++++++++++++++++++++++++++++++++++++++++++++ */
	
	def String getIdTag(Node node, NodeOverride no){
		var idTag = ""					
		if(node !== null){
			if (util.getNodeAttrValue(node,"id") !== null && !util.getNodeAttrValue(node,"id").equalsIgnoreCase("") ){
				idTag = "#" + util.getNodeAttrValue(node,"id")
			}
		}else if(no !== null){
			if (NodeOverride.getAttr(no,"id") !== null && !NodeOverride.getAttr(no,"id").equalsIgnoreCase("") ){
				idTag = "#" + NodeOverride.getAttr(no,"id")
			}
		}	
		return idTag
	}
	
	def String getLabel(Node node, NodeOverride no){
		var label = ""
		if(node !== null){
			if ( util.getNodeAttrValue(node,"label") !== null && !util.getNodeAttrValue(node,"label").equalsIgnoreCase("") ){
				label = util.getNodeAttrValue(node,"label")
			}
		}else if(no !== null){
			if ( NodeOverride.getAttr(no,"label") !== null && !NodeOverride.getAttr(no,"label").equalsIgnoreCase("") ){
				label = NodeOverride.getAttr(no,"label")
			}
		}		
		return label
	}
	
	def String getOnClick(Node node, NodeOverride no){
		var onclick = ""
		if(node !== null){
			if (util.getNodeAttrValue(node,"click") !== null && !util.getNodeAttrValue(node,"click").equalsIgnoreCase("")){
				onclick = "onclick=\"" + util.getNodeAttrValue(node,"click") + "\""
			}
		}else if(no !== null){
			if (NodeOverride.getAttr(no,"click") !== null && !NodeOverride.getAttr(no,"click").equalsIgnoreCase("")){
				onclick = "onclick=\"" + NodeOverride.getAttr(no,"click") + "\""
			}
		}		
		return onclick
	}
	
	def String getText(Node node, NodeOverride no){
		var text = ""
		if(node !== null){
			if (util.getNodeAttrValue(node,"text") !== null && !util.getNodeAttrValue(node,"text").equalsIgnoreCase("")){
				text = "\"" + util.getNodeAttrValue(node,"text") + " \""
			}
		}else if(no !== null){
			if (NodeOverride.getAttr(no,"text") !== null && !NodeOverride.getAttr(no,"text").equalsIgnoreCase("")){
				text = "\"" + NodeOverride.getAttr(no,"text") + " \""
			}
		}		
		return text
	}
	
	def String getOverride(NodeOverride no, String type){
		var String classOverride = ""
			if(NodeOverride.getAttr(no, "flexOverride") !== null){
				if("OnlyClass".equalsIgnoreCase(type)){
					classOverride = " " + NodeOverride.getAttr(no, "flexOverride")
				}else if("ClassDeclaration".equalsIgnoreCase(type)){
					classOverride = " class=\"" + NodeOverride.getAttr(no, "flexOverride") + "\""
				}else if("FullDeclaration".equalsIgnoreCase(type)){
					classOverride = "(class=\"" + NodeOverride.getAttr(no, "flexOverride") + "\")"
				}				
			}
		return classOverride
	}
		
}