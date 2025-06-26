if(aval.click) {
	audio_play_sound(eMenuSelect, 0, false);
	type.fn(id, treeX, treeY);
}
else
{
	audio_play_sound(eBlocked, 0, false);
}