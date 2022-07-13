if (isLast) endfunction();

with(par_letter) 
	if (writerId == other.id) 
		instance_destroy();

ds_queue_destroy(commandsQueue);
