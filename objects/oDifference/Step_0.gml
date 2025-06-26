if (time >= 0 && !answered) time--;

var _keyEnter = false;

if (keyboard_check_pressed(vk_shift) && !answered) 
{
	pageToggle = !pageToggle;
	audio_play_sound(eShift, 0, false);
}

if(pageToggle && !answered)
{
	
	var _keyUp = keyboard_check_pressed(vk_up);
	var _keyDown = keyboard_check_pressed(vk_down);

	if (_keyUp || _keyDown) 
	{
		if(inputToggle) audio_play_sound(eDownLeft, 0, false);
		else audio_play_sound(eUpRight, 0, false);
		inputToggle = !inputToggle;
	}
	
	var _key1 = keyboard_check_pressed(vk_numpad1) || keyboard_check_pressed(ord("1"));
	var _key2 = keyboard_check_pressed(vk_numpad2) || keyboard_check_pressed(ord("2"));
	var _key3 = keyboard_check_pressed(vk_numpad3) || keyboard_check_pressed(ord("3"));
	var _key4 = keyboard_check_pressed(vk_numpad4) || keyboard_check_pressed(ord("4"));
	var _keyDelete = keyboard_check_pressed(vk_backspace);

	if (!inputToggle)
	{
		if (string_length(answer1) < 4)
		{
			if (_key1 && !answered) answer1 += "1";
			if (_key2 && !answered) answer1 += "2";
			if (_key3 && !answered) answer1 += "3";
			if (_key4 && !answered) answer1 += "4";
		}

		if (_keyDelete && !answered) answer1 = string_copy(answer1, 1, string_length(answer1) - 1);
	}
	else
	{
		if (string_length(answer2) < 4)
		{
			if (_key1 && !answered) answer2 += "1";
			if (_key2 && !answered) answer2 += "2";
			if (_key3 && !answered) answer2 += "3";
			if (_key4 && !answered) answer2 += "4";
		}

		if (_keyDelete && !answered) answer2 = string_copy(answer2, 1, string_length(answer2) - 1);
	}
	
	_keyEnter = keyboard_check_pressed(vk_enter);
	
}


if ((_keyEnter || time <= 0) && !answered)
{
	cor1 = CompareAnswer(answer1, C1);
	cor2 = CompareAnswer(answer2, C2);
	answered = true;
	pageToggle = true;
	
	if (cor1) 
	{
		instance_create_depth(
			width/2 + 50, 
			70,
			-999999,
			oBattleFloatingText,
			{font: fnM5x7, col: c_lime, text: "Bien!"}
		);
	}
	else
	{
		instance_create_depth(
			width/2 + 50, 
			70,
			-999999,
			oBattleFloatingText,
			{font: fnM5x7, col: c_red, text: "Que mal..."}
		);
	}
	
	if (cor1) 
	{
		instance_create_depth(
			width/2 + 50, 
			110,
			-999999,
			oBattleFloatingText,
			{font: fnM5x7, col: c_lime, text: "Bien!"}
		);
	}
	else
	{
		instance_create_depth(
			width/2 + 50, 
			110,
			-999999,
			oBattleFloatingText,
			{font: fnM5x7, col: c_red, text: "Que mal..."}
		);
	}
	
	if (cor1 && cor2) {
		success = true;
		audio_play_sound(eCorrect, 0, false);
	}
	else audio_play_sound(eWrong, 0, false);
}

if (answered) close--;

if (close <= 0) instance_destroy();