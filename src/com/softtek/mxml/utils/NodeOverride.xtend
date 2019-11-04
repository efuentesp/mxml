package com.softtek.mxml.utils

import java.util.ArrayList
import com.softtek.mxml.mxml.Node

class NodeOverride {
	
	String prefix
	String name
	ArrayList<AttrOverride> attrs
	
	new(){
		attrs = new ArrayList<AttrOverride>()
	}
	
	new(String prefix, String name, ArrayList<AttrOverride> attrs){
		this.prefix = prefix
		this.name = name
		this.attrs = attrs
	}
	
	def setPrefix(String prefix){
		this.prefix = prefix
	}
	
	def getPrefix(){
		return this.prefix
	}
	
	def setName(String name){
		this.name = name
	}
	
	def getName(){
		return this.name
	}
	
	def setAttrs(ArrayList<AttrOverride> attrs){
		this.attrs = attrs
	}
	
	def getAttrs(){
		return this.attrs
	}
	
	def static NodeOverride fromNodeToNodeOverride(Node node){
		return new NodeOverride(node.prefix, node.name, AttrOverride.fromAttrToAttrOverride(node.attrs))
	}
	
	def static String getAttr(NodeOverride node, String key){
		for( a : node.attrs.toList)
		   	if(a.key.equals(key))  return (a.value)			
	}
	
	def static String getConcatAttrs(NodeOverride node, ArrayList<String> attrToSkip){
    	var String attrs = ""
    	if(!node.attrs.empty){
    		for(attr : node.attrs){    				
    			if(attr.value.contains("resourceManager.getString")){
    			 attrs += " " + "data-i18n" + "=\"" + getResourceFileNameFromAttrs(attr.value)+"."+getResourceNameFromAttrs(attr.value) + "\""  
    			}
    			else{
    				if(attrToSkip !== null && !attrToSkip.empty){
    					if(!attrToSkip.contains(attr.key)){
    						attrs += " " + attr.key + "=\"" + attr.value  + "\""
    					}
    				}else if( !attr.key.equalsIgnoreCase("flexOverride")){
    					attrs += " " + attr.key + "=\"" + attr.value  + "\""
    				}
    			}
    			 	   					
    		}
    	}
    	return attrs
    }
    
     def private static String getResourceFileNameFromAttrs(String value){
    	var fname   = value.split("\'").get(1).trim
    	var ns_name = value.split("\'").get(3).trim
    	var ns      = ns_name.replace(".","_").split("_").get(0)
    	var name    = ns_name.replace(".","_").split("_").get(1)  
    	return fname + "_" + ns  + "_" + name
    }
    
    
    def private static String getResourceNameFromAttrs(String value){
    	var ns_name = value.split("\'").get(3).trim
    	var name    = ns_name.replace(".","_").split("_").get(1)           
    	return name
    }    
    
	
}