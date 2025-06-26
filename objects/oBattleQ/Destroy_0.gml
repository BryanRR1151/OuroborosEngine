var _success = success;

var _count = array_length(global.go.questions) - 1;
global.go.questions[_count].c = _success;

if (_success) global.go.correct++;

with(oBattle) qSuccess = _success;