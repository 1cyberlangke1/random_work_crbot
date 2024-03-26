screen_x,screen_y = getDisplaySize();--分辨率
screen_dpi = getDisplayDpi();--DPI
Debug = false;

if screen_x==720 and screen_y==1280 and screen_dpi==320 then
	toast("屏幕分辨率为: "..screen_x.."*"..screen_y.." DPI: "..screen_dpi.."\n支持的分辨率",0,0);
    sleep(1000);
    hideToast();
else
	toast("屏幕分辨率为: "..screen_x.."*"..screen_y.." DPI: "..screen_dpi.."\n为不支持的分辨率\n请设置为720*1280 DPI: 320",0,0);
    sleep(1000);
    exitScript();
end

config = getUIConfig("main.config");
config = jsonLib.decode(config);
config_page_0 = config["page0"];
config_page_1 = config["page1"];

if Debug == true then
	for i, v in pairs(config) do
 	       print(i , v)
	end

	for i, v in pairs(config_page_0) do
   	     print(i , v)
	end

	for i, v in pairs(config_page_1) do
    	    print(i , v)
	end
end

sd_path = getSdPath();--Sd路径
script_path = sd_path.."/random_work";--脚本文件夹路径

if fileExist(script_path) == false then
	mkdir(script_path);
end

if fileExist(script_path.."/data") == false then
	mkdir(script_path.."/data");
end

game_package = config_page_1["启动包名"]--游戏包名
------------------------------------------------------------------------------------------------
function cp_file(file1, file2)
	exec("cp -rf "..file1.." "..file2);
end
--[[
	cp_file(file1, file2)
    root权限复制并覆盖文件
    file1:源文件目录
    file2:目标目录
]]
function rand_tap(x1,y1,x2,y2)
    math.randomseed(os.time());
    tap(math.random(x1,x2),math.random(y1,y2));
end
--[[
	rand_tap(矩形左上角x, 矩形左上角y, 矩形右下角x, 矩形右下角y)
    在矩形范围内随机点击
]]

function get_elixir()
	local x, y = -1 , -1;
    local elixir = -1;
    for i=0,10 do
    	ret,x,y=findPic(180,1220,250,1260,"圣水_"..math.tointeger(i)..".png","101010",0,0.75);
    	if x~=-1 and y~=-1 then
    		return i;
    	end
    end
    return elixir;
end
--[[
	get_elixir()
    返回圣水值
]]

function get_main_ui()
	sleep(100);
    local ui=-1;
    local x,y = -1, -1;
    local x1={90, 220, 340, 460, 580};
    local y1=1240;
    local tip={"商店界面", "收藏界面", "对战界面", "部落界面", "活动界面"};
    for i=1,5 do
		ret,x,y=findPic(x1[i], y1, x1[i]+50, y1+40,"主界面标识_"..math.tointeger(i)..".png","101010",0,0.75);
    	if x~=-1 and y~=-1 then
    		ui = i;
            toast(tip[ui]);
            break;
    	end
    end
    return ui;
end
--[[
	get_main_ui()
	获取主页ui
    1: 商店
    2: 收藏
    3: 对战
    4: 部落
    5: 活动
    -1: 未识别到
]]

function get_daliy_cap_state()
	local ui = get_main_ui();
    local state=-1;
    local x, y = -1, -1;
    if ui == -1 then 
    	return -1; 
    else
    	rand_tap(700,1265,710,1270);
    end
    sleep(2500);
    ret,x,y=findPic(40,100,115,800, "活动界面代币标识.png","101010",0,0.75);
    if x == -1 and y == -1 then
    	swipe(340+rnd(-5,5),600+rnd(-5,5),340+rnd(-5,5),1000+rnd(-5,5),500);
        sleep(1000);
        swipe(340+rnd(-5,5),600+rnd(-5,5),340+rnd(-5,5),1000+rnd(-5,5),500);
        sleep(1000);
        swipe(340+rnd(-5,5),600+rnd(-5,5),340+rnd(-5,5),1000+rnd(-5,5),500);
        sleep(1000);
        swipe(340+rnd(-5,5),600+rnd(-5,5),340+rnd(-5,5),1000+rnd(-5,5),500);
      	sleep(1000);
        swipe(340+rnd(-5,5),600+rnd(-5,5),340+rnd(-5,5),1000+rnd(-5,5),500);
        sleep(2500);
    end
    ret,x,y=findPic(40,100,115,800, "活动界面代币标识.png","101010",0,0.75);
    if x~=-1 and y~=-1 then
       	rand_tap(x, y,x+5,y+5);
        sleep(1000);
        ret,x,y=findPic(0,0,screen_x,screen_y, "活动界面代币标识_1.png","101010",0,0.75);
        if x~=-1 and y~=-1 then
           	state = 0;
        else
        	sleep(1000);
           	ret,x,y=findPic(0,0,screen_x,screen_y, "活动界面代币标识_2.png","101010",0,0.75);
            if x~=-1 and y~=-1 then
               	state = 1;
            else
               	state = -1;
            end
        end
    else
       	state = -1;
    end
	ret,x,y=findPic(40,100,115,800, "活动界面代币标识.png","101010",0,0.75);
    local tmpx, tmpy = x, y;
    if state == -1 then
    	toast("未获取到每日代币状态");
    elseif state == 1 then
    	toast("每日代币以打满");
    else
    	toast("每日代币未打满");
    end
    sleep(500)
    hideToast();
    return state;
end
--[[
	get_daliy_cap_state()
	获取每日代币状态
    0:未打满
    1:打满
    -1:未识别
]]

