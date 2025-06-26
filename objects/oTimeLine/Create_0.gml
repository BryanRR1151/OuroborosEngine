// Inherit the parent event
event_inherited();

success = false;

var _numT = array_length(global.questions.t) - 1;
var _index = irandom(_numT);
var _timeline = global.questions.t[_index];

width = 320;
height = 180;

time = 3600;

//MAX: 100
textQ = "Ingrese el orden correcto de los eventos..."

var _rand = [];
array_copy(_rand, 0, _timeline.e, 0, array_length(_timeline.e));
_rand = array_shuffle(_rand)

//MAX: 50
_events = []
for (var i = 0; i < 4; i++) 
{
    array_push(_events, _rand[i]);
}

var _sorted = []
array_copy(_sorted, 0, _events, 0, 4);
array_sort(_sorted, function(a, b) {
    return a.order - b.order;
});

array_push(global.go.questions, 
{
	q: _timeline,
	c: false,
	t: "T",
	o: _sorted
});

// Step 2: Build result string
var result_string = "";

for (var i = 0; i < 4; i++) {
    var target_code = _sorted[i].order;

    // Find position in sorted array
    for (var j = 0; j < 4; j++) {
        if (_events[j].order == target_code) {
            result_string += string(j + 1); // 1-based index
            break;
        }
    }
}

correct = result_string;

answered = false;

close = 180;

answer = "";