package com.softtek.mxml.generator

import com.softtek.mxml.mxml.Node
import com.softtek.mxml.mxml.Project
import com.softtek.mxml.utils.State
import com.softtek.mxml.utils.Util
import java.util.LinkedHashMap
import java.util.LinkedHashSet
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess2
import com.softtek.mxml.utils.ComplexNodeOverride
import com.softtek.mxml.utils.NodeOverride

class PugGenerator {
	
	Util util = new Util()
	LinkedHashMap<String, String> nsl	
	String fname = ""
	LinkedHashMap<String,LinkedHashSet<State>> appStates = new LinkedHashMap<String,LinkedHashSet<State>>()
	PugStateGenerator pugStateGenerator = new PugStateGenerator()
	PugElementGenerator pugElementGenerator = new PugElementGenerator()
	
	def doGenerator(Resource r, IFileSystemAccess2 fsa, LinkedHashMap<String,LinkedHashSet<State>> appStates) {
	   this.appStates.putAll(appStates)
       for (p : r.allContents.toIterable.filter(typeof(Project))){
		for (m: p.files){
			 m.file_ref.generateCodeByNode(m.file_ref.name,m.path_ref,fsa)
		}
	   }
	}
	
	def void generateCodeByNode(Node node, String fname, String path,IFileSystemAccess2 fsa) {	
		//Create a mutable copy from immutable node 
		var NodeOverride overrideNode= State.getOverrideApp(node)
		this.fname = fname
		nsl =  new LinkedHashMap<String, String>()
      	nsl.putAll(util.getNameSpaceLocation(nsl, node))   
      	
      	if(!this.appStates.empty){
			if(this.appStates.containsKey(fname)){
				pugStateGenerator.genStates(node, util.removeNameDecorator(fname), path, fsa, this.appStates.get(fname), this.nsl)
			}else{
				fsa.generateFile("pug/"+path+"/"+util.removeNameDecorator(fname)+".pug", genNodes(-2, overrideNode) )
			}
		}else{
			fsa.generateFile("pug/"+path+"/"+util.removeNameDecorator(fname)+".pug", genNodes(-2, overrideNode))
		}	        	
	}

    
    def CharSequence genNodes(int indentation, NodeOverride n)'''
		«IF (n instanceof ComplexNodeOverride)»		  		  
		  «pugElementGenerator.getNodeType(indentation, n, this.nsl, this.fname)»
		  «var innernode = n as ComplexNodeOverride»
		  «FOR i: innernode.nodes»
		  	«IF  n.name.equalsIgnoreCase('Application')»
		  		«genNodes(indentation+3, i)»
		  	«ELSE»
		  		«genNodes(indentation+1, i)»
		  	«ENDIF»		  
		  «ENDFOR»
		«ELSE»
		   «pugElementGenerator.getNodeType(indentation, n, this.nsl, this.fname)»
		«ENDIF»
	'''
	
      //Use this syntax?
      //label(for='«getNodeAttrKeyValue(n,"id")»') «getNodeAttrValue(n,"text")»
      //button(for='«getNodeAttrKeyValue(n,"id")»') «getNodeAttrValue(n,"label")»
	      
	
}