function get_daliy_tasks_state()
	sleep(5000);
    local ui = get_main_ui();
    if ui == -1 then
    	toast("未识别");
        sleep(500);
        hideToast();
        return 1;
    end
	if ui ~= 3 then
        if ui == 1 then rand_tap(385,1220,390,1225);
        elseif ui == 2 then rand_tap(400,1215,405,1220);
        elseif ui == 4 then rand_tap(280,1195,285,1200);
        else rand_tap(300,1220,335,1225); end
        sleep(2000);
    end
    rand_tap(40,390,90,440);
    sleep(1500);
    local task = 0;
    local x, y = -1, -1;
    local task_y={675, 810, 960};
    for i=1,3 do
    	ret,x,y=findPic(530,task_y[i],600,task_y[i]+60, "任务完成.png","101010",0,0.75);
        if x~=-1 and y ~=-1 then task=task+1; end
    end
    ret,x,y=findPic(630,220,680,250, "关闭任务界面.png","101010",0,0.75);
    if x~=-1 and y ~=-1 then rand_tap(x, y, x+5, y+5); end
    if task == 3 then
    	toast("已打满任务");
        sleep(1000);
        hideToast();
        return 1;
    else
		toast("未打满任务");
        sleep(1000);
        hideToast();
        return 0;
    end
end
--[[
	get_daliy_tasks_state()
    获取每日任务状态
    0:未打满
    1:打满/未识别
]]

function open_chest()
	local second = os.time();
    local flg=true;
    while(flg) do
    	local x,y = -1, -1;
    	ret,x,y = findPic(280,1030,390,1100,"开箱界面标识_1.png","101010",0,0.8);
        if x~=-1 and y ~=-1 then
        	second = os.time();
            toast("开箱",screen_x, 0);
            rand_tap(190,560,500,860);
        end
        x,y = -1, -1;
		ret,x,y = findPic(260,0,430,110,"开箱界面标识_2.png","101010",0,0.8);
        if x~=-1 and y ~=-1 then
        	second = os.time();
            toast("开箱",screen_x, 0);
            rand_tap(190,560,500,860);
        end
		x,y = -1, -1;
		ret,x,y = findPic(300,940,410,995,"开箱界面标识_3.png","101010",0,0.8);
        if x~=-1 and y ~=-1 then
        	second = os.time();
            toast("开箱",screen_x, 0);
            rand_tap(x, y, x+5, y+5);
        end
		ret,x,y = findPic(320,1090,390,1130,"开箱界面标识_4.png","101010",0,0.8);
        if x~=-1 and y ~=-1 then
        	second = os.time();
            toast("开箱",screen_x, 0);
            rand_tap(x, y, x+5, y+5);sleep(2000);
            rand_tap(x, y, x+5, y+5);sleep(2000);
            rand_tap(x, y, x+5, y+5);sleep(2000);
            rand_tap(x, y, x+5, y+5);sleep(2000);
            break;
        end
        if os.time()-second > 1 and os.time()-second< 5 then
        	toast("未检测到开箱界面: "..os.time()-second.."秒");
        end
        if os.time()-second >= 5 then
        	toast("结束开箱");
            flg=false;
        end
        sleep(1000);
    end
    sleep(300)
end
--[[
	open_chest()
    开箱
]]

function place_card(dirn, pos, idx)
	local target_x=0;
    local target_y=0;
    local card_x=0;
    local card_y=0;
    local is_spell = false;
    --270 1200
	if idx == 0 then
    	card_x, card_y = 175, 1075;
   	elseif idx == 1 then
    	card_x, card_y = 315, 1075;
 	elseif idx == 2 then
    	card_x, card_y = 445, 1075;
 	else
  	  	card_x, card_y = 580, 1075;
    end

    for i=1, 16 do
    	local x, y = -1, -1;
        ret,x,y=findPic(card_x, card_y, card_x+90, card_y+125, "手牌法术_"..math.tointeger(i)..".png","101010",0,0.75);
        if x~=-1 and y~=-1 then
        	is_spell = true;
            break;
        end
    end
    if is_spell == false then
    	if dirn == 0 then
    		if pos == 0 then
        		target_x, target_y = 330, 940;
        	elseif pos == 1 then
        		target_x, target_y = 160, 850;
        	elseif pos == 2 then
            	target_x, target_y = 330, 685;
        	else
        		target_x, target_y = 160, 580;
        	end
   		else 
			if pos == 0 then
        		target_x, target_y = 365, 940;
        	elseif pos == 1 then
        		target_x, target_y = 535, 850;
        	elseif pos == 2 then
            	target_x, target_y = 365, 685;
        	else
        		target_x, target_y = 535, 580;
        	end
    	end
    else
    	if dirn == 0 then
        	target_x, target_y = 165, 270;
        else
        	target_x,target_y = 545, 270;
        end
    end
    rand_tap(card_x,card_y,card_x+90,card_y+125);
    sleep(100);
    rand_tap(target_x,target_y,target_x+5,target_y+5);
    sleep(100);
end
--[[
	place_card(下牌方向, 下牌位置, 第几张牌)
    下牌方向:0~1
     0:左路
     1:右路
	下牌位置: 0~3
     0:国王塔沉底
     1:公主塔后沉底
     2:中置
     3:桥头
    第几张牌: 0~3
    0:第一张牌
    ...:....
]]

function battle_L1(target_elixir, dirn, pos)
	local second = os.time();
    local elixir = 0;
    local flg = true;
	while (flg)
    do
    	local x ,y = -1, -1;
        ret,x,y = findPic(160,1230,200,1300,"战斗界面标识.png","101010",0,0.8);
        if x~=-1 and y~=-1 then
        	second = os.time();
            elixir = get_elixir();
            if elixir>0 then
            	toast("当前圣水"..elixir, screen_x, 0);
            end
            if Debug == true then
            	toast("当前圣水"..elixir, screen_x, 0);
            end
            if elixir >= target_elixir then
            	if dirn == 2 then 
            		math.randomseed(os.time());
            	    if pos ~= 4 then 
                    	place_card(math.random(0,1), pos, math.random(0,3));
                    else 
                    	place_card(math.random(0,1), math.random(0,3), math.random(0,3));
                    end
          	    else
                	if pos ~= 4 then 
            			place_card(dirn, pos, math.random(0,3));
                    else
                    	place_card(dirn, math.random(0,3), math.random(0,3));
                    end
           	    end
            end
            
            goto continue;
        end
        
        ret,x,y = findPic(330,1080,400,1120,"战斗结束确定.png","101010",0,0.8)
        if x~=-1 and y~=-1 then
        	toast("战斗结束");
            rand_tap(x, y, x+50, y+50);
            sleep(500);
            break;
            hideToast();
        end
        
		ret,x,y = findPic(60,1100,125,1230,"2v2战斗结束确定.png","101010",0,0.8)
        if x~=-1 and y~=-1 then
        	toast("战斗结束");
            rand_tap(330,1080,400,1120);
            sleep(500);
            break;
            hideToast();
        end
        
        if os.time()-second>=50 then
        	toast("超时",0,0);
            sleep(500);
            flg = false;
            hideToast();
            goto continue;
        end
        if os.time()-second>10 then
        toast("未检测到战斗界面: "..os.time()-second.."秒");
        end
        sleep(1000);
        ::continue::
    end
   return flg;
