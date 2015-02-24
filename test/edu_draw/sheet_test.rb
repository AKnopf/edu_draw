require_relative "../test_helper"
module EduDraw
	class SheetTest < Minitest::Unit::TestCase
		def setup
			@sheet = Sheet.new(x: 10, y: 20, title: "test")
		end

		def test_initialize
			assert_equal 10, @sheet.width
			assert_equal 20, @sheet.height
			assert_equal "test", @sheet.caption
		end

		def test_cursor_visible
			assert @sheet.send :needs_cursor?
		end

		def test_window
			assert_kind_of Gosu::Window, @sheet
		end

		def test_new_pen_creates_pen
			assert_respond_to @sheet, :new_pen
			assert_kind_of Pen, @sheet.new_pen
		end

		def test_new_pen_creates_new_instance
			Pen.expects(:new).once
			AnimationPen.expects(:new).never
			@sheet.new_pen
		end

		def test_new_animation_pen
			AnimationPen.expects(:new).never
			Pen.expects(:new).once
			@sheet.new_animation_pen
		end
	end
end