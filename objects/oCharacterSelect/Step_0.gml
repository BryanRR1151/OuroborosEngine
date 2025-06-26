var _keyLeft = keyboard_check_pressed(vk_left);
var _keyRight = keyboard_check_pressed(vk_right);
		
var _moveH = _keyRight - _keyLeft;
		
if (_moveH == -1 && _index > 0) 
{
	audio_play_sound(eDownLeft, 0, false);
	_index--;
}
if (_moveH == 1 && _index < cMax - 1)
{
	audio_play_sound(eUpRight, 0, false);
	_index++;
}

switch (_index mod 3)
{
	case 0: _pointerX = 60; break;
	case 1: _pointerX = 160; break;
	case 2: _pointerX = 260; break;
}

var _keyEnter = keyboard_check_pressed(vk_enter)

if (_keyEnter)
{
	if (SelectedCharacter(_index))
	{
		if (array_length(global.selectedCharacters) > 1) 
		{
			audio_play_sound(eMenuSelect, 0, false);
			RemoveItem(_index);
		}
		else audio_play_sound(eBlocked, 0, false);
	}
	else if (global.general.characters[_index].unlocked)
	{
		if (array_length(global.selectedCharacters) < 3) 
		{
			audio_play_sound(eMenuSelect, 0, false);
			array_push(global.selectedCharacters, _index);
		}
		else audio_play_sound(eBlocked, 0, false);
	}
	else
	{
		audio_play_sound(eBlocked, 0, false);
	}
}