end
--[[
	battle_L1(下牌圣水,下牌方向,下牌位置);
    L1:圣水量到达下牌圣水值时向预设位置随机下牌
    下牌圣水: 1~10
    下牌位置: 0~4
     0:国王塔沉底
     1:公主塔后沉底
     2:中置
     3:桥头
     4:随机
    下牌方向:0~2
     0:左路
     1:右路
     2:随机
    正常打完返回true
    超时返回false
]]

function remove_interference()
	local x,y = -1, -1;
    ret,x,y=findPic(300,960,430,1050,"成就界面标识.png","101010",0,0.75);
    if x~=-1 and y~=-1 then
    	toast("成就界面");
    	rand_tap(300,960,430,1050);
        sleep(5000);
        hideToast();
        return 1;
    end
	ret,x,y=findPic(350,770,460,800,"不再提示.png","101010",0,0.75);
    if x~=-1 and y~=-1 then
    	toast("不再提示");
    	rand_tap(355,775,450,790);
        sleep(5000);
        hideToast();
        return 1;
    end
    ret,x,y=findPic(240,1160,470,1280,"皇室征程确定.png","101010",0,0.75);
	if x~=-1 and y~=-1 then
    	toast("皇室征程确定");
    	rand_tap(x+5,y+5,x+10,y+10);
        sleep(5000);
        hideToast();
        return 1;
    end
	ret,x,y=findPic(0, 0,screen_x,screen_y,"关闭按钮_1.png","101010",0,0.65);
	if x~=-1 and y~=-1 then
    	toast("关闭按钮");
    	rand_tap(x+5,y+5,x+10,y+10);
        sleep(5000);
        hideToast();
        return 1;
    end
	ret,x,y=findPic(0, 0,screen_x,screen_y,"关闭按钮_2.png","101010",0,0.65);
	if x~=-1 and y~=-1 then
    	toast("关闭按钮");
    	rand_tap(x+5,y+5,x+10,y+10);
        sleep(5000);
        hideToast();
        return 1;
    end
	ret,x,y=findPic(0, 0,screen_x,screen_y,"关闭按钮_3.png","101010",0,0.65);
	if x~=-1 and y~=-1 then
    	toast("关闭按钮");
    	rand_tap(x+5,y+5,x+10,y+10);
        sleep(5000);
        hideToast();
        return 1;
    end
    ret,x,y = findPic(160,1230,200,1300,"战斗界面标识.png","101010",0,0.8);
    if x~=-1 and y~=-1 then
        toast("战斗");
        battle_L1(10-math.tointeger(config_page_0["下牌时机_L1"]),math.tointeger(config_page_0["下牌方向_L1"]),math.tointeger(config_page_0["下牌位置_L1"]));
        sleep(5000);
        hideToast();
        return 1;
    end
    ret,x,y = findPic(280,1030,390,1100,"开箱界面标识_1.png","101010",0,0.8);
	if x~=-1 and y~=-1 then
        toast("开箱");
        open_chest();
        sleep(5000);
        hideToast();
        return 1;
    end
	ret,x,y = findPic(260,0,430,110,"开箱界面标识_2.png","101010",0,0.8);
	if x~=-1 and y~=-1 then
        toast("开箱");
        open_chest();
        sleep(5000);
        hideToast();
        return 1;
    end
    ret,x,y = findPic(300,940,410,995,"开箱界面标识_3.png","101010",0,0.8);
	if x~=-1 and y~=-1 then
        toast("开箱");
        open_chest();
        sleep(5000);
        hideToast();
        return 1;
    end
    ret,x,y = findPic(320,1090,390,1130,"开箱界面标识_4.png","101010",0,0.8);
    if x~=-1 and y ~=-1 then
		toast("开箱");
        open_chest();
        sleep(5000);
        hideToast();
        return 1;
    end
    ret,x,y = findPic(0, 0,screen_x,screen_y,"解锁按钮.png","101010",0,0.9);
    if x~=-1 and y~=-1 then
        rand_tap(x+5,y+5,x+10,y+10);
        toast("解锁");
        sleep(5000);
        hideToast();
        return 1;
    end
    return 0;
end
--[[
	remove_interference()
    清除干扰
    0:什么都没识别到
    1:点了弹窗之类的
]]

package_name = config_page_1["启动包名"];
is_switch_acc = math.tointeger(config_page_1["国际服切号"]);--0:关 1:开
min_acc = math.tointeger(config_page_1["起账号"]);
max_acc = math.tointeger(config_page_1["尾账号"]);
game_acc_data_path = "/data/data/"..package_name.."/";
acc_data_path = script_path.."/data"; --脚本保存账号路径
function switch_acc(now_acc)
	if package_name ~= "com.supercell.clashroyale" then
    	toast("该功能只支持国际服\n你的启动包名为: "..package_name);
        sleep(1000);
        hideToast();
        return nil;
    end
	if is_switch_acc == 0 then
    	toast("未开启切号");
        sleep(1000);
        return nil;
    end
    if now_acc<min_acc then now_acc = min_acc end;
    if now_acc>max_acc then now_acc = max_acc end;
    if fileExist(acc_data_path.."/"..math.tointeger(now_acc).."/shared_prefs") == false then
    	toast("账号"..now_acc.."不存在");
        sleep(1000)
        hideToast();
        return 0;
    end
    stopApp(package_name);
    cp_file(acc_data_path.."/"..now_acc.."/shared_prefs", game_acc_data_path);
    runApp(package_name);
    toast("启动游戏");
    sleep(500);
    local second=os.time();
    local ui = -1;
    local out_time = false;
    while true do
   		toast("启动游戏: "..math.tointeger(os.time()-second).."秒\n".."当前账号: 账号"..math.tointeger(now_acc));
        ui = get_main_ui();
        if ui~= -1 then
        	toast("成功进入游戏");
            sleep(1000);
        	break;
        end
        if os.time()-second>50 then
        	out_time = true;
            toast("超时");
            sleep(1000);
            break;
        end
    end
    hideToast();
    if out_time == false then
    	return 1;
    else 
    	return 0;
    end  
