if (isOver && canContinue && keyboard_check_pressed(vk_enter))
	next(++page);

if (!isOver && keyboard_check(vk_shift))
	skip();
