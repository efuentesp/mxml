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
	   
	def String genLabel(int indentation, Node n)'''		
		«util.getIndentation(indentation)»label«this.getIdTag(n)» « getText(n)»
	'''
	
	def String genButton(int indentation, Node n)'''		
		«util.getIndentation(indentation)»button«this.getIdTag(n)»«IF !this.getOnClick(n).equalsIgnoreCase("")»(«this.getOnClick(n)»)«ENDIF»«IF !this.getLabel(n).equalsIgnoreCase("")» «this.getLabel(n)»«ENDIF»
	'''
	
	def String genView(int indentation, Node n, LinkedHashMap<String, String> nsl)'''		
		«util.getIndentation(indentation)»include pug/«IF nsl.get("views") !== null»«nsl.get("views").replace("*", n.name)»«ELSEIF nsl.get("view") !== null»«nsl.get("view").replace("*", n.name)»«ENDIF».pug
	'''
	
	def String genRemoteObject(int indentation, Node n)'''
		«util.getIndentation(indentation)».RemoteObject
		«IF !n.attrs.empty»«util.getIndentation(indentation+1)»p«util.getConcatAttrs(n)»«ENDIF»
	'''
	
	def String genMethod(int indentation, Node n)'''
		«util.getIndentation(indentation)».method
		«IF !n.attrs.empty»«util.getIndentation(indentation+1)»p«util.getConcatAttrs(n)»«ENDIF»
	'''
	
	def String genState(int indentation, Node n)'''
		«util.getIndentation(indentation)».State
		«IF !n.attrs.empty»«util.getIndentation(indentation+1)»p«util.getConcatAttrs(n)»«ENDIF»
	'''
	
	def String genVBox(int indentation, Node n)'''
		«util.getIndentation(indentation)».VBox
		«IF !n.attrs.empty»«util.getIndentation(indentation+1)»p«util.getConcatAttrs(n)»«ENDIF»
	'''
	
	def String genHBox(int indentation, Node n)'''
		«util.getIndentation(indentation)».HBox
		«IF !n.attrs.empty»«util.getIndentation(indentation+1)»p«util.getConcatAttrs(n)»«ENDIF»
	'''
	
	def String genTextInput(int indentation, Node n)'''
		«util.getIndentation(indentation)»input(type="text", name="")
	'''
	
	def String genImage(int indentation, Node n)'''
		«util.getIndentation(indentation)».image
		«IF !n.attrs.empty»«util.getIndentation(indentation+1)»p«util.getConcatAttrs(n)»«ENDIF»
	'''
	
	def String genManager(int indentation, Node n)'''
		«util.getIndentation(indentation)».manager
		«IF !n.attrs.empty»«util.getIndentation(indentation+1)»p«util.getConcatAttrs(n)»«ENDIF»
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
			text = util.getNodeAttrValue(node,"text") + " \""
		}
		return text
	}
		
}