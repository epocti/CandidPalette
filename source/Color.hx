package;

import openfl.display.Sprite;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;
import openfl.display.Bitmap;

class Color extends Sprite {
	var hexCode:Int;
	var displayBitmap:Bitmap;

	public function new(initColor = 0xFFFFFFFF){
		super();
		// Init color data and display object
		hexCode = initColor;
		displayBitmap = new Bitmap(new BitmapData(Common.squareSize, Common.squareSize));
		displayBitmap.bitmapData.fillRect(new Rectangle(0, 0, Common.squareSize, Common.squareSize), initColor);
		addChild(displayBitmap);
	}

	// Get the hex code for this color
	public function getColor():Int {
		return hexCode;
	}

	// Change this color via hex code + update display object
	public function setColor(newHex:Int){
		hexCode = newHex;
		displayBitmap.bitmapData.floodFill(0, 0, 0xFFFFFFFF);
		displayBitmap.bitmapData.fillRect(new Rectangle(0, 0, Common.squareSize, Common.squareSize), hexCode);
	}

	// Instance functions for color conversion
	public function getThisRed(){
		return (this.hexCode >> 16) & 0x000000FF;
	}
	public function getThisGreen(){
		return (this.hexCode >> 8) & 0x000000FF;
	}
	public function getThisBlue(){
		return this.hexCode & 0x000000FF;
	}
	public function getThisAlpha(){
		return (this.hexCode >> 24) & 0x000000FF;
	}

	// Static functions for color conversion
	public static function toARGB(red:Int, green:Int, blue:Int, alpha:Int):Int {
		return (alpha & 0xFF) << 24 | (red & 0xFF) << 16 | (green & 0xFF) << 8 | (blue & 0xFF);
	}

	public static function toRGB(red:Int, green:Int, blue:Int):Int {
		return (red & 0xFF) << 16 | (green & 0xFF) << 8 | (blue & 0xFF);
	}

	public static function getRed(hexCode:Int):Int {
		return (hexCode >> 16) & 0x000000FF;
	}
	public static function getGreen(hexCode:Int):Int {
		return (hexCode >> 8) & 0x000000FF;
	}
	public static function getBlue(hexCode:Int):Int {
		return hexCode & 0x000000FF;
	}
	public static function getAlpha(hexCode:Int):Int {
		return (hexCode >> 24) & 0x000000FF;
	}
}
