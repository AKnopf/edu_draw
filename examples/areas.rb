require "edu_draw"

sheet = EduDraw::Sheet.new(x: 150, y: 150)
pen = sheet.new_pen(x: 52, y: 10)

# Every move in the fill-block will create a filled a shape
pen.fill do
	5.times do
		pen.move 40
		pen.turn_right 36
	end
end

#Every move out of the fill block just draws a line
# Those 10 moves result in a half-filled decagon
5.times do
	pen.move 40
	pen.turn_right 36
end


sheet.show