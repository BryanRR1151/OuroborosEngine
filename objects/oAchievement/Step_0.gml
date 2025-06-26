var _keyLeft = keyboard_check_pressed(vk_left);
var _keyRight = keyboard_check_pressed(vk_right);
		
var _moveH = _keyRight - _keyLeft;
		
if (_moveH == -1 && _index > 1) 
{
	audio_play_sound(eDownLeft, 0, false);
	_index--;
}

if (_moveH == 1 && _index < aMax)
{
	audio_play_sound(eUpRight, 0, false);
	_index++;
}