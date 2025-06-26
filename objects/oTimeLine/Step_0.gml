if (time >= 0 && !answered) time--;

var _key1 = keyboard_check_pressed(vk_numpad1) || keyboard_check_pressed(ord("1"));
var _key2 = keyboard_check_pressed(vk_numpad2) || keyboard_check_pressed(ord("2"));
var _key3 = keyboard_check_pressed(vk_numpad3) || keyboard_check_pressed(ord("3"));
var _key4 = keyboard_check_pressed(vk_numpad4) || keyboard_check_pressed(ord("4"));
var _keyDelete = keyboard_check_pressed(vk_backspace);
var _keyEnter = keyboard_check_pressed(vk_enter);

if (string_length(answer) < 4)
{
	if (_key1 && !answered) answer += "1";
	if (_key2 && !answered) answer += "2";
	if (_key3 && !answered) answer += "3";
	if (_key4 && !answered) answer += "4";
}

if (_keyDelete && !answered) answer = string_copy(answer, 1, string_length(answer) - 1);

if (_keyEnter && !answered)
{
	if (answer == correct)
	{
		instance_create_depth(
			width/2, 
			height/2 + 15,
			-999999,
			oBattleFloatingText,
			{font: fnM5x7, col: c_lime, text: "Bien!"}
		);
		success = true;
		audio_play_sound(eCorrect, 0, false);
		answered = true;
	}
}

if ((_keyEnter || time <= 0) && !answered)
{
	instance_create_depth(
		width/2, 
		height/2 + 15,
		-999999,
		oBattleFloatingText,
		{font: fnM5x7, col: c_red, text: "Que mal..."}
	);
	answered = true;
	audio_play_sound(eWrong, 0, false);
}

if (answered) close--;

if (close <= 0) instance_destroy();