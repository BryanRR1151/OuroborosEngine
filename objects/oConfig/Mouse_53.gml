show_debug_message("MouseX: " + string(mouse_x));
show_debug_message("MouseY: " + string(mouse_y));

if (mouse_x > input_x/2 && mouse_x < input_x/2 + input_w/2) {
    if (mouse_y > input_y/2 && mouse_y < input_y/2 + input_h/2) {
        active_field = "volume";
    } else if (mouse_y > input_y/2 + 40 && mouse_y < input_y/2 + input_h/2 + 40) {
        active_field = "questionChance";
    } else if (mouse_y > input_y/2 + 80 && mouse_y < input_y/2 + input_h/2 + 80) {
        active_field = "questionTime";
    } else {
        active_field = "";
    }
}else active_field = "";

show_debug_message("active_field: " + active_field);

if (mouse_x > input_x && mouse_x < input_x + input_w && mouse_y > input_y + 240 && mouse_y < input_y + 270) {
    global.config.volume = clamp(real(volume_input), 0, 100);
	global.config.questionChance = clamp(real(questionChance_input), 0, 100);
    global.config.questionTime = max(real(questionTime_input), 0);
    
    show_message("Settings Saved!");
}