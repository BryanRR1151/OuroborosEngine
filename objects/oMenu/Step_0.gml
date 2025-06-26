if (active)
{
	//Control menu with keyboard
	var _move =  keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
	hover += _move;
	
	if (_move == 1) audio_play_sound(eDownLeft, 0, false);
	if (_move == -1) audio_play_sound(eUpRight, 0, false);
	
	if (hover > array_length(options) - 1) hover = 0;
	if (hover < 0) hover = array_length(options) - 1;
	
	//Execute selected option
	if (keyboard_check_pressed(vk_enter))
	{
		if (options[hover].func != undefined && options[hover].avail)
		{
			audio_play_sound(eMenuSelect, 0, false);
			if (options[hover].func != -1)
			{
				var _func = options[hover].func;
				if (options[hover].args != -1) script_execute_ext(_func, options[hover].args);
				else _func();
			}
		}
		else audio_play_sound(eBlocked, 0, false);
	}
	
	if (keyboard_check_pressed(vk_escape))
	{
		if (subMenuLevel > 0) MenuGoBack();
	}
	
}