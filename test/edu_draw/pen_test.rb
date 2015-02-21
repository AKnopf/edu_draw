require_relative "../test_helper"
module EduDraw
	class PenTest < Minitest::Unit::TestCase
		def setup
			@sheet_stub = stub shapes: []
			@pen = Pen.new(@sheet_stub, x: 10, y: 20, angle: 25, color: Gosu::Color::BLACK)
		end

		def test_initialize
			assert_equal 10, @pen.x
			assert_equal 20, @pen.y
			assert_equal 25, @pen.angle
			assert_equal Gosu::Color::BLACK, @pen.color
		end

		def test_move
			@pen.move 100
			expected_x = 10 + Math.cos(25 * Math::PI / 180.0) * 100
			expected_y = 20 + Math.sin(25 * Math::PI / 180.0) * 100
			assert_equal expected_x, @pen.x 						# x changed
			assert_equal expected_y, @pen.y 						# y changed
			assert_equal 25, @pen.angle 							  # angle unchanged
			assert_equal Gosu::Color::BLACK, @pen.color # color unchanged
		end

		def test_doesnt_draws_when_up
			@sheet_stub.expects(:shapes).times(0)
			@pen.up!
			@pen.move 100
		end

		def test_up_and_down
			assert @pen.down?
			refute @pen.up?

			@pen.up!
			assert @pen.up?
			refute @pen.down?

			@pen.down!
			assert @pen.down?
			refute @pen.up?
		end

		def test_turning
			assert_equal 25, @pen.angle

			@pen.turn_left 25
			assert_equal 0, @pen.angle

			@pen.turn_left 10
			assert_equal 350, @pen.angle

			@pen.turn_right 20
			assert_equal 10, @pen.angle
		end

		def test_angle_in_rad
			assert_equal 25 * Math::PI / 180.0, @pen.angle_in_rad
		end
	end
end