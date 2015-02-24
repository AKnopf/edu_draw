module EduDraw
	# An AnimatedPen is a special {Pen} that is used for drawing animated shapes
	class AnimationPen < Pen

		# @private
		# Creates a new AnimationPen
		# @overload initialize(x, y, angle, color)
		# @param (see Pen#initialize)
		def initialize(*args)
			super
			@update_block = -> {}
			@draw_block = -> {}
		end

		# Defines what needs to be done every frame before drawing
		#
		# @example
		# 	# This makes the pen turn around slowly
		# 	pen.each_frame do
		# 		pen.turn_right 1
		# 	end
		def each_frame &block
			@update_block = block
		end

		# Defines what the pen needs to draw every frame
		#
		# @note Every {#move} outside this block will draw only in the first frame
		#
		# @note Remember to set the state of the pen so that it can start drawing the next frame.
		# 		In the given example the last `pen.turn_right 90` is not neccessary for the shape,
		# 		but without it, the pen would draw the rectangle in a different direction on the next frame.
		# 		Maybe, this is what you need, but it is still recommended to do these changes in the
		# 		{#each_frame}-block.
		#
		# @example
		# 	# Draw a rectangle
		# 	pen.draw_frame do
		# 		pen.move 20
		# 		pen.turn_right 90
		# 		pen.move 10
		# 		pen.turn_right 90
		# 		pen.move 20
		# 		pen.turn_right 90
		# 		pen.move 10
		# 		pen.turn_right 90
		# 	end
		def draw_frame &block
			@draw_block = block
		end

		# @private
		def update
			empty_shapes
			@update_block.call
			@draw_block.call
		end

		private

			def empty_shapes
				shapes.clear
			end
	end
end
