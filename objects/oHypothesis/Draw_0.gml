draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_sprite_stretched(sBox, 0, x + 10, y + 5, width - 20, height - 10);

draw_set_halign(fa_center);
draw_set_font(fnM3x6);
draw_text(width/2 + 135, y + 5, string("{0}s", ceil(time/60)));

if(!pageToggle)
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_font(fnM3x6);
	draw_text(width/2, y + 5, WrapText("Complete el siguiente texto...", 2, 65));
	
	draw_set_valign(fa_middle);
	draw_text(width/2, height/2, textL);
	
	draw_text(x + 290, y + 145, "->");
	draw_sprite(sShift, 0, x + 290, y + 160);
}
else
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_sprite(sUp, 0, width/2, height/2 - 8);
	draw_sprite(sLeft, 0, width/2 - 16, height/2);
	draw_sprite(sRight, 0, width/2 + 16, height/2);
	draw_sprite(sDown, 0, width/2, height/2 + 8);

	draw_set_font(fnM3x6);
	draw_set_valign(fa_top);
	if (answered)
	{
		if (correct = "U") draw_set_color(c_lime);
		else draw_set_color(c_red);
	}
	draw_text(width/2, y + 10, WrapText(_answers[0], 3, 21));
	
	draw_set_valign(fa_bottom);
	if (answered)
	{
		if (correct = "D") draw_set_color(c_lime);
		else draw_set_color(c_red);
	}
	draw_text(width/2, y + 165, WrapText(_answers[3], 3, 21));
	
	draw_set_valign(fa_middle);
	if (answered)
	{
		if (correct = "L") draw_set_color(c_lime);
		else draw_set_color(c_red);
	}
	draw_text(width/2 - 100, height/2, WrapText(_answers[1], 3, 21));

	if (answered)
	{
		if (correct = "R") draw_set_color(c_lime);
		else draw_set_color(c_red);
	}
	draw_text(width/2 + 100, height/2, WrapText(_answers[2], 3, 21));
	
	draw_set_color(c_white)
	draw_text(x + 30, y + 145, "<-");
	draw_sprite(sShift, 0, x + 30, y + 160);
}