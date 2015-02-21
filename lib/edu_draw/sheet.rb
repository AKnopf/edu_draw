module EduDraw
	# A Sheet is a 2D-Canvas that can be drawn on using {Pen}
	class Sheet < Gosu::Window

		# @private
		attr_reader :shapes

		# Creates a new Sheet
		#
		# @param x [Fixnum] width in pixels
		# @param y [Fixnum] height in pixels
		# @param title [String] Caption of the window
		def initialize(x: 100, y: 100, title: "A blank sheet")
			super x, y, false
			self.caption = title
			@shapes = []
		end

		# @private
		def needs_cursor?
			true
		end

		# Creates a new {Pen} that draws on self
		#
		# @see {Pen}
		#
		# @param x [Fixnum] x-coordinate of starting position. Left is 0.
		# @param y [Fixnum] y-coordinate of starting position. Top is 0.
		# @param angle [Fixnum] Direction of pen in degree. 0 points to the right.
		# @param color [Gosu::Color] Color of the pen
		def new_pen(x: 0, y: 0, angle: 0, color: Gosu::Color::GREEN)
			Pen.new(self, x: x, y: y, angle: angle, color: color)
		end

		# @private
		def draw
			shapes.each do |shape|
				method,*args = shape
				send method, *args
			end
		end

		# @private
		def update
			if button_down? Gosu::KbEscape
				close
			end
		end
	end
end