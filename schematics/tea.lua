
local _ = {name = "air", param1 = 0}
local L = {name = "tea_bush:greentea_bush", param1 = 255}
local W = {name = "default:bush_stem", param1 = 255}

tea_bush.greenteabush = {
  size = {x = 3, y = 2, z = 3},
  
  yslice_prob = {
		{ypos = 0, prob = 127},
  },
  
  data = {
    _,L,_,
	_,L,_,
	
	_,L,_,
	L,W,L,
	
	_,L,_,
	_,L,_,
  }
}