screen_x,screen_y = getDisplaySize();--�ֱ���
screen_dpi = getDisplayDpi();--DPI
Debug = false;

if screen_x==720 and screen_y==1280 and screen_dpi==320 then
	toast("��Ļ�ֱ���Ϊ: "..screen_x.."*"..screen_y.." DPI: "..screen_dpi.."\n֧�ֵķֱ���",0,0);
    sleep(1000);
    hideToast();
    setControlBarPosNew(0, 0);
else
	toast("��Ļ�ֱ���Ϊ: "..screen_x.."*"..screen_y.." DPI: "..screen_dpi.."\nΪ��֧�ֵķֱ���\n������Ϊ720*1280 DPI: 320",0,0);
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

sd_path = getSdPath();--Sd·��
script_name = "random_work"--�ű�����
script_path = sd_path.."/"..script_name;--�ű��ļ���·��
script_data_path = script_path.."/data.txt";--�ű�����·��

if fileExist(script_path) == false then
	mkdir(script_path);
end

if fileExist(script_path.."/data") == false then
	mkdir(script_path.."/data");
end

if fileExist(script_data_path) == false then
	exec("touch "..script_data_path);
end
game_package = config_page_1["��������"]--��Ϸ����
------------------------------------------------------------------------------------------------
function reboot()
	exec("reboot");
end
--[[
	reboot();
    �����豸
]]

function now_time_str()
	local str = os.date("%Y��%m��%d�� %H:%M:%S");
    return str;
end
--[[
	now_time_str();
    ��ǰ�豸ʱ��
    ����һ���ַ���
]]

function cp_file(file1, file2)
	exec("cp -rf "..file1.." "..file2);
end
--[[
	cp_file(file1, file2)
    rootȨ�޸��Ʋ������ļ�
    file1:Դ�ļ�Ŀ¼
    file2:Ŀ��Ŀ¼
]]
function rand_tap(x1,y1,x2,y2)
    math.randomseed(os.time());
    tap(math.random(x1,x2),math.random(y1,y2));
end
--[[
	rand_tap(�������Ͻ�x, �������Ͻ�y, �������½�x, �������½�y)
    �ھ��η�Χ��������
]]

function get_elixir()
	local x, y = -1 , -1;
    local elixir = -1;
    for i=0,10 do
    	ret,x,y=findPic(180,1220,250,1260,"ʥˮ_"..math.tointeger(i)..".png","101010",0,0.75);
    	if x~=-1 and y~=-1 then
    		return i;
    	end
    end
    return elixir;
end
--[[
	get_elixir()
    ����ʥˮֵ
]]

function get_main_ui()
	sleep(100);
    local ui=-1;
    local x,y = -1, -1;
    local x1={90, 220, 340, 460, 580};
    local y1=1240;
    local tip={"�̵����", "�ղؽ���", "��ս����", "�������", "�����"};
    for i=1,5 do
		ret,x,y=findPic(x1[i], y1, x1[i]+50, y1+40,"�������ʶ_"..math.tointeger(i)..".png","101010",0,0.75);
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
	��ȡ��ҳui
    1: �̵�
    2: �ղ�
    3: ��ս
    4: ����
    5: �
    -1: δʶ��
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
    ret,x,y=findPic(40,100,115,800, "�������ұ�ʶ.png","101010",0,0.75);
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
    ret,x,y=findPic(40,100,115,800, "�������ұ�ʶ.png","101010",0,0.75);
    if x~=-1 and y~=-1 then
       	rand_tap(x, y,x+5,y+5);
        sleep(1000);
        ret,x,y=findPic(0,0,screen_x,screen_y, "�������ұ�ʶ_1.png","101010",0,0.75);
        if x~=-1 and y~=-1 then
           	state = 0;
        else
        	sleep(1000);
           	ret,x,y=findPic(0,0,screen_x,screen_y, "�������ұ�ʶ_2.png","101010",0,0.75);
            if x~=-1 and y~=-1 then
               	state = 1;
            else
               	state = -1;
            end
        end
    else
       	state = -1;
    end
	ret,x,y=findPic(40,100,115,800, "�������ұ�ʶ.png","101010",0,0.75);
    local tmpx, tmpy = x, y;
    if state == -1 then
    	toast("δ��ȡ��ÿ�մ���״̬");
    elseif state == 1 then
    	toast("ÿ�մ����Դ���");
    else
    	toast("ÿ�մ���δ����");
    end
    sleep(500)
    hideToast();
    return state;
end
--[[
	get_daliy_cap_state()
	��ȡÿ�մ���״̬
    0:δ����
    1:����
    -1:δʶ��
]]

function get_daliy_tasks_state()
	sleep(5000);
    local ui = get_main_ui();
    if ui == -1 then
    	toast("δʶ��");
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
    	ret,x,y=findPic(530,task_y[i],600,task_y[i]+60, "�������.png","101010",0,0.75);
        if x~=-1 and y ~=-1 then task=task+1; end
    end
    ret,x,y=findPic(630,220,680,250, "�ر��������.png","101010",0,0.75);
    if x~=-1 and y ~=-1 then rand_tap(x, y, x+5, y+5); end
    if task == 3 then
    	toast("�Ѵ�������");
        sleep(1000);
        hideToast();
        return 1;
    else
		toast("δ��������");
        sleep(1000);
        hideToast();
        return 0;
    end
end
--[[
	get_daliy_tasks_state()
    ��ȡÿ������״̬
    0:δ����
    1:����/δʶ��
]]

