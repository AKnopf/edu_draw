require_relative "../test_helper"
module EduDraw
	class AnimationPenTest < Minitest::Unit::TestCase
		include BasicPenTests

		def setup
			@pen = AnimationPen.new(x: 10, y: 20, angle: 25, color: Gosu::Color::BLACK)
		end

		def test_update_removes_shapes
			pen_shapes << Object.new
			@pen.send :update
			assert_empty pen_shapes
		end
	end
end