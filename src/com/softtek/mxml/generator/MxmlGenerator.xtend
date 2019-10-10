/*
 * generated by Xtext 2.19.0
 */
package com.softtek.mxml.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import com.softtek.mxml.mxml.Node
import com.softtek.mxml.generator.HtmlGenerator
import com.softtek.mxml.generator.PugGenerator
import com.softtek.mxml.mxml.ComplexNode
import com.softtek.mxml.mxml.Project

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class MxmlGenerator extends AbstractGenerator {
  HtmlGenerator htmlGenerator= new HtmlGenerator()
  PugGenerator pugGenerator= new PugGenerator()
  
	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		 pugGenerator.doGenerator(resource,fsa)
		  
//		fsa.generateFile('greetings.txt', 'People to greet: ' + 
//			resource.allContents
//				.filter(Greeting)
//				.map[name]
//				.join(', '))
	}
	
	
	def void printNodes(Node n){
		if (n instanceof ComplexNode)
			  { 
			  	println("Complex:"+n.name)
			  	var innernode = n as ComplexNode 
			  	for(i: innernode.nodes){
			  		printNodes(i)
			  	}
			  	println("Complex:/"+n.name)
		}
		else
		println("Simple:"+n.name)
	}
	
	
	
}
