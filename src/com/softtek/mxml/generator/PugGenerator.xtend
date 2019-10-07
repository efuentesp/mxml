package com.softtek.mxml.generator

import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.eclipse.emf.ecore.resource.Resource
import com.softtek.mxml.mxml.Node
import java.util.List
import com.softtek.mxml.mxml.ComplexNode

class PugGenerator {
	
	def doGenerator(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
	    var nodes = resource.allContents.filter(Node).toList
	    println(resource.URI.lastSegment)
	    var filename=resource.URI.lastSegment.substring(0,resource.URI.lastSegment.indexOf("."))
		fsa.generateFile("pug/"+filename+".pug", genPugFile(nodes))	
	}
	
	
	def CharSequence genPugFile(List<Node> nodes) '''
		doctype html
		html(lang="en")
		  head
		    title= pageTitle
		  body
		  «genNodes(nodes.head)»
	'''
      
    def CharSequence genNodes(Node n)'''
		«IF (n instanceof ComplexNode)»
		  «getNodeType(n)»
		  «var innernode = n as ComplexNode»
		  «FOR i: innernode.nodes»
		  «   genNodes(i)»
		  «ENDFOR»
		«ELSE»
		  «getNodeType(n)»
		«ENDIF»
	'''
      
      //Use this syntax?
      //label(for='«getNodeAttrKeyValue(n,"id")»') «getNodeAttrValue(n,"text")»
      //button(for='«getNodeAttrKeyValue(n,"id")»') «getNodeAttrValue(n,"label")»
	      
		 
	def CharSequence getNodeType(Node n)'''
		«IF (n.prefix.equals('mx')) » 
		«IF (n.name.equals('Label'))» 
		  label.«n.prefix»#«getNodeAttrValue(n,"id")» «getNodeAttrValue(n,"text")»
		«ENDIF»
	    «IF (n.name.equals('Button'))» 
	      button.«n.prefix»#«getNodeAttrValue(n,"id")» «getNodeAttrValue(n,"label")»
	    «ENDIF»
	    «IF (!n.name.equals('Label') && !n.name.equals('Button') )» 
		.«getNodeClass(n)»
		«ENDIF»
        «ENDIF»
	'''

	def String getNodeAttrValue(Node n, String key){
	   for( a:n.attrs.toList)
	    if(a.key.equals(key))  return (a.value)
	}
    
    def String getNodeAttrKeyValue(Node n, String key){
	   for( a:n.attrs.toList)
	    if(a.key.equals(key))  return (a.key+ ":" +"\""+a.value+"\"")
	}
	
	def String getNodeClass(Node n){
	   return (n.name.toLowerCase)
	}
	
}