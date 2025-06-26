var _keyToggle = keyboard_check_pressed(vk_shift);
if (_keyToggle)
{
	resultsPage = !resultsPage;
	var rPage = resultsPage;
	with (oButtonReturn) visible = rPage;
	audio_play_sound(eShift, 0, false);
}

if (!resultsPage)
{
	var _keyUp = keyboard_check_pressed(vk_up);
	var _keyDown = keyboard_check_pressed(vk_down);
	var _keyLeft = keyboard_check_pressed(vk_left);
	var _keyRight = keyboard_check_pressed(vk_right);
		
	var _moveH = _keyRight - _keyLeft;
	var _moveV = _keyDown - _keyUp;
		
	if (_moveH == -1 && qPage > 1) 
	{
		audio_play_sound(eDownLeft, 0, false);
		qPage--;
	}
	if (_moveH == 1 && qPage < qTotal ) 
	{
		audio_play_sound(eUpRight, 0, false);
		qPage++;
	}
	
	if (_moveV == -1)
	{
		audio_play_sound(eDownLeft, 0, false);
		qToggle = false;
	}
	if (_moveV == 1) 
	{
		audio_play_sound(eDownLeft, 0, false);
		qToggle = true;
	}
}
