// Inherit the parent event
event_inherited();

global.party = [];

for (var i = 0; i < array_length(global.selectedCharacters); i++)
{
	var _index = global.selectedCharacters[i];
	var _obj = variable_clone(global.playableCharacters[_index]);
	array_push(global.party, _obj);
}

if (instance_exists(oMusic))
{
	with(oMusic) 
	{
		audio_stop_sound(current_sound);
		
		current_sound = audio_play_sound(mTree, 0, true);
	}
}

//room_goto(rTree);
room_goto(rCutStart);