end
--[[
	switch_acc(now_acc);
    切号
    now_acc: 要切换的第几个号(整数)
    nil: 未开启切号/启动包名不是国际服
    0:账号不存在/超时
    1:成功切号
]]

function get_main_ui_chest_state()
	local chest_state = {nil, nil, nil, nil};
	sleep(500);
    local ui = get_main_ui();
    if ui == -1 then
    	toast("未识别");
        sleep(500);
        hideToast();
        return chest_state;
    end
	if ui ~= 3 then
        if ui == 1 then rand_tap(385,1220,390,1225);
        elseif ui == 2 then rand_tap(400,1215,405,1220);
        elseif ui == 4 then rand_tap(280,1195,285,1200);
        else rand_tap(300,1220,335,1225); end
        sleep(2000);
    end
    local chest_x={60, 230, 410, 590};
    for i=1,4 do
    	local x,y = -1, -1;
        ret,x,y=findPic(chest_x[i], 1000, chest_x[i]+80, 1100, "宝箱位_"..math.tointeger(i)..".png","101010",0,0.75);
        if x ~=-1 and x~=-1 then
        	chest_state[i] = 0;
        else
        	chest_state[i] = 1;
        end
    end
    toast("宝箱位1:"..chest_state[1].."\n宝箱位2:"..chest_state[2].."\n宝箱位3:"..chest_state[3].."\n宝箱位4:"..chest_state[4]);
    sleep(500);
    hideToast();
    return chest_state;
end 
--[[
	get_main_ui_chest_state();
    返回主页宝箱状态(数组)
    nil:未识别到
    0:无宝箱
    1:有宝箱
]]


