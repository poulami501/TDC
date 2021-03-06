﻿/************************************************************************************
@Copyright (C) 2006 Hurix Systems Pvt. Ltd. All Rights Reserved.
@Author						: Deepak Kumar Sahu
@Client						: CTB
@Project					: TerraNova Tutorial
@Date						: 27/12/07
@Version					: 1.0
@Class						: TN_ContentServices
@Description				:
This class is used for Loading the XML, and create the respective object.
@Extends					:
@Used In					:
@Change Log					:
/******************************************************************/

import com.TN_xmlLoad;

class com.TN_ContentServices{
	private var XMLObj:XML;
	public var screenObj:Object;
	public function TN_ContentServices(XMLURL:String){
		screenObj= new Object();
		var thisReff=this;
		var init=function(xObj){
			thisReff.initScreenObj(xObj)
		}
		var loadContent= new TN_xmlLoad(XMLURL,init)
	}
	/******************************************************************
	@Method						: initScreenObj
	@Description				: This method will create the Screen Objects based on XML Input, and later stores the content as diffrerent property.
	@Input						: XMLObject
	@Output						: 
	/****************************************************************************************/
	private function initScreenObj(xObj){
		var xmlLength=xObj.firstChild.childNodes.length;
		screenObj.totalScreen=xmlLength;
		for(var i=0;i<xmlLength;i++){
			var xmlNode=xObj.firstChild.childNodes[i]
			var xmlID=xmlNode.attributes["id"]
			//Creating the Object with the name of ID's facilitated in XML
			screenObj[xmlID]=new Object();
			screenObj[xmlID].guidedMessage=xmlNode.attributes["UserGuide"].split(",")
			var childLenght=xObj.firstChild.childNodes[i].childNodes.length;
			for(var j=0;j<childLenght;j++){
				var childNode=xObj.firstChild.childNodes[i].childNodes[j]
				var childID=childNode.attributes["id"]
				//Storing the conetnt in  screenObj Object with the Child id property
				screenObj[xmlID][childID]=xObj.firstChild.childNodes[i].childNodes[j].firstChild.nodeValue.toString();

			}
		}
	}
	/******************************************************************
	@Method						: drawContent()
	@Description				: This method will palce the contnet inside the Text Objects
	@Input						: ScreenId
	@Output						: 
	/****************************************************************************************/
	public function drawContent(screenId,mcReff){
		var mc=mcReff;
		for (var i in mc){
			var objName=i;
			if(typeof mc[i]=="movieclip" or typeof mc[objName]=="object"){
				
					if(screenObj[screenId][objName]!=undefined){
						
						mc[objName].htmlText=screenObj[screenId][objName]
					
				}else if(String(objName).substr(String(objName).length-3,String(objName).length)=="_mc"){
					drawContent(screenId,mc[objName])
				}
			}
		}
		
	}
	
}

