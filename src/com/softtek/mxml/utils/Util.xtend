package com.softtek.mxml.utils

import com.softtek.mxml.mxml.Node
import java.util.LinkedHashMap
import java.util.LinkedHashSet
import com.softtek.mxml.mxml.ComplexNode
import java.util.HashSet
import java.util.HashMap
import java.util.ArrayList
import com.softtek.mxml.mxml.Project
import org.eclipse.emf.ecore.resource.Resource

class Util {	
	
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
	
	def String getIndentation(int size){
		var String identation = ""
			for(var x = 0; x < size; x++){
				identation += "   "
			}
		return identation
	}
	
	def LinkedHashMap<String, String> getNodeAttrMap(Node n){
		var LinkedHashMap<String, String> attrs = new LinkedHashMap<String, String>()
			for( a : n.attrs.toList){
				attrs.put(a.key, a.value)
			}
		return attrs
	}
	
	def void getAppTagsAttrs(Node node, LinkedHashMap<String, LinkedHashSet<String>> app){
		var String nodeNameprintln =  (node.prefix.equalsIgnoreCase("<")) ? node.name : node.prefix + ":" +  node.name;		
		var LinkedHashSet<String> attrs = new LinkedHashSet<String>()					
				
		for(attr : node.attrs){
			if(attr.ns !== null){
				attrs.add(attr.ns + ":" + attr.key)
			}else{
				attrs.add(attr.key)
			}			
		}
		if(!node.prefix.equalsIgnoreCase("filename")){		
			addAppEntry(app, nodeNameprintln, attrs)
		}		
			
	}
	
	def addAppEntry(LinkedHashMap<String, LinkedHashSet<String>> app, String tag, LinkedHashSet<String> attrs){
		if(app.empty){
			app.put(tag, attrs)
		}else{
			if(app.containsKey(tag)){
				var LinkedHashSet<String> auxAttrs = new LinkedHashSet<String>()
				auxAttrs.addAll(app.get(tag))
				auxAttrs.addAll(attrs)
				app.remove(tag)
				app.put(tag, auxAttrs)
			}else{
				app.put(tag, attrs)
			}
		}
	}
    
    def LinkedHashMap<String, String> getNameSpaceLocation(LinkedHashMap<String, String> nsl, Node node){
    	var LinkedHashMap<String, String> aux = new LinkedHashMap<String, String>()
    	aux.putAll(nsl)    		
	    	if (node instanceof ComplexNode){	
	    		aux.putAll(lookNodeNameSpaceLocation(node))
		  		var innernode = node as ComplexNode
		  		for(i: innernode.nodes){
		  			aux.putAll(lookNodeNameSpaceLocation(i))
		  		}			  	
			}else{
				aux.putAll(lookNodeNameSpaceLocation(node))
			}
    	return aux
    }
    
    def LinkedHashMap<String, String> lookNodeNameSpaceLocation(Node node){
    	var LinkedHashMap<String, String> aux = new LinkedHashMap<String, String>()
    	    for(attr : node.attrs){
    	    	if(attr.ns!==null && attr.ns.equals('xmlns') ){
    	    		aux.put(attr.key, attr.value.replace(".","/"))
    	    	}
    	    }
    	return aux
    }
    
    def String getConcatAttrs(Node node){
    	var String attrs = ""
    	if(!node.attrs.empty){
    		for(attr : node.attrs){
    			if(attr.value.contains("resourceManager.getString")){
    			 attrs += " " + "data-i18n" + "=\"" + getResourceFileNameFromAttrs(attr.value)+"."+getResourceNameFromAttrs(attr.value) + "\""  
    			}
    			else
    			 attrs += " " + attr.key + "=\"" + attr.value  + "\""    			
    		}
    	}
    	return attrs
    }
    
    
    def State getStateByName(HashMap<String,HashSet<State>> viewsStates, String name, String fname){
    	var State state = null
    	var HashSet<State> states = new HashSet<State>()
    	if(!viewsStates.empty){
    		if(viewsStates.containsKey(fname)){
    			states.addAll(viewsStates.get(fname))
    			for(s : states){
    				if(s.name.equalsIgnoreCase(name)){
    					state = s
    				}
    			}
    		}
    	}
    	return state
    }
    
    def String clearFlexOverrideString(String cadena){    
		return (cadena == null) ? "" : cadena.replace("{", "").
					replace("}", "").
					replace("this.", "")    		
    }
    
	/* Get App States */
	