function get_main_ui_chest_state()
	local chest_state = {nil, nil, nil, nil};
	sleep(500);
    local ui = get_main_ui();
    if ui == -1 then
    	toast("δʶ��");
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
        ret,x,y=findPic(chest_x[i], 1000, chest_x[i]+80, 1100, "����λ_"..math.tointeger(i)..".png","101010",0,0.75);
        if x ~=-1 and x~=-1 then
        	chest_state[i] = 0;
        else
        	chest_state[i] = 1;
        end
    end
    toast("����λ1:"..chest_state[1].."\n����λ2:"..chest_state[2].."\n����λ3:"..chest_state[3].."\n����λ4:"..chest_state[4]);
    sleep(500);
    hideToast();
    return chest_state;
end 
--[[
	get_main_ui_chest_state();
    ������ҳ����״̬(����)
    nil:δʶ��
    0:�ޱ���
    1:�б���
]]

function open_chest()
	local second = os.time();
    local flg=true;
    while(flg) do
    	local x,y = -1, -1;
    	ret,x,y = findPic(280,1030,390,1100,"��������ʶ_1.png","101010",0,0.8);
        if x~=-1 and y ~=-1 then
        	second = os.time();
            toast("����",screen_x, 0);
            rand_tap(190,560,500,860);
        end
        x,y = -1, -1;
		ret,x,y = findPic(260,0,430,110,"��������ʶ_2.png","101010",0,0.8);
        if x~=-1 and y ~=-1 then
        	second = os.time();
            toast("����",screen_x, 0);
            rand_tap(190,560,500,860);
        end
		x,y = -1, -1;
		ret,x,y = findPic(300,940,410,995,"��������ʶ_3.png","101010",0,0.8);
        if x~=-1 and y ~=-1 then
        	second = os.time();
            toast("����",screen_x, 0);
            rand_tap(x, y, x+5, y+5);
        end
		ret,x,y = findPic(320,1090,390,1130,"��������ʶ_4.png","101010",0,0.8);
        if x~=-1 and y ~=-1 then
        	second = os.time();
            toast("����",screen_x, 0);
            rand_tap(x, y, x+5, y+5);sleep(2000);
            rand_tap(x, y, x+5, y+5);sleep(2000);
            rand_tap(x, y, x+5, y+5);sleep(2000);
            rand_tap(x, y, x+5, y+5);sleep(2000);
            break;
        end
        if os.time()-second > 1 and os.time()-second< 5 then
        	toast("δ��⵽�������: "..os.time()-second.."��");
        end
        if os.time()-second >= 5 then
        	toast("��������");
            flg=false;
        end
        sleep(1000);
    end
    sleep(300)
end
--[[
	open_chest()
    ����
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
        ret,x,y=findPic(card_x, card_y, card_x+90, card_y+125, "���Ʒ���_"..math.tointeger(i)..".png","101010",0,0.75);
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
	place_card(���Ʒ���, ����λ��, �ڼ�����)
    ���Ʒ���:0~1
     0:��·
     1:��·
	����λ��: 0~3
     0:����������
     1:�����������
     2:����
     3:��ͷ
    �ڼ�����: 0~3
    0:��һ����
    ...:....
]]

function battle_L1(target_elixir, dirn, pos)
	local second = os.time();
    local elixir = 0;
    local flg = true;
	while (flg)
    do
    	local x ,y = -1, -1;
        ret,x,y = findPic(160,1230,200,1300,"ս�������ʶ.png","101010",0,0.8);
        if x~=-1 and y~=-1 then
        	second = os.time();
            elixir = get_elixir();
            if elixir>0 then
            	toast("��ǰʥˮ"..elixir, screen_x, screen_y);
            end
            if Debug == true then
            	toast("��ǰʥˮ"..elixir, screen_x, screen_y);
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
        
        ret,x,y = findPic(330,1080,400,1120,"ս������ȷ��.png","101010",0,0.8)
        if x~=-1 and y~=-1 then
        	toast("ս������");
            rand_tap(x, y, x+50, y+50);
            sleep(500);
            break;
            hideToast();
        end
        
		ret,x,y = findPic(60,1100,125,1230,"2v2ս������ȷ��.png","101010",0,0.8)
        if x~=-1 and y~=-1 then
        	toast("ս������");
            rand_tap(330,1080,400,1120);
            sleep(500);
            break;
            hideToast();
        end
        
        if os.time()-second>=50 then
        	toast("��ʱ",0,0);
            sleep(500);
            flg = false;
            hideToast();
            goto continue;
        end
        if os.time()-second>10 then
        toast("δ��⵽ս������: "..os.time()-second.."��");
        end
        sleep(1000);
        ::continue::
    end
   return flg;
end
--[[
	battle_L1(����ʥˮ,���Ʒ���,����λ��);
    L1:ʥˮ����������ʥˮֵʱ��Ԥ��λ���������
    ����ʥˮ: 1~10
    ����λ��: 0~4
     0:����������
     1:�����������
     2:����
     3:��ͷ
     4:���
    ���Ʒ���:0~2
     0:��·
     1:��·
     2:���
    �������귵��true
    ��ʱ����false
]]

