// Inherit the parent event
event_inherited();

success = false;

var _numQ = array_length(global.questions.q) - 1;
var _index = irandom(_numQ);
var _question = global.questions.q[_index];

array_push(global.go.questions, 
{
	q: _question,
	c: false,
	t: "Q",
});

width = 320;
height = 180;

time = 1800;

//MAX: 100
textQ = _question.q;

var _rand = [];
array_copy(_rand, 0, _question.f, 0, array_length( _question.f));
_rand = array_shuffle(_rand)

//MAX: 50
_answers = []
for (var i = 0; i < 3; i++) 
{
    array_push(_answers, _rand[i]);
}

array_push(_answers, _question.a);
_answers = array_shuffle(_answers);

var _dir = ["U", "L", "R", "D"]

for (var i = 0; i < 4; i++) 
{
	if (_answers[i] == _question.a) 
	{
		correct = _dir[i];
		break;
	}
}

answered = false;

close = 180;