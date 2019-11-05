package com.softtek.mxml.utils

import java.util.ArrayList
import java.util.LinkedHashSet
import com.softtek.mxml.mxml.ComplexNode
import com.softtek.mxml.mxml.SimpleNode
import com.softtek.mxml.mxml.Node
import java.util.LinkedHashMap
import com.softtek.mxml.mxml.Project
import org.eclipse.emf.ecore.resource.Resource

class State {
	
	String fname;
	String name;
	LinkedHashSet<FlexOverride> flexOverrides;
	String basedOn;	
	
	 new(String fname, String name, String basedOn){
	 	this.fname = fname
	 	this.name = name
	 	this.basedOn = basedOn	 	
	 }
	
	 new (String fname, String name, LinkedHashSet<FlexOverride> flexOverrides, String basedOn){
	 	this.fname = fname
	 	this.name = name
	 	this.flexOverrides = flexOverrides
	 	this.basedOn = basedOn
	 }
	 
	 def public setFname(String fname){
	 	this.fname = fname
	 }
	 
	 def getFname(){
	 	return this.fname
	 }
	 
	 def setName(String name){
		this.name = name
	}
	
	def String getName(){
		return this.name	
	}
	
	def setFlexOverrides(LinkedHashSet<FlexOverride> flexOverrides){
		this.flexOverrides = flexOverrides
	}
	
	def LinkedHashSet<FlexOverride> getFlexOverrides(){
		return this.flexOverrides	
	}
	
	def addFlexOverride(FlexOverride flexOverride){
		this.flexOverrides.add(flexOverride)
	}
	
	def addFlexOverrides(LinkedHashSet<FlexOverride> flexOverrides){
		this.flexOverrides.addAll(flexOverrides)
	}
	
	def removeFlexOverride(FlexOverride flexOverride){
		this.flexOverrides.remove(flexOverride)
	}	
	
	def setBasedOn(String basedOn){
		this.basedOn = basedOn
	}
	
	def String getBasedOn(){
		return this.basedOn	
	}
	
	/* Devuelve los nodos que conforman el archivo con objetos del tipo NodeOverride y  ComplexNodeOverride */
	def static ComplexNodeOverride getOverrideApp(Node node){
		var ComplexNodeOverride fileNodes = new ComplexNodeOverride(node.prefix, node.name, AttrOverride.fromAttrToAttrOverride(node.attrs))		
		if(node instanceof ComplexNode){
			for(n : node.nodes){
			if(n instanceof ComplexNode){
				fileNodes.addNode(getComplexNodeOverride(n as ComplexNode, new ComplexNodeOverride(n.prefix, n.name, AttrOverride.fromAttrToAttrOverride(n.attrs))))
			}else if(n instanceof SimpleNode){
				fileNodes.addNode(new NodeOverride(n.prefix, n.name, AttrOverride.fromAttrToAttrOverride(n.attrs)))
			}
		}
		}else{
			fileNodes.addNode(new NodeOverride(node.prefix, node.name, AttrOverride.fromAttrToAttrOverride(node.attrs)))
		}
			
		return fileNodes
	}
	
	def static NodeOverride getComplexNodeOverride(ComplexNode node, ComplexNodeOverride root){		
		for(n : node.nodes){
			if(n instanceof ComplexNode){
				root.addNode(getComplexNodeOverride(n, new ComplexNodeOverride(n.prefix, n.name, AttrOverride.fromAttrToAttrOverride(n.attrs))))
			}
			else{
				root.addNode(new NodeOverride(n.prefix, n.name, AttrOverride.fromAttrToAttrOverride(n.attrs)))
			}
		}
		return root
	}
	
	/* Añade en los State los overrides del state señalado como basedOn */
	def static State basedOnState(State state, LinkedHashSet<State> states){
		if(state.basedOn !== ""){
			for( s : states){
				var State basedOnState = s
				if(basedOnState.name.equalsIgnoreCase(state.basedOn)){		
					if(basedOnState.basedOn !== null){
						basedOnState = basedOnState(basedOnState, states)
						state.addFlexOverrides(basedOnState.flexOverrides)
					}else{
						state.addFlexOverrides(basedOnState.flexOverrides)	
					}					
				}
			}
		}
		return state
	}
	
	
	def static printState (State state){		
	 	println("-------> " + state.name)	  		
 		for(o : state.flexOverrides){
 			println(o.type)
 		}		 
	}
	
	
	/* GEN APP STATES */
	
