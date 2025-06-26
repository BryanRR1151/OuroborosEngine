if (resultsPage)
{
	draw_set_color(c_white);
	draw_set_font(fnM5x7);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_sprite_stretched(sBox, 0, 10, 10, 300, 130);
	
	draw_set_halign(fa_center);
	draw_text(width/2, 15, "PARTIDA TERMINADA");
	draw_set_halign(fa_left);
	draw_text(20, 30, string("TIEMPO: {0} segundos", qTime));
	draw_text(20, 45, string("RESPUESTAS CORRECTAS: {0}/{1}", qCorrect, qTotal));
	draw_text(20, 60, string("ZAFIRO SADA: {0}", qSapphire));
	draw_text(20, 75, string("ORO: {0}", qGold));
	draw_text(20, 90, string("CALIFICACION: {0}", mGrade));
	draw_text(20, 105, string("PUNTAJE: {0}", qGrade));
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fnM3x6);
	draw_text(x + 285, y + 110, "Preguntas");
	draw_sprite(sShift, 0, x + 285, y + 125);
}
else
{
	draw_set_color(c_white);
	draw_set_font(fnM3x6);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_sprite_stretched(sBox, 0, 5, 5, 310, 170);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(width/2, 160, string("{0}/{1}", qPage, qTotal));
	draw_sprite(sLeft, 0, width/2 - 20, 160);
	draw_sprite(sRight, 0, width/2 + 20, 160);
	
	draw_sprite(sShift, 0, x + 30, y + 160);
	draw_set_halign(fa_left);
	draw_text(x + 50, y + 160, "Resultados");
	
	var _question = global.go.questions[qPage-1];
	
	switch (_question.t)
	{
		case "C": drawConsequence(_question); break;
		case "D": drawDifference(_question)	; break;
		case "H": drawHypothesis(_question)	; break;
		case "I": drawImage(_question)		; break;
		case "Q": drawQuestion(_question)	; break;
		case "T": drawTimeline(_question)	; break;
	}
}

