global.general = 
{
	gold: 0,
	achievements: 
	[
		{	code: 1, name: "Perfecto!", description: "Gana una partida sin ninguna respuesta incorrecta.", completed: false, 
			check: function()
			{
				return global.go.win && (array_length(global.go.questions) == global.go.correct);
			}
		},
		{	code: 2, name: "$$$", description: "Gana una partida con 5000g.", completed: false, 
			check: function()
			{
				return global.go.win && (global.player.gold >= 5000);
			}
		},
		{	code: 3, name: "Motor Ouroboros Completo", description: "Gana una partida una vez.", completed: false, 
			check: function()
			{
				return global.go.win;
			}
		}
	],
	characters:
	[
		{	code: 1, selected: true, unlocked: true,
			check: function()
			{
				return true;
			}
		},
		{	code: 2, selected: true, unlocked: true,
			check: function()
			{
				return true;
			}
		},
		{	code: 3, selected: true, unlocked: true,
			check: function()
			{
				return true;
			}
		},
		{	code: 4, selected: false, unlocked: false,
			check: function()
			{
				return global.general.achievements[0].completed;
			}
		}
	]
}


function SaveGeneral()
{
	if (file_exists("General.dat")) file_delete("General.dat");
	ini_open("General.dat");
	
	var _totalA = array_length(global.general.achievements);
	var _totalC = array_length(global.general.characters);
	
	ini_write_real("General", "totalA", _totalA);
	ini_write_real("General", "totalC", _totalC);
	ini_write_real("General", "gold", global.general.gold);
	
	for (var i = 1; i <= _totalA; i++)
	{
		var _cmp = global.general.achievements[i-1].completed ? 1 : 0;
		ini_write_real(string("A{0}", i), "complete", _cmp);
	}
	
	for (var i = 1; i <= _totalC; i++)
	{
		var _cmpU = global.general.characters[i-1].unlocked ? 1 : 0;
		var _cmpS = global.general.characters[i-1].selected ? 1 : 0;
		ini_write_real(string("C{0}", i), "unlocked", _cmpU);
		ini_write_real(string("C{0}", i), "selected", _cmpS);
	}
	ini_close();
}

function LoadGeneral()
{
	if (file_exists("General.dat"))
	{
		ini_open("General.dat");
		var aNumber = ini_read_real("General", "totalA", 0);
		var cNumber = ini_read_real("General", "totalC", 0);
		var _gold = ini_read_real("General", "gold", 0);
		
		global.general.gold = _gold;
		
		for (var i = 1; i <= aNumber; i++)
		{
			var _secName = string("A{0}", i);
			var _cmp = ini_read_real(_secName, "complete", 0);
			global.general.achievements[i-1].completed = (_cmp == 1);
		}
		
		for (var i = 1; i <= cNumber; i++)
		{
			var _secName = string("C{0}", i);
			var _cmpU = ini_read_real(_secName, "unlocked", 0);
			var _cmpS = ini_read_real(_secName, "selected", 0);
			global.general.characters[i-1].unlocked = (_cmpU == 1);
			global.general.characters[i-1].selected = (_cmpS == 1);
		}
		
		ini_close();
	}
}

LoadGeneral();