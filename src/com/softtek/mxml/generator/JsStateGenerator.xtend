package com.softtek.mxml.generator

import com.softtek.mxml.mxml.ComplexNode
import com.softtek.mxml.mxml.Node
import com.softtek.mxml.mxml.Project
import com.softtek.mxml.utils.State
import com.softtek.mxml.utils.Util
import java.util.LinkedHashMap
import java.util.LinkedHashSet
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess2

class JsStateGenerator {
		
	Util util = new Util()
	
	def doGenerator(IFileSystemAccess2 fsa, LinkedHashMap<String,LinkedHashSet<State>> appStates) {		
		fsa.generateFile("dist/assets/states/states.js", appStates.genStatesJs())		
	}
	
	def CharSequence genStatesJs(LinkedHashMap<String,LinkedHashSet<State>> appStates)'''
	$(document).ready(function() {
«FOR entry : appStates.entrySet» 
	     
	  «"  "»hideAllStates_«util.removeNameDecorator(entry.key)»();
	  «"  "»$("#«util.removeNameDecorator(entry.key)»_baseState").show();
	    
	  «"  "»$("#btn_«util.removeNameDecorator(entry.key)»_baseState").click(function() {
	  «"  "»  hideAllStates_«util.removeNameDecorator(entry.key)»();
	  «"  "»  $("#«util.removeNameDecorator(entry.key)»_baseState").show();
	  «"  "»});
«FOR state : entry.value»
	    
	 «"  "»$("#btn_«util.removeNameDecorator(entry.key)»_«state.name.toFirstLower»").click(function() {
	 «"    "»hideAllStates_«util.removeNameDecorator(entry.key)»();
	 «"    "»$("#«util.removeNameDecorator(entry.key)»_«state.name.toFirstLower»").show();
	 «"  "»});
«ENDFOR»
«ENDFOR»
	});
	 
«FOR entry : appStates.entrySet» 	
	  
	function hideAllStates_«util.removeNameDecorator(entry.key)»() {
	  $("#«util.removeNameDecorator(entry.key)»_baseState").hide();
	«FOR state : entry.value»
	  «"  "»$("#«util.removeNameDecorator(entry.key)»_«state.name.toFirstLower»").hide();
	«ENDFOR»
	}	
«ENDFOR»
	'''
	
}