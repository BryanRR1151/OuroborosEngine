//Action Library
global.actionLibrary=
{
	attack:
	{
		name: "Atacar",
		description: "{0} ataca!",
		subMenu: -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation: "attack",
		effectSprite: sAttackBonk,
		effectSound: eNormalAttack,
		effectOnTarget: MODE.ALWAYS,
		avail: function ()
		{
			return true;
		},
		func: function(_user, _targets)
		{
			var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
			
			BattleChangeHP(_targets[0], -_damage, 0);
		},
		messagePlus: "x2 ATK",
		soundPlus: ePlus,
		funcPlus: function(_user, _targets)
		{
			var _damage = ceil(_user.strength * 2 + random_range(-_user.strength * 0.25, _user.strength * 0.25));
			
			BattleChangeHP(_targets[0], -_damage, 0);
		}
	},
	heal:
	{
		name: "Curar",
		description: "{0} cura a su equipo!",
		subMenu: "Especiales",
		targetRequired: false,
		targetEnemyByDefault: false,
		targetAll: MODE.ALWAYS,
		userAnimation: "heal",
		effectSprite: sAttackHeal,
		effectSound: eHeal,
		effectOnTarget: MODE.ALWAYS,
		avail: function (_user)
		{
			return _user.mp >= 5;
		},
		func: function(_user, _targets)
		{
			var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
			
			for (var i = 0; i < array_length(_targets); i++)
			{
				BattleChangeHP(_targets[i], _damage, 0);
			}
			BattleChangeMP(_user, -5);
		},
		messagePlus: "x2 CURACION",
		soundPlus: ePlus,
		funcPlus: function(_user, _targets)
		{
			var _damage = ceil(_user.strength * 2 + random_range(-_user.strength * 0.25, _user.strength * 0.25));
			
			for (var i = 0; i < array_length(_targets); i++)
			{
				BattleChangeHP(_targets[i], _damage, 0);
			}
			BattleChangeMP(_user, -5);
		}
	},
	rage:
	{
		name: "Furia",
		description: "{0} ataca descuidadamente!",
		subMenu: "Especiales",
		targetRequired: false,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation: "attack",
		effectSprite: sAttackFire,
		effectSound: eNormalAttack,
		effectOnTarget: MODE.ALWAYS,
		avail: function (_user)
		{
			return _user.mp >= 5;
		},
		func: function(_user, _targets)
		{
			var _damage = ceil(_user.strength * 2 + random_range(-_user.strength * 0.25, _user.strength * 0.25));
			
			BattleChangeHP(_targets[0], -_damage, 0);
			BattleChangeHP(_user, ceil(-_user.strength/4), 0);
			BattleChangeMP(_user, -5);
		},
		messagePlus: "x2 ATK",
		soundPlus: ePlus,
		funcPlus: function(_user, _targets)
		{
			var _damage = ceil(_user.strength * 4 + random_range(-_user.strength * 0.25, _user.strength * 0.25));
			
			BattleChangeHP(_targets[0], -_damage, 0);
			BattleChangeHP(_user, -1, 0);
			BattleChangeMP(_user, -5);
		}
	},
	goldTouch:
	{
		name: "Saqueo",
		description: "{0} saquea las piezas de su enemigo!",
		subMenu: "Especiales",
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation: "attack",
		effectSprite: sAttackFire,
		effectSound: eNormalAttack,
		effectOnTarget: MODE.ALWAYS,
		avail: function (_user)
		{
			return _user.mp >= 5;
		},
		func: function(_user, _targets)
		{
			var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
			
			BattleChangeGold(200);
			BattleChangeHP(_targets[0], -_damage, 0);
			BattleChangeMP(_user, -5);
		},
		messagePlus: "+300g",
		soundPlus: ePlus,
		funcPlus: function(_user, _targets)
		{
			var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
			
			BattleChangeGold(500);
			BattleChangeHP(_targets[0], -_damage, 0);
			BattleChangeMP(_user, -5);
		}
	}
}

enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}

function CloseMenu()
{
	with (oMenu) 
	{
		active = false;
		
		for(var i = 0; i < array_length(global.nodes); i++)
		{
			var curNode = global.nodes[i];
			
			if(curNode.treeX == global.treeX && curNode.treeY == global.treeY)
			{
				curNode.object.aval = global.tree.activeNode;
			} else if(abs(curNode.treeX - global.treeX) == 1 && curNode.treeY == global.treeY + 1)
			{
				curNode.object.aval = global.tree.freeNode;
			} else if (curNode.object.aval.nodeId != 1)
			{
				curNode.object.aval =  global.tree.blockedNode;
			}
		}
		
		instance_destroy();
	}
}

function BuyItem(_price, _func, _fnArg)
{
	if(global.player.gold >= _price)
	{
		global.player.gold -= _price;
		_func(_fnArg);
		CloseMenu();
	}
}

function atkChg(_value)
{
	for(var i = 0; i < array_length(global.party); i++)
	{
		global.party[i].strength += _value;
	}
}

function hpChg(_value)
{
	for(var i = 0; i < array_length(global.party); i++)
	{
		global.party[i].hp += _value;
		global.party[i].hpMax += _value;
	}
}

function mpChg(_value)
{
	for(var i = 0; i < array_length(global.party); i++)
	{
		global.party[i].mp += _value;
		global.party[i].mpMax += _value;
	}
}

global.player =
{
	gold: 500
}

function FormatPixelAlignedLine(_name, _price, _target_width) {
    draw_set_font(fnM5x7);
	var _left = string(_name);
    var _right = string(_price);

    var _left_width = string_width(_left);
    var _right_width = string_width(_right);
    var _dot_width = string_width(".");

    var _dots_needed = floor((_target_width - _left_width - _right_width) / _dot_width);
    var _dots = string_repeat(".", _dots_needed);

    // If the spacing is still off by a few pixels (because of rounding), trim a dot or two
    var _final = _left + _dots + _right;
    while (string_width(_final) > _target_width && string_length(_dots) > 0) {
        _dots = string_delete(_dots, string_length(_dots), 1);
        _final = _left + _dots + _right;
    }

    return _final;
}

