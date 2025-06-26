// Inherit the parent event
event_inherited();

var _numI = array_length(global.questions.i) - 1;
var _index = irandom(_numI);
var _image = global.questions.i[_index];

array_push(global.go.questions, 
{
	q: _image,
	c: false,
	t: "I",
});

success = false;
width = 320;
height = 180;

time = 1800;

//MAX: 100
textQ = _image.q;

var _rand = [];
array_copy(_rand, 0, _image.f, 0, array_length( _image.f));
_rand = array_shuffle(_rand)

//MAX: 50
_answers = []
for (var i = 0; i < 3; i++) 
{
    array_push(_answers, _rand[i]);
}

array_push(_answers, _image.a);
_answers = array_shuffle(_answers);

var _dir = ["U", "L", "R", "D"]

for (var i = 0; i < 4; i++) 
{
	if (_answers[i] == _image.a) 
	{
		correct = _dir[i];
		break;
	}
}

_sprite = noone;
switch (_image.i) 
{
	case 1 : _sprite = iCristopherColumbus; break;
	case 2 : _sprite = iSIRG; break;
	case 3 : _sprite = iCarolingio; break;
	default: _sprite = iCristopherColumbus; break;
}

answered = false;

pageToggle = false;

close = 180;