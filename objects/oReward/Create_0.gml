width = 320;
height = 180;

var _items = [];

if (isBoss) 
{
	instance_create_depth(
		camera_get_view_x(view_camera[0]) + 160,
		camera_get_view_y(view_camera[0]) + 90,
		-999999,
		oBattleFloatingText,
		{font: fnM5x7, col: c_yellow, text: "+1000g!"}
	);
	audio_play_sound(eCoin, 0, false);
	global.player.gold += 1000;
	array_copy(_items, 0, global.item.plusItems, 0, array_length(global.item.plusItems));
}
else array_copy(_items, 0, global.item.rewardItems, 0, array_length(global.item.rewardItems));

_items = array_shuffle(_items);

options = [];
for (var i = 0; i < 3; i++)
{
	array_push(options, global.item[$ _items[i]]);
}

_pointerX = 160;

select = 2;