battle_state = math.tointeger(config_page_0["对战开关"]);--0: 关 1:开
battle_target = math.tointeger(config_page_0["打什么"]);--0: 皇室征程 1: 传奇之路
battle_daliy_cap = math.tointeger(config_page_0["代币开关"]);--0: 关 1:开
battle_daliy_tasks = math.tointeger(config_page_0["任务开关"]);--0: 关 1:开
battle_extra_times = math.tointeger(config_page_0["额外打场数"]);--0: 关 1:开
function main_ui_battle()
	local error = false;--错误标记
    local chest_state = {nil, nil, nil, nil};--箱子状态
    local is_chest_full = false;--箱子是否满了
    local is_daliy_cap_finish = false;--每日代币是否打满
    local is_daliy_tasks_finish = false;--每日任务是否打满
    local ui = get_main_ui();--当前主界面ui
    local x, y = -1, -1;
	if battle_state == 0 then
    	toast("未开启对战");
        sleep(1000);
        hideToast();
    	return 1;
    end
    remove_interference();
    if battle_extra_times < 0 then battle_extra_times = 0 ; end
    if ui ~= -1 then
    	if ui ~= 3 then
    		if ui == 1 then rand_tap(510,1190,570,1250);
        	elseif ui == 2 then rand_tap(380,1175,460,1260);
       	 	elseif ui == 4 then rand_tap(270,1175,335,1255);
       	 	else rand_tap(265,1175,340,1255); end
        	sleep(1000);
   		end
		if battle_target == 0 then
    		ret,x,y = findPic(460,765,520,865,"皇室征程切换.png","101010",0,0.8);
     	   if x == -1 and y == -1 then
     	   		rand_tap(550,800,565,850);
     	       toast("切换到皇室征程");
       		end
    	else
    		ret,x,y = findPic(460,765,520,865,"皇室征程切换.png","101010",0,0.8);
        	if x ~= -1 and y ~= -1 then
        		rand_tap(550,800,565,850);
            	toast("切换到传奇征途");
        end
    end
    end
    sleep(3000);
    hideToast();
    local second = os.time();
    while is_chest_full == false do
        remove_interference();
    	chest_state = get_main_ui_chest_state();
    	if chest_state[1] == 1 and chest_state[2] == 1 and chest_state[3] == 1 and chest_state[4] == 1 then 
        	is_chest_full = true; toast("箱子已满"); sleep(1000); hideToast(); break; 
        elseif chest_state[1] ~= nil then
        	toast("箱子未满\n开始对战"); sleep(2000); hideToast();
            ret,x,y = findPic(180,650,590,940,"对战按钮.png","101010",0,0.8);
            if x~=-1 and y~=-1 then
            	rand_tap(x,y, x+10, y+10);
                toast("点击对战按钮");
            	battle_L1(10-math.tointeger(config_page_0["下牌时机_L1"]),math.tointeger(config_page_0["下牌方向_L1"]),math.tointeger(config_page_0["下牌位置_L1"]));
            	second = os.time();
            end
        end
        if os.time() - second >=30 then
        	toast("未识别到界面"..os.time() - second.."秒");
            sleep(1000);
            hideToast();
        end
        if os.time()- second >= 50 then
        	toast("超时");
            sleep(1000);
            hideToast();
            error = true;
            break;
       	end
        sleep(100);
    end
    if error == true then return 0; end
    if is_chest_full == true then
    	toast("箱子已打满");
        sleep(1000);
        hideToast();
    end
    if battle_daliy_cap ~= 0 then
    	local daliy_cap_state = get_daliy_cap_state();
    	if daliy_cap_state == 1 then is_daliy_cap_finish = true; end
    	if daliy_cap_state == -1 then is_daliy_cap_finish = true; toast("活动可能未解锁");sleep(1000);end
    	second = os.time();
   		while is_daliy_cap_finish == false do
    		remove_interference();
			local daliy_cap_state = get_daliy_cap_state();
    		if daliy_cap_state == 1 then is_daliy_cap_finish = true; break; end
        	ret,x,y = findPic(100,970,140,1005,"派对1v1.png","101010",0,0.8);
        	if x~=-1 and y ~=-1 then
        		rand_tap(x,y,x+20,y+20);
            	sleep(2000);
            	ret,x,y = findPic(280,850,430,920,"派对对战按钮.png","101010",0,0.8);
            	if x~=-1 and y ~=-1 then
            		toast("代币未满\n开始对战");
                	rand_tap(x,y,x+20,y+20);
                	sleep(1000);
                	hideToast();
                	battle_L1(10-math.tointeger(config_page_0["下牌时机_L1"]),math.tointeger(config_page_0["下牌方向_L1"]),math.tointeger(config_page_0["下牌位置_L1"]));
                	second = os.time();
            	end
        	end
			if os.time() - second >=30 then
        		toast("未识别到界面"..os.time() - second.."秒");
            	sleep(1000);
            	hideToast();
        	end
        	if os.time()- second >= 50 then
        		toast("超时");
            	sleep(1000);
            	hideToast();
            	error = true;
            	break;
       		end
        	sleep(2500);
    	end
    else
    	toast("未开启打代币");
        sleep(1000);
        hideToast();
    end
    if error == true then return 0; end
    if is_daliy_cap_finish == true then
    	toast("代币已打满");
        sleep(1000);
        hideToast();
    end
    
    if battle_daliy_tasks~=0 then
    	local second = os.time();
    	while is_daliy_tasks_finish == false do
        	remove_interference();
            local daliy_tasks_state = get_daliy_tasks_state();
            if daliy_tasks_state == 1 then is_daliy_tasks_finish = true; break; end
			toast("任务未完成\n开始对战"); sleep(2000); hideToast();
            ret,x,y = findPic(180,650,590,940,"对战按钮.png","101010",0,0.8);
            if x~=-1 and y~=-1 then
            	rand_tap(x,y, x+10, y+10);
                toast("点击对战按钮");
            	battle_L1(10-math.tointeger(config_page_0["下牌时机_L1"]),math.tointeger(config_page_0["下牌方向_L1"]),math.tointeger(config_page_0["下牌位置_L1"]));
            	second = os.time();
            end
			if os.time() - second >=30 then
        		toast("未识别到界面"..os.time() - second.."秒");
            	sleep(1000);
            	hideToast();
        	end
        	if os.time()- second >= 50 then
        		toast("超时");
            	sleep(1000);
            	hideToast();
            	error = true;
            	break;
       		end
        	sleep(2500);
        end
    else
		toast("未开启打任务");
        sleep(1000);
        hideToast();
    end
    if error == true then return 0; end
	if is_daliy_tasks_finish == true then
    	toast("任务已打满");
        sleep(1000);
        hideToast();
    end
    
    local extra_times = 1;
    local second = os.time();
    while extra_times <= battle_extra_times do
    	remove_interference();
        ret,x,y = findPic(180,650,590,940,"对战按钮.png","101010",0,0.8);
		if x~=-1 and y~=-1 then
            rand_tap(x,y, x+10, y+10);
            toast("点击对战按钮\n".."打第"..extra_times.."场");
            battle_L1(10-math.tointeger(config_page_0["下牌时机_L1"]),math.tointeger(config_page_0["下牌方向_L1"]),math.tointeger(config_page_0["下牌位置_L1"]));
            second = os.time();
            extra_times = extra_times + 1;
        end
		if os.time() - second >=30 then
        	toast("未识别到界面"..os.time() - second.."秒");
            sleep(1000);
            hideToast();
        end
        if os.time()- second >= 50 then
        	toast("超时");
            sleep(1000);
            hideToast();
            error = true;
            break;
       	end
        sleep(2500);
    end
    toast("对战结束");
    sleep(1000);
    hideToast();
    return 1;
end
--[[
	main_ui_battle()
	对战
    1: 完成目标
    0: 未完成
]]

function start_game()
	stopApp(game_package);
    sleep(500)
    runApp(game_package);
    local main_ui = -1;
    local second = os.time();
    while main_ui == -1 do
    	remove_interference();
        main_ui = get_main_ui();
        if main_ui ~= -1 then toast("成功启动游戏"); sleep(1000); break; end
        if os.time() - second >15 then toast("未识别到界面"..os.time() - second.."秒");	sleep(1000);end
        if os.time() - second >=50 then toast("超时");sleep(1000); break; end
    end
    hideToast();
    if main_ui == -1 then return 1 else return 0; end
end
--[[
	start_game()
    启动/重启游戏
    0:超时
    1:成功
]]

open_chest_state = math.tointeger(config_page_0["开宝箱开关"]);--0: 关 1:开
function main_ui_open_chest()
	if open_chest_state == 0 then
    	toast("未开启开宝箱");
        sleep(1000);
        hideToast();
        return 1;
    end
	local ui = get_main_ui();
    if ui == -1 then
    	toast("未识别");
        sleep(500);
        hideToast();
        return 0;
    end
	if ui ~= 3 then
        if ui == 1 then rand_tap(385,1220,390,1225);
        elseif ui == 2 then rand_tap(400,1215,405,1220);
        elseif ui == 4 then rand_tap(280,1195,285,1200);
        else rand_tap(300,1220,335,1225); end
        sleep(2000);
    end
    toast("开箱");
    sleep(500);
    hideToast();
    local second = os.time();
    while (true) do
    	remove_interference();
    	ret,x,y = findPic(10,1080,710,1150,"开箱按钮.png","101010",0,0.9);
        if x~=-1 and y~=-1 then
        	rand_tap(x+5,y+5,x+10,y+10);
            toast("开启宝箱");
            hideToast();
            sleep(1000);
        	open_chest();
            second=os.time();
        end
        toast("寻找箱子中", screen_x, 0);
		if os.time()- second >= 5 then
        	toast("结束开箱");
            sleep(1000);
            hideToast();
            break;
       	end
        sleep(500);
    end
    local chest_x = {125, 250, 390, 570};
	for i=1,4 do
    	remove_interference();
        rand_tap( chest_x[i], 1000, chest_x[i], 1020);
        toast("查看第"..i.."个箱子");
        sleep(2000);
    	ret,x,y = findPic(0, 0,screen_x,screen_y,"解锁按钮.png","101010",0,0.9);
        if x~=-1 and y~=-1 then
        	rand_tap(x+5,y+5,x+10,y+10);
            toast("解锁");
            sleep(1000);
            hideToast();
        end
        tap(516, 74);
        sleep(1000);
    end
    return 1;
