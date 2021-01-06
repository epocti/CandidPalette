package;

class Common {
	// Screen width and height constants
	public static inline var screenWidth = 384;
	public static inline var screenHeight = 408;

	// Size of color squares.
	public static inline var squareSize = 24;

	// The central palette object.
	public static var palette:Palette;

	// In seconds, the global speed of animations. Default is .5.
	public static var animationLength:Float = .5;

	public function new(){
	}
}
