if (instance_exists(oMusic))
{
	var _battleMusic = battleMusic;
	with(oMusic) 
	{
		audio_pause_sound(current_sound);
		current_sound_aux = audio_play_sound(_battleMusic, 0, true);
	}
}

instance_deactivate_all(true);

units = [];
turn = 0;
unitTurnOrder = [];
unitRenderOrder = [];
turnCount = 0;
roundCount = 0;
battleWaitTimeFrames = 30;
battleWaitTimeRemaining = 0;
battleText = "";
currentUser = noone;
currentAction = -1;
currentTargets = noone;
qSuccess = false;

//Make targetting cursor
cursor =
{
	activeUser: noone,
	activeTarget: noone,
	activeAction: -1,
	targetSide: -1,
	targetIndex: 0,
	targetAll: false,
	confirmDelay: 0,
	active: false
};

for(var i = 0; i < array_length(enemies); i++)
{
	enemyUnits[i] = instance_create_depth(x + 250 + (i*10), y + 68 + (i*20), depth - 10,
					oBattleUnitEnemy, enemies[i]);
					
	array_push(units, enemyUnits[i]);
}

for(var i = 0; i < array_length(global.party); i++)
{
	partyUnits[i] = instance_create_depth(x + 70 + (i*10), y + 68 + (i*15), depth - 10,
					oBattleUnitPC, global.party[i]);
					
	array_push(units, partyUnits[i]);
}

//Shuffle turn order
unitTurnOrder = array_shuffle(units);

//Get render order
RefreshRenderOrder = function()
{
	unitRenderOrder = [];
	array_copy(unitRenderOrder, 0, units, 0, array_length(units));
	array_sort(unitRenderOrder, function(_1, _2)
	{
		return _1.y - _2.y;
	});
}

RefreshRenderOrder();

function BattleStateSelectAction()
{
	if (!instance_exists(oMenu))
	{
		//Get current unit
		var _unit = unitTurnOrder[turn];
	
		//is the unit dead or unable to act?
		if(!instance_exists(_unit) || (_unit.hp <= 0))
		{
			battleState = BattleStateVictoryCheck;
			exit;
		}
	
		//If unit is player controlled:
		if (_unit.object_index == oBattleUnitPC)
		{
			var _menuOptions = [];
			var _subMenus = {};
			
			var _actionList = _unit.actions;
			
			for (var i = 0; i < array_length(_actionList); i++)
			{
				var _action = _actionList[i];
				//var _available = true; //TODO: see if available
				var _available = _unit.actions[i].avail(_unit);
				var _nameAndCount = _action.name;
				if (_action.subMenu == -1)
				{
					array_push(_menuOptions, { name: _nameAndCount, func: MenuSelectAction, args: [_unit, _action], avail: _available });
				}
				else
				{
					//create or add to a submenu
					if (is_undefined(_subMenus[$ _action.subMenu]))
					{
						variable_struct_set(_subMenus, _action.subMenu, [{ name: _nameAndCount, func: MenuSelectAction, args: [_unit, _action], avail: _available }]);
					}
					else
					{
						array_push(_subMenus[$ _action.subMenu], { name: _nameAndCount, func: MenuSelectAction, args: [_unit, _action], avail: _available });
					}
				}
				
				
			}
			
			//turn sub menus into an array
			var _subMenusArray = variable_struct_get_names(_subMenus);
			for (var j = 0; j < array_length(_subMenusArray); j++)
			{
				//TODO: sort submenu
				
				//add back option at the end of each submenu
				array_push(_subMenus[$ _subMenusArray[j]], { name: "Regresar", func: MenuGoBack, args: -1, avail: true });
				//add submenu into main menu
				array_push(_menuOptions, {name: _subMenusArray[j], func: SubMenu, args: [_subMenus[$ _subMenusArray[j]]], avail: true })
			}
			
			Menu(x + 10, y + 110, _menuOptions, undefined, 74, 60);
			
		}
		else
		{
			var _enemyAction = _unit.AIScript();
			if (_enemyAction != -1) BeginAction(_unit.id, _enemyAction[0], _enemyAction[1]);
		}
	}
	
}

