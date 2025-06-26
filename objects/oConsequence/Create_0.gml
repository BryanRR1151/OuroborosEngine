// Inherit the parent event
event_inherited();

var _numC = array_length(global.questions.c) - 1;
var _index = irandom(_numC);
var _consequence = global.questions.c[_index];

success = false;
width = 320;
height = 180;

time = 3600;

//MAX: 50
textE = _consequence.q;

var _fakes = [];
var _truths = [];

for (var i = 0; i < array_length(_consequence.f); i++) {
    array_push(_fakes, {
        v:  _consequence.f[i],
        t: "F"
    });
}

for (var i = 0; i < array_length(_consequence.t); i++) {
    array_push(_truths, {
        v: _consequence.t[i],
        t: "V"
    });
}

var _full = array_concat(_fakes, _truths);
_full = array_shuffle(_full);

_options = [];
_textCorrect = "";

//MAX: 130 caracteres y 4 opciones
for (var i = 0; i < 4; i++)
{
	array_push(_options, _full[i])
	_textCorrect += _options[i].t;
}

array_push(global.go.questions, 
{
	q: _consequence,
	c: false,
	t: "C",
	o: _options
});

_answers = [_textCorrect]

while (array_length(_answers) < 4) {
    var new_str = "";
    for (var i = 0; i < 4; i++) {
        new_str += choose("V", "F");
    }

    // Verificar si ya existe
    var exists = false;
    for (var j = 0; j < array_length(_answers); j++) {
        if (_answers[j] == new_str) {
            exists = true;
            break;
        }
    }

    if (!exists) {
        array_push(_answers, new_str);
    }
}

_answers = array_shuffle(_answers);

var _dir = ["U", "L", "R", "D"]

for (var i = 0; i < 4; i++) 
{
	if (_answers[i] == _textCorrect) 
	{
		correct = _dir[i];
		break;
	}
}

answered = false;

pageToggle = false;

close = 180;