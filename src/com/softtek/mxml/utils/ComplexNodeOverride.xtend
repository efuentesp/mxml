package com.softtek.mxml.utils

import java.util.ArrayList
import com.softtek.mxml.mxml.ComplexNode

class ComplexNodeOverride extends NodeOverride{
	
	ArrayList<NodeOverride> nodes
	
	new(String prefix, String name, ArrayList<AttrOverride> attrs){
		super(prefix, name, attrs)		
		this.nodes = new ArrayList<NodeOverride>()
	}
	
	new(String prefix, String name, ArrayList<AttrOverride> attrs, ArrayList<NodeOverride> nodes){
		super(prefix, name, attrs)
		this.nodes = nodes
	}
	
	def setNodes(ArrayList<NodeOverride> nodes){
		this.nodes = nodes
	}
	
	def getNodes(){
		return this.nodes
	}
	
	def addNode(NodeOverride node){
		this.nodes.add(node)
	}
	
	
}