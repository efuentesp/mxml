package com.softtek.mxml.generator

import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.eclipse.emf.ecore.resource.Resource
import com.softtek.mxml.mxml.Node
import java.util.List
import com.softtek.mxml.mxml.ComplexNode
import com.softtek.mxml.mxml.Project
import com.softtek.mxml.utils.Util

class PugGenerator {
	
	Util util = new Util()

	def doGenerator(Resource r, IFileSystemAccess2 fsa) {
       for (p : r.allContents.toIterable.filter(typeof(Project))){
		for (m: p.files){
			 m.file_ref.generateCodeByNode(m.file_ref.name,m.path_ref,fsa)
		}
	   }
	}
	
	def void generateCodeByNode(Node node, String fname, String path,IFileSystemAccess2 fsa) {				
		fsa.generateFile("pug/"+path+"/"+fname+".pug", genPugFile(node))				
	}
	
	def CharSequence genPugFile(Node node) '''
		doctype html
		html(lang="en")
		  head
		    title= pageTitle
		  body
		«genNodes(0, node)»
	'''
      
    def CharSequence genNodes(int indentation, Node n)'''
		«IF (n instanceof ComplexNode)»
		  «util.getIndentation(indentation+1)»«getNodeType(n)»
		  «var innernode = n as ComplexNode»
		  «FOR i: innernode.nodes»
		  «genNodes(indentation+1, i)»
		  «ENDFOR»
		«ELSE»
		   «util.getIndentation(indentation+1)»«getNodeType(n)»
		«ENDIF»
	'''
      
      //Use this syntax?
      //label(for='«getNodeAttrKeyValue(n,"id")»') «getNodeAttrValue(n,"text")»
      //button(for='«getNodeAttrKeyValue(n,"id")»') «getNodeAttrValue(n,"label")»
	      
		 
	def CharSequence getNodeType(Node n)'''
		«IF (n.prefix.equals('mx')) » 
		«IF (n.name.equals('Label'))» 
		  label.«n.prefix»#«util.getNodeAttrValue(n,"id")» «util.getNodeAttrValue(n,"text")»
		«ENDIF»
	    «IF (n.name.equals('Button'))» 
	      button.«n.prefix»#«util.getNodeAttrValue(n,"id")» «util.getNodeAttrValue(n,"label")»
	    «ENDIF»
	    «IF (!n.name.equals('Label') && !n.name.equals('Button') )» 
		.«util.getNodeClass(n)»
		«ENDIF»
        «ENDIF»
	'''

	
}