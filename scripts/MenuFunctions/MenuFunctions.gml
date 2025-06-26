//@desc Menu - makes a menu, options provided in the form [{ name: "", func: foo, args: -1, avail: bool }, [...]]
function Menu(_x, _y, _options, _description = -1, _width = undefined, _height = undefined, _shop = false)
{
	with (instance_create_depth(_x, _y, -999999, oMenu, { shop: _shop }))
	{
		options = _options;
		description = _description;
		var _optionsCount = array_length(_options);
		visibleOptionsMax = _optionsCount;
		
		//Set up size
		xmargin = 10;
		ymargin = 8;
		draw_set_font(fnM5x7);
		heightLine = 12;
		
		//Auto width
		if(_width == undefined)
		{
			width = 1;
			if (description != -1) width = max(width, string_width(_description));
			for (var i = 0; i < _optionsCount; i++)
			{
				width = max(width, string_width(_options[i].name));
			}
			widthFull = width + xmargin * 2;
		}
		else widthFull = _width;
		
		//Auto height
		if (_height == undefined)
		{
			height = heightLine * (_optionsCount + (description != -1));
			heightFull = height + ymargin * 2;
		}
		else
		{
			heightFull = _height;
			//scrolling?
			if ((heightLine * (_optionsCount + (description != -1))) > (_height - ymargin * 2))
			{
				scrolling = true;
				visibleOptionsMax = (_height - ymargin * 2) div heightLine;
			}
		}
	}
}

function SubMenu(_options)
{
	//store old options in array and increase submenu level
	optionsAbove[subMenuLevel] = options;
	subMenuLevel++;
	options = _options;
	hover = 0;
}

function MenuGoBack()
{
	subMenuLevel--;
	options = optionsAbove[subMenuLevel];
	hover = 0;
}

function MenuSelectAction(_user, _action)
{
	with (oMenu) active = false;
	
	//Activate the targetting cursos if needed, or simply begin the action
	with (oBattle)
	{
		if (_action.targetRequired)
		{
			with(cursor)
			{
				active = true;
				activeAction = _action;
				targetAll = _action.targetAll;
				if(targetAll == MODE.VARIES) targetAll = true; //toggle starts as true
				activeUser = _user;
				
				//which side to target by default?
				if (_action.targetEnemyByDefault) //target enemy by default
				{
					targetIndex = 0;
					targetSide = oBattle.enemyUnits;
					activeTarget = oBattle.enemyUnits[targetIndex];
				}
				else //target self by default
				{
					targetSide = oBattle.partyUnits;
					activeTarget = activeUser;
					var _findSelf = function(_element)
					{
						return (_element == activeTarget);
					}
					targetIndex = array_find_index(oBattle.partyUnits, _findSelf);
				}
			}
		}
		else //If no target needed, begin the action and end the menu
		{
			var _rand = irandom(1);
			switch (_rand)
			{
				case 0: BeginAction(_user, _action, -1); break;
				case 1: BeginActionQuestion(_user, _action, -1); break;
			}
			with (oMenu) instance_destroy();
		}
	}
}

function WrapText(_text, _max_lines, _max_chars) 
{
	var words = string_split(_text, " ");
	var result = "";
	var line = "";
	var line_count = 0;
	for (var i = 0; i < array_length(words); i++) {
		var word = words[i];

		// If adding the word exceeds the limit
		if (string_length(line) + string_length(word) + 1 > _max_chars) {
			result += line + "\n";
			line = word;
			line_count++;

			// Stop if max lines reached
			if (line_count >= _max_lines) {
				result = string_trim(result); // clean trailing whitespace
				result += "..."; // indicate cut-off
				return result;
			}
		} else {
			if (line != "") line += " ";
			line += word;
		}
	}

	// Add the last line
	if (line != "") {
		result += line;
	}

	return result;
}


function CompareAnswer(_answer, _correct)
{
	var _lenA = string_length(_answer);
	var _lenC = string_length(_correct);
	
	if (_lenA != _lenC) return false;
	
	var _a1 = array_create(_lenA, "");
    var _a2 = array_create(_lenA, "");
	
	for (var i = 0; i < _lenA; i++) {
        _a1[i] = string_char_at(_answer, i + 1);
        _a2[i] = string_char_at(_correct, i + 1);
    }
	
	array_sort(_a1, true);
    array_sort(_a2, true);
	
	for (var i = 0; i < _lenA; i++) {
        if (_a1[i] != _a2[i]) return false;
    }
	
	return true;
}
