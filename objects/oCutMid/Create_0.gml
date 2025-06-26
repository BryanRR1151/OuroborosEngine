width = 320;
height = 180;

fade_alpha = 1; // 1 = fully opaque, 0 = transparent
fade_speed = 0.02; // Adjust for faster/slower fade

oColor1 = c_aqua;
oColor2 = c_fuchsia;
oCenter = width/2 + 8 + 3;
oMiddle = 50;

dNum = array_length(global.cutMid);
dIndex = 0;
text = WrapText(global.cutMid[dIndex], 5, 67);

function DrawScene()
{
	var _oCenter = oCenter - 32;
	
	draw_sprite_ext(sOBody, 0, _oCenter - 16, oMiddle, 1, 1, 90, oColor2, 1);
	draw_sprite_ext(sOHead, 0, _oCenter - 16, oMiddle + 16, 1, 1, 90, oColor2, 1);
	draw_sprite_ext(sOCorners, 2, _oCenter - 32, oMiddle + 16, 1, 1, 0, oColor2, 1);
	draw_sprite_ext(sOCorners, 0, _oCenter - 32, oMiddle, 1, 1, 0, oColor2, 1);
	
	draw_sprite_ext(sFinalBossIdle, 0, _oCenter + 64, oMiddle + 8, -1, 1, 0, c_white, 1);
}