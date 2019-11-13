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
	
	def addAttr(AttrOverride attr){
		this.attrs.add(attr)
	}
	
	def static NodeOverride fromNodeToNodeOverride(Node node){
		return new NodeOverride(node.prefix, node.name, AttrOverride.fromAttrToAttrOverride(node.attrs))
	}
	
	def static String getAttr(NodeOverride node, String key){
		for( a : node.attrs.toList)
		   	if(a.key.equals(key)) 
		   	  return (a.value)			
	}
	
	def static String getAttrCheckI18NextParagraph(NodeOverride node, String key){
		for( a : node.attrs.toList)
		   	if(a.key.equals(key)) {
		   	  var res= a.value
		   	  if (a.value.contains("resourceManager")) {
    			    res = "p(data-i18n" + "=\"" + getdatai18n(a.value) + "\")" 
    			    return res 
    		  }
    		  return "p " + res
    		}	
    	return ""	
	}
	
	def static String getAttrCheckI18NextLabel(NodeOverride node, String key){
		for( a : node.attrs.toList)
		   	if(a.key.equals(key)) {
		   	  var res= a.value
		   	  if (a.value.contains("resourceManager")) {
    			    res = "label(data-i18n" + "=\"" + getdatai18n(a.value) + "\")" 
    			    return res 
    		  }
    		  return "label " + res
    		}	
    	return ""	
	}
	
	def static String getAttrCheckI18Next(NodeOverride node, String key){
		for( a : node.attrs.toList)
		   	if(a.key.equals(key)) {
		   	  if (a.value.contains("resourceManager")) {
    			    return "" 
    		  }
    		  return a.value
    		}	
	}
	
	
	def static String getConcatAttrsNoDataResource(NodeOverride node, ArrayList<String> attrToSkip){
    	var String attrs = ""
    	var ArrayList<String> charstoremove = new ArrayList<String>();
    	charstoremove.add("{")
    	charstoremove.add("}")
    	if(!node.attrs.empty){
    		for(attr : node.attrs){   
    			var String value= attr.value
    				if(attrToSkip !== null && !attrToSkip.empty){
    					if(!attrToSkip.contains(attr.key)){
    						attrs += " " + attr.key + "=\"" + new Util().replaceStrings(charstoremove ,value)  + "\""
    					}
    				}else if( attr.key.equals("flexOverride")){
    					attrs += " class=\"" + new Util().replaceStrings(charstoremove ,value)  + "\""
    				}else{
    					attrs += " " + attr.key + "=\"" + new Util().replaceStrings(charstoremove ,value) + "\""
    				}			 	   					
    		}
    	}    
    	return checkHtmlAttrClass(attrs)
    }
	
	def static String getConcatAttrs(NodeOverride node, ArrayList<String> attrToSkip){
    	var String attrs = ""
    	var ArrayList<String> charstoremove = new ArrayList<String>();
    	charstoremove.add("{")
    	charstoremove.add("}")
    	if(!node.attrs.empty){
    		for(attr : node.attrs){   
    			var String value= attr.value			
    			if (attr.value.contains("?resourceManager")) {    
    			   attrs += " class=\"ternaryOperation\" data-i18n" + "=\"" + getdatai18n(attr.value)+ "\""
    			}else if (attr.value.contains("resourceManager")) {
    			   attrs += " " + "data-i18n" + "=\"" + getdatai18n(attr.value) + "\""    			    			
    			}else{
    				if(attrToSkip !== null && !attrToSkip.empty){
    					if(!attrToSkip.contains(attr.key)){
    						attrs += " " + attr.key + "=\"" + new Util().replaceStrings(charstoremove ,value)  + "\""
    					}
    				}else if( attr.key.equals("flexOverride")){
    					attrs += " class=\"" + new Util().replaceStrings(charstoremove ,value)  + "\""
    				}else{
    					attrs += " " + attr.key + "=\"" + new Util().replaceStrings(charstoremove ,value) + "\""
    				}
    			}    			 	   					
    		}
    	}    
    	return checkHtmlAttrClass(attrs)
    }
    
    def static String getdatai18n(String value){
    	var entry_value = new Util().getFileNameAndResourceFromAttrs(value).entrySet.get(0).value
    	var entry_key = new Util().getFileNameAndResourceFromAttrs(value).entrySet.get(0).key
    	return entry_value+"_"+entry_key+"."+entry_key.split("_").get(entry_key.split("_").size-1)	
    }
    
    def static String checkHtmlAttrClass(String attr){    	
    	var String[] attrs = attr.split(" ")
    	var int count = 0
    	var ArrayList<String> allClass = new ArrayList<String>()
    	var ArrayList<String> newAttrs = new ArrayList<String>()
    	var String sAttrs = "" 
    	for(a : attrs){
    		if(a.contains("class=")){
    			count++
    			allClass.add(a)
    		}else{
    			newAttrs.add(a)
    		}	
    	}
    	if(count > 0){    		
    		var String sClass = "class=\""
    		for(c: allClass){
    			if(allClass.head.equals(c)){
    				sClass+= c.replace("\"", "").split("=").get(1).trim
    			}else{
    				sClass+= " " + c.replace("\"", "").split("=").get(1).trim
    			}
    		}
    		sClass+= "\""
    		newAttrs.add(sClass)
    	}else{
    		newAttrs.addAll(allClass)
    	}    		
    	for(a : newAttrs){
    		if(newAttrs.head.equals(a))
    			sAttrs += a
    		else
    			sAttrs += " " + a    		
    	}       			    	
    	return sAttrs
    }
    
	
}