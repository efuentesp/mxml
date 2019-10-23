package com.softtek.mxml.generator

import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.eclipse.emf.ecore.resource.Resource
import com.softtek.mxml.mxml.Node
import java.util.List
import com.softtek.mxml.mxml.ComplexNode
import com.softtek.mxml.mxml.Project
import com.softtek.mxml.utils.Util
import java.util.LinkedHashMap

class PugElementGenerator {
	
	Util util = new Util()
	
	def CharSequence genApp(Node n, String fname)'''
	doctype html
	html(lang="en")
	   head
	      title «fname»
	   body''' 
	   
	//Text
	
	def String genLabel(int indentation, Node n)'''		
		«util.getIndentation(indentation)»label«this.getIdTag(n)» « getText(n)»
	'''
	
	def String genText(int indentation, Node n)'''		
		«util.getIndentation(indentation)»text«this.getIdTag(n)» « getLabel(n)»
	'''
		
	def String genTextInput(int indentation, Node n)'''
		«util.getIndentation(indentation)»input(type="text" «util.getConcatAttrs(n)»)
	'''
	
	def String genTextArea(int indentation, Node n)'''
		«util.getIndentation(indentation)»textarea( «util.getConcatAttrs(n)»)
	'''
	
	//Buttons
	
	def String genButton(int indentation, Node n)'''		
		«util.getIndentation(indentation)»button«this.getIdTag(n)»«IF !this.getOnClick(n).equalsIgnoreCase("")»(«this.getOnClick(n)»)«ENDIF»«IF !this.getLabel(n).equalsIgnoreCase("")» «this.getLabel(n)»«ENDIF»
	'''
	
	def String genLinkButton(int indentation, Node n)'''
		«util.getIndentation(indentation)»a(href="#"): button(class="linkButton" type="button")«IF !this.getLabel(n).equalsIgnoreCase("")» «this.getLabel(n)»«ENDIF»
	'''
	
	def String genRadioButton(int indentation, Node n)'''		
		«util.getIndentation(indentation)»input(type="radio" «util.getConcatAttrs(n)» )
		| «IF !this.getLabel(n).equalsIgnoreCase("")» «this.getLabel(n)»«ENDIF»
	'''
	
	def String genCheckBoxButton(int indentation, Node n)'''		
		«util.getIndentation(indentation)»input(type="checkbox" «util.getConcatAttrs(n)» ) 
		| «IF !this.getLabel(n).equalsIgnoreCase("")» «this.getLabel(n)»«ENDIF»
    '''
	
	// Value Selectors
	
	def String genHSLider(int indentation, Node n)'''
		«util.getIndentation(indentation)»input(type="range" class="hSlider" «util.getConcatAttrs(n)»)
	'''
	
	def String genVSLider(int indentation, Node n)'''
		«util.getIndentation(indentation)»input(type="range" class="vSlider" «util.getConcatAttrs(n)»)
	'''
	
	def String genNumericStepper(int indentation, Node n)'''
		«util.getIndentation(indentation)»input(type="number" «util.getConcatAttrs(n)»)
	'''
	
	def String genColorPicker(int indentation, Node n)'''
		«util.getIndentation(indentation)»input(type="color" «util.getConcatAttrs(n)»)
	'''
	
	def String genDateField(int indentation, Node n)'''
		«util.getIndentation(indentation)»input(type="date" «util.getConcatAttrs(n)»)
	'''
	
	def String genDateChooser(int indentation, Node n)'''
		«util.getIndentation(indentation)»input(type="date" «util.getConcatAttrs(n)»)
	'''
	
 
	 // Lists
	 
	def String genList(int indentation, Node n)'''
		«util.getIndentation(indentation)»select(size="3" «util.getConcatAttrs(n)»)
		«util.getIndentation(indentation+1)»option(value="A") A
		«util.getIndentation(indentation+1)»option(value="B") B
		«util.getIndentation(indentation+1)»option(value="C") C
	'''
	 
	def String genComboBox(int indentation, Node n)'''
		«util.getIndentation(indentation)»select(«util.getConcatAttrs(n)»)
		«util.getIndentation(indentation+1)»option(value="A") A
		«util.getIndentation(indentation+1)»option(value="B") B
		«util.getIndentation(indentation+1)»option(value="C") C
	'''
	 
