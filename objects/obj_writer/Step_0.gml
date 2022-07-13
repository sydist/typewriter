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
