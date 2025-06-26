draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_sprite_stretched(sBox, 0, x + 10, y + 10, width - 20, height - 20);

draw_set_halign(fa_center);
draw_set_font(fnM3x6);
draw_text(width/2 + 135, y + 15, string("{0}s", ceil(time/60)));

draw_text(width/2, y + 130, WrapText(textQ, 2, 65));
draw_sprite_stretched(sBox, 0, width/2 - 20, y + 145, 40, 20);

draw_set_halign(fa_left);
draw_text(x + 30, y + 25, "1. " + WrapText(_events[0].event, 3, 21));
draw_text(x + 210, y + 25, "2. " + WrapText(_events[1].event, 3, 21));
draw_text(x + 30, y + 80, "3. " + WrapText(_events[2].event, 3, 21));
draw_text(x + 210, y + 80, "4. " + WrapText(_events[3].event, 3, 21));

draw_set_halign(fa_center);
if (answered)
{
	draw_set_color(c_lime);
	draw_text(width/2 + 35, y + 145, correct);
	
	if (answer == correct) draw_set_color(c_lime);
	else draw_set_color(c_red);
}
draw_text(width/2, y + 145, answer);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(width/2 + 125, y + 140, "Responder");
draw_sprite(sEnter, 0, width/2 + 125, y + 155)