end

--[[
	main_ui_battle()
	开/解锁箱
    1: 完成目标
    0: 未完成
]]

daily_deal_state = math.tointeger(config_page_0["领日常奖励开关"]);--0: 关 1:开
function main_ui_daily_deal()
	if daily_deal_state == 0 then
    	toast("未开启领商店日常奖励");
        sleep(1000);
        hideToast();
        return 1;
    end
	local ui = get_main_ui();
    if ui == -1 then
    	toast("未识别");
        sleep(500);
        hideToast();
        return 0;
    end
	if ui ~= 1 then
    	rand_tap(20,1190,80,1250);
        sleep(2000);
    end
    local second = os.time();
    local x, y = -1, -1;
    while true do
    	remove_interference();
    	ret,x,y = findPic(0,0,screen_x,screen_y,"商店免费_1.png|商店免费_2.png","101010",0,0.9);
        if x==-1 and y==-1 then swipe(340+rnd(-5,5),600+rnd(-5,5),340+rnd(-5,5),500+rnd(-5,5),50); end
        if x~=-1 and y~=-1 then
			rand_tap(x, y, x+5, y+5);
        	toast("领取");
            sleep(1000);
            hideToast();
            second = os.time();
        end
    	ret,x,y = findPic(270,730,445,1010,"免费领取按钮.png","101010",0,0.9);
        if x~=-1 and y~=-1 then
        	rand_tap(x, y, x+5, y+5);
        	toast("领取");
            sleep(1000);
            hideToast();
            second = os.time();
        end
		ret,x,y=findPic(0, 0,screen_x,screen_y,"关闭按钮_1.png","101010",0,0.75);
		if x~=-1 and y~=-1 then
    		toast("关闭按钮");
    		rand_tap(x+5,y+5,x+10,y+10);
        	sleep(1000);
        	second = os.time();
    	end
		ret,x,y = findPic(280,1030,390,1100,"开箱界面标识_1.png","101010",0,0.8);
		if x~=-1 and y~=-1 then
        	open_chest();
            second = os.time();
    	end
		ret,x,y = findPic(260,0,430,110,"开箱界面标识_2.png","101010",0,0.8);
		if x~=-1 and y~=-1 then
        	open_chest();
            second = os.time();
    	end
		ret,x,y = findPic(300,940,410,995,"开箱界面标识_3.png","101010",0,0.8);
		if x~=-1 and y~=-1 then
        	open_chest();
            second = os.time();
    	end
    	if os.time() - second >= 20 then break; end
        sleep(250);
   	end
    toast("结束领商店日常奖励");
    sleep(1000);
    hideToast();
    return 1;
end
--[[
	main_ui_battle()
	领取商店日常奖励
    1: 完成目标
    0: 未完成
]]

claim_rewards_state = math.tointeger(config_page_0["领令牌奖励开关"]);--0: 关 1:开
function main_ui_claim_rewards()
	remove_interference();
	if claim_rewards_state == 0 then
    	toast("未开启领令牌奖励");
        sleep(1000);
        hideToast();
        return 1;
    end
	local ui = get_main_ui();
    if ui == -1 then
    	toast("未识别令牌");
        sleep(500);
        hideToast();
        return 0;
    end
	if ui ~= 3 then
    	if ui == 1 then rand_tap(510,1190,570,1250);
        elseif ui == 2 then rand_tap(380,1175,460,1260);
        elseif ui == 4 then rand_tap(270,1175,335,1255);
        else rand_tap(265,1175,340,1255); end
        sleep(2000);
    end
    local second = os.time();
    local x, y = -1, -1;
    local is_rewards = false;
    while true do
    	if os.time()-second>=30 then
        	toast("无可领奖励");
            sleep(500);
            hideToast();
            break;
        end
        ret,x,y = findPic(0,0,screen_x,screen_y,"令牌奖励.png","101010",0,0.8);
        if x~=-1 and y~=-1 then
        	toast("可领奖励");
            rand_tap(x, y, x+5, y+5);
            sleep(500);
            hideToast();
            is_rewards = true;
            break;
        end
        toast("识别令牌奖励"..os.time()-second.."秒");
        sleep(100);
    end
    if is_rewards == false then return 1; end
    second = os.time();
    while true do
    	ret,x,y = findPic(120,240,240,290,"领取令牌奖励.png","101010",0,0.8);
        if x~=-1 and y~=-1 then
        	rand_tap(x, y, x+5, y+5);
            sleep(1000);
            os.time();
        end
		ret,x,y = findPic(50,170,220,1150,"令牌奖励领取.png","101010",0,0.8);
        if x~=-1 and y~=-1 then
        	rand_tap(x, y, x+5, y+5);
            os.time();
        end
		ret,x,y = findPic(280,1030,390,1100,"开箱界面标识_1.png","101010",0,0.8);
		if x~=-1 and y~=-1 then
        	open_chest();
            second = os.time();
    	end
		ret,x,y = findPic(260,0,430,110,"开箱界面标识_2.png","101010",0,0.8);
		if x~=-1 and y~=-1 then
        	open_chest();
            second = os.time();
    	end
		ret,x,y = findPic(300,940,410,995,"开箱界面标识_3.png","101010",0,0.8);
		if x~=-1 and y~=-1 then
        	open_chest();
            second = os.time();
    	end
        if os.time() - second >= 5 then toast("未识别到奖励"..os.time() - second.."秒"); end
    	if os.time() - second >= 20 then break; end
        sleep(250);
    end
    toast("结束领令牌奖励");
    sleep(1000);
    hideToast();
    remove_interference();
    return 1;
