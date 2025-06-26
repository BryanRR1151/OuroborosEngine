draw_set_font(fnM3x6);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_sprite(sFree, 0, x + 10, y + 136);
draw_sprite(sBlocked, 0, x + 10, y + 136 + 16);
draw_sprite(sActive, 0, x + 10, y + 136 + 32);

draw_sprite(sNormal, 0, 300, y + 136 - 8);
draw_sprite(sShop, 0, 300, y + 136 + 16 - 8);
draw_sprite(sBoss, 0, 300, y + 136 + 32 - 8);

draw_set_halign(fa_left);
draw_text(x + 20, y + 134, "Disponible");
draw_text(x + 20, y + 134 + 16, "No Disponible");
draw_text(x + 20, y + 134 + 32, "Completado");

draw_set_halign(fa_right);
draw_text(300, y + 134, "Batalla");
draw_text(300, y + 134 + 16, "Tienda");
draw_text(300, y + 134 + 32, "Desafio");