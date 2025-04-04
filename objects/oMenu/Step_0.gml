if (active)
{
	//Control menu with keyboard
	hover += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
	if (hover > array_length(options) - 1) hover = 0;
	if (hover < 0) hover = array_length(options) - 1;
	
	//Execute selected option
	if (keyboard_check_pressed(vk_enter))
	{
		if (options[hover].func != undefined && options[hover].avail)
		{
			if (options[hover].func != -1)
			{
				var _func = options[hover].func;
				if (options[hover].args != -1) script_execute_ext(_func, options[hover].args);
				else _func();
			}
		}
	}
	
	if (keyboard_check_pressed(vk_escape))
	{
		if (subMenuLevel > 0) MenuGoBack();
	}
	
}