global.item = 
{
	rewardItems: ["braveAmulet", "solidShield", "solidShieldEX", "goldItem", "holyShield", "holyShieldEX",
				  "oldBook", "oldBookEX", "greatSword", "mysticStaff"],
	plusItems: ["braveAmuletEX", "solidShieldEX", "goldItemEX", "holyShieldEX", "oldBookEX", "greatSwordEX",
				"mysticStaffEX"],
	shopItems: ["braveAmulet", "braveAmuletEX", "solidShield", "solidShieldEX", "holyShieldEX", "oldBook",
				"oldBookEX", "greatSword", "greatSwordEX", "mysticStaff", "mysticStaffEX"],
	braveAmulet: { spriteR: sAmulet, nameR: "Amuleto Valiente", descR: "+ATK, +HP",
		name: FormatPixelAlignedLine("Amuleto Valiente (+ATK, +HP)", "500", 285), 
		func: BuyItem, 
		args: [500, function(_value)
		{
			atkChg(_value);
			hpChg(_value+2);
		}, 4],
		avail: function ()
		{
			return global.player.gold >= 500;
		}
	},
	braveAmuletEX: { spriteR: sAmuletEX, nameR: "Amuleto Valiente EX", descR: "++ATK, ++HP",
		name: FormatPixelAlignedLine("Amuleto Valiente EX (++ATK, ++HP)", "1500", 285), 
		func: BuyItem, 
		args: [1500, function(_value)
		{
			atkChg(_value);
			hpChg(_value+2);
		}, 8],
		avail: function ()
		{
			return global.player.gold >= 1500;
		}
	},
	solidShield: { spriteR: sShield, nameR: "Escudo Solido", descR: "++HP",
		name: FormatPixelAlignedLine("Escudo Solido (++HP)", "250", 285), 
		func: BuyItem, 
		args: [250, function(_value)
		{
			hpChg(_value);
		}, 15],
		avail: function ()
		{
			return global.player.gold >= 250;
		}
	},
	solidShieldEX: { spriteR: sShieldEX, nameR: "Escudo Solido EX", descR: "+++HP, +ATK",
		name: FormatPixelAlignedLine("Escudo Solido EX (+++HP, +ATK)", "1000", 285), 
		func: BuyItem, 
		args: [1000, function(_value)
		{
			hpChg(_value);
			atkChg(4);
		}, 30],
		avail: function ()
		{
			return global.player.gold >= 1000;
		}
	},
	goldItem: { spriteR: sGold, nameR: "Oro", descR: "+750g",
		name: FormatPixelAlignedLine("Oro (+750g)", "749", 285), 
		func: BuyItem, 
		args: [749, function(_value)
		{
			global.player.gold += _value;
		}, 749],
		avail: function ()
		{
			return global.player.gold >= 749;
		}
	},
	goldItemEX: { spriteR: sGoldEX, nameR: "Oro... EX?", descR: "+2000g",
		name: FormatPixelAlignedLine("Oro... EX? (+2000g)", "1999", 285), 
		func: BuyItem, 
		args: [1999, function(_value)
		{
			global.player.gold += _value;
		}, 1999],
		avail: function ()
		{
			return global.player.gold >= 1999;
		}
	},
	holyShield: { spriteR: sHolyShield, nameR: "Escudo Santo", descR: "++HP, +ENRG",
		name: FormatPixelAlignedLine("Escudo Santo (++HP, +ENRG)", "500", 285), 
		func: BuyItem, 
		args: [500, function(_value)
		{
			hpChg(_value);
			mpChg(5);
		}, 15],
		avail: function ()
		{
			return global.player.gold >= 500;
		}
	},
	holyShieldEX: { spriteR: sHolyShieldEX, nameR: "Escudo Santo EX", descR: "+++HP, ++ENRG",
		name: FormatPixelAlignedLine("Escudo Santo EX (+++HP, ++ENRG)", "750", 285), 
		func: BuyItem, 
		args: [750, function(_value)
		{
			hpChg(_value);
			mpChg(10);
		}, 30],
		avail: function ()
		{
			return global.player.gold >= 750;
		}
	},
	oldBook: { spriteR: sBook, nameR: "Libro Viejo", descR: "++ENRG",
		name: FormatPixelAlignedLine("Libro Viejo (++ENRG)", "250", 285), 
		func: BuyItem, 
		args: [250, function(_value)
		{
			mpChg(_value);
		}, 10],
		avail: function ()
		{
			return global.player.gold >= 250;
		}
	},
	oldBookEX: { spriteR: sBookEX, nameR: "Libro Viejo EX", descR: "++++ENRG, +ATK",
		name: FormatPixelAlignedLine("Libro Viejo EX (++++ENRG, +ATK)", "750", 285), 
		func: BuyItem, 
		args: [750, function(_value)
		{
			mpChg(_value);
			atkChg(4);
		}, 30],
		avail: function ()
		{
			return global.player.gold >= 750;
		}
	},
	greatSword: { spriteR: sSword, nameR: "Espada Grande", descR: "++ATK",
		name: FormatPixelAlignedLine("Espada Grande (++ATK)", "500", 285), 
		func: BuyItem, 
		args: [500, function(_value)
		{
			atkChg(_value);
		}, 8],
		avail: function ()
		{
			return global.player.gold >= 500;
		}
	},
	greatSwordEX: { spriteR: sSwordEX, nameR: "Espada Grande EX", descR: "++++ATK, ++HP",
		name: FormatPixelAlignedLine("Espada Grande EX (++++ATK, ++HP)", "2000", 285), 
		func: BuyItem, 
		args: [2000, function(_value)
		{
			atkChg(_value);
			hpChg(10);
		}, 16],
		avail: function ()
		{
			return global.player.gold >= 2000;
		}
	},
	mysticStaff: { spriteR: sStaff, nameR: "Cetro Mistico", descR: "+ATK, ++ENRG",
		name: FormatPixelAlignedLine("Cetro Mistico (+ATK, ++ENRG)", "500", 285), 
		func: BuyItem, 
		args: [500, function(_value)
		{
			atkChg(_value);
			mpChg(10);
		}, 4],
		avail: function ()
		{
			return global.player.gold >= 500;
		}
	},
	mysticStaffEX: { spriteR: sStaffEX, nameR: "Cetro Mistico EX", descR: "+++ATK, +++ENRG",
		name: FormatPixelAlignedLine("Cetro Mistico EX (+++ATK, +++ENRG)", "1500", 285), 
		func: BuyItem, 
		args: [1500, function(_value)
		{
			atkChg(_value);
			mpChg(15);
		}, 12],
		avail: function ()
		{
			return global.player.gold >= 1500;
		}
	},
}

