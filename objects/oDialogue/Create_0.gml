width = 320;
height = 180;

var _numD = array_length(global.dialogues) - 1;
var _index = irandom(_numD);
_dialogue = global.dialogues[_index];

//MAX: 500
var _lines = string_split(_dialogue.d, "*");
d = "";
for (var i = 0; i < array_length(_lines); i++)
{
	d += WrapText(_lines[i], 10, 65) + "\n";
}

_sprite = [];
switch (_dialogue.s)
{
	case 1: _sprite = sOtonIdle; break;
	case 2: _sprite = sCarloIdle; break;
	case 3: _sprite = sEnriqueIdle; break;
	case 4: _sprite = sNapoleonIdle; break;
}

var _q = irandom(3);

qObject = noone;

switch (_q)
{
	case 0: qObject = oConsequence	; break;
	case 1: qObject = oDifference	; break;
	case 2: qObject = oHypothesis	; break;
	case 3: qObject = oImage		; break;
}