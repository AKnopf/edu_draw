# edu_draw
Simple ruby drawing API based on gosu meant for educational purposes.

## Install

		gem install edu_draw

If you run into any problems its most likely because of [gosu](https://github.com/jlnr/gosu/wiki/Ruby-Tutorial), as this is the only runtime dependency of edu_draw.

## Usage
There are only two classes: A sheet to draw on and a pen to draw with. The sheet is also the window. Unfortunately, the underlying engine only supports really one window, so you should only create one sheet per program. This is done as follows:
First, load edu_draw into your program

		require "edu_draw"

Then, create the sheet

		sheet = EduDraw::Sheet.new x: 500, y: 600, title: "It works"

Now that you have a sheet, that is 500 pixels wide and 600 pixels high, you can create pens for this sheet to draw on.

		green_pen = sheet.new_pen x: 100, y: 20

Green is the default color for pens but you can have any color using the `color` parameter.

Now it's time to draw a rectangle!


		green_pen.move 100
		green_pen.turn_right 90
		green_pen.move 80
		green_pen.turn_right 90
		green_pen.move 100
		green_pen.turn_right 90
		green_pen.move 80


When you are done drawing, you have to make one final call to the sheet, to actually display the window with your drawings.

		sheet.show

The whole program looks like this:


		require "edu_draw"

		sheet = EduDraw::Sheet.new x: 500, y: 600, title: "A beautiful rectangle"
		green_pen = sheet.new_pen(x: 100, y: 20)

		green_pen.move 100
		green_pen.turn_right 90
		green_pen.move 80
		green_pen.turn_right 90
		green_pen.move 100
		green_pen.turn_right 90
		green_pen.move 80

		sheet.show

### Areas / Filled shapes
You can also draw filled or party-filled shapes. Here is an short example, that can be also found in the examples folder:

		require "edu_draw"

		sheet = EduDraw::Sheet.new(x: 150, y: 150)
		pen = sheet.new_pen(x: 52, y: 10)

		# Every move in the fill-block will create a filled a shape
		pen.fill do
			5.times do
				pen.move 40
				pen.turn_right 36
			end
		end

		# Every move out of the fill block just draws a line
		# Those 10 moves result in a half-filled decagon
		5.times do
			pen.move 40
			pen.turn_right 36
		end


		sheet.show


### Animations
You can even draw animated shapes. Here is an short example, that can be also found in the examples folder:

		require "edu_draw"

		sheet = EduDraw::Sheet.new(x: 150, y: 150)

		# Instead of using sheet.new_pen, now you create a new_animation_pen
		pen = sheet.new_animation_pen(x: 75, y: 75)

		# Here you define what happens in the beginning of each frame
		pen.each_frame do
			pen.turn_right 1
		end

		# Now you define what the pen should draw each frame
		# It is important to leave the pen in a state, where
		# it can start drawing on the next frame, that's why
		# the pens moves back, even though it does not draw
		# any actual lines.
		pen.draw_frame do
			pen.move 50
			pen.move -50
		end


		# You're set. Now just show the sheet as usual and enjoy
		# the wonderfully spinning line you just drew.
		sheet.show


## Changelog
- 2.0.0
	- Adds ability to fill shapes. See `examples/areas.rb`
	- Adds ability to draw animated shapes. See `examples/animations.rb`
	- Makes state of pen writable
	- Greatly improves documentation

## Contributing
Feel free to contribute anything, may it be better tests, better documentation or more features. As you can see, I tried to keep the code tidy so it is appreciated if you'd do the same. Just add a pull request and we will make it work. Oh, and don't forget to have fun ;)

## Kudos
Kudos to the wonderful people behind [Gosu](http://www.libgosu.org/). You do some great work.