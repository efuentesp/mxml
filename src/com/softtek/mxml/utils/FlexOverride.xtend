package com.softtek.mxml.utils

import com.softtek.mxml.mxml.Node
import java.util.ArrayList
import org.eclipse.emf.common.util.EList
import java.util.LinkedHashSet

class FlexOverride {
	
	// type = AddChild | RemoveChild | SetProperty | SetStyle | SetEventHandler
	String type; 
	String relativeTo;
	ArrayList<NodeOverride> childs;
	// position = firstChild | lastChild | before | after
	String position;
	String target;	
	String value;
	String handler;	 
	
	new (String type){
		this.type = type
		this.childs = new ArrayList<NodeOverride>()
	}
	
	def setType(String type){
		this.type = type
	}
	
	def String getType(){
		return this.type	
	}	
	
	def setRelativeTo(String relativeTo){
		this.relativeTo = relativeTo
	}
	
	def String getRelativeTo(){
		return this.relativeTo	
	}
	
	def setChilds(ArrayList<NodeOverride> childs){
		this.childs = childs
	}
	
	def ArrayList<NodeOverride> getChilds(){
		return this.childs	
	}
	
	def setPosition(String position){
		this.position = position
	}
	
	def String getPosition(){
		return this.position	
	}
	
	def setTarget(String target){
		this.target = target
	}
	
	def String getTarget(){
		return this.target	
	}	
	
	def setValue(String value){
		this.value = value
	}
	
	def String getValue(){
		return this.value	
	}
		
	def  setHandler(String handler){
		this.handler = handler
	}
	
	def String getHandler(){
		return this.handler	
	}
	
	
	/* Flex Override AddChild */
	
	def static ArrayList<NodeOverride> addFirstChild(ComplexNodeOverride node, ArrayList<NodeOverride> newNodes){
		var ArrayList<NodeOverride> aux = new ArrayList<NodeOverride>()		
		for(n : newNodes){
			aux.add(addChildOverride(n))
		}		
		aux.addAll(node.nodes)
		return aux
	}
	
	def static ArrayList<NodeOverride> addLastChild(ComplexNodeOverride node, ArrayList<NodeOverride> newNodes){
		var ArrayList<NodeOverride> aux = new ArrayList<NodeOverride>()	
		aux.addAll(node.nodes)	
		for(n : newNodes){
			aux.add(addChildOverride(n))
		}				
		return aux
	}
	
	def static ArrayList<NodeOverride> addChildBefore(NodeOverride node, ArrayList<NodeOverride> newNodes){
		var ArrayList<NodeOverride> aux = new ArrayList<NodeOverride>()
		aux.add(node)
		for(childNode : newNodes){
			aux.add(addChildOverride(childNode))			
		}		
		return aux
	}
	
	def static ArrayList<NodeOverride> addChildAfter(NodeOverride node, ArrayList<NodeOverride> newNodes){
		var ArrayList<NodeOverride> aux = new ArrayList<NodeOverride>()		
		for(childNode : newNodes){
			aux.add(addChildOverride(childNode))
		}	
		aux.add(node)
		return aux
	}
	
	/* Flex Overrides */
	
	def static NodeOverride addChildOverride(NodeOverride node){
		var ArrayList<AttrOverride> aux = node.attrs
		aux.add(new AttrOverride("", "flexOverride", "addChild"))
		node.attrs = aux
		return node
	}
	
	def static NodeOverride removeChildOverride(NodeOverride node){
		var ArrayList<AttrOverride> aux = node.attrs
		aux.add(new AttrOverride("", "flexOverride", "removeChild"))
		node.attrs = aux
		return node
	}
	
	def static NodeOverride setPropertyOverride(NodeOverride node){
		var ArrayList<AttrOverride> aux = node.attrs	
		aux.add(new AttrOverride("", "flexOverride", "setProperty"))
		node.attrs = aux
		return node
	}
	
	def static NodeOverride setStyleOverride(NodeOverride node){
		var ArrayList<AttrOverride> aux = node.attrs	
		aux.add(new AttrOverride("", "flexOverride", "setStyle"))
		node.attrs = aux
		return node
	}	
	
	def static NodeOverride setEventHandlerOverride(NodeOverride node){
		var ArrayList<AttrOverride> aux = node.attrs
		aux.add(new AttrOverride("", "flexOverride", "setEventHandler"))
		node.attrs = aux
		return node
	}	
	
	def static String clearString(String cadena){    
		return (cadena === null) ? "" : cadena.replace("{", "").
					replace("}", "").
					replace("this.", "")    		
    }
    
    override toString(){    	
    	println("   -- type: " + this.type)
    	println("   -- relativeTo: " + this.relativeTo)
    	println("   -- childs: " + this.childs.toString)
    	println("   -- posotion: " + this.position)
    	println("   -- target: " + this.target)    	
    	println("   -- value: " + this.value)
    	println("   -- handler: " + this.handler)
    }
    
    def static LinkedHashSet<FlexOverride> removeFlexOverride(FlexOverride flexOverride, LinkedHashSet<FlexOverride> overrides){
    	var LinkedHashSet<FlexOverride> newOverrides = new LinkedHashSet<FlexOverride>()
    	newOverrides.addAll(overrides)
    	newOverrides.remove(flexOverride)
    	return newOverrides
    }
    
	
}