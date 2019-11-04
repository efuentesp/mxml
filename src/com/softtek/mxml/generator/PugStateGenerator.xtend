package com.softtek.mxml.generator

import com.softtek.mxml.mxml.ComplexNode
import com.softtek.mxml.mxml.Node
import com.softtek.mxml.utils.ComplexNodeOverride
import com.softtek.mxml.utils.FlexOverride
import com.softtek.mxml.utils.NodeOverride
import com.softtek.mxml.utils.State
import com.softtek.mxml.utils.Util
import java.util.LinkedHashMap
import java.util.LinkedHashSet
import org.eclipse.xtext.generator.IFileSystemAccess2
import java.util.ArrayList

class PugStateGenerator {

	LinkedHashSet<State> states
	Util util = new Util()
	String fname
	LinkedHashMap<String, String> nsl
	PugElementGenerator pugElementGenerator = new PugElementGenerator()	
	
	def void genStates(Node node, String fname, String path, IFileSystemAccess2 fsa, LinkedHashSet<State> states, LinkedHashMap<String, String> nsl) {
		this.fname = fname
		this.nsl = nsl
		this.states = states		
		fsa.generateFile("pug/"+path+"/" + fname + ".pug", this.genBaseState(node, states))				
		for(state : states){			
			fsa.generateFile("pug/"+path+"/" + fname + "_" + state.name.toFirstLower +".pug", this.genState(State.getOverrideApp(node), State.basedOnState(state, states)))
		}			
	}
	

	/* GEN BASE STATE */
	
	def CharSequence genBaseState(Node node, LinkedHashSet<State> states)'''
	div(id="«fname»_states" class="states")
	«util.getIndentation(1)»button(id="btn_«fname»_baseState") «fname» [baseState]
	«FOR state : states»
	«util.getIndentation(1)»button(id="btn_«fname»_«state.name.toFirstLower»") «fname» [«state.name.toFirstLower»]
	«ENDFOR»
	«util.getIndentation(1)»div(id="«fname»_baseState")
	«this.genNodes(1, node)»
	«FOR state : states»
	«util.getIndentation(1)»include ./«fname»_«state.name.toFirstLower».pug
	«ENDFOR»
	'''
	
    def CharSequence genNodes(int indentation, Node n)'''
		«IF (n instanceof ComplexNode)»				
		  «IF !n.name.equalsIgnoreCase('states')»	
		  «pugElementGenerator.getNodeType(indentation, n, null, this.nsl, this.fname)»
		  «var innernode = n as ComplexNode»
		  «FOR i: innernode.nodes»
		  	«IF  n.name.equalsIgnoreCase('Application')»
		  		«genNodes(indentation+3, i)»
		  	«ELSEIF n.name.equalsIgnoreCase('Panel')»
		  		«genNodes(indentation+2, i)»
		  	«ELSE»
		  		«genNodes(indentation+1, i)»
		  	«ENDIF»		  
		  «ENDFOR»	
		  «ENDIF»		
		«ELSE»
		   «pugElementGenerator.getNodeType(indentation, n, null, this.nsl, this.fname)»
		«ENDIF»
	'''	
	
	/* GEN STATES */
	
	def CharSequence genState(NodeOverride node, State state)'''
	div(id="«this.fname»_«state.name.toFirstLower»")
	«this.genNodesState(0, node, state.flexOverrides)»
	'''
	
	def CharSequence genNodesState(int indentation, NodeOverride n, LinkedHashSet<FlexOverride> overrides)'''		
		«var o = this.overrideNode(NodeOverride.getAttr(n, "id"), overrides)»
		«IF (n instanceof ComplexNodeOverride)»				
		  «IF !n.name.equalsIgnoreCase('states') && !n.name.equalsIgnoreCase('filename')»	
		  	«IF o !== null»
				«var ArrayList<NodeOverride> result = applyComplexNodeOverride(n, o)»
				«FOR r: result»
					«genNodesState(indentation, r, FlexOverride.removeFlexOverride(o, overrides))»
				«ENDFOR»
		  	«ELSE»
		  	  «pugElementGenerator.getNodeType(indentation, null, n, this.nsl, this.fname)»
		  	  «var innernode = n as ComplexNodeOverride»
  			  «FOR i: innernode.nodes»
  			  	«IF  n.name.equalsIgnoreCase('Application')»
					«genNodesState(indentation+3, i, overrides)»
  			  	«ELSEIF n.name.equalsIgnoreCase('Panel')»
					«genNodesState(indentation+2, i, overrides)»
  			  	«ELSE»
					«genNodesState(indentation+1, i, overrides)»
  			  	«ENDIF»		  
  			  «ENDFOR»	
		  	«ENDIF»	  	
		  «ENDIF»		
		«ELSE»				
			«IF o !== null»	
				«overrideSimpleNode(indentation, n, o, overrides)»
			«ELSE»
			«pugElementGenerator.getNodeType(indentation, null, n, this.nsl, this.fname)»
			«ENDIF»
		«ENDIF»
	'''	
	
