draw_set_alpha(fade_alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, 320, 180, false);

draw_set_alpha(1 - fade_alpha);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(fnM3x6);

draw_sprite_stretched(sBox, 0, 5, 100, width - 10, 75);
draw_text(10, 100, text);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(295, 145, "->")
draw_sprite(sEnter, 0, 295, 160);

switch (dIndex)
{
	case 0: DrawScene0(); break;
	case 1: DrawScene1(); break;
	case 2: DrawScene2(); break;
	case 3:
	case 4: DrawScene34(); break;
	case 5:
	case 6:
	case 7: DrawScene567(); break;
}