end
--[[
	main_ui_claim_rewards()
    领取令牌奖励
    1: 完成目标
    0: 未完成
]]

daily_task_state = math.tointeger(config_page_0["领任务奖励开关"]);--0: 关 1:开
function main_ui_daily_task()
	if daily_task_state == 0 then
    	toast("未开启领任务奖励");
        sleep(1000);
        hideToast();
        return 1;
    end
    local ui  = get_main_ui();
	if ui == -1 then
    	toast("未识别");
        sleep(500);
        hideToast();
        return 0;
    end
	if ui ~= 3 then
    	if ui == 1 then rand_tap(510,1190,570,1250);
        elseif ui == 2 then rand_tap(380,1175,460,1260);
        elseif ui == 4 then rand_tap(270,1175,335,1255);
        else rand_tap(265,1175,340,1255); end
        sleep(2000);
    end
    sleep(5000);
    rand_tap(40,390,90,440);
    sleep(1500);
    local x, y = -1, -1;
    local task_y={675, 810, 960};
    local rewards_x={160, 325, 520};
    for i=1,3 do
        ret,x,y=findPic(530,task_y[i],600,task_y[i]+60, "任务完成.png","101010",0,0.75);
        if x~=-1 and y ~=-1 then
        	toast("领取第"..i.."个任务奖励");
        	rand_tap(rewards_x[i], 450,rewards_x[i]+10, 460);
			ret,x,y = findPic(280,1030,390,1100,"开箱界面标识_1.png","101010",0,0.8);
			if x~=-1 and y~=-1 then
        		open_chest();
    		end
			ret,x,y = findPic(260,0,430,110,"开箱界面标识_2.png","101010",0,0.8);
			if x~=-1 and y~=-1 then
        		open_chest();
    		end
			ret,x,y = findPic(300,940,410,995,"开箱界面标识_3.png","101010",0,0.8);
			if x~=-1 and y~=-1 then
        		open_chest();
        	end
			ret,x,y = findPic(300,940,410,995,"开箱界面标识_4.png","101010",0,0.8);
			if x~=-1 and y~=-1 then
        		open_chest();
        	end
        end
        sleep(2500);
    end
    toast("领取任务奖励完成");
    sleep(1000);
    hideToast();
    remove_interference();
    return 1;
end
--[[
	main_ui_claim_rewards()
    领取日常任务
    1: 完成目标
    0: 未完成
]]

up_card_state = math.tointeger(config_page_0["升级卡牌开关"]);--0: 关 1:开
function main_ui_up_card()
	if up_card_state  == 0 then
    	toast("未开启升级卡牌");
        sleep(1000);
        hideToast();
        return 1;
    end
    local ui  = get_main_ui();
	if ui == -1 then
    	toast("未识别");
        sleep(500);
        hideToast();
        return 0;
    end
    local x, y = -1, -1;
    if ui ~= 2 then rand_tap(300, 1200, 305, 1205);
    	if ui == 1 then rand_tap(175, 1195, 180, 1200);
        elseif ui == 3 then rand_tap(185, 1200, 190, 1205);
        elseif ui == 4 then rand_tap(185, 1200, 305, 1205);
        else rand_tap(180, 1205, 305, 1210); end
    end
    sleep(1000);
    rand_tap(185,120,240,150);
    sleep(1000);
    swipe(340+rnd(-5,5),600+rnd(-5,5),340+rnd(-5,5),1000+rnd(-5,5),500);
    sleep(1000);
    swipe(340+rnd(-5,5),600+rnd(-5,5),340+rnd(-5,5),1000+rnd(-5,5),500);
    sleep(1000);
    swipe(340+rnd(-5,5),600+rnd(-5,5),340+rnd(-5,5),1000+rnd(-5,5),500);
    sleep(2000);
    local card_x={130, 260, 450, 630, 110, 270, 440, 620};
    local card_y={470, 480, 490, 470, 760, 750, 760, 760};
    local ui = get_main_ui();
    for i=1,8 do
    	remove_interference();
        ui = get_main_ui();
        if ui ~= 2 then 
        	toast("未在收藏界面");
            sleep(1000);
            hideToast();
            break;
        end
    	rand_tap(card_x[i],card_y[i],card_x[i]+5,card_y[i]+5);
        toast("检查第"..i.."号位");
        sleep(1000);
        hideToast();
        ret,x,y=findPic(0,0,screen_x,screen_y, "升级卡牌_1.png","101010",0,0.75);
        if x~=-1 and y~=-1 then
        	rand_tap(x, y, x+5, y+5);
            toast("卡牌足够");
            sleep(1500);
            hideToast();
        end
 		ret,x,y=findPic(0,0,screen_x,screen_y, "升级卡牌_2.png","101010",0,0.75);
        if x~=-1 and y~=-1 then
        	rand_tap(x, y, x+5, y+5);
            toast("卡牌足够");
            sleep(1500);
            hideToast();
        end
        ret,x,y=findPic(0,0,screen_x,screen_y, "确定升级卡牌_1.png","101010",0,0.75);
        if x~=-1 and y~=-1 then
            rand_tap(x, y, x+5, y+5);
            toast("确定升级卡牌");
            sleep(1500);
            hideToast();
        end
		ret,x,y=findPic(0,0,screen_x,screen_y, "确定升级卡牌_2.png","101010",0,0.75);
        if x~=-1 and y~=-1 then
            rand_tap(x, y, x+5, y+5);
            toast("确定升级卡牌");
            sleep(1500);
            hideToast();
        end
        ret,x,y=findPic(0, 0,screen_x,screen_y,"升级卡牌确定_1.png","101010",0,0.75);
        if x~=-1 and y~=-1 then
        	rand_tap(x, y, x+5, y+5);
            toast("升级卡牌确定");
            sleep(1500);
        end
        ret,x,y=findPic(0, 0,screen_x,screen_y,"升级卡牌确定_2.png","101010",0,0.75);
        if x~=-1 and y~=-1 then
        	rand_tap(x, y, x+5, y+5);
            toast("升级卡牌确定");
            sleep(1500);
        end
        ret,x,y=findPic(0, 0,screen_x,screen_y,"升级卡牌确定_3.png","101010",0,0.75);
        if x~=-1 and y~=-1 then
        	rand_tap(x, y, x+5, y+5);
            toast("升级卡牌确定");
            sleep(1500);
        end
        ret,x,y=findPic(0, 0,screen_x,screen_y,"升级卡牌确定_1.png","101010",0,0.75);
		if x~=-1 and y~=-1 then
            rand_tap(x, y, x+5, y+5);
            toast("升级卡牌确定");
            while true do
            	sleep(2000);
            	ret,x,y=findPic(0,0,screen_x,screen_y,"升级卡牌界面标识.png","101010",0,0.75);
                if x~=-1 and y~=-1 then	rand_tap(0,0,screen_x,screen_y); else break; end
            end
            hideToast();
            goto continue;
        end
		ret,x,y=findPic(0, 0,screen_x,screen_y,"升级卡牌确定_2.png","101010",0,0.75);
		if x~=-1 and y~=-1 then
            rand_tap(x, y, x+5, y+5);
            toast("升级卡牌确定");
            while true do
            	sleep(3000);
            	ret,x,y=findPic(0,0,screen_x,screen_y,"升级卡牌界面标识.png","101010",0,0.75);
                if x~=-1 and y~=-1 then	rand_tap(0,0,screen_x,screen_y); else break; end
            end
            hideToast();
            goto continue;
        end
		ret,x,y=findPic(0, 0,screen_x,screen_y,"升级卡牌确定_3.png","101010",0,0.75);
		if x~=-1 and y~=-1 then
            rand_tap(x, y, x+5, y+5);
            toast("升级卡牌确定");
            while true do
            	sleep(3000);
            	ret,x,y=findPic(0,0,screen_x,screen_y,"升级卡牌界面标识.png","101010",0,0.75);
                if x~=-1 and y~=-1 then	rand_tap(0,0,screen_x,screen_y); else break; end
            end
            hideToast();
            goto continue;
        end
        ret,x,y=findPic(0, 0,screen_x,screen_y,"关闭按钮_2.png","101010",0,0.65);
		if x~=-1 and y~=-1 then
             rand_tap(x, y, x+5, y+5);
            toast("金币不足");
            sleep(1500);
            hideToast();
        end
        ret,x,y=findPic(0, 0,screen_x,screen_y,"关闭按钮_2.png","101010",0,0.65);
        if x~=-1 and y~=-1 then
            rand_tap(x, y, x+5, y+5);
            toast("关闭");
            sleep(1500);
            hideToast();
        end
		::continue::
    end
    toast("升级卡牌结束");
    sleep(1000);
    hideToast();
    remove_interference();
    return 1;