function BeginActionQuestion(_user, _action, _targets)
{
	qSuccess = false;
	currentUser = _user;
	currentAction = _action;
	currentTargets = _targets;
	
    battleState = BattleWaitQuestion;
	
	var _rand = irandom(1);
	var _qObject = noone;
	
	switch (_rand)
	{
		case 0: _qObject = oQuestion; break;
		case 1: _qObject = oTimeLine; break;
	}
	
	instance_create_depth(
		camera_get_view_x(view_camera[0]),
		camera_get_view_y(view_camera[0]),
		-99999,
		_qObject
	);
}

function BeginAction(_user, _action, _targets)
{
	currentUser = _user;
	currentAction = _action;
	currentTargets = _targets;
	battleText = string_ext(_action.description, [_user.name]);
	if (!is_array(currentTargets)) currentTargets = [currentTargets];
	battleWaitTimeRemaining = battleWaitTimeFrames;
	
	with(_user)
	{
		acting = true;
		//play user animation if it is defined for that action, and that user
		if (!is_undefined(_action[$ "userAnimation"])) && (!is_undefined(_user.sprites[$ _action.userAnimation]))
		{
			sprite_index = sprites[$ _action.userAnimation];
			image_index = 0;
		}
	}
	
	battleState = BattleStatePerformAction;
}

function BattleWaitQuestion()
{
	if (!instance_exists(oQuestion) && !instance_exists(oTimeLine))
	{
		var _user = currentUser;
		var _action = currentAction;
		
		battleText = string_ext(_action.description, [_user.name]);
		if (!is_array(currentTargets)) currentTargets = [currentTargets];
		battleWaitTimeRemaining = battleWaitTimeFrames;
		
		with(_user)
		{
			acting = true;
			//play user animation if it is defined for that action, and that user
			if (!is_undefined(_action[$ "userAnimation"])) && (!is_undefined(_user.sprites[$ _action.userAnimation]))
			{
				sprite_index = sprites[$ _action.userAnimation];
				image_index = 0;
			}
		}
	
		battleState = BattleStatePerformAction;
	}
}

function BattleStatePerformAction()
{
	//if animation etc is still playing
	if (currentUser.acting)
	{
		//when it ends, perform action effect if it exists
		if (currentUser.image_index >= currentUser.image_number - 1)
		{
			with (currentUser)
			{
				sprite_index = sprites.idle;
				image_index = 0;
				acting = false;
			}
				
			var targetGroup;
			var isEnemyDefault = currentAction.targetEnemyByDefault;

			if (currentUser.isParty) targetGroup = isEnemyDefault ? enemyUnits : partyUnits;
			else targetGroup = isEnemyDefault ? partyUnits : enemyUnits;
			
			if (!currentAction.targetRequired)
			{
				var aliveTargets = [];
				for (var i = 0; i < array_length(targetGroup); i++)
				{
					if (targetGroup[i].hp > 0) array_push(aliveTargets, targetGroup[i]);
				}
				
				if (currentAction.targetAll == MODE.ALWAYS) currentTargets = aliveTargets;
				else if (currentAction.targetAll == MODE.NEVER)
				{
					var _rand = irandom(array_length(aliveTargets) - 1);
					currentTargets = [aliveTargets[_rand]];
				}
			}
			
			if(variable_struct_exists(currentAction, "effectSprite"))
			{
				if ((currentAction.effectOnTarget == MODE.ALWAYS) || 
				   ((currentAction.effectOnTarget == MODE.VARIES) && (array_length(currentTargets) <= 1)))
				{
					for (var i = 0; i < array_length(currentTargets); i++)
					{
						instance_create_depth(currentTargets[i].x, currentTargets[i].y,
						currentTargets[i].depth - 1, oBattleEffect, {sprite_index: currentAction.effectSprite, _sound: currentAction.effectSound });
					}
				}
				else //play it at 0,0
				{
					var _effectSprite = currentAction.effectSprite;
					if (variable_struct_exists(currentAction, "effectSpriteNoTarget")) _effectSprite = currentAction.effectSpriteNoTarget;
					instance_create_depth(x, y, depth - 100, oBattleEffect, {sprite_index: _effectSprite, _sound: currentAction.effectSound });
				}
			}
			
			if (!qSuccess) currentAction.func(currentUser, currentTargets);
			else
			{
				var _rand = irandom(1);
				if (_rand == 1)
				{
					currentAction.funcPlus(currentUser, currentTargets);
					instance_create_depth(
						camera_get_view_x(view_camera[0]) + 160,
						camera_get_view_y(view_camera[0]) + 90,
						-999999,
						oBattleFloatingText,
						{font: fnM5x7, col: c_fuchsia, text: currentAction.messagePlus}
					);
					audio_play_sound(currentAction.soundPlus, 0, false);
				}
				else
				{
					currentAction.func(currentUser, currentTargets);
					instance_create_depth(
						camera_get_view_x(view_camera[0]) + 160,
						camera_get_view_y(view_camera[0]) + 90,
						-999999,
						oBattleFloatingText,
						{font: fnM5x7, col: c_yellow, text: "+500g!"}
					);
					global.player.gold += 500;
					audio_play_sound(eCoin, 0, false);
				}
				qSuccess = false;
			}
		}
	}
	else //wait for delay and then end the turn
	{
		if(!instance_exists(oBattleEffect))
		{
			battleWaitTimeRemaining--;
			if(battleWaitTimeRemaining == 0)
			{
				battleState = BattleStateVictoryCheck;
			}
		}
	}
}

