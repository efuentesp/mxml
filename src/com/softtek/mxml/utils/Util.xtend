package com.softtek.mxml.utils

import com.softtek.mxml.mxml.ComplexNode
import com.softtek.mxml.mxml.Node
import java.util.LinkedHashMap
import java.util.LinkedHashSet
import java.util.ArrayList
import java.util.List
import java.util.Arrays

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
    
    
	def String getConcatAttrs(Node node, ArrayList<String> attrToSkip){
    	var String attrs = ""
    	var ArrayList<String> charstoremove = new ArrayList<String>();
    	charstoremove.add("{")
    	charstoremove.add("}")
    	if(!node.attrs.empty){
    		for(attr : node.attrs){    	
    			var String value= attr.value			
    			if (attr.value.contains("?resourceManager")) {    
    			  attrs += " class=\"ternaryOperation\" data-i18n" + "=\"" + this.getFileNameAndResourceFromAttrs(attr.value).entrySet.get(0).value+"."+this.getFileNameAndResourceFromAttrs(attr.value).entrySet.get(0).key + "\""
    			}else if (attr.value.contains("resourceManager")) {
    				attrs += " " + "data-i18n" + "=\"" + this.getFileNameAndResourceFromAttrs(attr.value).entrySet.get(0).value+"."+this.getFileNameAndResourceFromAttrs(attr.value).entrySet.get(0).key + "\""    			    			
    			}else{
    				if(attrToSkip !== null && !attrToSkip.empty){
    					if(!attrToSkip.contains(attr.key)){
    						attrs += " " + attr.key + "=\"" + replaceStrings(charstoremove ,value) + "\""
    					}
    				}else{
    					attrs += " " + attr.key + "=\"" + replaceStrings(charstoremove ,value)   + "\""
    				}
    			}    			 	   					
    		}
    	}    
    	return checkHtmlAttrClass(attrs)
    }
    
    def String replaceStrings(ArrayList<String> strs, String value){   
     	var String value1 = new String(value);
     	var String value2
     	var Boolean contains=false
     	for (str:strs){
     		if (value.contains(str)) {
     		   contains=true
     		   value2 =value1.replace(str,"")
     		  }
     		 value1=value2
     	}
     	if (contains) return value1 else return value
    }
     
    def String checkHtmlAttrClass(String attr){    	
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
    
    def String removeNameDecorator(String fname){
    	var String[] aux = fname.split("@_")
    	return aux.get(1)
    }
        
    // Resources

	def LinkedHashMap<String, String> getFileNameAndResourceFromAttrs(String value){
		var LinkedHashMap<String, String> result = new LinkedHashMap<String, String>()
		if (value.contains("?resourceManager")) {
			var String [] test = ((value.split("\\?").get(1)).replace("resourceManager.getString(", "").replace("'", "").replace(")", "").replace("}", "").split(":"))
			result.put(test.get(0).replace("\\.", "_").split(",").get(1), test.get(0).replace("\\.", "_").split(",").get(0))
			result.put(test.get(1).replace("\\.", "_").split(",").get(1), test.get(1).replace("\\.", "_").split(",").get(0))
		}else if(value.contains("resourceManager.getString")){
			var String [] test = value.replace("{resourceManager.getString(", "").replace(")", "").replace("}", "").replace("'", "").replace(".", "_").replace(":", "").split(",")
			result.put(test.get(1), test.get(0))
		}
		return result
	}
	
	
	//Skip Attribute Lists
	 public ArrayList<String> skipAttrsFormItem = new ArrayList<String>(Arrays.asList("paddingTop", "paddingBottom", "width","height","direction","label"));
	 
	 public ArrayList<String> skipAttrsButton = new ArrayList<String>(Arrays.asList("skin", "width", "height","styleName","direction","textAlign",
	                                                                                "borderColor","labelPlacement","buttonMode","useHandCursor",
	                                                                                "horizontalCenter","bottom","xmlns:mx","implements","label"));
	   
	 public ArrayList<String> skipAttrsLinkButton = new ArrayList<String>(Arrays.asList("skin", "width", "height","styleName","direction","textAlign",
	                                                                                "borderColor","labelPlacement","buttonMode","useHandCursor",
	                                                                                "horizontalCenter","bottom","xmlns:mx","implements","label"));
	                                                                                                                                                             
	 public ArrayList<String> skipAttrsHBox = new ArrayList<String>(Arrays.asList("width","paddingTop","verticalScrollPolicy","horizontalScrollPolicy",
	                                                                                "horizontalAlign","height","verticalAlign","horizontalGap",
	                                                                                "styleName","paddingBottom","paddingLeft","paddingRight",
	                                                                                "minHeight","xmlns:mx","xmlns:controls","xmlns:view","creationComplete",
	                                                                                "implements","xmlns:mate","right","xmlns:views","initialize",
	                                                                                "xmlns:maps","disabledOverlayAlpha"))
	                                                                                
	 public ArrayList<String> skipAttrsVBox = new ArrayList<String>(Arrays.asList("width","height","paddingTop","verticalGap","horizontalAlign",
	                                                                               "verticalAlign","creationComplete","paddingBottom","paddingLeft",
	                                                                               "visible","x","y","verticalScrollPolicy","paddingRight","initialize",
	                                                                               "horizontalScrollPolicy","scroll","backgroundAlpha","backgroundColor",
	                                                                               "cornerRadius","left","right","horizontalCenter","verticalCenter",
	                                                                               "disabledOverlayAlpha","implements","xmlns:mx","xmlns:viewCmp",
	                                                                               "xmlns:validatorCmp","xmlns:rm","xmlns:components","xmlns:cmpView",
	                                                                               "xmlns:cmpViewRender","xmlns:cmpViewUpload","xmlns:com","xmlns:component",
	                                                                               "xmlns:vista","xmlns:views", "xmlns:controls", "xmlns:view"))     
	  
	  public ArrayList<String> skipAttrsText = new ArrayList<String>(Arrays.asList("width","selectable"));                        

      public ArrayList<String> skipAttrsTextArea = new ArrayList<String>(Arrays.asList("width","textAlign","wordWrap","selectable","borderStyle","height", 
                                                                                       "htmlText","horizontalScrollPolicy","verticalScrollPolicy","fontWeight",
                                                                                       "borderThickness","paddingLeft","paddingBottom","paddingRight","paddingTop",
                                                                                       "text")); 
                                                                                       
      public ArrayList<String> skipAttrsTextInput = new ArrayList<String>(Arrays.asList("restrict","maxChars","width","focusOut","editable","change","text",
                                                                                        "textAlign","keyUp","keyDown","disabledColor","enter"));
       
      public ArrayList<String> skipAttrsPanel = new ArrayList<String>(Arrays.asList("styleName","width","verticalScrollPolicy","horizontalScrollPolicy",
      	                                                                            "paddingBottom","layout","horizontalAlign","paddingLeft","paddingRight",
      	                                                                            "xmlns:mx","height", "paddingTop", "xmlns:cmpView", "verticalAlign", 
                                                                                    "creationComplete", "resizeEffect", "titleStyleName","title")); 
                                                                       
}