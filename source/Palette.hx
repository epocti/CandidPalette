package;

import openfl.display.BitmapData;
import motion.easing.Expo;
import motion.Actuate;
import openfl.events.MouseEvent;
import openfl.display.Sprite;

class Palette extends Sprite {
	public var colors:Array<Color>;
	var newColorButton:ImageButton;

	public function new(){
		super();

		colors = new Array<Color>();

		newColorButton = new ImageButton("assets/ui/addColor.png", "assets/ui/addColorOver.png", "assets/ui/addColorClick.png");
		addChild(newColorButton);
		newColorButton.addEventListener(MouseEvent.CLICK, onNewColorClick);
		this.y = 24;
	}

	public function addColor(newColor:Color){
		colors.push(newColor);
		colors[colors.length - 1].x = ((colors.length - 1) % 16) * Common.squareSize;
		colors[colors.length - 1].y = Math.floor((colors.length - 1) / 16) * Common.squareSize;
		addChild(newColor);

		colors[colors.length - 1].addEventListener(MouseEvent.CLICK, onColorClick);
		colors[colors.length - 1].addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onColorDown);
		colors[colors.length - 1].addEventListener(MouseEvent.RIGHT_MOUSE_UP, onColorUp);

		newColorButton.x = ((colors.length) % 16) * Common.squareSize;
		newColorButton.y = Math.floor((colors.length) / 16) * Common.squareSize;
	}

	public function setColor(index:Int, newHex:Int){
		colors[index].setColor(newHex);
	}

	public function getColorHexByIndex(index:Int){
		return colors[index].getColor();
	}

	public function removeColor(index:Int){
		removeChild(colors[index]);
		colors.remove(colors[index]);
		updateDisplay(true);
	}

	public function clear(){
		for(i in 0...colors.length){
			removeChild(colors[0]);
			colors.remove(colors[0]);
		}
		updateDisplay(true);
	}

	public function canAddColors():Bool {
		if(colors.length >= 256){
			return false;
		}
		else return true;
	}

	function onColorClick(evt:MouseEvent){
		var colorView:ColorView = new ColorView(colors.indexOf(evt.target));
		colorView.y = -24;
		addChild(colorView);
	}

	function onColorDown(evt:MouseEvent){
		newColorButton.startDrag();
		Actuate.tween(newColorButton, .5, {width:Common.squareSize * 1.5}).ease(Expo.easeOut);
		Actuate.tween(newColorButton, .5, {height:Common.squareSize * 1.5}).ease(Expo.easeOut);
		
	}
	function onColorUp(evt:MouseEvent){
		newColorButton.stopDrag();
		Actuate.tween(newColorButton, .5, {x:newColorButton.x + 16}).ease(Expo.easeOut);
		Actuate.tween(newColorButton, .5, {y:newColorButton.y + 16}).ease(Expo.easeOut);
		Actuate.tween(newColorButton, .5, {width:Common.squareSize}).ease(Expo.easeOut);
		Actuate.tween(newColorButton, .5, {height:Common.squareSize}).ease(Expo.easeOut);
	}

	function onNewColorClick(evt:MouseEvent){
		addColor(new Color(0xFF000000));
	}

	public function updateDisplay(withAnimation:Bool){
		// Tween (slide colors)
		if(withAnimation){
			for(color in colors){
				Actuate.tween(color, Common.animationLength, {x:(colors.indexOf(color) % 16) * Common.squareSize}).ease(Expo.easeOut);
				Actuate.tween(color, Common.animationLength, {y:Math.floor(colors.indexOf(color) / 16) * Common.squareSize}).ease(Expo.easeOut);
			}
			Actuate.tween(newColorButton, Common.animationLength, {x:(colors.length % 16) * Common.squareSize}).ease(Expo.easeOut);
			Actuate.tween(newColorButton, Common.animationLength, {y:Math.floor((colors.length) / 16) * Common.squareSize}).ease(Expo.easeOut);
		}
		// Immediate
		else {
			for(color in colors){
				color.x = (colors.indexOf(color) % 16) * Common.squareSize;
				color.y = Math.floor(colors.indexOf(color) / 16) * Common.squareSize;
			}
			newColorButton.x = (colors.length % 16) * Common.squareSize;
			newColorButton.y = Math.floor((colors.length) / 16) * Common.squareSize;
		}
	}

	public function newPaletteFromImage(data:BitmapData){
		// First clear the palette
		clear();

		// Calculate 256 prominent colors, sorted by most apparent after the fact
		var imgDataLinear:Array<Int> = new Array<Int>();
		var colorCounts:Map<Int, Int> = new Map<Int, Int>();
		var colorCounts2d:Array<Array<Int>> = new Array<Array<Int>>();

		// First get all pixels into a linear format for easier counting
		trace("Step 1, Linearizing pixels");
		for(y in 0...data.height){
			for(x in 0...data.width){
				imgDataLinear.push(data.getPixel32(x, y));
			}
		}

		// Then count each color
		trace("Step 2, Counting up colors");
		for(pixel in imgDataLinear){
			if(!colorCounts.exists(pixel)){
				colorCounts.set(pixel, 1);
			}
			else colorCounts.set(pixel, colorCounts.get(pixel) + 1);
		}

		// Convert to an array for easier calculation
		trace("Step 3, Converting to array");
		for(color in colorCounts.keys()){
			colorCounts2d.push([color, colorCounts.get(color)]);
		}

		// Sort by increasing value
		trace("Step 4, Sorting");
		var tempStore:Array<Int>;
		for (i in 0...colorCounts2d.length - 1){
			for (j in 0...colorCounts2d.length - 1){
				if(colorCounts2d[j + 1][1] > colorCounts2d[j][1]){
					tempStore = colorCounts2d[j + 1];
					colorCounts2d[j + 1] = colorCounts2d[j];
					colorCounts2d[j] = tempStore;
				}
			}
		}

		// Finally add
		trace("Step 5, Adding to palette");
		if(colorCounts2d.length >= 256){
			for(i in 0...256){
				addColor(new Color(colorCounts2d[i][0]));
			}
		}
		else {
			for(i in 0...colorCounts2d.length) addColor(new Color(colorCounts2d[i][0]));
		}

		updateDisplay(true);
	}

	public function dumpInfo() {
		trace("Palette Data:");
		for(color in colors){
			trace(colors.indexOf(color) + ": (" + color.getThisRed() + ", " + color.getThisGreen() + ", " + color.getThisBlue() + ", " + color.getThisAlpha() + ")");
		}
	}
}