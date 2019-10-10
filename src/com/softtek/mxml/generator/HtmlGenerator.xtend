package com.softtek.mxml.generator

import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.eclipse.emf.ecore.resource.Resource
import com.softtek.mxml.mxml.Node
import java.util.List
import com.softtek.mxml.mxml.ComplexNode

class HtmlGenerator {
	
	def doGenerator(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		var nodes = resource.allContents.filter(Node).toList
		println(resource.URI.lastSegment)
	    var filename=resource.URI.lastSegment.substring(0,resource.URI.lastSegment.indexOf("."))
		
		fsa.generateFile("html/"+filename+".html", genHtmlFile(nodes))	

	}
	
	
	def CharSequence genHtmlFile(List<Node> nodes) '''
		<!DOCTYPE html>
		<html>
		<body>
		  «genNodes(nodes.head)»
		</body>
		</html>
		
		<style>
		    .controlbarcontent {
		      border: 1px solid gray;
		      background: lightgray;
		    }
		    .hgroup {
		      display: flex;
		      flex-direction: row;
		    }
		    .vgroup {
		      display: flex;
		      flex-direction: column;
		      border: 1px solid gray;
		    }
		</style>
	'''
      
    def CharSequence genNodes(Node n)'''
		«IF (n instanceof ComplexNode)»
		  «getNodeType(n)»
		  «var innernode = n as ComplexNode»
		  «FOR i: innernode.nodes»
		  «   genNodes(i)»
		  «ENDFOR»
		  «getNodeTypeEnd(n.name)»
		«ELSE»
		  «getNodeType(n)»
		«ENDIF»
	'''
      
	def CharSequence getNodeType(Node n)'''
		«IF (n.name.equals('controlBarContent'))» 
		<div id="«n.name»" class="«getNodeClass(n)»">
        «ENDIF»
        «IF (n.name.equals('Application'))» 
        <div id="«n.name»" class="«getNodeClass(n)»">
        «ENDIF»
        «IF (n.name.equals('HGroup'))» 
		<div id="«n.name»" class="«getNodeClass(n)»">
        «ENDIF»
        «IF (n.name.equals('VGroup'))» 
		<div id="«n.name»" class="«getNodeClass(n)»">
        «ENDIF»
        «IF (n.name.equals('DataGrid'))» 
        <table id="«n.name»" class="«getNodeClass(n)»">
        «ENDIF»
        «IF (n.name.equals('ArrayList'))» 
        <tr>
        «ENDIF»
        «IF (n.name.equals('Label'))» 
		 <label «getNodeAttrKeyValue(n,"id")»> «getNodeAttrValue(n,"text")» </label>
        «ENDIF»
        «IF (n.name.equals('Button'))» 
         <button «getNodeAttrKeyValue(n,"id")»> «getNodeAttrValue(n,"label")» </button>
        «ENDIF»
        «IF (n.name.equals('GridColumn'))» 
		 <th> «getNodeAttrValue(n,"headerText")» </th>
        «ENDIF»
        «IF (n.name.equals('Object'))» 
         <tr>
         «FOR a:n.attrs»
         <td> «a.value» </td>
         «ENDFOR»
         </tr>
        «ENDIF»
	'''
	
	def CharSequence getNodeTypeEnd(String name)'''
		«IF (name.equals('controlBarContent'))» 
		</div>
        «ENDIF»
        «IF (name.equals('Application'))» 
		</div>
        «ENDIF»
        «IF (name.equals('HGroup'))» 
		</div>
        «ENDIF»
        «IF (name.equals('VGroup'))» 
		</div>
        «ENDIF»
        «IF (name.equals('DataGrid'))» 
         </table>
        «ENDIF»
        «IF (name.equals('ArrayList'))» 
         </tr>
        «ENDIF»
	'''
	
	
	
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
	
	
	/*
	 *
	 *  <s:DataGrid includeIn="cartView" requestedRowCount="4">
                <s:columns>
                    <s:ArrayList>
                        <s:GridColumn dataField="dataField1" headerText="Column	1"></s:GridColumn>
                        <s:GridColumn dataField="dataField2" headerText="Column	2"></s:GridColumn>
                        <s:GridColumn dataField="dataField3" headerText="Column	3"></s:GridColumn>
                    </s:ArrayList>
                </s:columns>
                <s:typicalItem>
                    <fx:Object dataField1="Sample Data" dataField2="Sample Data" dataField3="Sample	Data"></fx:Object>
                </s:typicalItem>
                <s:ArrayList>
                    <fx:Object dataField1="data1" dataField2="data1" dataField3="data1"></fx:Object>
                    <fx:Object dataField1="data2" dataField2="data2" dataField3="data2"></fx:Object>
                    <fx:Object dataField1="data3" dataField2="data3" dataField3="data3"></fx:Object>
                    <fx:Object dataField1="data4" dataField2="data4" dataField3="data4"></fx:Object>
                </s:ArrayList>
            </s:DataGrid>
            */
           
	
}