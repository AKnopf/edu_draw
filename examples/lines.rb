require "edu_draw"

# Create a new Sheet. That's your window.
sheet = EduDraw::Sheet.new x: 500, y: 600, title: "It works"

# Create a new pen for this sheet at the position 100 pixel from the left and 20 pixel from the top
pen = sheet.new_pen(x: 100, y: 20)

# Draw a decagon
10.times do
	pen.move 40
	pen.turn_right 36
end

# Move to the right without drawing a line
pen.up!
pen.move 150
pen.down!

# Draw a octagon
8.times do
	pen.move 40
	pen.turn_right 45
end

# Move to the middle bottom of the sheet without drawing lines
pen.up!
pen.move -55
pen.turn_right 90
pen.move 250
pen.turn_left 180
pen.down!
pen.move 10

# Define how to draw a tree recursively
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

# Draw 8 trees in a circle
8.times do
	draw_tree pen, 40
	pen.turn_left 45
end

# After all drawing is done, #show has to be called on the window to actually display everything
sheet.show

# Press Escape to close the window again