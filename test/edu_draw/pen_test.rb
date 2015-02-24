require_relative "../test_helper"
module EduDraw
	class PenTest < Minitest::Unit::TestCase
		include BasicPenTests

		def setup
			@pen = Pen.new(x: 10, y: 20, angle: 25, color: Gosu::Color::BLACK)
		end

		def test_update_does_not_remove_shapes
			pen_shapes << Object.new
			@pen.send :update
			refute_empty pen_shapes
		end
	end
end