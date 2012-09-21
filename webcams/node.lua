gl.setup(1024, 768)

imgs = {}
tick = 0

node.event("content_update", function(filename)
	if filename == "imgs.txt" then
		print("Updating cams!")
		imgfile = resource.load_file("imgs.txt")
		local tmpimgs = {}
		local n = 1
		for line in imgfile:gmatch("[^\r\n]+") do
			print(line)
			tmpimgs[n] = resource.load_image(line)
			n = n + 1
		end
		imgs = tmpimgs
	end
end)

function node.render()
	if tick < 1 then
		gl.clear(0,0,0,1)
		if #imgs > 0 then
			img = imgs[math.random(#imgs)]
--			img = imgs[1]

--			util.draw_correct(img , 0, 0, WIDTH, HEIGHT)
		end
		tick = 100
	else
		tick = tick - 1
	end
	util.draw_correct(img, 0, 0, WIDTH, HEIGHT)
end

