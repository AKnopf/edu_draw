require_relative "../lib/edu_draw"

sheet = EduDraw::Sheet.new(x: 150, y: 150)
pen = sheet.new_pen(x: 52, y: 10)

pen.fill do
	5.times do
		move 40
		turn_right 36
	end
end
5.times do
	pen.move 40
	pen.turn_right 36
end


sheet.show