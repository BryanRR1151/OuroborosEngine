global.time_start = current_time/1000;

LoadQuestions();
//LoadDialogues();

global.go = {
	questions: [],
	correct: 0,
	win: false
};

nodes = [];

var xStart = x + 160;
var yStart = y + 160;

var xMargin = 32;
var yMargin = 24;

function CreateNode(posX, posY, _treeX, _treeY, args = undefined)
{
	var _object = undefined;
	
	var _node = {
		object		: undefined,
		treeX		: _treeX,
		treeY		: _treeY
	}
	
	if(args != undefined)
	{
		args.treeX = _node.treeX;
		args.treeY = _node.treeY;
		_object = instance_create_depth(posX, posY, depth - 10, oNode, args);
	}
	else
	{
		var nodeTypeKey = array_shuffle(global.tree.randomKeys)[0];
		_object = instance_create_depth(posX, posY, depth - 10, oNode, { aval: global.tree.blockedNode, type: global.tree[$nodeTypeKey], treeX: _node.treeX, treeY: _node.treeY });
	}
	
	_node.object = _object;
	
    return _node;
}

var _node = CreateNode(xStart, yStart, 0, 1, { aval: global.tree.freeNode, type: global.tree.normalNode });
array_push(nodes, _node);

for(var i = 2; i <= 4; i++)
{
	var lastX = xStart - (xMargin*(i-1));
	var curX = 1 - i;
	for(var j=0; j < i; j++)
	{
		_node = CreateNode(lastX, yStart - (yMargin * (i-1)), curX, i);
		array_push(nodes, _node);
		curX += 2;
		lastX += xMargin*2;
	}
}

for(var i = 5; i <= 6; i++)
{
	var lastX = xStart - (xMargin*(7-i));
	var curX = i - 7;
	for(var j=0; j < 8-i; j++)
	{
		_node = CreateNode(lastX, yStart - (yMargin * (i-1)), curX, i);
		array_push(nodes, _node);
		curX += 2;
		lastX += xMargin*2;
	}
}

_node = CreateNode(xStart, yStart - (yMargin * 6), 0, 7, { aval: global.tree.blockedNode, type: global.tree.finalBossNode });
array_push(nodes, _node);

global.nodes = nodes;