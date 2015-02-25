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