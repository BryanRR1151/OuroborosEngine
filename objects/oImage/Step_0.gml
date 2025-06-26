if (time >= 0 && !answered) time--;

var _keyUp = false;
var _keyDown = false;
var _keyLeft = false;
var _keyRight = false;

if (keyboard_check_pressed(vk_shift) && !answered) 
{
	pageToggle = !pageToggle;
	audio_play_sound(eShift, 0, false);
}

if(pageToggle)
{
	_keyUp = keyboard_check_pressed(vk_up);
	_keyDown = keyboard_check_pressed(vk_down);
	_keyLeft = keyboard_check_pressed(vk_left);
	_keyRight = keyboard_check_pressed(vk_right);

	if (_keyUp && correct == "U"  && !answered)
	{
		answered = true;
		instance_create_depth(
			width/2, 
			height/2 + 15,
			-999999,
			oBattleFloatingText,
			{font: fnM5x7, col: c_lime, text: "Bien!"}
		);
		success = true;
		audio_play_sound(eCorrect, 0, false);
	}

	if (_keyDown && correct == "D"  && !answered)
	{
		instance_create_depth(
			width/2, 
			height/2 + 15,
			-999999,
			oBattleFloatingText,
			{font: fnM5x7, col: c_lime, text: "Bien!"}
		);
		answered = true;
		success = true;
		audio_play_sound(eCorrect, 0, false);
	}

	if (_keyLeft && correct == "L"  && !answered)
	{
		instance_create_depth(
			width/2, 
			height/2 + 15,
			-999999,
			oBattleFloatingText,
			{font: fnM5x7, col: c_lime, text: "Bien!"}
		);
		answered = true;
		success = true;
		audio_play_sound(eCorrect, 0, false);
	}

	if (_keyRight && correct == "R" && !answered)
	{
		instance_create_depth(
			width/2, 
			height/2 + 15,
			-999999,
			oBattleFloatingText,
			{font: fnM5x7, col: c_lime, text: "Bien!"}
		);
		answered = true;
		success = true;
		audio_play_sound(eCorrect, 0, false);
	}
}


if ((_keyUp || _keyDown || _keyLeft || _keyRight || time <= 0) && !answered)
{
	instance_create_depth(
		width/2, 
		height/2 + 15,
		-999999,
		oBattleFloatingText,
		{font: fnM5x7, col: c_red, text: "Que mal..."}
	);
	answered = true;
	pageToggle = true;
	audio_play_sound(eWrong, 0, false);
}

if (answered) close--;

if (close <= 0) instance_destroy();