function remove_interference()
	local x,y = -1, -1;
    ret,x,y=findPic(300,960,430,1050,"�ɾͽ����ʶ.png","101010",0,0.75);
    if x~=-1 and y~=-1 then
    	toast("�ɾͽ���");
    	rand_tap(300,960,430,1050);
        sleep(5000);
        hideToast();
        return 1;
    end
	ret,x,y=findPic(0,0,210,760,"���¼���.png","101010",0,0.75);
    if x~=-1 and y~=-1 then
    	toast("���¼���");
    	rand_tap(100,730,200,755);
        sleep(5000);
        hideToast();
        return 1;
    end
	ret,x,y=findPic(0, 0,screen_x,screen_y,"����.png","101010",0,0.75);
    if x~=-1 and y~=-1 then
    	toast("����");
    	rand_tap(x+5,y+5,x+10,y+10);
        sleep(5000);
        hideToast();
        return 1;
    end
	ret,x,y=findPic(0, 0,screen_x,screen_y,"������ʾ.png","101010",0,0.75);
    if x~=-1 and y~=-1 then
    	toast("������ʾ");
    	rand_tap(x+5,y+5,x+10,y+10);
        sleep(5000);
        hideToast();
        return 1;
    end
    ret,x,y=findPic(240,1160,470,1280,"��������ȷ��.png","101010",0,0.75);
	if x~=-1 and y~=-1 then
    	toast("��������ȷ��");
    	rand_tap(x+5,y+5,x+10,y+10);
        sleep(5000);
        hideToast();
        return 1;
    end
	ret,x,y=findPic(0, 0,screen_x,screen_y,"�رհ�ť_1.png","101010",0,0.65);
	if x~=-1 and y~=-1 then
    	toast("�رհ�ť");
    	rand_tap(x+5,y+5,x+10,y+10);
        sleep(5000);
        hideToast();
        return 1;
    end
	ret,x,y=findPic(0, 0,screen_x,screen_y,"�رհ�ť_2.png","101010",0,0.65);
	if x~=-1 and y~=-1 then
    	toast("�رհ�ť");
    	rand_tap(x+5,y+5,x+10,y+10);
        sleep(5000);
        hideToast();
        return 1;
    end
	ret,x,y=findPic(0, 0,screen_x,screen_y,"�رհ�ť_3.png","101010",0,0.65);
	if x~=-1 and y~=-1 then
    	toast("�رհ�ť");
    	rand_tap(x+5,y+5,x+10,y+10);
        sleep(5000);
        hideToast();
        return 1;
    end
    ret,x,y = findPic(160,1230,200,1300,"ս�������ʶ.png","101010",0,0.8);
    if x~=-1 and y~=-1 then
        toast("ս��");
        battle_L1(10-math.tointeger(config_page_0["����ʱ��_L1"]),math.tointeger(config_page_0["���Ʒ���_L1"]),math.tointeger(config_page_0["����λ��_L1"]));
        sleep(5000);
        hideToast();
        return 1;
    end
    ret,x,y = findPic(280,1030,390,1100,"��������ʶ_1.png","101010",0,0.8);
	if x~=-1 and y~=-1 then
        toast("����");
        open_chest();
        sleep(5000);
        hideToast();
        return 1;
    end
	ret,x,y = findPic(260,0,430,110,"��������ʶ_2.png","101010",0,0.8);
	if x~=-1 and y~=-1 then
        toast("����");
        open_chest();
        sleep(5000);
        hideToast();
        return 1;
    end
    ret,x,y = findPic(300,940,410,995,"��������ʶ_3.png","101010",0,0.8);
	if x~=-1 and y~=-1 then
        toast("����");
        open_chest();
        sleep(5000);
        hideToast();
        return 1;
    end
    ret,x,y = findPic(320,1090,390,1130,"��������ʶ_4.png","101010",0,0.8);
    if x~=-1 and y ~=-1 then
		toast("����");
        open_chest();
        sleep(5000);
        hideToast();
        return 1;
    end
    ret,x,y = findPic(0, 0,screen_x,screen_y,"������ť.png","101010",0,0.9);
    if x~=-1 and y~=-1 then
        rand_tap(x+5,y+5,x+10,y+10);
        toast("����");
        sleep(5000);
        hideToast();
        return 1;
    end
    return 0;
end
--[[
	remove_interference()
    �������
    0:ʲô��ûʶ��
    1:���˵���֮���
]]

package_name = config_page_1["��������"];
is_switch_acc = math.tointeger(config_page_1["���ʷ��к�"]);--0:�� 1:��
min_acc = math.tointeger(config_page_1["���˺�"]);
max_acc = math.tointeger(config_page_1["β�˺�"]);
game_acc_data_path = "/data/data/"..package_name.."/";
acc_data_path = script_path.."/data"; --�ű������˺�·��
function switch_acc(now_acc)
	if package_name ~= "com.supercell.clashroyale" then
    	toast("�ù���ֻ֧�ֹ��ʷ�\n�����������Ϊ: "..package_name);
        sleep(1000);
        hideToast();
        return nil;
    end
	if is_switch_acc == 0 then
    	toast("δ�����к�");
        sleep(1000);
        return nil;
    end
    if now_acc<min_acc then now_acc = min_acc end;
    if now_acc>max_acc then now_acc = max_acc end;
    if fileExist(acc_data_path.."/"..math.tointeger(now_acc).."/shared_prefs") == false then
    	toast("�˺�"..now_acc.."������");
        sleep(1000)
        hideToast();
        return 0;
    end
    stopApp(package_name);
    cp_file(acc_data_path.."/"..now_acc.."/shared_prefs", game_acc_data_path);
