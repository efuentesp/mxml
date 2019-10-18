package com.softtek.mxml.generator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.emf.ecore.resource.Resource
import com.softtek.mxml.mxml.Node
import com.softtek.mxml.mxml.ComplexNode
import com.softtek.mxml.mxml.Project
import java.util.Arrays
import com.softtek.mxml.utils.Util

class JsonResourceGenerator {
	
	Util util = new Util()
	
	def doGenerator(Resource r, IFileSystemAccess2 fsa) {
       for (p : r.allContents.toIterable.filter(typeof(Project))){
		for (m: p.files){
			 m.file_ref.generateCodeByNode(m.file_ref.name,m.path_ref,fsa)
		}
	   }
	}
	
	def void generateCodeByNode(Node node, String fname, String path,IFileSystemAccess2 fsa) {	
		var json=genJsonFromNode(-2, node).toString
		if (json.length>0){
		  fsa.generateFile("pug/"+path+"/"+fname+".js", getScript(json))
		}				
	}
  
    def CharSequence getScript(String json)'''
      json={
       «json.substring(0, json.length() - 3)»
      }
      
      function getText(){
         for (var key in json) {
          console.log(key);
          console.log(json[key]); 
          if (document.getElementById(key)!==null)
           if (key!==null)
             document.getElementById(key).innerText=json[key]
          }
      }
      
      getText()
    '''
    
    def CharSequence genJsonFromNode (int indentation, Node n)'''
		«IF (n instanceof ComplexNode)»		  		  
		  «getJsonFromNodeAttrs(indentation, n)»
		  «var innernode = n as ComplexNode»
		  «FOR i: innernode.nodes»
		  	«IF  n.name.equalsIgnoreCase('Application')»
		  		«genJsonFromNode(indentation+3, i)»
		  	«ELSE»
		  		«genJsonFromNode(indentation+1, i)»
		  	«ENDIF»		  
		  «ENDFOR»
		«ELSE»
		   «getJsonFromNodeAttrs(indentation, n)»
		«ENDIF»
	'''
    
    def String getJsonFromNodeAttrs(int indentation,Node node){
    	if(!node.attrs.empty){
    		for(attr : node.attrs){
    			if(attr.value.contains("resourceManager.getString")){
    			  var value=Arrays.toString(attr.value.split(",").tail).replace("\'","").replace(")","").replace("}","").replace("[","").replace("]","")
    	          println(value)
    	          return "\"" +util.getNodeAttrValue(node,"id") + "\"" + ":"+ "\""+value+"\","
    	        }   			
    		}
    	}
    	return ""
    }
   
}