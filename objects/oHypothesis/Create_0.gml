// Inherit the parent event
event_inherited();

var _numH = array_length(global.questions.h) - 1;
var _index = irandom(_numH);
var _hypothesis = global.questions.h[_index];

array_push(global.go.questions, 
{
	q: _hypothesis,
	c: false,
	t: "H",
});

success = false;
width = 320;
height = 180;

time = 3600;

//MAX: 300
textL = _hypothesis.q;
textL = WrapText(textL, 10, 65);

var _rand = [];
array_copy(_rand, 0, _hypothesis.f, 0, array_length( _hypothesis.f));
_rand = array_shuffle(_rand);

//MAX: 50
_answers = [];
for (var i = 0; i < 3; i++) 
{
    array_push(_answers, _rand[i]);
}

array_push(_answers, _hypothesis.a);
_answers = array_shuffle(_answers);

var _dir = ["U", "L", "R", "D"];

for (var i = 0; i < 4; i++) 
{
	if (_answers[i] == _hypothesis.a) 
	{
		correct = _dir[i];
		break;
	}
}

answered = false;

pageToggle = false;

close = 180;