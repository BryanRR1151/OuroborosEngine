draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_sprite_stretched(sBox, 0, x + 10, y + 5, width - 20, height - 10);

draw_sprite_stretched(sBox, 0, x + 20, y + 20, 80, 120);
draw_sprite_stretched(sBox, 0, x + 120, y + 20, 80, 120);
draw_sprite_stretched(sBox, 0, x + 220, y + 20, 80, 120);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnM5x7);
draw_sprite_ext(sPointer, 0, x + _pointerX, y + 135, 1, 1, 90, c_white, 1);

for(var i = 0; i < 3; i++)
{
	draw_sprite(options[i].spriteR, 0, x + 60 + 100*i, y + 40);
	draw_text(x + 60 + 100*i, y + 70, WrapText(options[i].nameR, 2, 11));
	draw_text(x + 60 + 100*i, y + 100, WrapText(options[i].descR, 5, 11));
}

draw_set_font(fnM3x6);
draw_text(width/2 + 125, y + 145, "Seleccionar");
draw_sprite(sEnter, 0, width/2 + 125, y + 160)

draw_text(width/2 - 135 + 8, y + 145, "Mover");
draw_sprite(sLeft, 0, width/2 - 135, y + 160);
draw_sprite(sRight, 0, width/2 - 135 + 16, y + 160);