var _randomKeys = [];
for (var i = 0; i < 3; i++) array_push(_randomKeys, "normalNode");
for (var i = 0; i < 4; i++) array_push(_randomKeys, "shopNode");
for (var i = 0; i < 3; i++) array_push(_randomKeys, "bossNode");
_randomKeys = array_shuffle(_randomKeys);

global.tree =
{
	activeNode	: { sprite: sActive, click: false, nodeId: 1 },
	blockedNode	: { sprite: sBlocked, click: false, nodeId: 2 },
	freeNode	: { sprite: sFree, click: true, nodeId: 3 },
	normalNode	: { sprite: sNormal, fn: function(_caller, _treeX, _treeY)
		{
			var i = irandom(1);
			var _last = noone;
			switch (i) 
			{
				case 0: _last = global.enemies.soldier; break;
				case 1: _last = global.enemies.healer; break;
			}
			
			NewEncounter([global.enemies.soldier, _last, global.enemies.soldier], sBgField, _caller, _treeX, _treeY, mNormalBattle);
		}
	},
	bossNode	: { sprite: sBoss , fn: function(_caller, _treeX, _treeY)
		{
			NewEncounter([global.enemies.tank, global.enemies.tank, global.enemies.healer], sBgField, _caller, _treeX, _treeY, mChallengeBattle, true);
		}
	},
	finalBossNode	: { sprite: sBoss , fn: function(_caller, _treeX, _treeY)
		{
			global.final = 
			{
				caller: _caller,
				treeX: _treeX,
				treeY: _treeY
			}
			room_goto(rCutMid);
		}
	},
	shopNode	: {	sprite: sShop, fn: function(_caller, _treeX, _treeY)
		{
			
			var _menuOptions = [];
			var _items = [];
			array_copy(_items, 0, global.item.shopItems, 0, array_length(global.item.shopItems));
			_items = array_shuffle(_items);
			var iNumber = array_length(_items);
			
			for (var i = 0; i < min(5, iNumber); i++)
			{
				var _obj = global.item[$ _items[i]];
				
				array_push(_menuOptions, { name: _obj.name,
					func: _obj.func, args: _obj.args,
					avail: _obj.avail() });
			}
			array_push(_menuOptions, { name: "Regresar", func: CloseMenu, args: -1, avail: true });
			
			var _x = camera_get_view_x(view_camera[0]);
			var _y = camera_get_view_y(view_camera[0]);

			global.treeX = _treeX;
			global.treeY = _treeY;
			
			instance_create_depth(
				_x,
				_y,
				-9999,
				oDialogue,
				{
					_x: _x,
					_y: _y,
					_menuOptions: _menuOptions
				}
			);

		}
	},
	randomKeys: _randomKeys
}

