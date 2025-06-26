function LoadQuestions() 
{
	if (file_exists("Questions.dat"))
	{
		ini_open("Questions.dat");
		var qNumber = ini_read_real("General", "qNumber", 0);
		var tNumber = ini_read_real("General", "tNumber", 0);
		var iNumber = ini_read_real("General", "iNumber", 0);
		var hNumber = ini_read_real("General", "hNumber", 0);
		var cNumber = ini_read_real("General", "cNumber", 0);
		var dNumber = ini_read_real("General", "dNumber", 0);
		
		global.questions = {};
		global.questions.q = [];
		global.questions.t = [];
		global.questions.i = [];
		global.questions.h = [];
		global.questions.c = [];
		global.questions.d = [];
		
		for (var i = 1; i <= qNumber; i++)
		{
			var _secName = string("Question{0}", i);
			var _obj = ReadSecQH(_secName);
			array_push(global.questions.q, _obj);
		}
		
		for (var i = 1; i <= tNumber; i++)
		{
			var _secName = string("Time{0}", i);
			var _obj = ReadSecT(_secName);
			array_push(global.questions.t, _obj);
		}
		
		for (var i = 1; i <= iNumber; i++)
		{
			var _secName = string("Image{0}", i);
			var _obj = ReadSecI(_secName);
			array_push(global.questions.i, _obj);
		}
		
		for (var i = 1; i <= hNumber; i++)
		{
			var _secName = string("Hypothesis{0}", i);
			var _obj = ReadSecQH(_secName);
			array_push(global.questions.h, _obj);
		}
		
		for (var i = 1; i <= cNumber; i++)
		{
			var _secName = string("Consequence{0}", i);
			var _obj = ReadSecC(_secName);
			array_push(global.questions.c, _obj);
		}
		
		for (var i = 1; i <= dNumber; i++)
		{
			var _secName = string("Difference{0}", i);
			var _obj = ReadSecD(_secName);
			array_push(global.questions.d, _obj);
		}
		
		ini_close();
	}
}
	
function LoadDialogues() 
{
	if (file_exists("Dialogues.dat"))
	{
		ini_open("Dialogues.dat");
		var dNumber = ini_read_real("General", "total", 0);
		var cSNumber = ini_read_real("General", "cSTotal", 0);
		var cMNumber = ini_read_real("General", "cMTotal", 0);
		var cENumber = ini_read_real("General", "cETotal", 0);
		global.dialogues = [];
		global.cutStart = [];
		global.cutMid = [];
		global.cutEnd = [];
		
		for (var i = 1; i <= dNumber; i++)
		{
			var _secName = string("Dialogue{0}", i);
			var _obj = ReadDialogue(_secName);
			array_push(global.dialogues, _obj);
		}
		
		var _secName = "CutStart";
		for (var i = 1; i <= cSNumber; i++)
		{
			var _obj = ini_read_string(_secName, string("d{0}", i), "");
			array_push(global.cutStart, _obj);
		}
		
		_secName = "CutMid";
		for (var i = 1; i <= cMNumber; i++)
		{
			var _obj = ini_read_string(_secName, string("d{0}", i), "");
			array_push(global.cutMid, _obj);
		}
		
		_secName = "CutEnd";
		for (var i = 1; i <= cENumber; i++)
		{
			var _obj = ini_read_string(_secName, string("d{0}", i), "");
			array_push(global.cutEnd, _obj);
		}
		
		ini_close();
	}
}

function ReadSecQH(_secName)
{
	var _numFakes = ini_read_real(_secName, "fakes", 3);
	var _fakes = [];
	var _question = ini_read_string(_secName, "question", "");
	var _answer = ini_read_string(_secName, "answer", "");
	
	for (var i = 1; i <= _numFakes; i++)
	{
		var _keyName = string("fake{0}", i);
		var _fake = ini_read_string(_secName, _keyName, "");
		array_push(_fakes, _fake);
	}
	
	return 
	{
		q: _question,
		a: _answer,
		f: _fakes
	}
}

function ReadSecT(_secName)
{
	var _numEvents = ini_read_real(_secName, "events", 4);
	var _events = [];
	
	for (var i = 1; i <= _numEvents; i++)
	{
		var _keyName = string("event{0}", i);
		var _event = ini_read_string(_secName, _keyName, "");
		var _obj = { order: i, event: _event}
		array_push(_events, _obj);
	}
	
	return 
	{
		e: _events
	}
}

function ReadSecI(_secName)
{
	var _image = ini_read_real(_secName, "image", 0);
	var _numFakes = ini_read_real(_secName, "fakes", 3);
	var _fakes = [];
	var _question = ini_read_string(_secName, "question", "");
	var _answer = ini_read_string(_secName, "answer", "");
	
	for (var i = 1; i <= _numFakes; i++)
	{
		var _keyName = string("fake{0}", i);
		var _fake = ini_read_string(_secName, _keyName, "");
		array_push(_fakes, _fake);
	}
	
	return 
	{
		i: _image,
		q: _question,
		a: _answer,
		f: _fakes
	}
}

function ReadSecC(_secName)
{
	var _numFakes = ini_read_real(_secName, "fakes", 0);
	var _numTruths = ini_read_real(_secName, "truths", 0);
	var _fakes = [];
	var _truths = [];
	var _question = ini_read_string(_secName, "question", "");
	
	for (var i = 1; i <= _numFakes; i++)
	{
		var _keyName = string("f{0}", i);
		var _fake = ini_read_string(_secName, _keyName, "");
		array_push(_fakes, _fake);
	}
	
	for (var i = 1; i <= _numTruths; i++)
	{
		var _keyName = string("t{0}", i);
		var _truth = ini_read_string(_secName, _keyName, "");
		array_push(_truths, _truth);
	}
	
	return 
	{
		q: _question,
		f: _fakes,
		t: _truths
	}
}

function ReadSecD(_secName)
{
	var _num1 = ini_read_real(_secName, "num1", 1);
	var _num2 = ini_read_real(_secName, "num2", 1);
	var _eC1 = [];
	var _eC2 = [];
	var _e1 = ini_read_string(_secName, "e1", "");
	var _e2 = ini_read_string(_secName, "e2", "");
	
	for (var i = 1; i <= _num1; i++)
	{
		var _keyName = string("c1{0}", i);
		var _c1 = ini_read_string(_secName, _keyName, "");
		array_push(_eC1, _c1);
	}
	
	for (var i = 1; i <= _num2; i++)
	{
		var _keyName = string("c2{0}", i);
		var _c2 = ini_read_string(_secName, _keyName, "");
		array_push(_eC2, _c2);
	}
	
	return 
	{
		e1: _e1,
		e2: _e2,
		c1: _eC1,
		c2: _eC2
	}
}

function ReadDialogue(_secName)
{
	var _sprite = ini_read_real(_secName, "sprite", 1);
	var _dialogue = ini_read_string(_secName, "dialogue", "");
	var _name = ini_read_string(_secName, "name", "");
	
	return 
	{
		s: _sprite,
		d: _dialogue,
		n: _name
	}
}