function BattleStateVictoryCheck()
{
	var _enemyWon = true;
	var _partyWon = true;
	
	for(var i = 0; i < array_length(enemyUnits); i++)
	{
		if(enemyUnits[i].hp > 0) 
		{
			battleState = BattleStateTurnProgression;
			_partyWon = false;
		}
	}
	
	for(var i = 0; i < array_length(partyUnits); i++)
	{
		if(partyUnits[i].hp > 0) 
		{
			battleState = BattleStateTurnProgression;
			_enemyWon = false;
		}
	}
	
	if(_partyWon) 
	{
		
		instance_activate_all();
		
		if (instance_exists(oMusic))
		{
			with (oMusic)
			{
				audio_stop_sound(current_sound_aux);
				audio_resume_sound(current_sound);
			}
		}
		
		instance_destroy();
		
		if (treeY == 7) 
		{
			global.time_end = current_time/1000;
			global.go.win = true;
			room_goto(rCutEnd);
		}
		else
		{
			instance_create_depth(
				camera_get_view_x(view_camera[0]),
				camera_get_view_y(view_camera[0]),
				-9999,
				oReward,
				{
					shop: false,
					isBoss: isBoss
				}
			);
		
			for(var i = 0; i < array_length(global.nodes); i++)
			{
				var curNode = global.nodes[i];
			
				if(curNode.treeX == treeX && curNode.treeY == treeY)
				{
					curNode.object.aval = global.tree.activeNode;
				} else if(abs(curNode.treeX - treeX) == 1 && curNode.treeY == treeY + 1)
				{
					curNode.object.aval = global.tree.freeNode;
				} else if (curNode.object.aval.nodeId != 1)
				{
					curNode.object.aval = global.tree.blockedNode;
				}
			}
		}
	}
	else if (_enemyWon)
	{
		global.time_end = current_time/1000;
		instance_activate_all();
		if (instance_exists(oMusic))
		{
			with (oMusic)
			{
				audio_stop_sound(current_sound_aux);
				audio_resume_sound(current_sound);
			}
		}
		room_goto(rGameOver);
	}
}

function BattleStateTurnProgression()
{
	battleText = ""; //reset battle text
	
	turnCount++;
	turn++;
	
	//Loop turns
	if (turn > array_length(unitTurnOrder) - 1)
	{
		turn = 0;
		roundCount++;
	}
	battleState = BattleStateSelectAction;
}

battleState = BattleStateSelectAction;