if (fade_alpha > 0) {
    fade_alpha -= fade_speed;
    if (fade_alpha < 0) fade_alpha = 0;
}

var _keyEnter = keyboard_check_pressed(vk_enter);

if (_keyEnter && (dIndex < dNum-1))
{
	audio_play_sound(eMenuSelect, 0, false);
	dIndex++;
	text = WrapText(global.cutMid[dIndex], 5, 67);
}
else if (_keyEnter && (dIndex >= dNum-1)) 
{
	draw_set_alpha(1);
	audio_play_sound(eMenuSelect, 0, false);
	NewEncounter([global.enemies.tank, global.enemies.commander, global.enemies.healer],
	sBgField, global.final.caller, 0, 7, mFinalBoss);
}
