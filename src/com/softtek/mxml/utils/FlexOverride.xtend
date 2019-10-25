package com.softtek.mxml.utils

import java.util.ArrayList
import com.softtek.mxml.mxml.Node
import java.util.HashSet

class FlexOverride {
	
	// type = AddChild | RemoveChild | SetProperty | SetStyle | SetEventHandler
	private String type; 
	private String relativeTo;
	private HashSet<Node> childs;
	// position = firstChild | lastChild | before | after
	private String position;
	private String target;
	private String name;
	private String value;
	private String handler;	 
	
	new (String type){
		this.type = type
	}
	
	def public setType(String type){
		this.type = type
	}
	
	def public String getType(){
		return this.type	
	}	
	
	def public setRelativeTo(String relativeTo){
		this.relativeTo = relativeTo
	}
	
	def public String getRelativeTo(){
		return this.relativeTo	
	}
	
	def public setChilds(HashSet<Node> childs){
		this.childs = childs
	}
	
	def public HashSet<Node> getChilds(){
		return this.childs	
	}
	
	def public addChild(Node node){
		this.childs.add(node)		
	}
	
	def public removeChild(Node node){
		this.childs.remove(node)
	}
	
	def public setPosition(String position){
		this.position = position
	}
	
	def public String getPosition(){
		return this.position	
	}
	
	def public setTarget(String target){
		this.target = target
	}
	
	def public String getTarget(){
		return this.target	
	}	
	
	def public setName(String name){
		this.name = name
	}
	
	def public String getName(){
		return this.name	
	}
	
	def public setValue(String value){
		this.value = value
	}
	
	def public String getValue(){
		return this.value	
	}
	
	
	def public setHandler(String handler){
		this.handler = handler
	}
	
	def public String getHandler(){
		return this.handler	
	}
	
}