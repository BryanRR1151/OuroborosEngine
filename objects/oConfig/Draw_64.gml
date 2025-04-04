draw_set_halign(fa_left);
draw_set_valign(fa_middle);

draw_set_color(c_white);
// Draw Labels
draw_text(input_x, input_y - 10, "Volumen:");
draw_text(input_x, input_y + 70, "Probabilidad de Preguntas (0-100):");
draw_text(input_x, input_y + 150, "Tiempo de Preguntas (segundos):");

draw_set_color(c_black);
draw_rectangle(input_x, input_y, input_x + input_w, input_y + input_h, false);
draw_rectangle(input_x, input_y + 80, input_x + input_w, input_y + input_h + 80, false);
draw_rectangle(input_x, input_y + 160, input_x + input_w, input_y + input_h + 160, false);
draw_rectangle(input_x + 360, input_y + 160,
			input_x + 360 + input_w/2, input_y + 160 + input_h, false);
draw_rectangle(input_x + 360 + 116, input_y + 160,
			input_x + 360 + 116 + input_w/2, input_y + 160 + input_h, false);


draw_set_color(c_silver);
// Draw Input Boxes
draw_rectangle(input_x + outline, input_y + outline,
			input_x + input_w - outline, input_y + input_h - outline, false);
draw_rectangle(input_x + outline, input_y + 80 + outline,
			input_x + input_w - outline, input_y + input_h + 80 - outline, false);
draw_rectangle(input_x + outline, input_y + 160 + outline,
			input_x + input_w - outline, input_y + input_h + 160 - outline, false);
			
draw_set_color(c_green);
draw_rectangle(input_x + 360 + outline, input_y + 160 + outline,
			input_x + 360 + input_w/2 - outline, input_y + 160 + input_h - outline, false);
			
draw_set_color(c_navy);
draw_rectangle(input_x + 360 + 116 + outline, input_y + 160 + outline,
			input_x + 360 + 116 + input_w/2 - outline, input_y + 160 + input_h - outline, false);


draw_set_color(c_black);
// Draw Input Text
draw_text(input_x + 10, input_y + 15, volume_input);
draw_text(input_x + 10, input_y + 95, questionChance_input);
draw_text(input_x + 10, input_y + 175, questionTime_input);

draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(input_x + 360 + input_w/4, input_y + 175, "Guardar");
draw_text(input_x + 360 + 116 + input_w/4, input_y + 175, "Cargar");

