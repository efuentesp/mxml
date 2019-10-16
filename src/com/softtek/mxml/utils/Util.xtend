package com.softtek.mxml.utils

import com.softtek.mxml.mxml.Node
import java.util.LinkedHashMap
import java.util.LinkedHashSet
import com.softtek.mxml.mxml.ComplexNode

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
    			attrs += " " + attr.key + ":\"" + attr.value  + "\""     			
    		}
    	}
    	return attrs
    }
    	
}