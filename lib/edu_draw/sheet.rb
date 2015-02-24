module EduDraw
	# A Sheet is a 2D-Canvas that can be drawn on using {Pen}
	class Sheet < Gosu::Window

		# @private
		# All pens created by and for this sheet
		attr_reader :pens
		private :pens

		# Creates a new Sheet
		#
		# @param x [Fixnum] width in pixels
		# @param y [Fixnum] height in pixels
		# @param title [String] Caption of the window
		def initialize(x: 100, y: 100, title: "A blank sheet")
			super x, y, false
			self.caption = title
			@pens = []
		end


		# Creates a new {Pen} that draws on self
		#
		# @see Pen
		#
		# @param x [Fixnum] x-coordinate of starting position. Left is 0.
		# @param y [Fixnum] y-coordinate of starting position. Top is 0.
		# @param angle [Fixnum] Direction of pen in degree. 0 points to the right.
		# @param color [Gosu::Color] Color of the pen
		def new_pen(x: 0, y: 0, angle: 0, color: Gosu::Color::GREEN)
			pen = Pen.new(x: x, y: y, angle: angle, color: color)
			pens << pen
			pen
		end

		# Create a new {AnimationPen} that draws something different each frame
		#
		# @see AnimationPen
		#
		# @param (see #new_pen)
		def new_animation_pen(x: 0, y: 0, angle: 0, color: Gosu::Color::GREEN)
			pen = AnimationPen.new(x: x, y: y, angle: angle, color: color)
			pens << pen
			pen
		end

		private
			# Makes gosu display the system mouse cursor
			def needs_cursor?
				true
			end

			# Gosu hook method for drawing window content
			def draw
				pens.map(&:shapes).each do |shapes|
					shapes.each do |shape|
						method,*args = shape
						send method, *args
					end
				end
			end

			# Gosu hook method for updating game state before drawing
			# This is called once per frame
			def update
				pens.each &:update
				if button_down? Gosu::KbEscape
					close
				end
			end
	end
end