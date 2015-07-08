using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Drawing;

namespace Odysseeanemone
{
	  class Program
	{
		static void Main(string[] args)
		{
			try{
			  int tilesize = Math.Abs(int.Parse(args[2]));
			  string filename = args[0];
			  string classname = args[1];
			  String outp = "//Tiles for " + filename + " generated with Odysseeanemone\r\n";
			  System.Drawing.Image img = System.Drawing.Image.FromFile(filename);
			  
			  for(int y=0;y<img.Height;y+=tilesize)
				for(int x=0;x<img.Width;x+=tilesize){
					outp+="."+classname+((int)(x/tilesize)).ToString()+((int)(y/tilesize)).ToString()+"{\r\n";
					outp+="  background-image:url("+filename+");\r\n";
					outp+="  background-position: -"+x.ToString()+"px -"+y.ToString()+"px;\r\n}\r\n";  
				}
			  TextWriter tw = File.CreateText(filename + ".css");
			  tw.Write(outp);
			  tw.Close();
			}
			catch(Exception e){
			  Console.WriteLine("Usage: Odysseeanemone [filename] [classname] [tilesize]\n("+e.Message.ToString()+")");
			  Console.ReadKey();
			}
		}
	}
}