end
--[[
	switch_acc(now_acc);
    �к�
    now_acc: Ҫ�л��ĵڼ�����(����)
    nil: δ�����к�/�����������ǹ��ʷ�
    0:�˺Ų�����
    1:�ɹ��к�
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
        if main_ui ~= -1 then toast("�ɹ�������Ϸ"); sleep(1000); break; end
        if os.time() - second >15 then toast("δʶ�𵽽���"..os.time() - second.."��");	sleep(1000);end
        if os.time() - second >=50 then toast("��ʱ");sleep(1000); break; end
    end
    hideToast();
    if main_ui == -1 then return 0 else return 1; end
end
--[[
	start_game()
    ����/������Ϸ
    0:��ʱ
    1:�ɹ�
]]

import('com.nx.assist.lua.LuaEngine');
import('com.nx.assist.lua.IOnMailResult');
send_email_state = math.tointeger(config_page_1["�����ʼ�����"]);--0: �� 1:��
out_box = config_page_1["��������"];
out_box_key = config_page_1["������������"];
in_box = config_page_1["�ռ�����"];
email_server = config_page_1["�������������"];
function send_email(email_txt)
	if send_email_state  == 0 then
        toast("δ���������ʼ�");
        sleep(1000);
        hideToast();
        return nil;
    end
	LuaEngine.sendMail(out_box, out_box_key, in_box, email_server, true, script_name.."�ű�������ʾ", email_txt,  IOnMailResult{
       onSuccess = function()
          if Debug == true then print("�ʼ����ͳɹ�"); end
          toast("�ʼ����ͳɹ�");
          sleep(1000);
          hideToast();
       end,
       onFailed = function(error_message)
       	  if Debug == true then print("�ʼ�����ʧ�� => " .. error_message); end
          toast("�ʼ�����ʧ�� => " .. error_message);
          sleep(1000);
          hideToast();
       end
    });
end
--[[
	send_email()
	�����ʼ�
    email_txt: ��������
]]

open_chest_state = math.tointeger(config_page_0["�����俪��"]);--0: �� 1:��
function main_ui_open_chest()
	if open_chest_state == 0 then
    	toast("δ����������");
        sleep(1000);
        hideToast();
        return 1;
    end
	local ui = get_main_ui();
    if ui == -1 then
    	toast("δʶ��");
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
    toast("����");
    sleep(500);
    hideToast();
    local second = os.time();
    while (true) do
    	remove_interference();
    	ret,x,y = findPic(10,1080,710,1150,"���䰴ť.png","101010",0,0.9);
        if x~=-1 and y~=-1 then
        	rand_tap(x+5,y+5,x+10,y+10);
            toast("��������");
            hideToast();
            sleep(1000);
        	open_chest();
            second=os.time();
        end
        toast("Ѱ��������", screen_x, 0);
		if os.time()- second >= 5 then
        	toast("��������");
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
        toast("�鿴��"..i.."������");
        sleep(2000);
    	ret,x,y = findPic(0, 0,screen_x,screen_y,"������ť.png","101010",0,0.9);
        if x~=-1 and y~=-1 then
        	rand_tap(x+5,y+5,x+10,y+10);
            toast("����");
            sleep(1000);
            hideToast();
        end
        tap(516, 74);
        sleep(1000);
    end
    return 1;
end

--[[
	main_ui_open_chest()
	��/������
    1: ���Ŀ��
    0: δ���
]]

daily_deal_state = math.tointeger(config_page_0["���ճ���������"]);--0: �� 1:��
function main_ui_daily_deal()
	if daily_deal_state == 0 then
    	toast("δ�������̵��ճ�����");
        sleep(1000);
        hideToast();
        return 1;
    end
	local ui = get_main_ui();
    if ui == -1 then
    	toast("δʶ��");
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
    	ret,x,y = findPic(0,0,screen_x,screen_y,"�̵����_1.png|�̵����_2.png","101010",0,0.9);
        if x==-1 and y==-1 then swipe(340+rnd(-5,5),600+rnd(-5,5),340+rnd(-5,5),500+rnd(-5,5),50); end
        if x~=-1 and y~=-1 then
			rand_tap(x, y, x+5, y+5);
        	toast("��ȡ");
            sleep(1000);
            hideToast();
            second = os.time();
        end
    	ret,x,y = findPic(270,730,445,1010,"�����ȡ��ť.png","101010",0,0.9);
        if x~=-1 and y~=-1 then
        	rand_tap(x, y, x+5, y+5);
        	toast("��ȡ");
            sleep(1000);
            hideToast();
            second = os.time();
        end
		ret,x,y=findPic(0, 0,screen_x,screen_y,"�رհ�ť_1.png","101010",0,0.75);
		if x~=-1 and y~=-1 then
    		toast("�رհ�ť");
    		rand_tap(x+5,y+5,x+10,y+10);
        	sleep(1000);
        	second = os.time();
    	end
		ret,x,y = findPic(280,1030,390,1100,"��������ʶ_1.png","101010",0,0.8);
		if x~=-1 and y~=-1 then
        	open_chest();
            second = os.time();
    	end
		ret,x,y = findPic(260,0,430,110,"��������ʶ_2.png","101010",0,0.8);
		if x~=-1 and y~=-1 then
        	open_chest();
            second = os.time();
    	end
		ret,x,y = findPic(300,940,410,995,"��������ʶ_3.png","101010",0,0.8);
		if x~=-1 and y~=-1 then
        	open_chest();
            second = os.time();
    	end
    	if os.time() - second >= 20 then break; end
        sleep(250);
   	end
    toast("�������̵��ճ�����");
    sleep(1000);
    hideToast();
    return 1;
end
--[[
	main_ui_battle()
	��ȡ�̵��ճ�����
    1: ���Ŀ��
    0: δ���
]]

claim_rewards_state = math.tointeger(config_page_0["�����ƽ�������"]);--0: �� 1:��
function main_ui_claim_rewards()
	remove_interference();
	if claim_rewards_state == 0 then
    	toast("δ���������ƽ���");
        sleep(1000);
        hideToast();
        return 1;
    end
	local ui = get_main_ui();
    if ui == -1 then
    	toast("δʶ������");
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
        	toast("�޿��콱��");
            sleep(500);
            hideToast();
            break;
        end
        ret,x,y = findPic(0,0,screen_x,screen_y,"���ƽ���.png","101010",0,0.8);
        if x~=-1 and y~=-1 then
        	toast("���콱��");
            rand_tap(x, y, x+5, y+5);
            sleep(500);
            hideToast();
            is_rewards = true;
            break;
        end
        toast("ʶ�����ƽ���"..os.time()-second.."��");
        sleep(100);
    end
    if is_rewards == false then return 1; end
    second = os.time();
    while true do
    	ret,x,y = findPic(120,240,240,290,"��ȡ���ƽ���.png","101010",0,0.8);
        if x~=-1 and y~=-1 then
        	rand_tap(x, y, x+5, y+5);
            sleep(1000);
            os.time();
        end
		ret,x,y = findPic(50,170,220,1150,"���ƽ�����ȡ.png","101010",0,0.8);
        if x~=-1 and y~=-1 then
        	rand_tap(x, y, x+5, y+5);
            os.time();
        end
		ret,x,y = findPic(280,1030,390,1100,"��������ʶ_1.png","101010",0,0.8);
		if x~=-1 and y~=-1 then
        	open_chest();
            second = os.time();
    	end
		ret,x,y = findPic(260,0,430,110,"��������ʶ_2.png","101010",0,0.8);
		if x~=-1 and y~=-1 then
        	open_chest();
            second = os.time();
    	end
		ret,x,y = findPic(300,940,410,995,"��������ʶ_3.png","101010",0,0.8);
		if x~=-1 and y~=-1 then
        	open_chest();
            second = os.time();
    	end
        if os.time() - second >= 5 then toast("δʶ�𵽽���"..os.time() - second.."��"); end
    	if os.time() - second >= 20 then break; end
        sleep(250);
    end
    toast("���������ƽ���");
    sleep(1000);
    hideToast();
    remove_interference();
    return 1;
end
--[[
	main_ui_claim_rewards()
    ��ȡ���ƽ���
    1: ���Ŀ��
    0: δ���
]]

battle_state = math.tointeger(config_page_0["��ս����"]);--0: �� 1:��
battle_target = math.tointeger(config_page_0["��ʲô"]);--0: �������� 1: ����֮·
battle_daliy_cap = math.tointeger(config_page_0["���ҿ���"]);--0: �� 1:��
battle_daliy_tasks = math.tointeger(config_page_0["���񿪹�"]);--0: �� 1:��
battle_extra_times = math.tointeger(config_page_0["�������"]);--0: �� 1:��
function main_ui_battle()
	local error = false;--������
    local chest_state = {nil, nil, nil, nil};--����״̬
    local is_chest_full = false;--�����Ƿ�����
    local is_daliy_cap_finish = false;--ÿ�մ����Ƿ����
    local is_daliy_tasks_finish = false;--ÿ�������Ƿ����
    local ui = get_main_ui();--��ǰ������ui
    local x, y = -1, -1;
	if battle_state == 0 then
    	toast("δ������ս");
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
    		ret,x,y = findPic(460,765,520,865,"���������л�.png","101010",0,0.8);
     	   if x == -1 and y == -1 then
     	   		rand_tap(550,800,565,850);
     	       toast("�л�����������");
       		end
    	else
    		ret,x,y = findPic(460,765,520,865,"���������л�.png","101010",0,0.8);
        	if x ~= -1 and y ~= -1 then
        		rand_tap(550,800,565,850);
            	toast("�л���������;");
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
        	is_chest_full = true; toast("��������"); sleep(1000); hideToast(); break; 
        elseif chest_state[1] ~= nil then
        	toast("����δ��\n��ʼ��ս"); sleep(2000); hideToast();
            ret,x,y = findPic(180,650,590,940,"��ս��ť.png","101010",0,0.8);
            if x~=-1 and y~=-1 then
            	rand_tap(x,y, x+10, y+10);
                toast("�����ս��ť");
            	battle_L1(10-math.tointeger(config_page_0["����ʱ��_L1"]),math.tointeger(config_page_0["���Ʒ���_L1"]),math.tointeger(config_page_0["����λ��_L1"]));
            	second = os.time();
            end
        end
        if os.time() - second >=30 then
        	toast("δʶ�𵽽���"..os.time() - second.."��");
            sleep(1000);
            hideToast();
        end
        if os.time()- second >= 50 then
        	toast("��ʱ");
            sleep(1000);
            hideToast();
            error = true;
            break;
       	end
        sleep(100);
    end
    if error == true then return 0; end
    if is_chest_full == true then
    	toast("�����Ѵ���");
        sleep(1000);
        hideToast();
    end
    if battle_daliy_cap ~= 0 then
    	local daliy_cap_state = get_daliy_cap_state();
    	if daliy_cap_state == 1 then is_daliy_cap_finish = true; end
    	if daliy_cap_state == -1 then is_daliy_cap_finish = true; toast("�����δ����");sleep(1000);end
    	second = os.time();
   		while is_daliy_cap_finish == false do
    		remove_interference();
			local daliy_cap_state = get_daliy_cap_state();
    		if daliy_cap_state == 1 then is_daliy_cap_finish = true; break; end
        	ret,x,y = findPic(100,970,140,1005,"�ɶ�1v1.png","101010",0,0.8);
        	if x~=-1 and y ~=-1 then
        		rand_tap(x,y,x+20,y+20);
            	sleep(2000);
            	ret,x,y = findPic(280,850,430,920,"�ɶԶ�ս��ť.png","101010",0,0.8);
            	if x~=-1 and y ~=-1 then
            		toast("����δ��\n��ʼ��ս");
                	rand_tap(x,y,x+20,y+20);
                	sleep(1000);
                	hideToast();
                	battle_L1(10-math.tointeger(config_page_0["����ʱ��_L1"]),math.tointeger(config_page_0["���Ʒ���_L1"]),math.tointeger(config_page_0["����λ��_L1"]));
                	second = os.time();
            	end
        	end
			if os.time() - second >=30 then
        		toast("δʶ�𵽽���"..os.time() - second.."��");
            	sleep(1000);
            	hideToast();
        	end
        	if os.time()- second >= 50 then
        		toast("��ʱ");
            	sleep(1000);
            	hideToast();
            	error = true;
            	break;
       		end
        	sleep(2500);
    	end
    else
    	toast("δ���������");
        sleep(1000);
        hideToast();
    end
    if error == true then return 0; end
    if is_daliy_cap_finish == true then
    	toast("�����Ѵ���");
        sleep(1000);
        hideToast();
    end
    
    if battle_daliy_tasks~=0 then
    	local second = os.time();
    	while is_daliy_tasks_finish == false do
        	remove_interference();
            local daliy_tasks_state = get_daliy_tasks_state();
            if daliy_tasks_state == 1 then is_daliy_tasks_finish = true; break; end
			toast("����δ���\n��ʼ��ս"); sleep(2000); hideToast();
            ret,x,y = findPic(180,650,590,940,"��ս��ť.png","101010",0,0.8);
            if x~=-1 and y~=-1 then
            	rand_tap(x,y, x+10, y+10);
                toast("�����ս��ť");
            	battle_L1(10-math.tointeger(config_page_0["����ʱ��_L1"]),math.tointeger(config_page_0["���Ʒ���_L1"]),math.tointeger(config_page_0["����λ��_L1"]));
            	second = os.time();
            end
			if os.time() - second >=30 then
        		toast("δʶ�𵽽���"..os.time() - second.."��");
            	sleep(1000);
            	hideToast();
        	end
        	if os.time()- second >= 50 then
        		toast("��ʱ");
            	sleep(1000);
            	hideToast();
            	error = true;
            	break;
       		end
        	sleep(2500);
        end
    else
		toast("δ����������");
        sleep(1000);
        hideToast();
    end
    if error == true then return 0; end
	if is_daliy_tasks_finish == true then
    	toast("�����Ѵ���");
        sleep(1000);
        hideToast();
    end
    
    local extra_times = 1;
    local second = os.time();
    while extra_times <= battle_extra_times do
    	remove_interference();
        ret,x,y = findPic(180,650,590,940,"��ս��ť.png","101010",0,0.8);
		if x~=-1 and y~=-1 then
            rand_tap(x,y, x+10, y+10);
            toast("�����ս��ť\n".."���"..extra_times.."��");
            battle_L1(10-math.tointeger(config_page_0["����ʱ��_L1"]),math.tointeger(config_page_0["���Ʒ���_L1"]),math.tointeger(config_page_0["����λ��_L1"]));
            second = os.time();
            extra_times = extra_times + 1;
        end
		if os.time() - second >=30 then
        	toast("δʶ�𵽽���"..os.time() - second.."��");
            sleep(1000);
            hideToast();
        end
        if os.time()- second >= 50 then
        	toast("��ʱ");
            sleep(1000);
            hideToast();
            error = true;
            break;
       	end
        sleep(2500);
    end
    toast("��ս����");
    sleep(1000);
    hideToast();
    return 1;
end
--[[
	main_ui_battle()
	��ս
    1: ���Ŀ��
    0: δ���
]]

daily_task_state = math.tointeger(config_page_0["������������"]);--0: �� 1:��
function main_ui_daily_task()
	if daily_task_state == 0 then
    	toast("δ������������");
        sleep(1000);
        hideToast();
        return 1;
    end
    local ui  = get_main_ui();
	if ui == -1 then
    	toast("δʶ��");
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
        ret,x,y=findPic(530,task_y[i],600,task_y[i]+60, "�������.png","101010",0,0.75);
        if x~=-1 and y ~=-1 then
        	toast("��ȡ��"..i.."��������");
        	rand_tap(rewards_x[i], 450,rewards_x[i]+10, 460);
			ret,x,y = findPic(280,1030,390,1100,"��������ʶ_1.png","101010",0,0.8);
			if x~=-1 and y~=-1 then
        		open_chest();
    		end
			ret,x,y = findPic(260,0,430,110,"��������ʶ_2.png","101010",0,0.8);
			if x~=-1 and y~=-1 then
        		open_chest();
    		end
			ret,x,y = findPic(300,940,410,995,"��������ʶ_3.png","101010",0,0.8);
			if x~=-1 and y~=-1 then
        		open_chest();
        	end
			ret,x,y = findPic(300,940,410,995,"��������ʶ_4.png","101010",0,0.8);
			if x~=-1 and y~=-1 then
        		open_chest();
        	end
        end
        sleep(2500);
    end
    toast("��ȡ���������");
    sleep(1000);
    hideToast();
    remove_interference();
    return 1;
end
--[[
	main_ui_claim_rewards()
    ��ȡ�ճ�����
    1: ���Ŀ��
    0: δ���
]]

up_card_state = math.tointeger(config_page_0["�������ƿ���"]);--0:�� 1:��
function main_ui_up_card()
	if up_card_state  == 0 then
    	toast("δ������������");
        sleep(1000);
        hideToast();
        return 1;
    end
    local ui  = get_main_ui();
	if ui == -1 then
    	toast("δʶ��");
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
    local card_x={130, 260, 450, 630, 110, 270, 440, 620, 580};
    local card_y={470, 480, 490, 470, 760, 750, 760, 760, 1075};
    local ui = get_main_ui();
    for i=1,9 do
        sleep(1000);
    	remove_interference();
        sleep(1000);
        ui = get_main_ui();
        if ui ~= 2 then 
        	toast("δ���ղؽ���");
            sleep(1000);
            hideToast();
            break;
        end
    	rand_tap(card_x[i],card_y[i],card_x[i]+5,card_y[i]+5);
        toast("����"..i.."��λ");
        sleep(1500);
        hideToast();
        ret,x,y=findPic(0,0,screen_x,screen_y, "��������_1.png","101010",0,0.75);
        if x~=-1 and y~=-1 then
        	rand_tap(x, y, x+5, y+5);
            toast("�����㹻");
            sleep(2000);
        end
 		ret,x,y=findPic(0,0,screen_x,screen_y, "��������_2.png","101010",0,0.75);
        if x~=-1 and y~=-1 then
        	rand_tap(x, y, x+5, y+5);
            toast("�����㹻");
            sleep(2000);
        end
        ret,x,y=findPic(0,0,screen_x,screen_y, "ȷ����������_1.png","101010",0,0.75);
        if x~=-1 and y~=-1 then
            rand_tap(x, y, x+5, y+5);
            toast("ȷ����������");
            sleep(3000);
        end
		ret,x,y=findPic(0,0,screen_x,screen_y, "ȷ����������_2.png","101010",0,0.75);
        if x~=-1 and y~=-1 then
            rand_tap(x, y, x+5, y+5);
            toast("ȷ����������");
            sleep(3000);
        end
        ret,x,y=findPic(0, 0,screen_x,screen_y,"��������ȷ��_1.png","101010",0,0.75);
        if x~=-1 and y~=-1 then
        	rand_tap(x, y, x+5, y+5);
            toast("��������ȷ��");
            sleep(3500);
            ret,x,y=findPic(0,0,screen_x,screen_y,"�������ƽ����ʶ.png","101010",0,0.75);
            if x~=-1 and y~=-1 then	rand_tap(0,0,screen_x,screen_y); end
            hideToast();
        end
        ret,x,y=findPic(0, 0,screen_x,screen_y,"��������ȷ��_2.png","101010",0,0.75);
        if x~=-1 and y~=-1 then
        	rand_tap(x, y, x+5, y+5);
            toast("��������ȷ��");
            sleep(3500);
            ret,x,y=findPic(0,0,screen_x,screen_y,"�������ƽ����ʶ.png","101010",0,0.75);
            if x~=-1 and y~=-1 then	rand_tap(0,0,screen_x,screen_y); end
            hideToast();
        end
        ret,x,y=findPic(0, 0,screen_x,screen_y,"��������ȷ��_3.png","101010",0,0.75);
        if x~=-1 and y~=-1 then
        	rand_tap(x, y, x+5, y+5);
            toast("��������ȷ��");
            sleep(3500);
            ret,x,y=findPic(0,0,screen_x,screen_y,"�������ƽ����ʶ.png","101010",0,0.75);
            if x~=-1 and y~=-1 then	rand_tap(0,0,screen_x,screen_y); end
            hideToast();
        end
        ret,x,y=findPic(0, 0,screen_x,screen_y,"��������ȷ��_1.png","101010",0,0.75);
		if x~=-1 and y~=-1 then
            rand_tap(x, y, x+5, y+5);
            toast("��������ȷ��");
            sleep(3500);
            ret,x,y=findPic(0,0,screen_x,screen_y,"�������ƽ����ʶ.png","101010",0,0.75);
            if x~=-1 and y~=-1 then	rand_tap(0,0,screen_x,screen_y); end
            hideToast();
            goto continue;
        end
		ret,x,y=findPic(0, 0,screen_x,screen_y,"��������ȷ��_2.png","101010",0,0.75);
		if x~=-1 and y~=-1 then
            rand_tap(x, y, x+5, y+5);
            toast("��������ȷ��");
            sleep(3500);
            ret,x,y=findPic(0,0,screen_x,screen_y,"�������ƽ����ʶ.png","101010",0,0.75);
            if x~=-1 and y~=-1 then	rand_tap(0,0,screen_x,screen_y); end
            hideToast();
            goto continue;
        end
		ret,x,y=findPic(0, 0,screen_x,screen_y,"��������ȷ��_3.png","101010",0,0.75);
		if x~=-1 and y~=-1 then
            rand_tap(x, y, x+5, y+5);
            toast("��������ȷ��");
            sleep(3500);
            ret,x,y=findPic(0,0,screen_x,screen_y,"�������ƽ����ʶ.png","101010",0,0.75);
            if x~=-1 and y~=-1 then	rand_tap(0,0,screen_x,screen_y); end
            hideToast();
            goto continue;
        end
        ret,x,y=findPic(0, 0,screen_x,screen_y,"�رհ�ť_2.png","101010",0,0.65);
		if x~=-1 and y~=-1 then
             rand_tap(x, y, x+5, y+5);
            toast("��Ҳ���");
            sleep(1500);
            hideToast();
        end
        ret,x,y=findPic(0, 0,screen_x,screen_y,"�رհ�ť_2.png","101010",0,0.65);
        if x~=-1 and y~=-1 then
            rand_tap(x, y, x+5, y+5);
            toast("�ر�");
            sleep(1500);
            hideToast();
        end
		::continue::
    end
    toast("�������ƽ���");
    sleep(1000);
    hideToast();
    remove_interference();
    return 1;
end
--[[
	main_ui_up_card()
    ��������
    1: ���Ŀ��
    0: δ���
]]

up_card_rewards_state = math.tointeger(config_page_0["��ȡ���ƴ�ʦ����"]);--0: �� 1:��
function main_ui_card_master_rewards()
	if up_card_rewards_state  == 0 then
    	toast("δ������ȡ���ƴ�ʦ");
        sleep(1000);
        hideToast();
        return 1;
    end
    local ui  = get_main_ui();
	if ui == -1 then
    	toast("δʶ��");
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
    
end
--[[
	main_ui_up_card()
    ��ȡ���ƴ�ʦ
    1: ���Ŀ��
    0: δ���
]]
---------------------------------------------------------------------------------------------------------

--battle_L1(10-math.tointeger(config_page_0["����ʱ��_L1"]),math.tointeger(config_page_0["���Ʒ���_L1"]),math.tointeger(config_page_0["����λ��_L1"]));
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
--reboot();
--print(now_time_str());


io.input(script_data_path);
read_content = io.read();
if read_content == null then now_acc = min_acc; else now_acc = math.tointeger(read_content); end
io.close();
if now_acc > max_acc then now_acc = max_acc; elseif now_acc < min_acc then now_acc = min_acc; end
MAX_EVENT = 6; -- ����¼�����
outline_time = math.tointeger(config_page_1["��������ʱ��"]);
is_ignore_exception = math.tointeger(config_page_1["�����쳣����"]);--0: �� 1:�� ���������¼�δ��ɾͲ�����������һ��

while true do
	local state = {};
    local second = os.time();
    for i=1,MAX_EVENT do state[i] = 0; end
    if is_switch_acc == 1 then 
        acc_HUD_id = createHUD(); 
        showHUD(acc_HUD_id,"�˺�"..now_acc,12,"0xffff0000","0xffffffff",0,screen_x,0,85,0);
    end
    switch_acc(now_acc);
    local try_run_count = 1;
    local is_game_in_main_ui = 0;
    while is_game_in_main_ui == 0 do
        toast("����������Ϸ����: "..try_run_count);
        sleep(1000);
    	is_game_in_main_ui = start_game();
        if is_game_in_main_ui == 0 then try_run_count = try_run_count + 1 else try_run_count = 1; end
        if try_run_count >= 10 then
        	send_email("���˺���~ (-��-)��<br>�ű��쳣, ���������豸���<br>ϣ��������һ���õ�һ��(> <)��<br>"..now_time_str());
            sleep(3000);
            reboot();
        end
    end
    local sum = 0;
    while sum < MAX_EVENT do
    	local seconds = math.floor(tickCount() / 1000);
        local minutes = math.floor(seconds / 60);
        local hours = math.floor(minutes / 60);
        local days = math.floor(hours / 24);
        seconds = seconds % 60;
        minutes = minutes % 60;
        hours = hours % 24;
        local sendtxt = "���˺���~ (-��-)��<br>";
    	if is_switch_acc == 0 then sendtxt = sendtxt.."�ű�������<br>"..days.."��"..hours.."Сʱ"..minutes.."����"..seconds.."��<br>"..now_time_str(); end
        if is_switch_acc == 1 then sendtxt = sendtxt.."�ű�������<br>"..days.."��"..hours.."Сʱ"..minutes.."����"..seconds.."��<br>".."���˺�:"..(max_acc-min_acc+1).."<br>��ǰ�˺�: ��"..(now_acc-min_acc+1).."���˺�<br>"..now_time_str(); end
    	sendtxt = sendtxt .. "<br>ϣ��������һ���õ�һ��(> <)��";
        send_email(sendtxt);
    	remove_interference();
        remove_interference();
        state[1] = main_ui_up_card();remove_interference();
    	state[2] = main_ui_daily_deal();remove_interference();
        state[3] = main_ui_open_chest();remove_interference();
        state[4] = main_ui_battle();remove_interference();
        state[5] = main_ui_claim_rewards();remove_interference();
        state[6] = main_ui_daily_task();remove_interference();
        sleep(1000);
        if is_ignore_exception == 0 then
        	sum = 0;
        	for i=1,MAX_EVENT do 
        		sum = sum + state[i];
            	if state[i] == 0 then start_game(); break; end
        	end
        else
        	break;
        end
    end
    sleep(1000);
    stopApp(game_package);
    hideHUD(acc_HUD_id);
    second = os.time();
    while os.time() - second <= 10 do
    	local seconds = math.floor(tickCount() / 1000);
        local minutes = math.floor(seconds / 60);
        local hours = math.floor(minutes / 60);
        local days = math.floor(hours / 24);
        seconds = seconds % 60;
        minutes = minutes % 60;
        hours = hours % 24;
    	if is_switch_acc == 0 then toast("�ű�������\n"..days.."��"..hours.."Сʱ"..minutes.."����"..seconds.."��"); end
        if is_switch_acc == 1 then toast("�ű�������\n"..days.."��"..hours.."Сʱ"..minutes.."����"..seconds.."��\n".."���˺�:"..(max_acc-min_acc+1).." ��ǰ�˺�: ��"..(now_acc-min_acc+1).."���˺�"); end
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
        	toast("��������ʱ��: "..outline_time.."����\n��ǰ�ѹ�: "..days.."��"..hours.."Сʱ"..minutes.."����"..seconds.."��");
            sleep(1000);
        end
    end
    if now_acc < max_acc then now_acc = now_acc + 1; else now_acc = min_acc; end
    if is_switch_acc == 1 then
    	writeFile(script_data_path,tostring(now_acc),false);
    end
end










