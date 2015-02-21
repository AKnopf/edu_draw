module EduDraw
	# A Pen is a drawing tool that provides basic drawing functionalities on a 2d {Sheet}.
	class Pen

		# @return [Fixnum] x-coordinate of position in pixel where left is 0
		attr_reader :x

		# @return [Fixnum] y-coordinate of position in pixel where top is 0
		attr_reader :y

		# @return [Fixnum] Direction of the pen in degree where 0 points to the right
		attr_reader :angle

		# @return [Gosu::Color] Color of the pen
		attr_reader :color

		# Creates a new Sheet
		#
		# @param x [Fixnum] initial value of {#x}
		# @param y [Fixnum] initial value of {#y}
		# @param angle [Fixnum] initial value of {#angle}
		# @param color [Gosu::Color] initial value of {#color}
		def initialize(sheet, x: 0, y: 0, angle: 0, color: Gosu::Color::GREEN)
			@x = x
			@y = y
			@angle = angle
			@color = color
			@sheet = sheet

			down!
		end

		# Changes the direction of self to be turned to the left
		# The {#angle} stays within 0..364
		#
		# @param degree [Fixnum] Amount of degree to be turned
		def turn_left(degree)
			@angle -= degree
			@angle = (@angle + 360) % 360 # Make sure angle is always in 0..359
		end

		# Changes the direction of self to be turned to the right
		# The {#angle} stays within 0..364
		#
		# @param degree [Fixnum] Amount of degree to be turned
		def turn_right(degree)
			turn_left -degree
		end

		# If the pen is up, it does not touch the {Sheet} and is not drawing. It can still be moved.
		def up?
			@up
		end

		# If the pen is up, it touches the {Sheet} and is drawing when moved.
		def down?
			!up?
		end

		# Lifts the pen from the {Sheet}
		#
		# @see {#up?}
		# @see {#down?}
		def up!
			@up = true
		end

		# Sticks the pen to the {Sheet}
		#
		# @see {#up?}
		# @see {#down?}
		def down!
			@up = false
		end

		# Moves the stick an amount of pixel into its direction.
		# Draws when it is {#down?}
		#
		# @param length [Fixnum] Amount of pixels moved
		def move(length)
			target_x = x + Math.cos(angle_in_rad) * length
			target_y = y + Math.sin(angle_in_rad) * length
			if down?
				@sheet.shapes << [:draw_line, x, y, color, target_x, target_y, color]
			end
			@x = target_x
			@y = target_y
		end

		# @return [Fixnum] angle in radians instead of degree
		def angle_in_rad
			angle * Math::PI / 180.0
		end
	end
end