	def String genDataGrid(int indentation, Node n)'''
		«util.getIndentation(indentation)»table(class="dataGrid" «util.getConcatAttrs(n)»)
		«util.getIndentation(indentation+1)»thead
		«util.getIndentation(indentation+2)»tr(class="gridRow")
		«util.getIndentation(indentation+3)»th(class="dataGridHeader"): span City
		«util.getIndentation(indentation+1)»tbody
		«util.getIndentation(indentation+2)»tr(class="gridRow")
		«util.getIndentation(indentation+3)»td(class="gridItem"): span Los Angeles
	'''
	 
	def String genTileList(int indentation, Node n)'''
		«util.getIndentation(indentation)»select(size="3" «util.getConcatAttrs(n)»)
		«util.getIndentation(indentation+1)»option(value="A") A
		«util.getIndentation(indentation+1)»option(value="B") B
		«util.getIndentation(indentation+1)»option(value="C") C
	'''
	 
	def String genHorizontalList(int indentation, Node n)'''
		«util.getIndentation(indentation)»select(class="hList" size="3" «util.getConcatAttrs(n)»)
		«util.getIndentation(indentation+1)»option(value="A") A
		«util.getIndentation(indentation+1)»option(value="B") B
		«util.getIndentation(indentation+1)»option(value="C") C
	'''
	 
	def String genTree(int indentation, Node n)'''
		«util.getIndentation(indentation)»ul(class="treeView" «util.getConcatAttrs(n)»)
		«util.getIndentation(indentation+1)»li: span(class="caret") Beverages
		«util.getIndentation(indentation+2)»ul(class="nested")
	'''
	 
	 
	// Advanced 
	
	def String genAdvancedDataGrid(int indentation, Node n)'''
		«util.getIndentation(indentation)»table(class="dataGrid" «util.getConcatAttrs(n)»)
		«util.getIndentation(indentation+1)»thead
		«util.getIndentation(indentation+2)»tr(class="gridRow")
		«util.getIndentation(indentation+3)»th(class="dataGridHeader"): span City
		«util.getIndentation(indentation+1)»tbody
		«util.getIndentation(indentation+2)»tr(class="gridRow")
		«util.getIndentation(indentation+3)»td(class="gridItem"): span Los Angeles
	'''
	
	// Media and Progress
	
	def String genImage(int indentation, Node n)'''
		«util.getIndentation(indentation)»div(class="image")
	'''
	
	def String genSWFLoader(int indentation, Node n)'''
		«util.getIndentation(indentation)»div(class="sWFLoader")
	'''
	
	// Control Bar
	
	def String genControlBar(int indentation, Node n)'''
		«util.getIndentation(indentation)»div(class="controlBar")
	'''
	
	def String genApplicationControlBar(int indentation, Node n)'''
		«util.getIndentation(indentation)»div(class="applicationControlBar")
	'''
	
	// Navigators
	
	def String genAccordion(int indentation, Node n)'''
		«util.getIndentation(indentation)»button(class="accordion") Section 1
		«util.getIndentation(indentation)»div(class="accordion-panel")
		«util.getIndentation(indentation)»p contents
	'''
	
	def String genToggleButtonBar(int indentation, Node n)'''
		«util.getIndentation(indentation)»div(class="toggleButtonBar")
	'''
	
	def String genMenuBar(int indentation, Node n)'''
		«util.getIndentation(indentation)»div(class="menuBar")
	'''
	
	def String genTabNavigator(int indentation, Node n)'''
		«util.getIndentation(indentation)»ul(class="tabs")
		«util.getIndentation(indentation+1)»li: a(href="#tab1") Nunc tincidunt
		«util.getIndentation(indentation)»div(class="tab_container")
		«util.getIndentation(indentation+1)»div(class="tab_content" id="tab1")
	'''
	
	// Pop ups
	
	def String genPopUpButton(int indentation, Node n)'''
	    «util.getIndentation(indentation)»div(id="popup" style="display: none;")
	         «util.getIndentation(indentation+1)»div(class="content-popup")
	            «util.getIndentation(indentation+2)»div(class="close"): a(href="#" id="close") X
	            «util.getIndentation(indentation+2)»div
	               «util.getIndentation(indentation+3)»contents
	               «util.getIndentation(indentation+3)»contents
	               «util.getIndentation(indentation+3)»div(style="float:left; width:100%;")
	    «util.getIndentation(indentation)»div(class="popup-overlay")
        «util.getIndentation(indentation)»button(type="button" id="open") Nombre PopUpButton
	'''
	
