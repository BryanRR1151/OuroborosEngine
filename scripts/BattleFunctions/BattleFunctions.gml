function NewEncounter(_enemies, _bg, _creator, _treeX, _treeY, _music, _isBoss = false){
	
	//_enemies = variable_clone(_enemies);
	
	var enemies = variable_clone(_enemies);
	
	var extraAtk = 3 * (_treeY-1);
	var extraHp = 7 * (_treeY-1);
	
	if (_treeY > 4) extraHp += _treeY * 6;
	
	for (var i = 0; i < array_length(enemies); i++)
	{
		enemies[i].hp = 1;
		enemies[i].hpMax = 1;
		enemies[i].strength = 1;
	}
	
	instance_create_depth(
		camera_get_view_x(view_camera[0]),
		camera_get_view_y(view_camera[0]),
		-9999,
		oBattle,
		{
			enemies: enemies,
			creator: _creator,
			battleMusic: _music,
			battleBackground: _bg,
			treeX: _treeX,
			treeY: _treeY,
			isBoss: _isBoss
		}
	);
}

function BattleChangeHP(_target, _amount, _aliveDeadOrEither = 0)
{
	//_aliveDeadOrEither: 0 = alive only, 1 = dead only, 2 = any
	var _failed = false;
	if ((_aliveDeadOrEither == 0) && (_target.hp <= 0)) _failed = true;
	if ((_aliveDeadOrEither == 1) && (_target.hp > 0)) _failed = true;
	
	var _col = c_white;
	
	if (_amount > 0) _col = c_lime;
	
	if(_failed)
	{
		_col = c_white;
		_amount = "DERROTADO...";
	}
	
	instance_create_depth(
		_target.x,
		_target.y,
		_target.depth - 1,
		oBattleFloatingText,
		{font: fnM5x7, col: _col, text: string(_amount)}
	);
	
	if (!_failed) _target.hp = clamp(_target.hp + _amount, 0, _target.hpMax);
}

function BattleChangeMP(_target, _amount)
{
	instance_create_depth(
		_target.x - 24,
		_target.y,
		_target.depth - 1,
		oBattleFloatingText,
		{font: fnM5x7, col: c_aqua, text: string(_amount)}
	);
	
	_target.mp = clamp(_target.mp + _amount, 0, _target.mpMax);
}

function BattleChangeGold(_amount)
{
	instance_create_depth(
		camera_get_view_x(view_camera[0]) + 160 + 30,
		camera_get_view_y(view_camera[0]) + 90,
		-999999,
		oBattleFloatingText,
		{font: fnM5x7, col: c_yellow, text: string("+{0}g!", _amount)}
	);
	audio_play_sound(eCoin, 0, false);
	global.player.gold += _amount;
}