package com.softtek.mxml.generator

import com.softtek.mxml.mxml.Node
import com.softtek.mxml.mxml.Project
import com.softtek.mxml.utils.State
import java.util.HashMap
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess2
import com.softtek.mxml.mxml.ComplexNode
import java.util.HashSet
import com.softtek.mxml.utils.Util
import com.softtek.mxml.utils.FlexOverride
import java.util.ArrayList
import java.util.LinkedHashMap
import java.util.LinkedHashSet

class PugStateGenetator {	
		
	def getAppStates(Resource r) {	
	  
		for (p : r.allContents.toIterable.filter(typeof(Project))){
			for (m: p.files){
				 m.file_ref.lookStates(m.file_ref.name)
			}
		}		
	
	}
	
	def lookStates(Node node, String fname){
		
			
	}
	
	
	
}