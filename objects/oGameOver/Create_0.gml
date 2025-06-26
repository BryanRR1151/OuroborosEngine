if (instance_exists(oMusic))
{
	with (oMusic)
	{
		audio_stop_sound(current_sound);
		current_sound = audio_play_sound(mTitle, 0, true);
	}
}

width = 320;
height = 180;

resultsPage = true;
qPage = 1;
qToggle = false;
qTime = global.time_end - global.time_start;
qGold = global.player.gold;
qTotal = array_length(global.go.questions);
qCorrect = 0;
qSapphire = "";
qGrade = 0;
mGrade = "";

if (global.go.win) qSapphire = "RECUPERADO";
else 
{
	qSapphire = "PERDIDO...";
	qGrade -= 100000;
}

for (var i = 0; i < qTotal; i++)
{
	if (global.go.questions[i].c) qCorrect++;
}

if (qTime <= 10 * 60) qGrade += 1500;
else if (qTime <= 15 * 60) qGrade += 1000;
else if (qTime <= 20 * 60) qGrade += 500;

if (qGold >= 5000) qGrade += 1500;
else if (qTime >= 2500) qGrade += 1000;
else if (qTime >= 1000) qGrade += 500;

var _qPercentage = qCorrect/qTotal;

if (_qPercentage == 1) qGrade += 3500;
else if (_qPercentage >= 0.7) qGrade += 2000;
else if (_qPercentage >= 0.5) qGrade += 500;

if (qGrade >= 4000) mGrade = "A";
else if (qGrade >= 2000) mGrade = "B";
else if (qGrade >= 0) mGrade = "C";
else mGrade = "D";

function drawConsequence(_question)
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_font(fnM3x6);
	if(_question.c) draw_set_color(c_lime);
	else draw_set_color(c_red);
	draw_text(width/2, y + 5, WrapText("Verdadero o Falso", 2, 65));
	
	draw_set_color(c_white);
	draw_text(width/2, y + 15, WrapText(_question.q.q, 2, 65));
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	var _options = _question.o;
	
	for(var i = 0; i < 4; i++)
	{
		draw_text(x + 20, y + 45 + i*30, WrapText(string("{0}. " + _options[i].v + " - {1}", i+1, _options[i].t), 2, 65));
	}
}

function drawDifference(_question)
{
	var textE0 = "Relaciona Causas y Consecuencias";
	var textE1 = _question.q.e1;
	var textE2 = _question.q.e2;
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_font(fnM3x6);
	
	if(_question.c) draw_set_color(c_lime);
	else draw_set_color(c_red);
	draw_text(width/2, y + 5, WrapText(textE0, 2, 65));
	
	draw_set_color(c_white);
	draw_text(width/2, y + 15, WrapText(textE1, 2, 65));
	
	var i = 0;
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	for(i = 0; i < array_length(_question.a1); i++)
	{
		draw_text(x + 20, y + 40 + i*30, WrapText(string("{0}. " + _question.a1[i].v, i+1), 2, 65));
	}
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_text(width/2, y + 25 + i*30, WrapText(textE2, 2, 65));
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	for(var j = 0; j < array_length(_question.a2); j++)
	{
		draw_text(x + 20, y + 50 + i*30, WrapText(string("{0}. " +  _question.a2[j].v, i+1), 2, 65));
		i++;
	}
}

function drawHypothesis(_question)
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_font(fnM3x6);
	
	if(_question.c) draw_set_color(c_lime);
	else draw_set_color(c_red);
	draw_text(width/2, y + 10, WrapText("Complete el siguiente texto...", 2, 65));
	
	draw_set_color(c_white);
	draw_set_valign(fa_middle);
	var _textL = _question.q.q;
	_textL = WrapText(_textL, 10, 65);
	draw_text(width/2, height/2, _textL);
	
	var _textA = _question.q.a;
	_textA = WrapText(_textA, 2, 65);
	draw_text(width/2, y + 140, _textA);
}

function drawImage(_question)
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fnM3x6);
	draw_text(x + 290, y + 145, "Mover");
	draw_sprite(sUp, 0, x + 290 - 8, y + 160);
	draw_sprite(sDown, 0, x + 290 + 8, y + 160);
	
	if(!qToggle)
	{
		var _sprite = noone;
	
		switch (_question.q.i)
		{
			case 1 : _sprite = iCristopherColumbus; break;
			case 2 : _sprite = iSIRG; break;
			case 3 : _sprite = iCarolingio; break;
			default: _sprite = iCristopherColumbus; break;
		}
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_set_font(fnM3x6);
		
		if(_question.c) draw_set_color(c_lime);
		else draw_set_color(c_red);
		draw_text(width/2, y + 5, WrapText("Segun esta imagen...", 2, 50));
	
		draw_set_valign(fa_middle);
		draw_sprite(_sprite, -1, width/2, height/2 + 5);
	}
	else
	{
		var _textQ = _question.q.q;
		var _textA = _question.q.a;
		
		draw_set_color(c_white);
		draw_set_valign(fa_top);
		draw_set_halign(fa_center);
		draw_set_font(fnM3x6);
		draw_text(width/2, y + 15, WrapText(_textQ, 2, 65));
		
		draw_set_valign(fa_middle);
		draw_text(width/2, height/2, WrapText(_textA, 2, 65));
	}
}

function drawQuestion(_question)
{
	var _textQ = _question.q.q;
	var _textA = _question.q.a;
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_font(fnM3x6);
	
	if(_question.c) draw_set_color(c_lime);
	else draw_set_color(c_red);
	draw_text(width/2, y + 15, WrapText(_textQ, 2, 65));
	
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	draw_text(width/2, height/2, WrapText(_textA, 2, 65));
}

function drawTimeline(_question)
{
	var _textQ = "Cual es el orden correcto?";
	
	draw_set_valign(fa_top);
	draw_set_halign(fa_center);
	draw_set_font(fnM3x6);

	if(_question.c) draw_set_color(c_lime);
	else draw_set_color(c_red);
	draw_text(width/2, y + 15, WrapText(_textQ, 2, 65));
	
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	for(var i = 0; i < 4; i++)
	{
		draw_text(x + 20, y + 45 + i*30, WrapText(string("{0}. " + _question.o[i].event, i+1), 2, 65));
	}
	
}

global.general.gold += ceil(global.player.gold/100);

for (var i = 0; i < array_length(global.general.achievements); i++)
{
	if (!global.general.achievements[i].completed)
	{
		global.general.achievements[i].completed = global.general.achievements[i].check();
	}
}

for (var i = 0; i < array_length(global.general.characters); i++)
{
	if (!global.general.characters[i].unlocked)
	{
		global.general.characters[i].unlocked = global.general.characters[i].check();
	}
}

SaveGeneral();