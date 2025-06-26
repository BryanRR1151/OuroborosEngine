switch (select)
{
	case 1: _pointerX = 60; break;
	case 2: _pointerX = 160; break;
	case 3: _pointerX = 260; break;
}

var _keyLeft = keyboard_check_pressed(vk_left);
var _keyRight = keyboard_check_pressed(vk_right);

var _moveH = _keyRight - _keyLeft;

if (_moveH == -1 && select > 1)
{
	audio_play_sound(eDownLeft, 0, false);
	select--;
}
if (_moveH == 1 && select < 3) 
{
	audio_play_sound(eUpRight, 0, false);
	select++;
}

var _keyEnter = keyboard_check_pressed(vk_enter);

if (_keyEnter) 
{
	var args = options[select-1].args;
	args[1](args[2]);
	audio_play_sound(eMenuSelect, 0, false);
	
	if(shop)
	{
		Menu(_x + 10, _y + 10, _menuOptions, undefined, 300, 160, shop);
	}
	instance_destroy();
}