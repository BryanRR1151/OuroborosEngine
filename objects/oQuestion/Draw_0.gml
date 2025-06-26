draw_set_color(c_white);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_sprite_stretched(sBox, 0, x + 10, y + 10, width - 20, 39);
draw_sprite_stretched(sBox, 0, x + 10, y + 50, width - 20, height - 55);

draw_set_font(fnM3x6);
draw_set_valign(fa_top);
draw_text(width/2 + 130, y + 10, string("{0}s", ceil(time/60)));

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_sprite(sUp, 0, width/2, 112 - 8);
draw_sprite(sLeft, 0, width/2 - 16, 112);
draw_sprite(sRight, 0, width/2 + 16, 112);
draw_sprite(sDown, 0, width/2, 112 + 8);

draw_text(width/2, y + 20, WrapText(textQ, 2, 65));

if (answered)
{
	if (correct = "U") draw_set_color(c_lime);
	else draw_set_color(c_red);
}
draw_set_valign(fa_top);
draw_text(width/2, 112 - 60, WrapText(_answers[0], 3, 21));

if (answered)
{
	if (correct = "D") draw_set_color(c_lime);
	else draw_set_color(c_red);
}
draw_set_valign(fa_bottom);
draw_text(width/2, 112 + 55, WrapText(_answers[3], 3, 21));

draw_set_valign(fa_middle);
if (answered)
{
	if (correct = "L") draw_set_color(c_lime);
	else draw_set_color(c_red);
}
draw_text(width/2 - 100, 112, WrapText(_answers[1], 3, 21));

if (answered)
{
	if (correct = "R") draw_set_color(c_lime);
	else draw_set_color(c_red);
}
draw_text(width/2 + 100, 112, WrapText(_answers[2], 3, 21));