	def static LinkedHashMap<String,LinkedHashSet<State>> getAppStates(Resource r) {	
	   var LinkedHashMap<String,LinkedHashSet<State>> viewsStates = new LinkedHashMap<String,LinkedHashSet<State>>()	
		
		for (p : r.allContents.toIterable.filter(typeof(Project))){
			for (m: p.files){
				 State.getOverrideApp(m.file_ref).lookStates(m.file_ref.name, viewsStates)
			}
		}		
		return viewsStates
	}
		
	def private static lookStates(NodeOverride node, String fname, LinkedHashMap<String,LinkedHashSet<State>> viewStates){
		if (node instanceof ComplexNodeOverride){	
			if (node.prefix.equalsIgnoreCase("mx") && node.name.equalsIgnoreCase('states') ){
				var states = node as ComplexNodeOverride
				for(s: states.nodes){					
					var State state = new State(fname, NodeOverride.getAttr(s, "name").replace("{", "").replace("}", "").trim, new LinkedHashSet<FlexOverride>(), NodeOverride.getAttr(s, "basedOn"))	
					for(o : (s as ComplexNodeOverride).nodes){
						addOverrides(state, o);
					}
					addState(fname, state, viewStates)
				}			
			}else{
				var innernode = node as ComplexNodeOverride
				for(i: innernode.nodes){
					lookStates(i, fname, viewStates)
				}
			}
		}		
	}
	
	def static private addState(String fname, State state, LinkedHashMap<String,LinkedHashSet<State>> viewStates){		
		var LinkedHashSet<State> states = new LinkedHashSet<State>()
		if(viewStates.empty){
			states.add(state)
			viewStates.put(fname, states)
		}else{
			states.add(state)
			if(viewStates.containsKey(fname)){
				states.addAll(viewStates.get(fname))				
				viewStates.remove(fname)
				viewStates.put(fname, states)
			}
			else{
				viewStates.put(fname, states)
			}
		}
	}
	
	def private static addOverrides(State state, NodeOverride node){					
		if (node.name.equalsIgnoreCase('AddChild')){
			addOverrideAddChild(state, node)
		}else if (node.name.equalsIgnoreCase('RemoveChild')){
			addOverrideRemoveChild(state, node)
		}else if (node.name.equalsIgnoreCase('SetProperty')){
			addOverrideSetProperty(state, node)
		}else if (node.name.equalsIgnoreCase('SetStyle')){
			addOverrideSetStyle(state, node)
		}else if (node.name.equalsIgnoreCase('SetEventHandler')){
			addOverrideSetEventHandler(state, node)
		}		
	}
		
	def static private addOverrideAddChild(State state, NodeOverride node){		
		var FlexOverride flexOverride = new FlexOverride("AddChild")
		flexOverride.relativeTo = FlexOverride.clearString(NodeOverride.getAttr(node, "relativeTo"))
		flexOverride.position = NodeOverride.getAttr(node, "position")		
		var ArrayList<NodeOverride> childs = new ArrayList<NodeOverride>()		
		var innernode = node as ComplexNodeOverride			
		for(i : innernode.nodes ){
			childs.add(i)					
		}
		flexOverride.childs = childs			
		state.addFlexOverride(flexOverride)
	}
	
		
	def static private addOverrideRemoveChild(State state, NodeOverride node){
		var FlexOverride flexOverride = new FlexOverride("RemoveChild")
		flexOverride.target = FlexOverride.clearString(NodeOverride.getAttr(node, "target"))	
		state.addFlexOverride(flexOverride)
	}
	
	def static private addOverrideSetProperty(State state, NodeOverride node){
		var FlexOverride flexOverride = new FlexOverride("SetProperty")
		flexOverride.target = FlexOverride.clearString(NodeOverride.getAttr(node, "target"))		
		flexOverride.value = NodeOverride.getAttr(node, "value")
		state.addFlexOverride(flexOverride)
	}
	
	def static private addOverrideSetStyle(State state, NodeOverride node){
		var FlexOverride flexOverride = new FlexOverride("SetStyle")
		flexOverride.target = FlexOverride.clearString(NodeOverride.getAttr(node, "target"))		
		flexOverride.value = NodeOverride.getAttr(node, "value")
		state.addFlexOverride(flexOverride)
	}
	
	def static private addOverrideSetEventHandler(State state, NodeOverride node){
		var FlexOverride flexOverride = new FlexOverride("SetEventHandler")
		flexOverride.target = FlexOverride.clearString(NodeOverride.getAttr(node, "target"))		
		flexOverride.value = NodeOverride.getAttr(node, "handler")
		state.addFlexOverride(flexOverride)
	}
	
}