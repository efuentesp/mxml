package com.softtek.mxml.utils

import com.softtek.mxml.mxml.Node
import java.util.LinkedHashMap
import java.util.LinkedHashSet

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

	
}