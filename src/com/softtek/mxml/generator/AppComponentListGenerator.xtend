package com.softtek.mxml.generator

import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.emf.ecore.resource.Resource
import com.softtek.mxml.mxml.Node
import com.softtek.mxml.mxml.ComplexNode
import com.softtek.mxml.mxml.Project
import com.softtek.mxml.utils.Util
import java.util.LinkedHashMap
import java.util.LinkedHashSet
import java.io.BufferedReader
import java.io.InputStreamReader
import java.io.IOException
import java.io.FileNotFoundException
import java.io.File

class AppComponentListGenerator {
	Util util = new Util()
  	LinkedHashMap<String, LinkedHashSet<String>> app = new LinkedHashMap<String, LinkedHashSet<String>>()
			
	def doGenerator(Resource r, IFileSystemAccess2 fsa) {
		for (p : r.allContents.toIterable.filter(typeof(Project))){
			for (m: p.files){			
				m.file_ref.generateCodeByNode(app, fsa)				 
			}
		}
	} 
	
	def LinkedHashMap<String, LinkedHashSet<String>> readComponentListFile(IFileSystemAccess2 fsa, LinkedHashMap<String, LinkedHashSet<String>> app){				
		var BufferedReader reader = new BufferedReader(new InputStreamReader(fsa.readBinaryFile("componentList.txt")));
		var LinkedHashSet<String> attrAux		
		while(reader.ready()) {
			attrAux = new LinkedHashSet<String>()
			var String[] line = reader.readLine().replace(",", "").replace("[", "").replace("]", "").split(" ")			
    		if(line.length > 1){    			
    			attrAux.addAll(line.subList(1, line.length))
    		}
    		util.addAppEntry(app, line.get(0),attrAux)		    		
		}				
		return app
	}
		
	def generateCodeByNode(Node node, LinkedHashMap<String, LinkedHashSet<String>> app, IFileSystemAccess2 fsa){				
		node.lookApp(app)	
		if(fsa.isFile("componentList.txt")){
			app.putAll(readComponentListFile(fsa, app))	
		}				
		fsa.generateFile("componentList.txt", genAppTagAttrs(app))			
	}
		
	def void lookApp(Node n, LinkedHashMap<String, LinkedHashSet<String>> app){
		if (n instanceof ComplexNode)
		  { 
		  	util.getAppTagsAttrs(n, app)
		  	var innernode = n as ComplexNode 
		  	for(i: innernode.nodes){			  	
		  		lookApp(i, app)
		  	}			  	
		}
		else
			util.getAppTagsAttrs(n, app)
	}
	
	def CharSequence genAppTagAttrs(LinkedHashMap<String, LinkedHashSet<String>> app)'''		
		«IF !app.empty»
			«FOR entry : app.entrySet»						
				«entry.key» «entry.value.toString»
			«ENDFOR»
		«ENDIF»		
	'''
	
}