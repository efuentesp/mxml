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

class PugGenerator {
	
	Util util = new Util()
	LinkedHashMap<String, String> nsl
	PugElementGenerator pugElement = new PugElementGenerator()
	String fname = ""

	def doGenerator(Resource r, IFileSystemAccess2 fsa) {
       for (p : r.allContents.toIterable.filter(typeof(Project))){
		for (m: p.files){
			 m.file_ref.generateCodeByNode(m.file_ref.name,m.path_ref,fsa)
		}
	   }
	}
	
	def void generateCodeByNode(Node node, String fname, String path,IFileSystemAccess2 fsa) {	
		this.fname = fname
		nsl =  new LinkedHashMap<String, String>()
      	nsl.putAll(util.getNameSpaceLocation(nsl, node))   
        fsa.generateFile("pug/"+path+"/"+fname+".pug", genNodes(-2, node))			
	}

    
    def CharSequence genNodes(int indentation, Node n)'''
		«IF (n instanceof ComplexNode)»		  		  
		  «getNodeType(indentation, n)»
		  «var innernode = n as ComplexNode»
		  «FOR i: innernode.nodes»
		  	«IF  n.name.equalsIgnoreCase('Application')»
		  		«genNodes(indentation+3, i)»
		  	«ELSE»
		  		«genNodes(indentation+1, i)»
		  	«ENDIF»		  
		  «ENDFOR»
		«ELSE»
		   «getNodeType(indentation, n)»
		«ENDIF»
	'''
	
      //Use this syntax?
      //label(for='«getNodeAttrKeyValue(n,"id")»') «getNodeAttrValue(n,"text")»
      //button(for='«getNodeAttrKeyValue(n,"id")»') «getNodeAttrValue(n,"label")»
	      
		 
	def CharSequence getNodeType(int indentation, Node n)'''
		«IF n.prefix.equals('mx') » 
			«IF n.name.equals('Label')» 
				«pugElement.genLabel(indentation, n)»
			«ELSEIF n.name.equals('Button')» 
				«pugElement.genButton(indentation, n)»
			«ELSEIF n.name.equals('RemoteObject')»
				«pugElement.genRemoteObject(indentation, n)»
			«ELSEIF n.name.equals('method')»
				«pugElement.genMethod(indentation, n)»
			«ELSEIF n.name.equals('State')»	
				«pugElement.genState(indentation, n)»
			«ELSEIF n.name.equals('VBox')»	
				«pugElement.genVBox(indentation, n)»
			«ELSEIF n.name.equals('HBox')»	
				«pugElement.genHBox(indentation, n)»
			«ELSEIF n.name.equals('TextInput')»	
				«pugElement.genTextInput(indentation, n)»
			«ELSEIF n.name.equals('Image')»	
				«pugElement.genImage(indentation, n)»
			«ELSEIF n.name.equals('Application')»	
				«pugElement.genApp(n, this.fname)»
		    «ELSE» 				
				«util.getIndentation(indentation)».«util.getNodeClass(n)»
			«ENDIF»
        «ELSEIF n.prefix.equals('views') || n.prefix.equals('view')»
        	«pugElement.genView(indentation, n, this.nsl)»
        «ELSEIF n.prefix.equals('managers')»
        	«pugElement.genManager(indentation, n)»
        «ELSEIF n.prefix.equals('componentes')»
        	«pugElement.genComponente(indentation, n)»
        «ENDIF»
	'''	
}