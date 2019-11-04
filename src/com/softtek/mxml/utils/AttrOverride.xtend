package com.softtek.mxml.utils

import java.util.ArrayList
import com.softtek.mxml.mxml.Node
import org.eclipse.emf.common.util.EList
import com.softtek.mxml.mxml.Attr

class AttrOverride {
	
	String ns
	String key
	String value
	
	new(String ns, String key, String value){
		this.ns = ns
		this.key = key
		this.value = value
	}
	
	def setNs(String ns){
		this.ns = ns
	}
	
	def getNs(){
		return this.ns
	}
	
	def setKey(String key){
		this.key = key
	}
	
	def getKey(){
		this.key
	}
	
	def setValue(String value){
		this.value = value
	}
	
	def getValue(){
		return this.value
	}
	
	def static ArrayList<AttrOverride> fromAttrToAttrOverride(EList<Attr> attrs){
		var ArrayList<AttrOverride> auxAttrs = new ArrayList<AttrOverride>()
		for(a : attrs){
			auxAttrs.add(new AttrOverride(a.ns, a.key, a.value))			
		}
		return auxAttrs
	}
	
	
	
}