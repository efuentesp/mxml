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
    
	def CharSequence getNodeType(int indentation, NodeOverride no, LinkedHashMap<String, String> nsl, String fname)'''	
		«getNodeOverride(indentation, no, nsl, fname)»
	'''	
	
	
	def CharSequence getNodeOverride(int indentation, NodeOverride n, LinkedHashMap<String, String> nsl, String fname)'''
	«IF n.prefix.equals('mx') » 
		«IF n.name.equals("Application")»
			«this.genApp(util.removeNameDecorator(fname))»
		«ELSEIF n.name.equals('Button')» 
			«this.genButton(indentation, n)»
		«ELSEIF n.name.equals('LinkButton')»	
			«this.genLinkButton(indentation, n)»
		«ELSEIF n.name.equals('RadioButton')»	
			«this.genRadioButton(indentation, n)»
		«ELSEIF n.name.equals('CheckBox')»	
			«this.genCheckBoxButton(indentation, n)»
		«ELSEIF n.name.equals('HBox')»	
			«this.genHBox(indentation, n)»
		«ELSEIF n.name.equals('VBox')»	
			«this.genVBox(indentation, n)»
		«ELSEIF n.name.equals('Canvas')»
			«this.genCanvas(indentation, n)»
		«ELSEIF n.name.equals('VDividedBox')»	
			«this.genVDividedBox(indentation, n)»
		«ELSEIF n.name.equals('HDividedBox')»	
			«this.genHDividedBox(indentation, n)»
		«ELSEIF n.name.equals('Panel')»	
			«this.genPanel(indentation, n)»
		«ELSEIF n.name.equals('Tile')»	
			«this.genTile(indentation, n)»
		«ELSEIF n.name.equals('Form')»	
			«this.genForm(indentation, n)»
		«ELSEIF n.name.equals('List')»	
			«this.genList(indentation, n)»
		«ELSEIF n.name.equals('ComboBox')»	
			«this.genComboBox(indentation, n)»
		«ELSEIF n.name.equals('DataGrid')»	
			«this.genDataGrid(indentation, n)»
		«ELSEIF n.name.equals('TileList')»	
			«this.genTileList(indentation, n)»
		«ELSEIF n.name.equals('HorizontalList')»	
			«this.genHorizontalList(indentation, n)»
		«ELSEIF n.name.equals('Tree')»	
			«this.genTree(indentation, n)»
		«ELSEIF n.name.equals('Image')»	
			«this.genImage(indentation, n)»
		«ELSEIF n.name.equals('SWFLoader')»	
			«this.genSWFLoader(indentation, n)»
		«ELSEIF n.name.equals('Accordion')»	
			«this.genAccordion(indentation, n)»
		«ELSEIF n.name.equals('TabNavigator')»	
			«this.genTabNavigator(indentation, n)»
		«ELSEIF n.name.equals('PopUpButton')»	
			«this.genPopUpButton(indentation, n)»
		«ELSEIF n.name.equals('TitleWindow')»	
			«this.genTitleWindow(indentation, n)»
		«ELSEIF n.name.equals('Label')»	
			«this.genLabel(indentation, n)»
		«ELSEIF n.name.equals('Text')»	
			«this.genText(indentation, n)»
		«ELSEIF n.name.equals('TextInput')»	
			«this.genTextInput(indentation, n)»
		«ELSEIF n.name.equals('TextArea')»	
			«this.genTextArea(indentation, n)»
		«ELSEIF n.name.equals('HSlider')»	
			«this.genHSLider(indentation, n)»
		«ELSEIF n.name.equals('VSlider')»	
			«this.genVSLider(indentation, n)»
		«ELSEIF n.name.equals('NumericStepper')»	
			«this.genNumericStepper(indentation, n)»
		«ELSEIF n.name.equals('ColorPicker')»	
			«this.genColorPicker(indentation, n)»
		«ELSEIF n.name.equals('DateField')»	
			«this.genDateField(indentation, n)»
		«ELSEIF n.name.equals('DateChooser')»	
			«this.genDateChooser(indentation, n)»
		«ELSEIF n.name.equals("FormItem")»
			«this.genFormItem(indentation, n)»
		«ELSEIF n.name.equals("AdvancedDataGridColumn")»
			«this.genAdvancedDataGridColumn(indentation, n)»
	    «ELSE» 				
			«util.getIndentation(indentation)».«n.name»
		«ENDIF»
	«ELSEIF n.prefix.equals('managers')»
		«this.genManager(indentation, n)»
	«ELSEIF n.prefix !==  null && !n.prefix.equals("filename")»
		«this.genIncludeComponent(indentation, n, nsl)»
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
	def String genLabel(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»label(«NodeOverride.getConcatAttrs(no, null)»)
	'''
	
	def String genText(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»label(«NodeOverride.getConcatAttrs(no, util.skipAttrsText)»)
	'''
		
	def String genTextInput(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»input(type="text" «NodeOverride.getConcatAttrs(no, util.skipAttrsTextInput)»)
	'''
	
	def String genTextArea(int indentation, NodeOverride no)'''	
			«util.getIndentation(indentation)»textarea( «NodeOverride.getConcatAttrs(no, util.skipAttrsTextArea)»)
	'''
	
	//Buttons
			
	def String genButton(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»button(«NodeOverride.getConcatAttrs(no, util.skipAttrsButton)») «NodeOverride.getAttrCheckI18Next(no,"label")»
	'''
	
	def String genLinkButton(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»a(href="#"): button(class="linkButton" type="button")«IF !this.getLabel(no).equalsIgnoreCase("")» «this.getLabel(no)»«ENDIF»
	'''
	
	def String genRadioButton(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»input(type="radio" «NodeOverride.getConcatAttrs(no, null)»)
			«util.getIndentation(indentation)»| «IF !this.getLabel(no).equalsIgnoreCase("")» «this.getLabel(no)»«ENDIF»
	'''
	
	def String genCheckBoxButton(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»input(type="checkbox" «NodeOverride.getConcatAttrs(no, null)») 
			«util.getIndentation(indentation)»| «IF !this.getLabel(no).equalsIgnoreCase("")» «this.getLabel(no)»«ENDIF»
    '''
	
	// Value Selectors
	
	def String genHSLider(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»input(type="range" class="hSlider")
	'''
	
	def String genVSLider(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»input(type="range" class="vSlider")
	'''
	
	def String genNumericStepper(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»input(type="number" «NodeOverride.getConcatAttrs(no, null)»)
	'''
	
	def String genColorPicker(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»input(type="color" «NodeOverride.getConcatAttrs(no, null)»)
	'''
	
	def String genDateField(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»input(type="date" «NodeOverride.getConcatAttrs(no, null)»)
	'''
	
	def String genDateChooser(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»input(type="date" «NodeOverride.getConcatAttrs(no, null)»)
	'''
	
 
	 // Lists
	 
	def String genList(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»select(size="3" «NodeOverride.getConcatAttrs(no, null)»)
			«util.getIndentation(indentation+1)»option(value="A") A
			«util.getIndentation(indentation+1)»option(value="B") B
			«util.getIndentation(indentation+1)»option(value="C") C
	'''
	 
	def String genComboBox(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»select(«NodeOverride.getConcatAttrs(no, null)»)
			«util.getIndentation(indentation+1)»option(value="A") A
			«util.getIndentation(indentation+1)»option(value="B") B
			«util.getIndentation(indentation+1)»option(value="C") C
	'''
	 
	def String genDataGrid(int indentation, NodeOverride no)'''
		«util.getIndentation(indentation)»table(class="dataGrid" «NodeOverride.getConcatAttrs(no, null)»)
		«util.getIndentation(indentation+1)»thead
		«util.getIndentation(indentation+2)»tr(class="gridRow")
		«util.getIndentation(indentation+3)»th(class="dataGridHeader"): span City
		«util.getIndentation(indentation+1)»tbody
		«util.getIndentation(indentation+2)»tr(class="gridRow")
		«util.getIndentation(indentation+3)»td(class="gridItem"): span Los Angeles
	'''
	 
	def genAdvancedDataGridColumn(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»div(class="AdvancedDataGridColumn"«NodeOverride.getConcatAttrs(no, null)»)
	''' 
	 
	def String genTileList(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»select(size="3" «NodeOverride.getConcatAttrs(no, null)»)
			«util.getIndentation(indentation+1)»option(value="A") A
			«util.getIndentation(indentation+1)»option(value="B") B
			«util.getIndentation(indentation+1)»option(value="C") C
	'''
	 
	def String genHorizontalList(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»select(class="hList" size="3" «NodeOverride.getConcatAttrs(no, null)»)
			«util.getIndentation(indentation+1)»option(value="A") A
			«util.getIndentation(indentation+1)»option(value="B") B
			«util.getIndentation(indentation+1)»option(value="C") C
	'''
	 
	def String genTree(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»ul(class="treeView" «NodeOverride.getConcatAttrs(no, null)»)
			«util.getIndentation(indentation+1)»li: span(class="caret") Beverages
			«util.getIndentation(indentation+2)»ul(class="nested")
	'''
	 
	 
	// Advanced 
	
	def String genAdvancedDataGrid(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»table(class="dataGrid" «NodeOverride.getConcatAttrs(no, null)»)
			«util.getIndentation(indentation+1)»thead
			«util.getIndentation(indentation+2)»tr(class="gridRow")
			«util.getIndentation(indentation+3)»th(class="dataGridHeader"): span City
			«util.getIndentation(indentation+1)»tbody
			«util.getIndentation(indentation+2)»tr(class="gridRow")
			«util.getIndentation(indentation+3)»td(class="gridItem"): span Los Angeles
	'''
	

	
	// Media and Progress
	
	def String genImage(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»div(class="image")
	'''
	
	def String genSWFLoader(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»div(class="sWFLoader")
	'''
	
	// Control Bar
	
	def String genControlBar(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»div(class="controlBar")
	'''
	
	def String genApplicationControlBar(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»div(class="applicationControlBar")
	'''
	
	// Navigators
	
	def String genAccordion(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»button(class="accordion") Section 1
			«util.getIndentation(indentation)»div(class="accordion-panel")
			«util.getIndentation(indentation)»p contents
	'''
	
	def String genToggleButtonBar(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»div(class="toggleButtonBar")
	'''
	
	def String genMenuBar(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»div(class="menuBar")
	'''
	
	def String genTabNavigator(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»ul(class="tabs")
			«util.getIndentation(indentation+1)»li: a(href="#tab1") Nunc tincidunt
			«util.getIndentation(indentation)»div(class="tab_container")
			«util.getIndentation(indentation+1)»div(class="tab_content" id="tab1")
	'''
	
	// Pop ups
	
	def String genPopUpButton(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»button(type="button" id="open") Nombre PopUpButton     
	'''
	
	def String genTitleWindow(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»div(id="popup" style="display: none;")
			«util.getIndentation(indentation+1)»div(class="content-popup")
			«util.getIndentation(indentation+2)»div(class="close"): a(href="#" id="close") X
			«util.getIndentation(indentation+2)»div
			«util.getIndentation(indentation+3)»contents
			«util.getIndentation(indentation+3)»contents
			«util.getIndentation(indentation+3)»div(style="float:left; width:100%;")
			«util.getIndentation(indentation)»div(class="popup-overlay")
	'''
	
	def String genPopUpMenuButton(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»div(class="popUpMenuButton")
	'''
	
	// Containers
	
	def String genHBox(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»div(class="hBox" «NodeOverride.getConcatAttrs(no, util.skipAttrsHBox)»)
			«util.getIndentation(indentation+1)»«NodeOverride.getAttrCheckI18NextLabel(no,"label")»
	'''
	
	def String genVBox(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»div(class="vBox" «NodeOverride.getConcatAttrs(no, util.skipAttrsVBox)»)
			«util.getIndentation(indentation+1)»«NodeOverride.getAttrCheckI18NextLabel(no,"label")»
	'''
	
	def String genCanvas(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»div(class="canvas")
	'''
	
	def String genVDividedBox(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»div(class="vDividedBox")
			«util.getIndentation(indentation+1)»div(class="vDivider")
	'''
	
	def String genHDividedBox(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»div(class="hDividedBox")
			«util.getIndentation(indentation+1)»div(class="hDivider")
	'''
	
	def String genPanel(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»div(class="panel" «NodeOverride.getConcatAttrsNoDataResource(no, util.skipAttrsPanel)»)
			«util.getIndentation(indentation+1)»div(class="panelTitle")
			«util.getIndentation(indentation+2)»«NodeOverride.getAttrCheckI18NextParagraph(no,"title")»
			«util.getIndentation(indentation+1)»div(class="panelContent")
	'''
	
	def String genTile(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»div(class="tile")
	'''
	
	def String genForm(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)»div(class="form")
			«util.getIndentation(indentation+1)»form(id="id")
			«util.getIndentation(indentation+2)»div(class="formTitle")
			«util.getIndentation(indentation+3)»p Form Title
			«util.getIndentation(indentation+2)»div(class="formContent")
	'''
	
	def String genFormItem(int indentation, NodeOverride no)'''
        «util.getIndentation(indentation)»label(class="formItem"«NodeOverride.getConcatAttrs(no, util.skipAttrsFormItem)») «NodeOverride.getAttrCheckI18Next(no,"label")»
	'''
	
	
	// Other
	
	def String genRemoteObject(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)».RemoteObject «getOverride(no, "FullDeclaration")»
	'''
	
	def String genMethod(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)».method «getOverride(no, "FullDeclaration")»
	'''
	
	def String genManager(int indentation, NodeOverride no)'''
			«util.getIndentation(indentation)».manager «getOverride(no, "FullDeclaration")»
	'''
	

	def String genIncludeComponent(int indentation, NodeOverride no, LinkedHashMap<String, String> nsl)'''
			«util.getIndentation(indentation)»include /«IF nsl.get(no.prefix) !== null»«nsl.get(no.prefix).replace("*", no.name)»«ENDIF».pug
	'''
	
	/* ++++++++++++++++++++++++++++++++++++++++++++++++ */
	
	def String getIdTag(NodeOverride no){
		var idTag = ""					
		if (NodeOverride.getAttr(no,"id") !== null && !NodeOverride.getAttr(no,"id").equalsIgnoreCase("") ){
				idTag = "#" + NodeOverride.getAttr(no,"id")
		}
		return idTag
	}
	
	def String getLabel(NodeOverride no){
		var label = ""
		if ( NodeOverride.getAttr(no,"label") !== null && !NodeOverride.getAttr(no,"label").equalsIgnoreCase("") ){
				label = NodeOverride.getAttr(no,"label")
	    }	
		return label
	}
	
	def String getOnClick(NodeOverride no){
		var onclick = ""
		if (NodeOverride.getAttr(no,"click") !== null && !NodeOverride.getAttr(no,"click").equalsIgnoreCase("")){
				onclick = "onclick=\"" + NodeOverride.getAttr(no,"click") + "\""
		}
		return onclick
	}
	
	def String getText(Node node, NodeOverride no){
		var text = ""
		if (NodeOverride.getAttr(no,"text") !== null && !NodeOverride.getAttr(no,"text").equalsIgnoreCase("")){
				text = "\"" + NodeOverride.getAttr(no,"text") + " \""
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