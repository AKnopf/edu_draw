require_relative 'lib/edu_draw'

sheet = EduDraw::Sheet.new x: 500, y: 600, title: "It works"
pen = sheet.new_pen(x: 100, y: 20)
10.times do
	pen.move 40
	pen.turn_right 36
end

pen.up!
pen.move 150
pen.down!

10.times do
	pen.move 40
	pen.turn_right 36
end

pen.up!
pen.move -55
pen.turn_right 90
pen.move 250
pen.turn_left 180
pen.down!
pen.move 10

def draw_tree(pen, length)
	angle = 20
	min_length = 4
	shrink_rate = 0.7
	return if length < min_length
	pen.move length
	pen.turn_left angle
	draw_tree pen, length * shrink_rate
	pen.turn_right angle * 2
	draw_tree pen, length * shrink_rate
	pen.turn_left angle
	pen.move -length
end

8.times do
	draw_tree pen, 40
	pen.turn_left 45
end

sheet.show