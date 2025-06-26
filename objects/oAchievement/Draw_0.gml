draw_set_color(c_white);
draw_set_font(fnM5x7);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_sprite_stretched(sBox, 0, 10, 10, 300, 130);

draw_set_halign(fa_center);
if (global.general.achievements[_index-1].completed) draw_set_color(c_lime);
else draw_set_color(c_red);
draw_text(width/2, y + 20, WrapText(global.general.achievements[_index-1].name, 2, 50));

draw_set_color(c_white);
draw_set_valign(fa_middle);
draw_text(width/2, height/2 - 15, WrapText(global.general.achievements[_index-1].description, 6, 50));

draw_set_valign(fa_top);
draw_text(width/2, y + 120, string("{0}/{1}", _index, aMax));

draw_set_valign(fa_middle);
draw_sprite(sLeft, 0, width/2 - 20, y + 128);
draw_sprite(sRight, 0, width/2 + 20, y + 128);