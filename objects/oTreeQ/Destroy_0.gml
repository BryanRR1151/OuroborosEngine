var _count = array_length(global.go.questions) - 1;
global.go.questions[_count].c = success;

if (success)
{
	global.go.correct++;
	
	instance_create_depth(
		_x,
		_y,
		-9999,
		oReward,
		{
			_x: _x,
			_y: _y,
			_menuOptions: _menuOptions,
			shop: true,
			isBoss: false
		}
	);
}
else
{
	Menu(_x + 10, _y + 10, _menuOptions, undefined, 300, 160, true);
}

