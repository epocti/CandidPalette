## An OpenFL-based, crossplatform palette editing tool

Vulpica (formerly Candid) Palette is a full-featured palette editor. Use it to create palettes for anything you may need: art, web design, etc.
Palette also offers the ability to easily create palettes using pre-exising images. Either select just the colors you need, or generate a palette sorted by the most frequent colors.
You can also export palettes for use in other programs such as Aseprite, Paint.NET, and (coming soon) Vulpica Editor.

## TODO
- Update lithium framework
- Allow colors to be re-ordered and deleted

## Building
(These instructions assume that you are new to the Haxe scene, so they may seem a little redundant for some.)

Palette depends on the latest versions of OpenFL and Lime. To install these, run `haxelib install openfl` and `haxelib install lime`. Afterwards, run `haxelib run lime setup` and `haxelib run openfl setup` to make sure the commandline tools as well as any extra dependencies for the two are installed.

To build and run Palette from source, `cd` to the root of the project (where `project.xml` is located) and run the command that corresponds to your platform:
* `lime test mac` - requires that you have Xcode installed
* `lime test linux` - requires that you have g++ installed
* `lime test windows` - requires that you have Visual Studio installed with C++/Win32 support

You can also achieve a faster compile time at the cost of performance by running `lime test neko`. Additionally, substitute `test` with `build` for the above commands to build without running afterward.

## Dependencies
It may work with older versions of the following, however it is **required** you use at least these versions if you wish to contribute:

- Haxe: 4.0.0
- OpenFL: 8.9.5
- Lime: 7.6.3
- Actuate: 1.8.9
