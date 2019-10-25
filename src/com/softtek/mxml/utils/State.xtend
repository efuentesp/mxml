package com.softtek.mxml.utils

import java.util.ArrayList
import java.util.LinkedHashSet

class State {
	
	private String fname;
	private String name;
	private LinkedHashSet<FlexOverride> flexOverrides;
	private String basedOn;	
	
	 new(String fname, String name, String basedOn){
	 	this.fname = fname
	 	this.name = name
	 	this.basedOn = basedOn	 	
	 }
	
	 new (String fname, String name, LinkedHashSet<FlexOverride> flexOverrides, String basedOn){
	 	this.fname = fname
	 	this.name = name
	 	this.flexOverrides = flexOverrides
	 	this.basedOn = basedOn
	 }
	 
	 def public setFname(String fname){
	 	this.fname = fname
	 }
	 
	 def public getFname(){
	 	return this.fname
	 }
	 
	 def public setName(String name){
		this.name = name
	}
	
	def public String getName(){
		return this.name	
	}
	
	def public setFlexOverrides(LinkedHashSet<FlexOverride> flexOverrides){
		this.flexOverrides = flexOverrides
	}
	
	def public LinkedHashSet<FlexOverride> getFlexOverrides(){
		return this.flexOverrides	
	}
	
	def public addFlexOverride(FlexOverride flexOverride){
		this.flexOverrides.add(flexOverride)
	}
	
	def public removeFlexOverride(FlexOverride flexOverride){
		this.flexOverrides.remove(flexOverride)
	}	
	
	def public setBasedOn(String basedOn){
		this.basedOn = basedOn
	}
	
	def public String getBasedOn(){
		return this.basedOn	
	}
}