if (keyboard_check_pressed(vk_enter)) 
{
	if (isLast) 
	{
		instance_destroy();
		exit;
	}
	
	else next();
}

else alarm[1] = 1;