//Party data
global.playableCharacters = 
[
	{
		name: "Oton I",
		isParty: true,
		hp: 30,
		hpMax: 30,
		mp: 15,
		mpMax: 15,
		strength: 6,
		sprites : { idle: sOtonIdle, attack: sOtonAttack, down: sOtonDown },
		actions : [global.actionLibrary.attack, global.actionLibrary.goldTouch],
		flavorText: "Oton el Grande. Estadisticas promedio."
	},
	{
		name: "Carlomagno",
		isParty: true,
		hp: 15,
		hpMax: 15,
		mp: 5,
		mpMax: 5,
		strength: 10,
		sprites : { idle: sCarloIdle, attack: sCarloAttack, down: sCarloDown },
		actions : [global.actionLibrary.attack, global.actionLibrary.rage],
		flavorText: "Carlos el Grande. Buen ataque pero baja vitalidad."
	},
	{
		name: "Enrique II",
		isParty: true,
		hp: 20,
		hpMax: 20,
		mp: 10,
		mpMax: 10,
		strength: 4,
		sprites : { idle: sEnriqueIdle, attack: sEnriqueAttack, heal: sEnriqueHeal, down: sEnriqueDown},
		actions : [global.actionLibrary.attack, global.actionLibrary.heal],
		flavorText: "Enrique el Santo. Puede curar a sus aliados."
	},
	{
		name: "Napoleon",
		isParty: true,
		hp: 30,
		hpMax: 30,
		mp: 30,
		mpMax: 30,
		strength: 10,
		sprites : { idle: sNapoleonIdle, attack: sNapoleonAttack, down: sNapoleonDown},
		actions : [global.actionLibrary.attack],
		flavorText: "Napoleon Bonaparte. Buenas estadisticas."
	},
]

//Enemy Data
global.enemies =
{
	soldier: 
	{
		name: "Soldado",
		isParty: false,
		hp: 20,
		hpMax: 20,
		mp: 0,
		mpMax: 0,
		strength: 5,
		sprites: { idle: sGenRobotIdle, attack: sGenRobotAttack},
		actions: [global.actionLibrary.attack],
		xpValue : 18,
		AIScript : function()
		{
			//Attack random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			
			var _target = _possibleTargets[irandom(array_length(_possibleTargets) - 1)]
			
			return [_action, _target];
		}
	},
	tank: 
	{
		name: "Tanque",
		isParty: false,
		hp: 30,
		hpMax: 30,
		mp: 0,
		mpMax: 0,
		strength: 10,
		sprites: { idle: sJuggernautIdle, attack: sJuggernautAttack},
		actions: [global.actionLibrary.attack],
		xpValue : 18,
		AIScript : function()
		{
			//Attack random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			
			var _target = _possibleTargets[irandom(array_length(_possibleTargets) - 1)]
			
			return [_action, _target];
		}
	},
	healer: 
	{
		name: "Reparador",
		isParty: false,
		hp: 10,
		hpMax: 10,
		mp: 0,
		mpMax: 0,
		strength: 10,
		sprites: { idle: sHealerIdle, attack: sHealerAttack, heal: sHealerAttack},
		actions: [global.actionLibrary.attack, global.actionLibrary.heal],
		xpValue : 18,
		AIScript : function()
		{
			//Attack random party member
			var _action = actions[1];
			//var _possibleTargets = array_filter(oBattle.enemyUnits, function(_unit, _index)
			//{
			//	return (_unit.hp > 0);
			//});
			
			//var _target = _possibleTargets[irandom(array_length(_possibleTargets) - 1)]
			
			return [_action, []];
		}
	},
	commander: 
	{
		name: "Coman.GPT",
		isParty: false,
		hp: 50,
		hpMax: 50,
		mp: 0,
		mpMax: 0,
		strength: 20,
		sprites: { idle: sFinalBossIdle, attack: sFinalBossAttack},
		actions: [global.actionLibrary.attack],
		xpValue : 18,
		AIScript : function()
		{
			//Attack random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			
			var _target = _possibleTargets[irandom(array_length(_possibleTargets) - 1)]
			
			return [_action, _target];
		}
	}
}





