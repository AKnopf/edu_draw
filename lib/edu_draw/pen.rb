module EduDraw
	# A Pen is a drawing tool that provides basic drawing functionalities on a 2d {Sheet}.
	class Pen

		PIXEL_TOLERANCE = 0.2

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
			@to_be_filled = []

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
		# @see #up?
		# @see #down?
		def up!
			@up = true
		end

		# Sticks the pen to the {Sheet}
		#
		# @see #up?
		# @see #down?
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
			handle_movement x, y, target_x, target_y
			@x = target_x
			@y = target_y
		end

		# @return [Fixnum] angle in radians instead of degree
		def angle_in_rad
			angle * Math::PI / 180.0
		end

		def fill(&block)
			@to_be_filled << [x,y]
			instance_eval &block
			if starting_point_is_end_point?
				@to_be_filled.delete_at(0)
			end
			origin_x = @to_be_filled.first[0]
			origin_y = @to_be_filled.first[1]
			@to_be_filled[1..@to_be_filled.length-1].each_cons(2) do |point_a, point_b|
				@sheet.shapes << [:draw_triangle,
					origin_x, origin_y, color,
					point_a[0], point_a[1], color,
					point_b[0], point_b[1], color]
			end
			@to_be_filled.clear
		end

		def fill_mode?
			@to_be_filled.length > 0
		end

		private
			def handle_movement(x, y, target_x, target_y)
				if down?
					if fill_mode?
						@to_be_filled << [target_x, target_y]
					else
						@sheet.shapes << [:draw_line, x, y, color, target_x, target_y, color]
					end
				end
			end

			def starting_point_is_end_point?
				start_x = @to_be_filled.first[0]
				start_y = @to_be_filled.first[1]
				end_x = @to_be_filled.last[0]
				end_y = @to_be_filled.last[1]
				(start_x - end_x).abs <= PIXEL_TOLERANCE and
					(start_y - end_y).abs <= PIXEL_TOLERANCE
			end
	end
end