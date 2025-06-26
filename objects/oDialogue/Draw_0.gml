draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_sprite_stretched(sBox, 0, x + 10, y + 5, width - 20, height - 10);

draw_set_font(fnM3x6);
draw_set_halign(fa_center);
draw_text(width/2, height/2 - 65, d);

draw_text(width/2, y + 15, _dialogue.n);
draw_sprite(_sprite, 0, x + 290, y + 15);

draw_text(x + 285, y + 140, "Continuar");
draw_sprite(sEnter, 0, x + 285, y + 160);