	def watchNodesOverride(NodeOverride node){
		if (node instanceof ComplexNodeOverride){  
			println(node.name)
			var innernode = node as ComplexNodeOverride
		  	for ( i: innernode.nodes ){
		  		watchNodesOverride(i)
		  	}	  	
		}else{
			println(node.name)
		}
	}
		
	def FlexOverride overrideNode(String nodeId, LinkedHashSet<FlexOverride> overrides){		
		for(o : overrides){
			if( nodeId !== null &&
				( nodeId.equalsIgnoreCase(o.relativeTo) || nodeId.equalsIgnoreCase(o.target) ) ){
				return o				
			}
		}
		return null
	}	
	
	def private CharSequence overrideSimpleNode(int indentation, NodeOverride n, FlexOverride o, LinkedHashSet<FlexOverride> overrides)'''
		«IF o.type.equalsIgnoreCase("AddChild")»					
			«FOR node : this.applySimpleNodeAddChildOverride(n, o)»
				«pugElementGenerator.getNodeType(indentation, null, node, this.nsl, this.fname)»
			«ENDFOR»
		«ELSE»
			«var node = applyNodeOverride(n, this.overrideNode(NodeOverride.getAttr(n, "id"), overrides))»
			«pugElementGenerator.getNodeType(indentation, null, node, this.nsl, this.fname)»
		«ENDIF»
	'''
			
	def private NodeOverride applyNodeOverride(NodeOverride node, FlexOverride o){
		if(o.type.equalsIgnoreCase("RemoveChild")){
			return FlexOverride.removeChildOverride(node)
		}else if(o.type.equalsIgnoreCase("SetProperty")){
			return FlexOverride.setPropertyOverride(node)
		}else if(o.type.equalsIgnoreCase("SetStyle")){
			return FlexOverride.setStyleOverride(node)
		}else if(o.type.equalsIgnoreCase("SetEventHandler")){
			return FlexOverride.setEventHandlerOverride(node)
		}
	}
	
	def private ArrayList<NodeOverride> applyComplexNodeOverride(NodeOverride node, FlexOverride o){			
		var ArrayList<NodeOverride> result = new ArrayList<NodeOverride>()
		if(o.type.equalsIgnoreCase("AddChild")){			
			if("before".equalsIgnoreCase(o.position) || "after".equalsIgnoreCase(o.position)){			
				result.addAll(applyComplexNodeAddChildBeforeAfterOverride(node, o))
			}else{
				result.addAll(applyComplexNodeAddChildFirstLastOverride(node, o))
			}			
		}else{
			result.add(applyNodeOverride(node, o))			
		}
		return result
	}
	

	def private ArrayList<NodeOverride> applyComplexNodeAddChildBeforeAfterOverride(NodeOverride node, FlexOverride o){
		if("before".equalsIgnoreCase(o.position)){
			return FlexOverride.addChildBefore(node, o.childs)
		}else if("after".equalsIgnoreCase(o.position)){
			return FlexOverride.addChildAfter(node, o.childs)
		}
	}
	
	def private ArrayList<NodeOverride> applyComplexNodeAddChildFirstLastOverride(NodeOverride node, FlexOverride o){
		if("firstChild".equalsIgnoreCase(o.position)){
			return FlexOverride.addFirstChild(node as ComplexNodeOverride, o.childs)
		}else {
			return FlexOverride.addLastChild(node as ComplexNodeOverride, o.childs)
		}
	}
	
	def private ArrayList<NodeOverride> applySimpleNodeAddChildOverride(NodeOverride node, FlexOverride o){		
		if(o.position === null || o.position.equalsIgnoreCase("after")){
			return FlexOverride.addChildAfter(node, o.childs)			
		}else if(o.position.equalsIgnoreCase("before")){
			return FlexOverride.addChildBefore(node, o.childs)
		}
	}	
	
}