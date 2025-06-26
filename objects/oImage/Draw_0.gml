if(!pageToggle)
{
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	draw_sprite_stretched(sBox, 0, x + 10, y + 5, width - 20, height - 10);
	
	draw_set_halign(fa_center);
	draw_set_font(fnM3x6);
	draw_text(width/2, y + 5, WrapText("Segun esta imagen...", 2, 65));
	
	draw_set_valign(fa_middle);
	draw_sprite(_sprite, -1, width/2, height/2 + 5);
	
	draw_text(x + 290, y + 145, "->");
	draw_sprite(sShift, 0, x + 290, y + 160);
}
else
{
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	draw_sprite_stretched(sBox, 0, x + 10, y + 10, width - 20, 39);
	draw_sprite_stretched(sBox, 0, x + 10, y + 50, width - 20, height - 55);

	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_sprite(sUp, 0, width/2, 112 - 8);
	draw_sprite(sLeft, 0, width/2 - 16, 112);
	draw_sprite(sRight, 0, width/2 + 16, 112);
	draw_sprite(sDown, 0, width/2, 112 + 8);

	draw_set_font(fnM3x6);
	draw_text(width/2, y + 16, WrapText(textQ, 2, 65));

	draw_set_valign(fa_top);
	if (answered)
	{
		if (correct = "U") draw_set_color(c_lime);
		else draw_set_color(c_red);
	}
	draw_text(width/2, 112 - 60, WrapText(_answers[0], 3, 21));
	
	draw_set_valign(fa_bottom);
	if (answered)
	{
		if (correct = "D") draw_set_color(c_lime);
		else draw_set_color(c_red);
	}
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

	draw_set_color(c_white)
	draw_text(x + 30, y + 145, "<-");
	draw_sprite(sShift, 0, x + 30, y + 160);
}

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_font(fnM3x6);
draw_text(width/2 + 135, y + 16, string("{0}s", ceil(time/60)));

