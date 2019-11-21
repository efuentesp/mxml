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
                       + "script(src='../assets/scripts/states.js')"
    
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
		«ELSEIF n.name.equals('DataGridColumn')»	
			«this.genDataGridColumn(indentation, n)»
		«ELSEIF n.name.equals('columns')»	
			«this.genDataGridColumns(indentation, n)»
		«ELSEIF n.name.equals('Array')»	
			«this.genDataArray(indentation, n)»
		«ELSEIF n.name.equals('AdvancedDataGrid')»
			«this.genDataGrid(indentation, n)»
		«ELSEIF n.name.equals('AdvancedDataGridColumn')»
		    «this.genDataGridColumn(indentation, n)»
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
		«var id = getProperty(no, "id", "id")»
		«var i18n = getI18n(no, "text")»
		«var text = getText(no, "text")»
		«var required = getRequired(no, "required")»
		«var flexOverride = getProperty(no, "flexOverride", "class")»
		«IF id === "" && i18n === "" && flexOverride === ""»
		«util.getIndentation(indentation)»label«text»
		«ELSE»
		«util.getIndentation(indentation)»label( «id»«i18n»«flexOverride» )«text»
		«ENDIF»
		«IF required»«util.getIndentation(indentation)»span(class="required") *«ENDIF»
	'''
	
	def String genText(int indentation, NodeOverride no)'''
		«var id = getProperty(no, "id", "id")»
		«var i18n = getI18n(no, "text")»
		«var text = getText(no, "text")»
		«var flexOverride = getProperty(no, "flexOverride", "class")»
		«IF id === "" && i18n === "" && flexOverride === ""»
		«util.getIndentation(indentation)»label«text»
		«ELSE»
		«util.getIndentation(indentation)»label(«id»«i18n»«flexOverride» )«text»
		«ENDIF»	
	'''
		
	def String genTextInput(int indentation, NodeOverride no)'''
		«var id = getProperty(no, "id", "id")»
		«var disabled = getEnabled(no, "enabled")»
		«var flexOverride = getProperty(no, "flexOverride", "class")»
		«util.getIndentation(indentation)»input( type="text"«id»«disabled»«flexOverride» )
	'''
	
	def String genTextArea(int indentation, NodeOverride no)'''	
		«var id = getProperty(no, "id", "id") »
		«var disabled = getEnabled(no, "enabled")»
		«var i18n =  getI18n(no, "text")»
		«var text = getText(no, "text")»
		«var flexOverride = getProperty(no, "flexOverride", "class")»
		«util.getIndentation(indentation)»textarea( rows="4" cols="50"«id»«disabled»«flexOverride» )«text»
	'''
	
	//Buttons
			
	def String genButton(int indentation, NodeOverride no)'''
		«var id = getProperty(no, "id", "id") »
		«var disabled = getEnabled(no, "enabled")»
		«var i18n =  getI18n(no, "label")»
		«var label = getText(no, "label")»
		«var icon = getProperty(no, "icon")»
		«var flexOverride = getProperty(no, "flexOverride", "class")»
		«var click= getProperty(no, "click")»
		«var toolTip= getProperty(no, "toolTip")»
		«IF toolTip === null && click === null»
		«util.getIndentation(indentation)»button( type="button"«id»«i18n»«disabled»«flexOverride» )«label»«icon»
		«ELSE»
		«util.getIndentation(indentation)»button( type="button" title="«toolTip»«click»"«id»«i18n»«disabled»«flexOverride» )«label»«icon»
		«ENDIF»
	'''
	
	def String genLinkButton(int indentation, NodeOverride no)'''
		«var id = getProperty(no, "id", "id") »
		«var i18n =  getI18n(no, "label")»
		«var click= getProperty(no, "click") !== null ? " title='" + getProperty(no, " click") + "'" : ""»
		«var flexOverride = getProperty(no, "flexOverride", "class")»
		«util.getIndentation(indentation)»a(href="#"): button( class="linkButton«flexOverride»" type="button"«id»«i18n»«click» )
	'''
	
	def String genRadioButton(int indentation, NodeOverride no)'''
		«util.getIndentation(indentation)»input(type="radio" «NodeOverride.getConcatAttrs(no, null)»)
		«IF !this.getLabel(no).equalsIgnoreCase("")»«util.getIndentation(indentation)»| «this.getLabel(no)»«ENDIF»
	'''
	
	def String genCheckBoxButton(int indentation, NodeOverride no)'''
		«util.getIndentation(indentation)»input(type="checkbox" «NodeOverride.getConcatAttrs(no, null)») 
		«IF !this.getLabel(no).equalsIgnoreCase("")»«util.getIndentation(indentation)»| «this.getLabel(no)»«ENDIF»
    '''
	
	// Value Selectors
	
	def String genHSLider(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»input(type="range" class="hSlider«flexOverride»")
	'''
	
	def String genVSLider(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»input(type="range" class="vSlider«flexOverride»")
	'''
	
	def String genNumericStepper(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride", "class")»
		«util.getIndentation(indentation)»input(type="number"«flexOverride»)
	'''
	
	def String genColorPicker(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride", "class")»
		«util.getIndentation(indentation)»input(type="color"«flexOverride»)
	'''
	
	def String genDateField(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride", "class")»
		«util.getIndentation(indentation)»input(type="date"«flexOverride»)
	'''
	
	def String genDateChooser(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride", "class")»
		«util.getIndentation(indentation)»input(type="date"«flexOverride»)
	'''
	
 
	 // Lists
	 
	def String genList(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride", "class")»
		«util.getIndentation(indentation)»select(size="3"«flexOverride»)
		«util.getIndentation(indentation+1)»option(value="A") A
		«util.getIndentation(indentation+1)»option(value="B") B
		«util.getIndentation(indentation+1)»option(value="C") C
	'''
	 
	def String genComboBox(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride", "class") !== null ? "(" + getProperty(no, "flexOverride", "class") + ")" : ""»
		«util.getIndentation(indentation)»select«flexOverride»
		«util.getIndentation(indentation+1)»option(value="A") A
		«util.getIndentation(indentation+1)»option(value="B") B
		«util.getIndentation(indentation+1)»option(value="C") C
	'''
	 	  
	def String genDataGrid(int indentation, NodeOverride no)'''
		«util.getIndentation(indentation)»table(class="dataGrid")
		«util.getIndentation(indentation+1)»thead
		«util.getIndentation(indentation+2)»tr(class="gridRow")
	'''
	
	def String genDataGridColumn(int indentation, NodeOverride no)'''
	    «var i18n =  getI18n(no, "headerText")»
		«util.getIndentation(indentation+1)»th(class="dataGridHeader"): span(«i18n»)
	'''
	
	def String genDataGridColumns(int indentation, NodeOverride no)'''
	'''
	 
	// If an Array contains a DatagritColumns we create a table.
	// Probably we will have more choices for Arrays
	def String genDataArray(int indentation, NodeOverride no)'''
	    «IF (util.containsNode(no,"DataGridColumn") || util.containsNode(no,"AdvancedDataGridColumn"))»
		«util.getIndentation(indentation)»table(class="dataGrid")
		«util.getIndentation(indentation+1)»thead
		«util.getIndentation(indentation+2)»tr(class="gridRow")
		«ENDIF»
	'''
	
	def String genTileList(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride", "class")»
		«util.getIndentation(indentation)»select(size="3"«flexOverride»)
		«util.getIndentation(indentation+1)»option(value="A") A
		«util.getIndentation(indentation+1)»option(value="B") B
		«util.getIndentation(indentation+1)»option(value="C") C
	'''
	 
	def String genHorizontalList(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»select(class="hList«flexOverride»" size="3")
		«util.getIndentation(indentation+1)»option(value="A") A
		«util.getIndentation(indentation+1)»option(value="B") B
		«util.getIndentation(indentation+1)»option(value="C") C
	'''
	 
	def String genTree(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»ul(class="treeView«flexOverride»")
		«util.getIndentation(indentation+1)»li: span(class="caret") Beverages
		«util.getIndentation(indentation+2)»ul(class="nested")
	'''
	 
	 
	// Advanced 
	
	def String genAdvancedDataGrid(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»table(class="dataGrid«flexOverride»")
		«util.getIndentation(indentation+1)»thead
		«util.getIndentation(indentation+2)»tr(class="gridRow")
		«util.getIndentation(indentation+3)»th(class="dataGridHeader"): span City
		«util.getIndentation(indentation+1)»tbody
		«util.getIndentation(indentation+2)»tr(class="gridRow")
		«util.getIndentation(indentation+3)»td(class="gridItem"): span Los Angeles
	'''
	

	
	// Media and Progress
	
	def String genImage(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»div(class="image«flexOverride»")
	'''
	
	def String genSWFLoader(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»div(class="sWFLoader«flexOverride»")
	'''
	
	// Control Bar
	
	def String genControlBar(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»div(class="controlBar«flexOverride»")
	'''
	
	def String genApplicationControlBar(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»div(class="applicationControlBar«flexOverride»")
	'''
	
	// Navigators
	
	def String genAccordion(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»button(class="accordion«flexOverride»") Section 1
		«util.getIndentation(indentation)»div(class="accordion-panel")
		«util.getIndentation(indentation)»p contents
	'''
	
	def String genToggleButtonBar(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»div(class="toggleButtonBar«flexOverride»")
	'''
	
	def String genMenuBar(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»div(class="menuBar«flexOverride»")
	'''
	
	def String genTabNavigator(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»ul(class="tabs«flexOverride»")
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
		«var id = getProperty(no, "id", "id")»
		«var i18n = getI18n(no, "label")»
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»div(class="hBox«flexOverride»"«id»)
		«IF i18n !== "" »
		«util.getIndentation(indentation+1)»label(«i18n»)
		«ENDIF»	
	'''
	
	def String genVBox(int indentation, NodeOverride no)'''
		«var id = getProperty(no, "id", "id")»
		«var i18n = getI18n(no, "label")»
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»div(class="vBox«flexOverride»"«id»)
		«IF i18n !== "" »
		«util.getIndentation(indentation+1)»label(«i18n»)
		«ENDIF»	
	'''
	
	def String genCanvas(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»div(class="canvas«flexOverride»")
	'''
	
	def String genVDividedBox(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»div(class="vDividedBox«flexOverride»")
		«util.getIndentation(indentation+1)»div(class="vDivider")
	'''
	
	def String genHDividedBox(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»div(class="hDividedBox«flexOverride»")
		«util.getIndentation(indentation+1)»div(class="hDivider")
	'''
	
	def String genPanel(int indentation, NodeOverride no)'''
		«var id = getProperty(no, "id", "id")»
		«var i18n =  getI18n(no, "title")»
		«var title = getText(no, "title")»
		«var flexOverride = getProperty(no, "flexOverride", "class")»
		«util.getIndentation(indentation)»div(class="panel«flexOverride»"«id»)
		«IF i18n !== "" || title !== ""»
		«util.getIndentation(indentation+1)»div(class="panelTitle")
		«util.getIndentation(indentation+2)»p«IF i18n !== ""»(«i18n»)«ELSEIF title !== ""»«title»«ENDIF»
		«ENDIF»
		«util.getIndentation(indentation+1)»div(class="panelContent")
		
	'''
	
	def String genTile(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»div(class="tile«flexOverride»")
	'''
	
	def String genForm(int indentation, NodeOverride no)'''
		«var flexOverride = getProperty(no, "flexOverride")»
		«util.getIndentation(indentation)»div(class="form«flexOverride»")
		«util.getIndentation(indentation+1)»form(id="id")
		«util.getIndentation(indentation+2)»div(class="formTitle")
		«util.getIndentation(indentation+3)»p Form Title
		«util.getIndentation(indentation+2)»div(class="formContent")
	'''
	
	def String genFormItem(int indentation, NodeOverride no)'''
		«var id = getProperty(no, "id", "id")»
		«var i18n =  getI18n(no, "label")»
		«var text = getText(no, "label")»
		«var required = getRequired(no, "required")»
		«var flexOverride = getProperty(no, "flexOverride", "class")»
		«IF id === "" && i18n === "" && flexOverride === ""»
		«util.getIndentation(indentation)»label«text»
		«ELSE»
		«util.getIndentation(indentation)»label(«id»«i18n»«flexOverride» )«text»
		«ENDIF»
		«IF required»«util.getIndentation(indentation)»span(class="required") *«ENDIF»
	'''
		
	// Other
	
	def String genRemoteObject(int indentation, NodeOverride no)'''
		«util.getIndentation(indentation)»div(class="RemoteObject")
	'''
	
	def String genMethod(int indentation, NodeOverride no)'''
		«util.getIndentation(indentation)»div(class="Method")
	'''
	
	def String genManager(int indentation, NodeOverride no)'''
		«util.getIndentation(indentation)»div(class="Manager")
	'''
	
	def String genIncludeComponent(int indentation, NodeOverride no, LinkedHashMap<String, String> nsl){
		if (nsl.get(no.prefix) !== null) {
		    var comment=""
			if (nsl.get(no.prefix).contains("http:") || nsl.get(no.prefix).contains("https:")) comment="//-"
			util.getIndentation(indentation) + comment + "include /" + nsl.get(no.prefix).replace("*", no.name)+".pug"
		}
	}
	
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
	
	
	/* GET VARS */
	
	def getI18n(NodeOverride no, String mxmlProperty){
		var i18n =  NodeOverride.getAttrCheckI18N(no, mxmlProperty) !== null && NodeOverride.getAttrCheckI18N(no, mxmlProperty).contains("i18n") ? " " + NodeOverride.getAttrCheckI18N(no, mxmlProperty) : ""
		return i18n
	}
	
	def getText(NodeOverride no, String mxmlProperty){
		var text = NodeOverride.getAttrCheckI18N(no, mxmlProperty) !== null && !NodeOverride.getAttrCheckI18N(no, mxmlProperty).contains("i18n") ? " " + NodeOverride.getAttrCheckI18N(no, mxmlProperty).replace("{", "").replace("}", "") : ""	
		return text
	}
	
//	def getVisible(NodeOverride no, String mxmlProperty){
//		var visible = NodeOverride.getAttr(no, mxmlProperty) !== null && NodeOverride.getAttr(no, mxmlProperty).equals("false") ? " style='visibility: hidden'"  : ""
//		return visible
//	}
	
	def getRequired(NodeOverride no, String mxmlProperty){
		var required = NodeOverride.getAttr(no, mxmlProperty) !== null && NodeOverride.getAttr(no, mxmlProperty).equals("true") ? true : false
		return required
	}
	
	def getProperty(NodeOverride no, String mxmlProperty, String pugProperty){
		var property = NodeOverride.getAttr(no, mxmlProperty) !== null ? " " + pugProperty + "='" + NodeOverride.getAttr(no, mxmlProperty).replace("{", "").replace("}", "") + "'": "" 
		return property
	}
	
	def getProperty(NodeOverride no, String mxmlProperty){
		var property = NodeOverride.getAttr(no, mxmlProperty) !== null ? " " + NodeOverride.getAttr(no, mxmlProperty).replace("{", "").replace("}", "") : "" 
		return property
	}
	
	def getEnabled(NodeOverride no, String mxmlProperty){
		var enabled = NodeOverride.getAttr(no, mxmlProperty) !== null && NodeOverride.getAttr(no, mxmlProperty).equals("false") ? " disabled" : ""
		return enabled
	}
	
	
	
}