end
--[[
	main_ui_claim_rewards()
    升级卡牌
    1: 完成目标
    0: 未完成
]]
---------------------------------------------------------------------------------------------------------

--battle_L1(10-math.tointeger(config_page_0["下牌时机_L1"]),math.tointeger(config_page_0["下牌方向_L1"]),math.tointeger(config_page_0["下牌位置_L1"]));
--open_chest();
--get_daliy_cap_state();
--[[tmp = min_acc
while true do
    if tmp>max_acc then tmp=min_acc; end
	switch_acc(tmp);
    tmp=tmp+1;
	sleep(3000);
end ]]
--get_main_ui_chest_state();
--get_daliy_tasks_state();
--start_game();
--remove_interference();
--main_ui_daily_deal();
--main_ui_claim_rewards();
--main_ui_daily_task();
--main_ui_open_chest();
--main_ui_battle();
--main_ui_up_card();


now_acc = min_acc;
MAX_EVENT = 6;
outline_time = math.tointeger(config_page_1["单开下线时间"]);
while true do
	local state = {};
    local second = os.time();
    for i=1,MAX_EVENT do state[i] = 0; end
    switch_acc(now_acc);
    if appIsFront(game_package) == false then start_game(); end
    local sum = 0;
    while sum < MAX_EVENT do
    	remove_interference();
        remove_interference();
        state[1] = main_ui_up_card();remove_interference();
    	state[2] = main_ui_daily_deal();remove_interference();
        state[3] = main_ui_open_chest();remove_interference();
        state[4] = main_ui_battle();remove_interference();
        state[5] = main_ui_claim_rewards();remove_interference();
        state[6] = main_ui_daily_task();remove_interference();
        sleep(1000);
        sum = 0;
        for i=1,MAX_EVENT do 
        	sum = sum + state[i];
            if state[i] == 0 then start_game(); break; end
        end
    end
    sleep(1000);
    stopApp(game_package);
    second = os.time();
    while os.time() - second <= 10 do
    	local seconds = math.floor(tickCount() / 1000);
        local minutes = math.floor(seconds / 60);
        local hours = math.floor(minutes / 60);
        local days = math.floor(hours / 24);
        seconds = seconds % 60;
        minutes = minutes % 60;
        hours = hours % 24;
    	if is_switch_acc == 0 then toast("脚本已运行\n"..days.."天"..hours.."小时"..minutes.."分钟"..seconds.."秒"); end
        if is_switch_acc == 1 then toast("脚本已运行\n"..days.."天"..hours.."小时"..minutes.."分钟"..seconds.."秒\n".."总账号:"..(max_acc-min_acc+1).." 当前账号: 第"..(now_acc-min_acc+1).."个账号"); end
        sleep(500);
    end
    if is_switch_acc == 0 then
    	second = os.time();
        while os.time() - second <= outline_time * 60 do
        	local seconds = os.time() - second;
            local minutes = math.floor(seconds / 60);
            local hours = math.floor(minutes / 60);
            local days = math.floor(hours / 24);
            seconds = seconds % 60;
            minutes = minutes % 60;
            hours = hours % 24
        	toast("单开下线时间: "..outline_time.."分钟\n当前已过: "..days.."天"..hours.."小时"..minutes.."分钟"..seconds.."秒");
            sleep(1000);
        end
    end
    if now_acc < max_acc then now_acc = now_acc + 1; else now_acc = min_acc; end
end