	def LinkedHashMap<String,LinkedHashSet<State>> getAppStates(Resource r) {	
	   var LinkedHashMap<String,LinkedHashSet<State>> viewsStates = new LinkedHashMap<String,LinkedHashSet<State>>()	
		
		for (p : r.allContents.toIterable.filter(typeof(Project))){
			for (m: p.files){
				 m.file_ref.lookStates(m.file_ref.name, viewsStates)
			}
		}		
		return viewsStates
	}
	
	def lookStates(Node node, String fname, LinkedHashMap<String,LinkedHashSet<State>> viewStates){
		if (node instanceof ComplexNode){	
			if (node.prefix.equalsIgnoreCase("mx") && node.name.equalsIgnoreCase('states') ){
				var states = node as ComplexNode
				for(s: states.nodes){					
					var State state = new State(fname, this.getNodeAttrValue(s, "name"), new LinkedHashSet<FlexOverride>(), this.getNodeAttrValue(s, "basedOn"))	
					for(o : (s as ComplexNode).nodes){
						this.addOverrides(state, o);
					}
					this.addState(fname, state, viewStates)
				}			
			}else{
				var innernode = node as ComplexNode
				for(i: innernode.nodes){
					lookStates(i, fname, viewStates)
				}
			}
		}		
	}
	
	def addState(String fname, State state, LinkedHashMap<String,LinkedHashSet<State>> viewStates){		
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
	
	def addOverrides(State state, Node node){					
		if (node.name.equalsIgnoreCase('AddChild')){
			this.addOverrideAddChild(state, node)
		}else if (node.name.equalsIgnoreCase('RemoveChild')){
			this.addOverrideRemoveChild(state, node)
		}else if (node.name.equalsIgnoreCase('SetProperty')){
			this.addOverrideSetProperty(state, node)
		}else if (node.name.equalsIgnoreCase('SetStyle')){
			this.addOverrideSetStyle(state, node)
		}else if (node.name.equalsIgnoreCase('SetEventHandler')){
			this.addOverrideSetEventHandler(state, node)
		}		
	}
		
	def addOverrideAddChild(State state, Node node){		
		var FlexOverride flexOverride = new FlexOverride("AddChild")
		flexOverride.relativeTo = this.clearFlexOverrideString(this.getNodeAttrValue(node, "relativeTo"))
		flexOverride.position = this.getNodeAttrValue(node, "position")		
		var HashSet<Node> childs = new HashSet<Node>()		
		var innernode = node as ComplexNode
		for(i : innernode.nodes ){
			childs.add(i)
		}
		flexOverride.childs = childs
		state.addFlexOverride(flexOverride)
	}
	
		
	def addOverrideRemoveChild(State state, Node node){
		var FlexOverride flexOverride = new FlexOverride("RemoveChild")
		flexOverride.target = this.clearFlexOverrideString(this.getNodeAttrValue(node, "target"))	
		state.addFlexOverride(flexOverride)
	}
	
	def addOverrideSetProperty(State state, Node node){
		var FlexOverride flexOverride = new FlexOverride("SetProperty")
		flexOverride.target = this.clearFlexOverrideString(this.getNodeAttrValue(node, "target"))
		flexOverride.name = this.getNodeAttrValue(node, "name")
		flexOverride.value = this.getNodeAttrValue(node, "value")
		state.addFlexOverride(flexOverride)
	}
	
	def addOverrideSetStyle(State state, Node node){
		var FlexOverride flexOverride = new FlexOverride("SetStyle")
		flexOverride.target = this.clearFlexOverrideString(this.getNodeAttrValue(node, "target"))
		flexOverride.name = this.getNodeAttrValue(node, "name")
		flexOverride.value = this.getNodeAttrValue(node, "value")
		state.addFlexOverride(flexOverride)
	}
	
	def addOverrideSetEventHandler(State state, Node node){
		var FlexOverride flexOverride = new FlexOverride("SetEventHandler")
		flexOverride.target = this.clearFlexOverrideString(this.getNodeAttrValue(node, "target"))
		flexOverride.name = this.getNodeAttrValue(node, "name")
		flexOverride.value = this.getNodeAttrValue(node, "handler")
		state.addFlexOverride(flexOverride)
	}
    
    // Resources
    def String getResourceFileNameFromAttrs(String value){
    	var fname   = value.split("\'").get(1).trim
    	var ns_name = value.split("\'").get(3).trim
    	var ns      = ns_name.replace(".","_").split("_").get(0)
    	var name    = ns_name.replace(".","_").split("_").get(1)  
    	return fname + "_" + ns  + "_" + name
    }
    
    
    def String getResourceNameFromAttrs(String value){
    	var ns_name = value.split("\'").get(3).trim
    	var name    = ns_name.replace(".","_").split("_").get(1)           
    	return name
    }
    
}