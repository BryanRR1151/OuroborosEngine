draw_set_color(c_white);
draw_set_font(fnM3x6);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_sprite_stretched(sBox, 0, 10, 10, 300, 130);

var _page = (_index div 3) * 3;

draw_set_halign(fa_center);
for (var i = _page; i < min(_page + 3, array_length(global.general.characters)); i++)
{
	var _mod = i mod 3;
	draw_sprite_stretched(sBox, 0, x + 20 + 100*_mod, y + 20, 80, 90);
	if (SelectedCharacter(i)) draw_set_color(c_lime);
	else if (global.general.characters[i].unlocked) draw_set_color(c_yellow);
	else draw_set_color(c_red);
	draw_text(x + 60 + 100*_mod, y + 20, WrapText(global.playableCharacters[i].name, 2, 50));
	
	draw_sprite(global.playableCharacters[i].sprites.idle, 1, x + 60 + 100*_mod, y + 50);
	
	draw_set_color(c_white);
	draw_set_font(fnM3x6);
	draw_text(x + 60 + 100*_mod, y + 60, WrapText(global.playableCharacters[i].flavorText, 3, 18));
}

draw_set_font(fnM5x7);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_sprite_ext(sPointer, 0, x + _pointerX, y + 95, 1, 1, 90, c_white, 1);
draw_text(width/2, y + 120, string("{0}/{1}", _index + 1, cMax));

draw_set_font(fnM3x6);
draw_set_valign(fa_middle);
draw_sprite(sLeft, 0, width/2 - 20, y + 128);
draw_sprite(sRight, 0, width/2 + 20, y + 128);

draw_sprite(sEnter, 0, width/2 + 130, y + 128);
draw_text(width/2 + 94, y + 125, "Seleccionar");