	def String genPopUpMenuButton(int indentation, Node n)'''
		«util.getIndentation(indentation)»div(class="popUpMenuButton")
	'''
	
	// Containers
	
	def String genHBox(int indentation, Node n)'''
		«util.getIndentation(indentation)»div(class="hBox")
	'''
	
	def String genVBox(int indentation, Node n)'''
		«util.getIndentation(indentation)»div(class="vBox")
	'''
	
	def String genCanvas(int indentation, Node n)'''
		«util.getIndentation(indentation)»div(class="canvas")
	'''
	
	def String genVDividedBox(int indentation, Node n)'''
		«util.getIndentation(indentation)»div(class="vDividedBox")
		«util.getIndentation(indentation+1)»div(class="vDivider")
	'''
	
	def String genHDividedBox(int indentation, Node n)'''
		«util.getIndentation(indentation)»div(class="hDividedBox")
		«util.getIndentation(indentation+1)»div(class="hDivider")
	'''
	
	def String genPanel(int indentation, Node n)'''
		«util.getIndentation(indentation)»div(class="panel")
		«util.getIndentation(indentation+1)»div(class="panelTitle")
		«util.getIndentation(indentation+1)»p Panel Title
		«util.getIndentation(indentation+1)»div(class="panelContent")
	'''
	
	def String genTile(int indentation, Node n)'''
		«util.getIndentation(indentation)»div(class="tile")
	'''
	
	def String genForm(int indentation, Node n)'''
		«util.getIndentation(indentation)»div(class="form")
		«util.getIndentation(indentation+1)»form(id="id")
		«util.getIndentation(indentation+2)»div(class="formTitle")
		«util.getIndentation(indentation+3)»p Form Title
		«util.getIndentation(indentation+2)»div(class="formContent")
	'''
	  
	// Include
	 
	def String genView(int indentation, Node n, LinkedHashMap<String, String> nsl)'''		
		«util.getIndentation(indentation)»include «IF nsl.get("views") !== null»«nsl.get("views").replace("*", n.name)»«ELSEIF nsl.get("view") !== null»«nsl.get("view").replace("*", n.name)»«ENDIF».pug
	'''
	
	// Other
	
	def String genRemoteObject(int indentation, Node n)'''
		«util.getIndentation(indentation)».RemoteObject
	'''
	
	def String genMethod(int indentation, Node n)'''
		«util.getIndentation(indentation)».method
	'''
	
	def String genState(int indentation, Node n)'''
		«util.getIndentation(indentation)».State
	'''
	
	def String genManager(int indentation, Node n)'''
		«util.getIndentation(indentation)».manager
	'''
	
	def String genComponente(int indentation, Node n)'''
		«util.getIndentation(indentation)».«util.getNodeClass(n)»
		«IF !n.attrs.empty»«util.getIndentation(indentation+1)»p«util.getConcatAttrs(n)»«ENDIF»
	'''
	
	/* ++++++++++++++++++++++++++++++++++++++++++++++++ */
	
	def String getIdTag(Node node){
		var idTag = ""	
		if (util.getNodeAttrValue(node,"id") !== null && !util.getNodeAttrValue(node,"id").equalsIgnoreCase("") ){
			idTag = "#" + util.getNodeAttrValue(node,"id")
		}			
		return idTag
	}
	
	def String getLabel(Node node){
		var label = ""
		if ( util.getNodeAttrValue(node,"label") !== null && !util.getNodeAttrValue(node,"label").equalsIgnoreCase("") ){
			label = util.getNodeAttrValue(node,"label")
		}
		return label
	}
	
	def String getOnClick(Node node){
		var onclick = ""
		if (util.getNodeAttrValue(node,"click") !== null && !util.getNodeAttrValue(node,"click").equalsIgnoreCase("")){
			onclick = "onclick=\"" + util.getNodeAttrValue(node,"click") + "\""
		}
		return onclick
	}
	
	def String getText(Node node){
		var text = ""
		if (util.getNodeAttrValue(node,"text") !== null && !util.getNodeAttrValue(node,"text").equalsIgnoreCase("")){
			text = "\"" + util.getNodeAttrValue(node,"text") + " \""
		}
		return text
	}
		
}