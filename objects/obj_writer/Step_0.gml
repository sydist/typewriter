
if (isOver && canContinue && keyboard_check_pressed(vk_enter)) {
	with(par_letter) 
		if (writerId == other.id) 
			instance_destroy();
	
	if (++page >= array_length(pages)) {
		instance_destroy();
		exit;	
	}
	
	message = pages[page];
	length = string_length(message);
	
	xOffset = 0;
	yOffset = 0;
	progress = 0;
	pause = 0;
	wave = 0;
	shake = 0;
	isOver = false;

	queueCommands();
	commandCheck();
}

if (!isOver && canSkip && keyboard_check(vk_shift)) {
	pause = 0;
	alarm[0] = 0;
	
	repeat(length - progress) 
		event_perform(ev_alarm, 0);
		
	if (sound != undefined) {
		audio_stop_sound(sound);
		audio_play_sound(sound, 0, false);
	}
	
	isOver = true;
}

if (x != xprevious || y != yprevious) {
	with(par_letter) {
		writerX = writerId.x;
		writerY = writerId.y;
		x = writerX + xOffset;
		y = writerY + yOffset;	
	}
}

if (!isOver && alarm[0] <= 0) 
	alarm[0] = spd + pause;

