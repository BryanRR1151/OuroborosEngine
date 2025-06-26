draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_sprite_stretched(sBox, 0, x + 10, y + 5, width - 20, height - 10);

draw_set_halign(fa_center);
draw_set_font(fnM3x6);
draw_text(width/2 + 135, y + 5, string("{0}s", ceil(time/60)));

if(!pageToggle)
{
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_font(fnM3x6);
	draw_text(width/2, y + 5, WrapText(textE0, 2, 65));
	draw_text(width/2, y + 15, WrapText(textE1, 2, 65));
	draw_text(width/2, y + 25, WrapText(textE2, 2, 65));
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
	for(var i = 0; i < 4; i++)
	{
		draw_text(x + 20, y + 60 + i*30, WrapText(string("{0}. " + _options[i].v, i+1), 2, 63));
	}
	
	draw_text(x + 290, y + 145, "->");
	draw_sprite(sShift, 0, x + 290, y + 160);
	
}
else
{
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fnM3x6);
	
	draw_text(width/2, y + 50, WrapText(textE1, 2, 65));
	draw_sprite_stretched(sBox, 0, width/2 - 25, y + 60, 50, 20);
	draw_text(width/2, y + 100, WrapText(textE2, 2, 65));
	draw_sprite_stretched(sBox, 0, width/2 - 25, y + 110, 50, 20);
	
	if (!inputToggle) draw_sprite(sPointer, 0, width/2 - 25, y + 70);
	else draw_sprite(sPointer, 0, width/2 - 25, y + 120);
	
	if (answered)
	{
		draw_set_color(c_lime);
		draw_text(width/2 + 50, 70, C1);
		
		if (cor1) draw_set_color(c_lime);
		else draw_set_color(c_red);
	}
	else
	{
		if (!inputToggle) draw_set_color(c_yellow);
		else draw_set_color(c_white);
	}
	draw_text(width/2, 70, answer1);
	
	if (answered)
	{
		draw_set_color(c_lime);
		draw_text(width/2 + 50, 120, C2);
		
		if (cor2) draw_set_color(c_lime);
		else draw_set_color(c_red);
	}
	else
	{
		if (inputToggle) draw_set_color(c_yellow);
		else draw_set_color(c_white);
	}
	draw_text(width/2, 120, answer2);
	
	draw_set_color(c_white)
	draw_text(x + 30, y + 145, "<-");
	draw_sprite(sShift, 0, x + 30, y + 160);
	
	draw_text(width/2, y + 145, "Mover");
	draw_sprite(sUp, 0, width/2 - 8, y + 160);
	draw_sprite(sDown, 0, width/2 + 8, y + 160);
	
	draw_text(x + 289, y + 145, "Responder");
	draw_sprite(sEnter, 0, x + 289, y + 160);
}