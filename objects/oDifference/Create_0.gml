// Inherit the parent event
event_inherited();

var _numD = array_length(global.questions.d) - 1;
var _index = irandom(_numD);
var _difference = global.questions.d[_index];

success = false;
width = 320;
height = 180;

time = 3600;

//MAX: 70
textE0 = "Relaciona Causas y Consecuencias";
textE1 = _difference.e1;
textE2 = _difference.e2;

var _c1 = [];
var _c2 = [];

for (var i = 0; i < array_length(_difference.c1); i++)
{
	array_push(_c1, {
		c: 1,
		v: _difference.c1[i]
	});
}

for (var i = 0; i < array_length(_difference.c2); i++)
{
	array_push(_c2, {
		c: 2,
		v: _difference.c2[i]
	});
}

var _full = array_concat(_c1, _c2);
_full = array_shuffle(_full);

C1 = "";
C2 = "";

//MAX: 130 caracteres y 4 opciones
_options = [];
for (var i = 0; i < 4; i++)
{
	array_push(_options, _full[i]);
	
	if (_full[i].c == 1) C1 += string(i + 1);
	else C2 += string(i + 1);
}

array_push(global.go.questions, 
{
	q: _difference,
	c: false,
	t: "D",
	a1: _c1,
	a2: _c2
});

answer1 = "";
answer2 = "";

cor1 = false;
cor2 = false;

answered = false;

pageToggle = false;
inputToggle = false;

close = 180;