if (is_over && can_continue && keyboard_check_pressed(vk_enter))
	next_page(++page);

if (!is_over && keyboard_check(vk_shift))
	skip();
