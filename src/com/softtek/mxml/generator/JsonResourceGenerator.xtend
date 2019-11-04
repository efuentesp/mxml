package com.softtek.mxml.generator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.emf.ecore.resource.Resource
import com.softtek.mxml.mxml.Node
import com.softtek.mxml.mxml.ComplexNode
import com.softtek.mxml.mxml.Project
import com.softtek.mxml.utils.Util
import java.util.HashSet
import java.util.Set

class JsonResourceGenerator {
	
	Util util = new Util()
	
	Set<String> jsonList = new HashSet<String>()
	var json=""
	
	def doGenerator(Resource r, IFileSystemAccess2 fsa) {
	   for (p : r.allContents.toIterable.filter(typeof(Project))){
		for (m: p.files){
			 json = m.file_ref.generateCodeByNode(util.removeNameDecorator(m.file_ref.name),m.path_ref)
		}
	   }
	   fsa.generateFile("dist/assets/i18n/langs/en.json", "{\n" + createJsonFormSet(jsonList) + "\n}")
	   fsa.generateFile("dist/assets/i18n/i18nextScript.js", geni18nextScript())
	}
	
	def CharSequence createJsonFormSet(Set<String> jsonList)'''
	«FOR j: jsonList SEPARATOR ','»
		 «j»
	«ENDFOR»
	'''
	
	def String generateCodeByNode(Node node, String fname, String path) {	
		var json=genJsonFromNode(-2, node).toString
		if (json.length>0){
		  return json
		}				
	}
  
    def CharSequence geni18nextScript()'''
      i18next.use(window.i18nextXHRBackend)
          .init({
      	   debug: true,
      	   //whitelist: ['en', 'es'],
      	   fallbackLng: 'en',
      	   backend: {
      		  loadPath: 'langs/{{lng}}.json'
      	   }
           }, (err, t) => {
      	    jqueryI18next.init(i18next, $);
      	    $('html').localize();
      });
    '''
    
    def CharSequence genJsonFromNode (int indentation, Node n)'''
		«IF (n instanceof ComplexNode)»		  	
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
    			  jsonList.add(setJsonKeyValue(attr.value))
    			  return setJsonKeyValue(attr.value)
    	        }   			
    		}
    	}
    	return ""
    }
  
    
    def String setJsonKeyValue(String value){
    	 var fname= util.getResourceFileNameFromAttrs(value)
    	 return  "\"" + fname +"\"" + ":{"+ "\"" +util.getResourceNameFromAttrs(value)+ "\"" + ":"+ "\""+util.getResourceNameFromAttrs(value)+"\"}"       
    }
   
}