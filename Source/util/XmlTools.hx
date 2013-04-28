package util;
import browser.xml.XML;


typedef XmlElement = {
	public var name:String;
	public var attr:Array<String>;
	public var children:Array<XmlObject>;
}

enum XmlObject {
	Element(val:XmlElement);
	Document(sub:Array<XmlObject>);
	PCData(val:String);
	None;
}

class XmlTools
{
	
	
	public static function xmlToObject(xml:Xml):XmlObject
	{
		//var object:XmlObject = { name:"", value:"", children:[] };
		trace(xml.nodeType);
		var object:XmlObject;
		switch(xml.nodeType) {
			case Xml.Document:
				var children:Array<XmlObject> = [];
				var iter = xml.iterator();
				while (iter.hasNext()) {
					children.push(xmlToObject(iter.next()));
				}
				object = XmlObject.Document(children);
			case Xml.Element:
				var elem:XmlElement = {
					name: xml.nodeName,
					attr: Lambda.array(Lambda.map(xml.attributes(), function(att) { return att; } )),
					children: Lambda.array(Lambda.map(xml, function(node){ return xmlToObject(node)}))
				}
				object = XmlObject.Element(elem);
				/*var attr = xml.attributes();
				trace(attr.hasNext());
				var iter = xml.iterator();
				while (iter.hasNext()) {
					object.children.push(xmlToObject(iter.next()));
				}*/
			case Xml.PCData:
				object = XmlObject.PCData(xml.nodeValue);
			default:
				XmlObject.None;
				//object.name = xml.nodeName;
				//object.value = xml.nodeValue;
		}
		//if (Xml.Document != xml.nodeType) object.name = xml.nodeName;
		//else object.name = "anonymous";
		//if (Xml.Document != xml.nodeType) object.value = xml.nodeValue;
		//object.children = [];
		
		//trace(xml.firstChild());
		//trace(xml.attributes());
		return object;
	}
}

