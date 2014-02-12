unit sty_engine;

interface

uses
  SysUtils,
  Windows,
  Math,
  Dialogs,
  SDL,
  SDL_TTF,
  //SDL_mixer,
  bass,
  iniFiles,
  SDL_image,
  SDL_Gfx,
  kys_type,
  kys_battle,
  kys_main;


//事件判断
function IsEventActive(snum, eventnum: integer): boolean;
function TimeToNum: integer;
//日期
procedure adddate(addday: integer);
procedure dayto(aday, mods: integer);
//luke新增
function inttohanzi(num: integer): WideString;
procedure daily;
procedure CheckTimeout;
procedure MyDiziLevelUp;
procedure EnemyDiziLevelUp;
function GetRoleMagicNumber(num: integer): shortint;
function GetMenpaiMagicNumber(num: integer): shortint;
procedure RoleLearnNewMenpaiMagic(num: integer);
//拼音輸入
function pinyinshuru(msg: WideString): WideString;
//初始化武功
procedure initialwugong;
//門派資源加成弟子成長速度
function mpzyjc(mpnum: integer): integer;
//戰鬥前自動設置武功
function aotosetmagic(rnum: integer): integer; overload;
function aotosetmagic(rnum, mods: integer): integer; overload;
//武功排序
procedure magicsort(var mag, lev: array of integer);
//計算武功強度值
function countmagvalue(mnum, mlev: integer): integer;
//選擇製造物品
function randomyaopin(rate: integer): integer;
function randomzhuangbei(rate: integer): integer;
function randommiji(rate: integer): integer;
function randomxiyouzhuangbei: integer;
//AI任命职务
procedure airenming;
//声望、等级排序
procedure ShengWangAndLevSort(var arr: array of integer);
//貼士
function gettips: WideString;
procedure addtips(str: WideString);
procedure settips;
procedure dectips(num:integer);
//即位排序
procedure jiweiSort(var arr: array of integer; big: integer);
procedure Jxtips;

//計算門派關係
procedure jisuanmenpaidata;
//调度人员
procedure initialMPdiaodu;
//AI門派戰鬥
procedure AIMPBattle;
procedure AIFight(id: integer);
function GetGeliveAblemag(rnum: integer): integer;
procedure HurtValueAI(Rnum1, Rnum2, mnum, level: integer);
procedure timetompbattle(id, mods: integer);
procedure newdizijoin;
procedure dalyrestore;
//任務
procedure LoadRenwus;
function TalktoWidestring(num: integer; fgrp, fidx: string): WideString;

//讀取戰場語錄
procedure initialBTalk;

implementation

uses
  kys_engine,
  kys_event,
  sty_show,
  sty_newevent;


//日期變更，按天計算

procedure dayto(aday, mods: integer);
var
  i, Count: integer;
begin
  if aday <= 0 then
    exit;
  Count := aday div 30;
  aday := aday mod 30;
  if mods = 0 then
  begin
    for i := 0 to Count - 1 do
    begin
      adddate(48 * 30);
    end;
    adddate(48 * aday);
  end
  else if mods = 1 then
  begin
    for i := 0 to Count - 1 do
    begin
      wdate[4] := wdate[4] + 48 * 30;
      while ((wdate[1] > 60) or (wdate[2] > 12) or (wdate[3] > 30) or (wdate[4] > 47)) do
      begin
        if (wdate[4] > 47) then
        begin
          wdate[3] := wdate[3] + 1;
          wdate[4] := wdate[4] - 48;
          checktimeout;
        end;
        if (wdate[3] > 30) then
        begin
          wdate[2] := wdate[2] + 1;
          wdate[3] := wdate[3] - 30;
        end;
        if (wdate[2] > 12) then
        begin
          wdate[1] := wdate[1] + 1;
          wdate[2] := wdate[2] - 12;
        end;
        if (wdate[1] > 60) then
        begin
          wdate[0] := wdate[0] + 1;
          wdate[1] := wdate[1] - 60;
        end;
      end;
    end;
    if aday > 0 then
    begin
      wdate[4] := wdate[4] + 48 * aday;
      while ((wdate[1] > 60) or (wdate[2] > 12) or (wdate[3] > 30) or (wdate[4] > 47)) do
      begin
        if (wdate[4] > 47) then
        begin
          wdate[3] := wdate[3] + 1;
          wdate[4] := wdate[4] - 48;
          checktimeout;
        end;
        if (wdate[3] > 30) then
        begin
          wdate[2] := wdate[2] + 1;
          wdate[3] := wdate[3] - 30;
        end;
        if (wdate[2] > 12) then
        begin
          wdate[1] := wdate[1] + 1;
          wdate[2] := wdate[2] - 12;
        end;
        if (wdate[1] > 60) then
        begin
          wdate[0] := wdate[0] + 1;
          wdate[1] := wdate[1] - 60;
        end;
      end;
    end;
  end;
end;
//事件是否可以触发

function IsEventActive(snum, eventnum: integer): boolean;
begin
  Result := False;
  if (DData[snum, eventnum, 11] >= 0) and (TimeToNum >= DData[snum, eventnum, 11]) and
    (DData[snum, eventnum, 12] >= 0) and (DData[snum, eventnum, 15] = 0) then
  begin
    if (DData[snum, eventnum, 12] = 0) and (DData[snum, eventnum, 13] = 0) then
      Result := True
    else if DData[snum, eventnum, 12] > 0 then
    begin
      if DData[snum, eventnum, 13] > 0 then
      begin
        if ((TimeToNum - DData[snum, eventnum, 11]) mod DData[snum, eventnum, 13]) <= DData[snum, eventnum, 12] then
          Result := True;
      end
      else
      if (TimeToNum - DData[snum, eventnum, 11]) < DData[snum, eventnum, 12] then Result := True;
    end;

  end;
end;

//返回数值型的时间

function TimeToNum: integer;
begin
  Result := (wdate[0] - 1) * 360 * 60 + (wdate[1] - 1) * 360 + (wdate[2] - 1) * 30 + wdate[3];
end;


//日期增長，按時辰計算

procedure adddate(addday: integer);
var
  i: integer;
begin
  if (wdate[0] < 1) then
    wdate[0] := 1;

  if (wdate[1] < 1) then
    wdate[1] := 1;

  if (wdate[2] < 1) then
    wdate[2] := 1;

  if (wdate[3] < 1) then
    wdate[3] := 1;

  if (wdate[4] < 0) then
    wdate[0] := 0;

  wdate[4] := wdate[4] + addday;
  while ((wdate[1] > 60) or (wdate[2] > 12) or (wdate[3] > 30) or (wdate[4] > 47)) do
  begin

    if (wdate[4] > 47) then
    begin
      wdate[3] := wdate[3] + 1;
      wdate[4] := wdate[4] - 48;
      MyDiziLevelUp;
      daily;
      checktimeout;
      dalyrestore;
      if wdate[3] = 2 then initialmpmagic
      else if wdate[3] = 14 then newdizijoin
      else if wdate[3] = 15 then jisuanmenpaidata
      else if wdate[3] = 16 then airenming
      else if wdate[3] mod 3 = 2 then
        initialMPdiaodu
      else if wdate[3] mod 3 = 0 then
        AIMPBattle;
    end;
    if (wdate[3] > 30) then
    begin
      wdate[2] := wdate[2] + 1;
      wdate[3] := wdate[3] - 30;
      EnemyDiziLevelUp;
    end;
    if (wdate[2] > 12) then
    begin
      wdate[1] := wdate[1] + 1;
      wdate[2] := wdate[2] - 12;
    end;
    if (wdate[1] > 60) then
    begin
      wdate[0] := wdate[0] + 1;
      wdate[1] := wdate[1] - 60;
    end;
  end;
end;


//數字轉換為漢字

function inttohanzi(num: integer): WideString;
var
  a1, a2: WideString;
  ten, one, i: integer;
begin

  if num < 10 then
  begin
    case num of
      1: a1 := '壹';
      2: a1 := '貳';
      3: a1 := '叁';
      4: a1 := '肆';
      5: a1 := '伍';
      6: a1 := '陸';
      7: a1 := '柒';
      8: a1 := '捌';
      9: a1 := '玖';
    end;
  end
  else
  begin
    ten := num div 10;
    one := num mod 10;
    case ten of
      1: a1 := '壹拾';
      2: a1 := '貳拾';
      3: a1 := '叁拾';
      4: a1 := '肆拾';
      5: a1 := '伍拾';
      6: a1 := '陸拾';
      7: a1 := '柒拾';
      8: a1 := '捌拾';
      9: a1 := '玖拾';
    end;
    case one of
      1: a2 := '壹';
      2: a2 := '貳';
      3: a2 := '叁';
      4: a2 := '肆';
      5: a2 := '伍';
      6: a2 := '陸';
      7: a2 := '柒';
      8: a2 := '捌';
      9: a2 := '玖';
    end;
    a1 := a1 + a2;
  end;
  Result := a1;
end;

procedure daily;
var
  i, i1: integer;
begin

  for i := 1 to length(Rrole) - 1 do
    if (Rrole[i].dtime < 1000) and (Rrole[i].dtime > 0) then
    begin
      Dec(Rrole[i].dtime);
      if rrole[i].dtime <=0 then
      begin
        rrole[i].nweizhi:=-1;
      end;
      if (Rrole[i].dtime <= 0) and (Rrole[i].MenPai > 0) and
       (Rscene[Rrole[i].weizhi].menpai <> Rrole[i].MenPai) and (Rmenpai[Rrole[i].MenPai].zongduo > 0) then
      begin
        Rrole[i].weizhi := Rmenpai[Rrole[i].MenPai].zongduo;
      end;
    end;
  for i := 0 to length(SceAnpai) - 1 do
  begin
    setrole(i, -1, 0);
    for i1 := 0 to 12 do
      SceAnpai[i][i1] := -1;
  end;
  for i := 1 to length(Rrole) - 1 do
    if (Rrole[i].menpai > 0) and (Rrole[i].weizhi > 0) and (Rrole[i].dtime < 1) then
    begin
      anpai(i);
    end;

end;


//檢查任務超時

procedure checkTimeout;
var
  i, j, j1, t, len, len0, add1, SelectTeamList: integer;
  str: WideString;
begin
  t := timetonum;
  for i := 0 to length(DData) - 1 do
    for j := 0 to 399 do
    begin
      if (DData[i, j, 11] >= 0) and (DData[i, j, 14] > 0) and (DData[i, j, 15] = 0) then
        if (DData[i, j, 16] > 0) and (DData[i, j, 17] >= 0) then
          if (t - DData[i, j, 14] = DData[i, j, 16]) then
            CallEvent(DData[i, j, 17]);
    end;
  len := length(songli);
  if len > 0 then
  begin
    for i := 0 to len - 1 do
    begin
      if songli[i][2] = t then
      begin
        add1 := random(50) + 50;
        str := gbktounicode(@Rmenpai[songli[i][0]].Name) + '向' + gbktounicode(@Rmenpai[songli[i][1]].Name) +
          '送禮，兩家關係增加' + format('%4d', [add1]);
        addtips(str);
        changempgx(songli[i][0], songli[i][1], add1);
        if len > 1 then
          for j := i to len - 2 do
            for j1 := 0 to 2 do
              songli[j][j1] := songli[j + 1][j1];
        setlength(songli, len - 1);
        break;
      end;
    end;
  end;
  for i := 0 to 19 do
  begin
    if (mpbdata[i].key >= 0) and (mpbdata[i].daytime <> -1) then
    begin
      if (t >= mpbdata[i].daytime) then
      begin
        if (t = mpbdata[i].daytime) then
        begin
          str := gbktounicode(@Rmenpai[mpbdata[i].attmp].Name);
          str := str + '與' + gbktounicode(@Rmenpai[mpbdata[i].defmp].Name);
          str := str + '在' + gbktounicode(@Rscene[mpbdata[i].snum].Name) + '的爭鬥開始！';
          addtips(str);

          if (mpbdata[i].attmp = Rrole[0].MenPai) and (Rrole[0].weizhi = mpbdata[i].snum) then
          begin
            NewTalk(0, 205, -2, 0, 0, 0, 0, 1);
            timetompbattle(i, 0);
            gotommap(-1, -1);
            exit;
          end
          else if (mpbdata[i].defmp = Rrole[0].MenPai) and (Rrole[0].weizhi = mpbdata[i].snum) then
          begin
            NewTalk(Rrole[mpbdata[i].bteam[2].rolearr[0].rnum].headnum, 204, -2, 0, 0, 0, 0, 1);
            timetompbattle(i, 1);
            gotommap(-1, -1);
            exit;
          end;
        end;
        if ((mpbdata[i].attmp <> Rrole[0].MenPai) and (mpbdata[i].defmp <> Rrole[0].MenPai)) or
          (Rrole[0].weizhi <> mpbdata[i].snum) then
        begin
          AIfight(i);
        end;
      end;
    end;
  end;
  for i := RccRole.Count - 1 downto 0 do
  begin
    if RccRole.adds[i].Dtime <= t then
    begin
      instruct_3([RccRole.adds[i].snum, RccRole.adds[i].DNum, 0, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
      Ddata[RccRole.adds[i].snum,RccRole.adds[i].DNum,1]:=-1;
      Rrole[RccRole.adds[i].rnum].lsweizhi := -1;
      Rrole[RccRole.adds[i].rnum].lsnweizhi := -1;
      Rrole[RccRole.adds[i].rnum].lsfangxiang := 0;
      for j := i to RccRole.Count - 2 do
      begin
        RccRole.adds[j].Rnum := RccRole.adds[j + 1].Rnum;
        RccRole.adds[j].snum := RccRole.adds[j + 1].snum;
        RccRole.adds[j].Dnum := RccRole.adds[j + 1].Dnum;
        RccRole.adds[j].Dtime := RccRole.adds[j + 1].Dtime;
      end;
      setlength(RccRole.adds, RccRole.Count - 1);
      Dec(RccRole.Count);
    end;
  end;
end;

procedure timetompbattle(id, mods: integer);
var
  len, len0, i, i1, SelectTeamList: integer;
begin
  if mods in [0, 1] then
  begin
    len0 := 0;
    SelectTeamList := SelectTeamMembers;
    for i := 0 to 5 do
    begin
      if SelectTeamList and (1 shl (i + 1)) > 0 then
      begin
        setlength(mpbdata[id].bteam[0].rolearr, len0 + 1);
        mpbdata[id].bteam[0].rolearr[len0].rnum := TeamList[i];
        mpbdata[id].bteam[0].rolearr[len0].snum := Rrole[TeamList[i]].weizhi;
        mpbdata[id].bteam[0].rolearr[len0].isin := 0;
        Inc(len0);
      end;
    end;
    len := length(mpbdata[id].bteam[2 + mods].rolearr);
    setlength(mpbdata[id].bteam[0].rolearr, len0 + len);
    for i := len0 to len0 + len - 1 do
    begin
      if mpbdata[id].bteam[2 + mods].rolearr[i].rnum = 0 then
      begin
        if i < len0 + len - 1 then
        begin
          for i1 := i to len0 + len - 2 do
          begin
            mpbdata[id].bteam[2 + mods].rolearr[i1 - len0].rnum :=
              mpbdata[id].bteam[2 + mods].rolearr[i1 - len0 + 1].rnum;
            mpbdata[id].bteam[2 + mods].rolearr[i1 - len0].snum :=
              mpbdata[id].bteam[2 + mods].rolearr[i1 - len0 + 1].snum;
          end;
        end;
        setlength(mpbdata[id].bteam[2 + mods].rolearr, len0 + len - 1);
        Dec(len);
      end; //if
      mpbdata[id].bteam[0].rolearr[i].rnum := mpbdata[id].bteam[2 + mods].rolearr[i - len0].rnum;
      mpbdata[id].bteam[0].rolearr[i].snum := Rrole[mpbdata[id].bteam[2 + mods].rolearr[i - len0].rnum].weizhi;
      if Rrole[mpbdata[id].bteam[0].rolearr[i].rnum].CurrentHP <= 0 then
        mpbdata[id].bteam[0].rolearr[i].isin := 1
      else
        mpbdata[id].bteam[0].rolearr[i].isin := 0;
    end;
    len := length(mpbdata[id].bteam[3 - mods].rolearr);
    setlength(mpbdata[id].bteam[1].rolearr, len);
    for i := 0 to len - 1 do
    begin
      mpbdata[id].bteam[1].rolearr[i].rnum := mpbdata[id].bteam[3 - mods].rolearr[i].rnum;
      mpbdata[id].bteam[1].rolearr[i].snum := Rrole[mpbdata[id].bteam[3 - mods].rolearr[i].rnum].weizhi;
      if Rrole[mpbdata[id].bteam[1].rolearr[i].rnum].CurrentHP <= 0 then
        mpbdata[id].bteam[1].rolearr[i].isin := 1
      else
        mpbdata[id].bteam[1].rolearr[i].isin := 0;
    end;
    clearrole(mpbdata[id].snum, -1);
    Battle(0, 0, -3 + mods, id);
  end;
end;


//新添加的，本门派弟子成长的过程

procedure MyDiziLevelUp;
var
  i, j, j1, j2, k, k1, k2, n, mpnum, tm, ltmp, Aptitude, miji, tneigong, zhiwujc6, zhiwujc7,
  zhiwujc9, mnum, nolw, lwstatus, nnum, lwnum, p, mexp: integer;
  tmp, lv: array[0..29] of integer;
  str: WideString;
  key: boolean;
  db1, db2: double;
begin
  mpnum := Rrole[0].menpai;
  for i := 0 to length(Rrole) - 1 do
  begin
    if Rrole[i].menpai = mpnum then
    begin
      if Rmenpai[mpnum].zhiwu[9] >= 0 then
        zhiwujc9 := Rrole[Rmenpai[mpnum].zhiwu[9]].Repute * Rrole[Rmenpai[mpnum].zhiwu[9]].level div 300
      else zhiwujc9 := 0;
      if Rmenpai[mpnum].zhiwu[7] >= 0 then
        zhiwujc7 := Rrole[Rmenpai[mpnum].zhiwu[7]].Repute * Rrole[Rmenpai[mpnum].zhiwu[7]].level div 300
      else zhiwujc7 := 0;
      if Rmenpai[mpnum].zhiwu[6] >= 0 then
        zhiwujc6 := Rrole[Rmenpai[mpnum].zhiwu[6]].Repute * Rrole[Rmenpai[mpnum].zhiwu[6]].level div 300
      else zhiwujc6 := 0;
      if (Rrole[i].nweizhi >= 0) and (Rrole[i].nweizhi <= 4) then
      begin
        Inc(Rrole[i].exp, round((Rrole[i].level * 2 + 20) * (100 + random(100)) * (100 + zhiwujc6) / 25000));
        Rrole[i].Exp := min(Rrole[i].Exp, 35000);
        Inc(Rrole[i].ExpForBook, round((Rrole[i].level * 2 + 20) * (100 + random(100)) *
          (100 + zhiwujc6) * 4 / 125000));
        Rrole[i].ExpForBook := min(Rrole[i].ExpForBook, 30000);
        while (Rrole[i].Level < MAX_LEVEL) and (uint16(Rrole[i].Exp) >= uint16(LevelUplist[Rrole[i].Level - 1])) do
        begin
          Rrole[i].Exp := Rrole[i].Exp - LevelUplist[Rrole[i].Level - 1];
          Rrole[i].Level := Rrole[i].Level + 1;
          LevelUp2(i);
        end;
        CheckBook;
        n := 0;
        for k := 0 to 29 do
        begin
          if Rrole[i].lmagic[k] <= 0 then break;
          if (Rrole[i].maglevel[k] >= 100) and (Rrole[i].maglevel[k] < 900) and
            (Rmagic[Rrole[i].lmagic[k]].magictype <> 5) then
          begin
            tmp[n] := k;
            Inc(n);
          end;
        end;

        if n > 0 then
        begin
          tm := random(n);
          ltmp := Rrole[i].maglevel[tmp[tm]];
          mexp := round((Rrole[i].level div 3 + 10) * (100 + random(100)) * (100 + zhiwujc6) / 30000);
          Inc(Rrole[i].maglevel[tmp[tm]], mexp);
          mnum := Rrole[i].lmagic[tmp[tm]];
          if Rrole[i].maglevel[tmp[tm]] > 999 then
            Rrole[i].maglevel[tmp[tm]] := 999;

          if ((Rrole[i].maglevel[tmp[tm]] div 100) > (ltmp div 100)) then
          begin
            EatOneItem(i, Rmagic[mnum].miji, False);
            str := '【門派公告】' + gbktounicode(@Rrole[i].Name) + '的' + gbktounicode(
              @(Rmagic[Rrole[i].lmagic[tmp[tm]]].Name)) + '升級為' +
              IntToStr(Rrole[i].maglevel[tmp[tm]] div 100 + 1) + '級';
            addtips(str);
          end;


          nolw := 0;
          lwstatus := 0;
          nnum := 0;
          for j1 := 0 to 4 do
          begin
            if Rmagic[mnum].zhaoshi[j1] <= 0 then
              break;
            Inc(nolw);

          end;
          nolw := nolw - 1;
          lwstatus := Rrole[i].lzhaoshi[tmp[tm]];
          for j1 := 0 to nolw do
            if (lwstatus and (1 shl j1)) = 0 then
              Inc(nnum);
          if nnum > 0 then
          begin
            if CheckEquipSet(Rrole[i].equip[0], Rrole[i].equip[1], Rrole[i].equip[2], Rrole[i].equip[3]) = 2 then
              Aptitude := 100
            else Aptitude := Rrole[i].Aptitude;
            if Ritem[Rmagic[mnum].miji].NeedAptitude >= 0 then
              Aptitude := 2 + Aptitude - Ritem[Rmagic[mnum].miji].NeedAptitude
            else
              Aptitude := 2 - 2 * (Ritem[Rmagic[mnum].miji].NeedAptitude + Aptitude);
            for j1 := 0 to (mexp div 4) do
            begin
              if random(5000) < Aptitude then
              begin
                lwnum := random(nnum);
                Rrole[i].MagLevel[tmp[tm]] := Rrole[i].MagLevel[tmp[tm]] + 100;
                if Rrole[i].MagLevel[tmp[tm]] < 1000 then
                begin
                  EatOneItem(i, Rmagic[mnum].miji, False);
                end;
                if Rrole[i].maglevel[tmp[tm]] > 999 then
                  Rrole[i].maglevel[tmp[tm]] := 999;
                p := 0;
                for j2 := 0 to nolw do
                  if (lwstatus and (1 shl j2)) = 0 then
                  begin
                    Inc(p);
                    if p > lwnum then
                      break;
                  end;
                EatOneItem(i, Rmagic[mnum].miji, False);
                Rrole[i].lzhaoshi[tmp[tm]] := Rrole[i].lzhaoshi[tmp[tm]] or (1 shl j2);

                str := GBKtoUnicode(@Rrole[i].Name);
                str := str + '領悟';
                str := str + GBKtoUnicode(@Rzhaoshi[Rmagic[mnum].zhaoshi[j2]].Name);

                addtips(str);
                break;
              end;
            end;
          end;
        end;
      end
      else if (Rrole[i].nweizhi >= 5) and (Rrole[i].nweizhi <= 9) then
      begin
        n := 0;
        for k := 0 to 29 do
        begin
          if Rrole[i].lmagic[k] <= 0 then break;
          if (Rrole[i].maglevel[k] < 400) and (Rrole[i].maglevel[k] >= 0) and
            (Rmagic[Rrole[i].lmagic[k]].magictype <> 5) then
          begin
            tmp[n] := k;
            Inc(n);
          end;
        end;

        if n > 0 then
        begin

          tm := random(n);
          ltmp := Rrole[i].maglevel[tmp[tm]];
          Inc(Rrole[i].maglevel[tmp[tm]], round((Rrole[0].level * 3 + 30 - ltmp div 10) * (100 + random(100)) *
            (100 + zhiwujc6) / 25000));

          if Rrole[i].maglevel[tmp[tm]] > 999 then
            Rrole[i].maglevel[tmp[tm]] := 999;
          if ((Rrole[i].maglevel[tmp[tm]] div 100) > (ltmp div 100)) then
          begin
            EatOneItem(i, Rmagic[Rrole[i].lmagic[tmp[tm]]].miji, False);
            str := '【門派公告】' + gbktounicode(@Rrole[i].Name) + '的' + gbktounicode(
              @(Rmagic[Rrole[i].lmagic[tmp[tm]]].Name)) + '升級為' +
              IntToStr(Rrole[i].maglevel[tmp[tm]] div 100 + 1) + '級';
            addtips(str);
          end;
        end
        else if ((Rmenpai[mpnum].zmr <> 0) or (Rmenpai[mpnum].zhiwu[6] >= 0)) and
          ((random(7500) < Rrole[i].msq) or (Rrole[i].lmagic[0] < 1)) then
        begin
          if (random(200) >= Rrole[i].msq) and (Rrole[i].lmagic[0] < 1) then
          begin
            Inc(Rrole[i].exp, round((Rrole[i].level * 4 + 40) * (100 + random(100)) * (100 + zhiwujc6) / 25000));
            Rrole[i].Exp := min(Rrole[i].Exp, 35000);

          end
          else
          begin
            for k := 0 to 399 do
            begin
              p := 0;
              if Rmpmagic[mpnum][k] <= 0 then break;
              if not (CanEquip(i, Rmagic[Rmpmagic[mpnum][k]].miji)) then continue;
              for k1 := 0 to 29 do
              begin
                if Rrole[i].lmagic[k1] = Rmpmagic[mpnum][k] then break;
                if Rrole[i].lmagic[k1] <= 0 then
                begin
                  Rrole[i].lmagic[k1] := Rmpmagic[mpnum][k];
                  EatOneItem(i, Rmagic[Rrole[i].lmagic[k1]].miji, False);
                  str := '【門派公告】' + gbktounicode(@Rrole[i].Name) + '學會' +
                    gbktounicode(@(Rmagic[Rrole[i].lmagic[k1]].Name));
                  addtips(str);
                  p := 1;
                  break;
                end;
              end;
              if p = 1 then
                break;
            end;
          end;
        end
        else if (Rmenpai[mpnum].zmr = 0) then
        begin
          n := 0;
          for k := 0 to 29 do
          begin
            if Rrole[i].lmagic[k] <= 0 then break;
            for k1 := 0 to 399 do
            begin
              if Rrole[i].lmagic[k] = rmpmagic[mpnum][k1] then break;
              if rmpmagic[mpnum][k1] < 0 then
              begin
                for k2 := 0 to MAX_ITEM_AMOUNT - 1 do
                begin
                  if Ritemlist[k2].number = Rmagic[Rrole[i].lmagic[k]].miji then break;
                  if Ritemlist[k2].number < 0 then
                  begin
                    tmp[n] := Rrole[i].lmagic[k];
                    lv[n] := Rrole[i].maglevel[k] div 100;
                    Inc(n);
                    break;
                  end;
                end;
                break;
              end;
            end;
          end;
          if CheckEquipSet(Rrole[i].equip[0], Rrole[i].equip[1], Rrole[i].equip[2], Rrole[i].equip[3]) = 2 then
            Aptitude := 100
          else Aptitude := Rrole[i].Aptitude;
          if (n > 0) then
          begin
            tm := random(n);
            if (randomf1 < 1 + Aptitude * lv[tm] * (100 + zhiwujc9) div 270) then
            begin
              instruct_32(Rmagic[tmp[tm]].miji, 1);
              str := '【門派公告】' + gbktounicode(@Rrole[i].Name) + '寫出' +
                gbktounicode(@(Ritem[Rmagic[tmp[tm]].miji].Name));
              addtips(str);
              Redraw;
            end;
          end;
        end;
      end
      else if (Rrole[i].nweizhi = 10) then
      begin
        n := 0;
        for k := 0 to 29 do
        begin
          if Rrole[i].lmagic[k] <= 0 then break;
          if (Rmagic[Rrole[i].lmagic[k]].magictype = 5) and ((Rrole[i].maglevel[k] div 100) <
            Rmagic[Rrole[i].lmagic[k]].MaxLevel) then
          begin
            tmp[n] := k;

            Inc(n);
          end;
        end;
        if n > 0 then
        begin
          tm := random(n);
          ltmp := Rrole[i].maglevel[tmp[tm]];
          Inc(Rrole[i].maglevel[tmp[tm]], round((Rrole[i].level div 3 + 10) * (100 + random(100)) *
            (100 + zhiwujc9) / 50000));
          if Rrole[i].maglevel[tmp[tm]] div 100 > Rmagic[Rrole[i].lmagic[tm]].MaxLevel then
            Rrole[i].maglevel[tmp[tm]] := Rmagic[Rrole[i].lmagic[tm]].MaxLevel * 100;
          if ((Rrole[i].maglevel[tmp[tm]] div 100) > (ltmp div 100)) then
          begin
            EatOneItem(i, Rmagic[Rrole[i].lmagic[tmp[tm]]].miji, False);
            str := '【門派公告】' + gbktounicode(@Rrole[i].Name) + '的' + gbktounicode(
              @(Rmagic[Rrole[i].lmagic[tmp[tm]]].Name)) + '升級為' +
              IntToStr(Rrole[i].maglevel[tmp[tm]] div 100 + 1) + '級';
            addtips(str);
            Redraw;
          end;
        end
        else
        begin
          n := 0;
          for k := 0 to 29 do
          begin
            if Rrole[i].lmagic[k] <= 0 then break;
            if Rmagic[Rrole[i].lmagic[k]].magictype = 5 then
            begin
              for k1 := 0 to 9 do
              begin
                if Rmenpai[mpnum].neigong[k1] <= 0 then break;
                if Rmenpai[mpnum].neigong[k1] = Rrole[i].lmagic[k] then
                begin
                  tmp[n] := Rrole[i].lmagic[k];
                  lv[n] := Rrole[i].maglevel[k] div 100;
                  Inc(n);
                  break;
                end;
              end;
            end;
          end;
          if n > 0 then
          begin
            tm := random(n);
            tneigong := tmp[tm];
            key := False;
            if CheckEquipSet(Rrole[i].equip[0], Rrole[i].equip[1], Rrole[i].equip[2], Rrole[i].equip[3]) = 2 then
              Aptitude := 100
            else Aptitude := Rrole[i].Aptitude;
            for k := 0 to 29 do
            begin
              if Rrole[i].lmagic[k] <= 0 then break;
              if (Rmagic[Rrole[i].lmagic[k]].magictype <> 5) then
              begin
                if (Rmagic[Rrole[i].lmagic[k]].teshu[0] = 0) and ((Rmagic[Rrole[i].lmagic[k]].teshumod[0] = -1)) then
                  continue;
                for k1 := 0 to 9 do
                begin
                  if (Rmagic[Rrole[i].lmagic[k]].teshu[k1] = tneigong) and
                    ((Rmagic[Rrole[i].lmagic[k]].teshumod[k1] = 0) or
                    (Rmagic[Rrole[i].lmagic[k]].teshumod[k1] = mpnum)) then
                    break;
                  if Rmagic[Rrole[i].lmagic[k]].teshu[k1] = 0 then
                  begin
                    if randomf1 < (1 + (1 + Aptitude) * lv[tm] * (100 + zhiwujc9) div 360) then
                    begin
                      Rmagic[Rrole[i].lmagic[k]].teshu[k1] := tneigong;
                      Rmagic[Rrole[i].lmagic[k]].teshumod[k1] := mpnum;
                      str := '【門派公告】' + gbktounicode(@Rrole[i].Name) + '將' +
                        gbktounicode(@(Rmagic[tneigong].Name)) + '與' +
                        gbktounicode(@(Rmagic[Rrole[i].lmagic[k]].Name)) + '融會貫通';
                      addtips(str);
                      key := True;
                    end;
                    break;
                  end;
                end;
              end;
              if key then break;
            end;
          end;
        end;
      end
      else if (Rrole[i].nweizhi = 11) and (Rmenpai[mpnum].zmr = 0) then
      begin
        key := False;
        k2 := 0;
        while not (key) and (k2 < 5) do
        begin
          k := randomyaopin(0);
          if k < 0 then break;
          for k1 := 0 to 4 do
          begin
            if Ritem[k].NeedItem[k1] < 0 then
            begin
              key := True;
              break;
            end;
            if Ritem[k].NeedMatAmount[k1] > Rmenpai[mpnum].ziyuan[Ritem[k].NeedItem[k1]] then
            begin
              break;
            end;
            if k1 = 4 then key := True;
          end;
          Inc(k2);
        end;
        if (key) then
        begin
          for k1 := 0 to 4 do
          begin
            if Ritem[k].NeedItem[k1] < 0 then
            begin
              break;
            end;
            Dec(Rmenpai[mpnum].ziyuan[Ritem[k].NeedItem[k1]], Ritem[k].NeedMatAmount[k1]);
          end;
          db1 := Rrole[i].level * Rrole[i].fuyuan;
          db2 := Ritem[k].rate * (100 + zhiwujc7);
          db1 := db1 * db2 / 200000;
          if (random(100) < db1) then
          begin
            instruct_32(k, 1);
            str := '【門派公告】' + gbktounicode(@Rrole[i].Name) + '煉製出' + gbktounicode(@(Ritem[k].Name));
            addtips(str);
          end;
        end;
      end
      else if (Rrole[i].nweizhi = 12) and (Rmenpai[mpnum].zmr = 0) then
      begin
        key := False;
        k2 := 0;
        while not (key) and (k2 < 5) do
        begin
          k := randomzhuangbei(0);
          if k < 0 then break;
          for k1 := 0 to 4 do
          begin
            if Ritem[k].NeedItem[k1] < 0 then
            begin
              key := True;
              break;
            end;
            if Ritem[k].NeedMatAmount[k1] > Rmenpai[mpnum].ziyuan[Ritem[k].NeedItem[k1]] then
            begin
              break;
            end;
            if k1 = 4 then key := True;
          end;
          Inc(k2);
        end;
        if (key) then
        begin
          for k1 := 0 to 4 do
          begin
            if Ritem[k].NeedItem[k1] < 0 then
            begin
              break;
            end;
            Dec(Rmenpai[mpnum].ziyuan[Ritem[k].NeedItem[k1]], Ritem[k].NeedMatAmount[k1]);
          end;
          db1 := Rrole[i].level * Rrole[i].fuyuan;
          db2 := Ritem[k].rate * (100 + zhiwujc7);
          db1 := db1 * db2 / 200000;
          if (random(100) < db1) then
          begin
            instruct_32(k, 1);
            str := '【門派公告】' + gbktounicode(@Rrole[i].Name) + '製造出' + gbktounicode(@(Ritem[k].Name));
            addtips(str);
          end;
        end;
      end;
    end;
  end;
end;

//其他门派弟子成长的过程

procedure EnemyDiziLevelUp;
var
  i, j, j1, j2, k, k1, mp0, n, n1, n2, tm, tm1, tm2, mpnum, tneigong, Aptitude, mnum, nolw,
  lwstatus, nnum, lwnum, p, ltmp: integer;
  tmp, tmp1, tmp2, lv: array[0..29] of integer;
  str: WideString;
  db1, db2, db3, db4: double;
  now: uint32;
begin

  mp0 := Rrole[0].menpai;
  for i := 0 to length(Rrole) - 1 do
  begin
    if (Rrole[i].menpai <> mp0) and (Rrole[i].menpai > 0) and (Rrole[i].menpai < 40) then
    begin
      mpnum := Rrole[i].menpai;
      db1 := (Rrole[i].level * 2 + 20) * (100 + random(100));
      db2 := Rrole[i].lwq * (Rmenpai[mpnum].czsd);
      db3 := mpzyjc(mpnum) * 30 * 8 / Rmenpai[mpnum].dizi;
      db4 := db1 * db2 * db3 / 250000000;
      Inc(Rrole[i].exp, round(db4));
      Rrole[i].Exp := min(Rrole[i].Exp, 35000);

      while (Rrole[i].Level < MAX_LEVEL) and (uint16(Rrole[i].Exp) >= uint16(LevelUplist[Rrole[i].Level - 1])) do
      begin
        Rrole[i].Exp := Rrole[i].Exp - LevelUplist[Rrole[i].Level - 1];
        Rrole[i].Level := Rrole[i].Level + 1;
        LevelUp2(i);
      end;

      n := 0;
      n1 := 0;
      n2 := 0;

      for k := 0 to 29 do
      begin
        if Rrole[i].lmagic[k] <= 0 then break;
        if (Rrole[i].maglevel[k] >= 100) and (Rrole[i].maglevel[k] < 900) and
          (Rmagic[Rrole[i].lmagic[k]].magictype <> 5) then
        begin
          tmp[n] := k;
          Inc(n);
        end;
        if (Rrole[i].maglevel[k] < 400) and (Rrole[i].maglevel[k] >= 0) and
          (Rmagic[Rrole[i].lmagic[k]].magictype <> 5) then
        begin
          tmp1[n1] := k;
          Inc(n1);
        end;
        if (Rmagic[Rrole[i].lmagic[k]].magictype = 5) and ((Rrole[i].maglevel[k] div 100) <
          Rmagic[Rrole[i].lmagic[k]].maxlevel) then
        begin
          tmp2[n2] := k;
          Inc(n2);
        end;
      end;
      if n > 0 then
      begin
        for j := 0 to 29 do
        begin
          if (random(100) > Rrole[i].lwq) and (random(Rmenpai[mpnum].dizi) > 7) then
            continue;
          tm := random(n);
          ltmp := Rrole[i].maglevel[tmp[tm]] div 100;
          db1 := (Rrole[i].level div 3 + 10) * (100 + random(100));
          db2 := (Rmenpai[mpnum].czsd) * mpzyjc(mpnum);
          db3 := db1 * db2 / 3000000;
          Inc(Rrole[i].maglevel[tmp[tm]], round(db3));
          mnum := Rrole[i].lmagic[tmp[tm]];

          if Rrole[i].maglevel[tmp[tm]] > 999 then
            Rrole[i].maglevel[tmp[tm]] := 999;

          if (Rrole[i].maglevel[tmp[tm]] div 100) > ltmp then
          begin
            EatOneItem(i, Rmagic[mnum].miji, False);
          end;

          nolw := 0;
          lwstatus := 0;
          nnum := 0;
          for j1 := 0 to 4 do
          begin
            if Rmagic[mnum].zhaoshi[j1] <= 0 then
              break;
            Inc(nolw);

          end;
          nolw := nolw - 1;
          lwstatus := Rrole[i].lzhaoshi[tmp[tm]];
          for j1 := 0 to nolw do
            if (lwstatus and (1 shl j1)) = 0 then
              Inc(nnum);
          if nnum > 0 then
          begin
            if CheckEquipSet(Rrole[i].equip[0], Rrole[i].equip[1], Rrole[i].equip[2], Rrole[i].equip[3]) = 2 then
              Aptitude := 100
            else Aptitude := Rrole[i].Aptitude;
            if Ritem[Rmagic[mnum].miji].NeedAptitude >= 0 then
              Aptitude := 2 + Aptitude - Ritem[Rmagic[mnum].miji].NeedAptitude
            else
              Aptitude := 2 - (Ritem[Rmagic[mnum].miji].NeedAptitude + Aptitude);
            for j1 := 0 to (round(db3) div 4) do
            begin
              if random(5000) < Aptitude then
              begin
                lwnum := random(nnum);
                Rrole[i].MagLevel[tmp[tm]] := Rrole[i].MagLevel[tmp[tm]] + 100;
                if Rrole[i].MagLevel[tmp[tm]] < 1000 then
                begin
                  EatOneItem(i, Rmagic[mnum].miji, False);
                end;
                if Rrole[i].maglevel[tmp[tm]] > 999 then
                  Rrole[i].maglevel[tmp[tm]] := 999;
                p := 0;
                for j2 := 0 to 4 do
                  if (lwstatus and (1 shl j2)) = 0 then
                  begin
                    Inc(p);
                    if p > lwnum then
                      break;
                  end;
                Rrole[i].lzhaoshi[tmp[tm]] := Rrole[i].lzhaoshi[tmp[tm]] or (1 shl j2);
                EatOneItem(i, Rmagic[mnum].miji, False);
                break;
              end;
            end;
          end;
        end;
      end;
      if n1 > 0 then
      begin
        for j := 0 to 29 do
        begin
          if (random(100) > Rrole[i].msq) and (random(Rmenpai[mpnum].dizi) > 7) then
            continue;
          tm1 := random(n1);
          ltmp := Rrole[i].maglevel[tmp1[tm1]] div 100;
          db1 := (Rrole[i].level * 3 + 30 - ltmp * 11) * (100 + random(100));
          db2 := (Rmenpai[Rrole[i].menpai].czsd) * mpzyjc(Rrole[i].menpai);
          db3 := db1 * db2 / 3000000;
          Inc(Rrole[i].maglevel[tmp1[tm1]], round(db3));
          if Rrole[i].maglevel[tmp1[tm1]] > 999 then
            Rrole[i].maglevel[tmp1[tm1]] := 999;
          if (Rrole[i].maglevel[tmp1[tm1]] div 100) > ltmp then
          begin
            EatOneItem(i, Rmagic[Rrole[i].lmagic[tmp1[tm1]]].miji, False);
          end;
        end;
      end;
      if n2 > 0 then
      begin
        for j := 0 to 29 do
        begin
          if (random(100) > Rrole[i].msq) and (random(Rmenpai[mpnum].dizi) > 1) then
            continue;
          tm2 := random(n2);
          ltmp := Rrole[i].maglevel[tmp2[tm2]] div 100;
          db1 := (Rrole[i].level div 3 + 10) * (100 + random(100));
          db2 := (Rmenpai[Rrole[i].menpai].czsd) * mpzyjc(Rrole[i].menpai);
          db3 := db1 * db2 / 5000000;
          Inc(Rrole[i].maglevel[tmp2[tm2]], round(db3));
          if Rrole[i].maglevel[tmp2[tm2]] > (Rmagic[Rrole[i].lmagic[tmp2[tm2]]].maxlevel * 100) then
            Rrole[i].maglevel[tmp2[tm2]] := Rmagic[Rrole[i].lmagic[tmp2[tm2]]].maxlevel * 100;
          if ((Rrole[i].maglevel[tmp2[tm2]] div 100) > ltmp) then
          begin
            EatOneItem(i, Rmagic[Rrole[i].lmagic[tmp2[tm2]]].miji, False);
          end;
        end;
      end;
      if random(100) < Rrole[i].msq then
      begin
        n := 0;
        for k := 0 to 29 do
        begin
          if Rrole[i].lmagic[k] <= 0 then break;
          if Rmagic[Rrole[i].lmagic[k]].magictype = 5 then
          begin
            for k1 := 0 to 9 do
            begin
              if Rmenpai[mpnum].neigong[k1] <= 0 then break;
              tmp[n] := Rrole[i].lmagic[k];
              lv[n] := Rrole[i].maglevel[k] div 100;
              Inc(n);
              break;
            end;
          end;
        end;
        if (n > 0) then
        begin
          tm := random(n);
          tneigong := tmp[tm];
          if CheckEquipSet(Rrole[i].equip[0], Rrole[i].equip[1], Rrole[i].equip[2], Rrole[i].equip[3]) = 2 then
            Aptitude := 100
          else Aptitude := Rrole[i].Aptitude;
          for k := 0 to 29 do
          begin
            if Rrole[i].lmagic[k] <= 0 then break;
            if (Rmagic[Rrole[i].lmagic[k]].magictype <> 5) then
            begin
              if (Rmagic[Rrole[i].lmagic[k]].teshu[0] = 0) and ((Rmagic[Rrole[i].lmagic[k]].teshumod[0] = -1)) then
                continue;
              for k1 := 0 to 9 do
              begin
                if (Rmagic[Rrole[i].lmagic[k]].teshu[k1] = tneigong) and
                  ((Rmagic[Rrole[i].lmagic[k]].teshumod[k1] = 0) or
                  (Rmagic[Rrole[i].lmagic[k]].teshumod[k1] = mpnum)) then
                  break;
                if Rmagic[Rrole[i].lmagic[k]].teshu[k1] = 0 then
                begin
                  if random(10000) < (1 + ((1 + Aptitude) * lv[tm] * mpzyjc(Rrole[i].menpai) div 360)) then
                  begin
                    Rmagic[Rrole[i].lmagic[k]].teshu[k1] := tneigong;
                    Rmagic[Rrole[i].lmagic[k]].teshumod[k1] := mpnum;
                  end;
                  break;
                end;
              end;
            end;
          end;
        end;
      end;
      if (Rrole[i].menpai > 0) and (Rrole[i].menpai < 40) and
        ((random(300) < Rrole[i].msq * Rmenpai[Rrole[i].menpai].czsd * mpzyjc(Rrole[i].menpai) div 10000) or
        (Rrole[i].lmagic[0] < 1)) then
      begin
        for k := 0 to 399 do
        begin
          if (Rmpmagic[mpnum][k] < 0) then break;
          if not (CanEquip(i, Rmagic[Rmpmagic[mpnum][k]].miji)) then continue;
          for k1 := 0 to 29 do
          begin
            if Rrole[i].lmagic[k1] = Rmpmagic[mpnum][k] then break;
            if Rrole[i].lmagic[k1] <= 0 then
            begin
              Rrole[i].lmagic[k1] := Rmpmagic[mpnum][k];
              break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

//获取角色武功的数量

function GetRoleMagicNumber(num: integer): shortint;
var
  i: shortint;
begin
  i := 0;
  while ((i < 30) and (Rrole[num].lmagic[i] > 0)) do
  begin
    Inc(i);
  end;
  Result := i;
end;

//获取门派武功的数量

function GetMenpaiMagicNumber(num: integer): shortint;
var
  i: shortint;
begin
  i := 0;
  while ((i < 20) and (rmenpai[num].neigong[i] <> -1)) do
  begin
    Inc(i);
  end;
  Result := i;
end;

//学习新的门派内功

procedure RoleLearnNewMenpaiMagic(num: integer);
var
  i, j, k: shortint;
  flag: boolean;
begin
  flag := True;
  j := rmenpai[Rrole[num].menpai].neigong[random(GetMenpaiMagicNumber(Rrole[num].menpai))];
  k := GetRoleMagicNumber(num);
  if (k >= 30) or (j = -1) then
    exit;
  for i := 0 to k - 1 do
  begin
    if Rrole[num].lmagic[i] = j then
      flag := False;
  end;
  if flag then
    Rrole[num].lmagic[k] := j;
end;
//拼音輸入法

function pinyinshuru(msg: WideString): WideString;
var
  f: textfile;
  tmp, filename: string;
  py, str: WideString; //输入的拼音
  npy, ctmp: char;
  p0, p1: pchar;
  i, j, k, k1, readf: integer;
  ye: integer; //记录选字处于哪一页
  fdata: array[0..65597] of byte;
  pyw: array[0..8000] of pyword; //保存汉字-拼音列表
  pp: array[0..200] of array[0..1] of char; //与输入拼音匹配的汉字
  houxuan: array[0..8] of array[0..1] of char;
  hxtmp: array[0..3] of char; //选字状态下，候选字符
  Name: array[0..9] of char;
  state: integer; //输入状态，0处于汉字，1处于拼音输入；2处于选字;3提醒
  //--------
begin
  //LoadR(0);
  //显示输入姓名的对话框
  //form1.ShowModal;
  //str := form1.edit1.text;
  //str := '请输入拼音后按空格键选字';
  //name := InputBox('Enter name', str, '我是主角');
  //str1 := unicodetobig5(@name[1]);
  //-------------------------------------


  filename := 'biao';
  readf := FileOpen(filename, fmopenread);
  FileSeek(readf, 0, 0);
  FileRead(readf, fdata[0], 65598);
  FileClose(readf);
  i := 0;
  k := 0;
  k1 := 0;
  while i < 65598 do
  begin
    if (fdata[i] = 13) and (fdata[i + 1] = 10) then
    begin
      if (k mod 2) = 0 then
      begin
        pyw[k div 2].hanzi[k1] := char(0);
        pyw[k div 2].hanzi[k1 + 1] := char(0);
      end
      else
      begin
        pyw[k div 2].pinyin[k1] := char(0);
        pyw[k div 2].pinyin[k1 + 1] := char(0);
      end;
      i := i + 1;
      k1 := 0;
      Inc(k);
    end
    else if (k mod 2) = 0 then
    begin
      pyw[k div 2].hanzi[k1] := char(fdata[i]);
      Inc(k1);
    end
    else if (k mod 2) = 1 then
    begin
      pyw[k div 2].pinyin[k1] := char(fdata[i]);
      Inc(k1);
    end;
    Inc(i);
  end;
  FillChar(Name, SizeOf(Name), 0);

  state := 0;
  Redraw;
  DrawRectangle(15, 300, 540, 50, 0, ColColor(255), 70);
  DrawShadowText(@msg[1], 25, 305, 18, ColColor(22), ColColor(24));
  str := '輸入拼音后按空格出字，按"-,="翻頁，完畢后按回車開始遊戲';
  DrawShadowText(@str[1], 25, 330, 18, ColColor(22), ColColor(24));
  DrawRectangle(15, 355, 540, 80, 0, ColColor(255), 70);
  str := '姓名：';
  DrawShadowText(@str[1], 25, 360, ColColor(33), ColColor(35));
  //str := '请输入拼音后按空格键选字';
  //drawshadowtext(@str[1], 32,  320, colcolor($66), colcolor($63));
  //str := '姓名输入完毕后按回车开始游戏';
  //drawshadowtext(@str[1], 32,  340, colcolor($66), colcolor($63));
  //sdl_updaterect(screen, 0, 0, screen.w, screen.h);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  SDL_EnableKeyRepeat(0, 10);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      //键盘事件
      SDL_KEYUP:
      begin
        //输入a-z
        if ((event.key.keysym.sym > 96) and (event.key.keysym.sym < 123) and (state < 2)) then
        begin
          if state = 0 then
          begin
            py := '';
            state := 1;
          end;
          npy := chr(event.key.keysym.sym);
          py := py + npy;
        end;
        //输入BACKSPACE，删除
        if ((event.key.keysym.sym = 8) and (state < 2)) then
        begin
          if state = 0 then
          begin
            for i := 1 to 9 do
              if ((Name[i] = char(0)) and (Name[i - 1] = char(0)) and (i mod 2 = 1)) then break;
            if i > 2 then
            begin
              Name[i - 2] := char(0);
              Name[i - 3] := char(0);
            end;
          end
          else
          begin
            Delete(py, length(py), 1);
            if length(py) = 0 then state := 0;
          end;
        end;
        //输入空格，进入选字
        if ((event.key.keysym.sym = SDLK_SPACE) and (state = 1)) then
        begin
          j := 0;
          for i := 0 to 8000 do
          begin
            if widesametext(py, pyw[i].pinyin) then
            begin
              pp[j][0] := pyw[i].hanzi[0];
              pp[j][1] := pyw[i].hanzi[1];
              j := j + 1;
            end;
          end;
          for i := 0 to 8 do
          begin
            if ((pp[i][0] <> char(0)) or (pp[i][1] <> char(0))) then
            begin
              houxuan[i][0] := pp[i][0];
              houxuan[i][1] := pp[i][1];
            end;
          end;
          ye := 0;
          state := 2;
        end;
        //输入-=，选字翻页
        if ((event.key.keysym.sym = SDLK_MINUS) or (event.key.keysym.sym = SDLK_EQUALS) and (state = 2)) then
        begin
          if (event.key.keysym.sym = SDLK_MINUS) and (ye > 0) then ye := ye - 1;
          if ((pp[9 * (ye + 1)][0] <> char(0)) or (pp[9 * (ye + 1)][1] <> char(0))) and
            (event.key.keysym.sym = SDLK_EQUALS) then ye := ye + 1;
          for i := 0 to 8 do
          begin
            if (pp[i + 9 * ye][0] <> char(0)) or (pp[i + 9 * ye][1] <> char(0)) then
            begin
              houxuan[i][0] := pp[i + 9 * ye][0];
              houxuan[i][1] := pp[i + 9 * ye][1];
            end;
          end;
        end;
        //输入1-9，选字
        if ((event.key.keysym.sym > 48) and (event.key.keysym.sym < 58) and ((state = 2) or (state = 3))) then
        begin
          for i := 1 to 9 do
            if (Name[i] = char(0)) and (Name[i - 1] = char(0)) and (i mod 2 = 1) then break;
          if i < 8 then
          begin
            Name[i - 1] := houxuan[event.key.keysym.sym - 49][0];
            Name[i] := houxuan[event.key.keysym.sym - 49][1];
          end;
          FillChar(py, SizeOf(py), 0);
          FillChar(pp, SizeOf(pp), 0);
          FillChar(houxuan, SizeOf(houxuan), 0);
          state := 0;
        end;
        //输入回车，结束输入法
        if ((event.key.keysym.sym = SDLK_RETURN) and (state = 0)) then
        begin
          for i := 1 to 9 do
            if (Name[i] = char(0)) and (Name[i - 1] = char(0)) and (i mod 2 = 1) then break;
          if (i < 4) and (i > 1) then
          begin
            state := 3;
          end
          else break;
        end;
      end;
    end;
    Redraw;
    DrawRectangle(15, 300, 540, 50, 0, ColColor(255), 70);
    DrawShadowText(@msg[1], 25, 305, 18, ColColor(22), ColColor(24));
    str := '輸入拼音后按空格出字，按"-,="翻頁，完畢后按回車開始遊戲';
    DrawShadowText(@str[1], 25, 330, 18, ColColor(22), ColColor(24));
    DrawRectangle(15, 355, 540, 80, 0, ColColor(255), 70);
    str := '姓名：';
    DrawShadowText(@str[1], 25, 360, ColColor(33), ColColor(35));
    str := gbktounicode(@Name);
    DrawShadowText(@str[1], 80, 360, ColColor(5), ColColor(7));
    DrawEngShadowText(@py[1], 42, 375, ColColor(22), ColColor(24));
    for i := 0 to 8 do
    begin
      if (houxuan[i][0] = char(0)) and (houxuan[i][1] = char(0)) then break
      else
      begin
        FillChar(str, SizeOf(str), 0);
        str := IntToStr(i + 1);
        DrawShadowText(@str[1], 25 + 48 * i, 400, ColColor($66), ColColor($63));
        hxtmp[0] := houxuan[i][0];
        hxtmp[1] := houxuan[i][1];
        hxtmp[2] := char(0);
        hxtmp[3] := char(0);
        str := gbktounicode(@hxtmp[0]);
        //str:=hxtmp;
        //str:=gbktounicode(@houxuan[i][0]);
        DrawShadowText(@str[1], 36 + 48 * i, 400, ColColor($5), ColColor($7));
      end;
    end;


    if (houxuan[0] = '') and (state = 2) then
    begin
      str := '查无此字,按任意数字键离开';
      DrawShadowText(@str[1], 32, 400, ColColor($22), ColColor($24));
    end;
    if state = 3 then
    begin
      DrawRectangle(50, 200, 540, 50, 0, ColColor(255), 100);
      DrawShadowText(@msg[1], 60, 205, ColColor(5), ColColor(7));
      str := '請按任意數字鍵離開';
      DrawShadowText(@str[1], 220, 227, ColColor($13), ColColor($15));
      state := 3;
    end;
    //str:=inttostr(state);
    //drawshadowtext(@str[1], 42,  300, colcolor($66), colcolor($63));
    //drawshadowtext(@pyw[1].pinyin[1], 82,  300, colcolor($66), colcolor($63));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  end;
  //-------------------------------------
  Result := '';
  if Name <> '' then Result := Name;
end;

//初始化武功

procedure initialwugong;
var
  i, i1, j, j1, n, k: integer;
begin

  for i := 0 to length(Rrole) - 1 do
  begin
    setgongti(i, 0);
    n := 0;
    for i1 := 0 to 29 do
    begin
      if ((Rrole[i].lmagic[i1] <= 0) or (n > 9)) then break
      else if (Rmagic[Rrole[i].lmagic[i1]].magictype <> 5) then
      begin
        Rrole[i].jhMagic[n] := i1;
        Inc(n);
      end;
    end;

    for j := 0 to 29 do
    begin
      if (Rrole[i].lmagic[j] < 0) then break;
      if Rmagic[Rrole[i].lmagic[j]].magictype = 5 then
      begin
        setgongti(i, Rrole[i].lmagic[j]);

        n := 0;
        if Rrole[i].gongti = -1 then
        begin
          for i1 := 0 to 29 do
            if ((Rrole[i].lmagic[i1] <= 0) or (n > 9)) then break
            else if (Rmagic[Rrole[i].lmagic[i1]].magictype <> 5) then
            begin
              Rrole[i].jhMagic[n] := i1;
              Inc(n);
            end;

        end
        else
        begin
          for i1 := 0 to 29 do
            if ((Rrole[i].lmagic[i1] <= 0) or (n > 9)) then break
            else if (Rmagic[Rrole[i].lmagic[i1]].magictype <> 5) then
            begin
              k := 0;
              for j1 := 0 to 9 do
              begin
                if (Rmagic[Rrole[i].lmagic[i1]].teshumod[0] = -1) or
                  ((Rmagic[Rrole[i].lmagic[i1]].teshu[j1] = Rrole[i].lmagic[Rrole[i].gongti]) and
                  ((Rmagic[Rrole[i].lmagic[i1]].teshumod[j1] = 0) or
                  (Rmagic[Rrole[i].lmagic[i1]].teshumod[j1] = Rrole[i].menpai))) then
                begin
                  k := 1;
                  break;
                end;
              end;
              if k = 1 then
              begin
                Rrole[i].jhMagic[n] := i1;
                Inc(n);

              end;
            end;
        end;

        break;
      end;
    end;
  end;
end;

function mpzyjc(mpnum: integer): integer;
var
  i, k: integer;
begin
  k := 0;
  for i := 0 to 9 do
  begin
    k := k + Rmenpai[mpnum].aziyuan[i];
    if (i > 4) and (i < 9) then k := k + Rmenpai[mpnum].aziyuan[i]
    else if (i = 9) then k := k + Rmenpai[mpnum].aziyuan[i] * 9;
  end;
  k := k - 100;

  Result := min(150, 100 + round(power((abs(k) * 5), 1 / 2) * sign(k)));
  Result := max(50, Result);
end;

//戰鬥前自動裝備武功

function aotosetmagic(rnum: integer): integer; overload;
begin
  Result := aotosetmagic(rnum, 0);
end;

//mods 0 自動裝備武功 不等於0 計算人物武功強力值 1計算強力值的時候內功不乘方
function aotosetmagic(rnum, mods: integer): integer; overload;
var
  i, i1, i2, j, k, n, k1, k2, k3, mpnum, tgt: integer;
  tmagic, tmlev, tgongti, tgtlev, tmag, tlev: array of integer;
  value, tvalue, MaxValue: double;
begin
  Result := 0;
  k1 := 0;
  k2 := 0;
  tvalue := 0;
  MaxValue := 0;
  tgt := 0;
  mpnum := Rrole[rnum].menpai;
  if mods = 0 then
  begin
    setgongti(rnum, 0);
  end;
  for j := 0 to 29 do
  begin
    if (Rrole[rnum].lmagic[j] <= 0) then break;
    if Rmagic[Rrole[rnum].lmagic[j]].magictype = 5 then
    begin
      setlength(tgongti, k1 + 1);
      setlength(tgtlev, k1 + 1);
      tgongti[k1] := Rrole[rnum].lmagic[j];
      tgtlev[k1] := Rrole[rnum].maglevel[j] div 100;
      Inc(k1);
    end
    else
    begin
      setlength(tmagic, k2 + 1);
      setlength(tmlev, k2 + 1);
      tmagic[k2] := Rrole[rnum].lmagic[j];
      tmlev[k2] := Rrole[rnum].maglevel[j] div 100;
      Inc(k2);
    end;
  end;
  if k1 > 0 then
  begin
    for i := 0 to k1 - 1 do
    begin
      value := Rmagic[tgongti[i]].AddHP[tgtlev[i]] * 2 + Rmagic[tgongti[i]].AddMP[tgtlev[i]] +
        Rmagic[tgongti[i]].AddAtt[tgtlev[i]] * 10 + Rmagic[tgongti[i]].AddDef[tgtlev[i]] *
        10 + Rmagic[tgongti[i]].AddSpd[tgtlev[i]] * 10;
      value := value + Rmagic[tgongti[i]].AddMedcine * 5 + Rmagic[tgongti[i]].AddUsePoi * 5 +
        Rmagic[tgongti[i]].AddMedPoi * 5 + Rmagic[tgongti[i]].AddDefPoi * 5 + Rmagic[tgongti[i]].AddFist *
        5 + Rmagic[tgongti[i]].AddSword * 5 + Rmagic[tgongti[i]].AddKnife * 5 +
        Rmagic[tgongti[i]].AddUnusual * 5 + Rmagic[tgongti[i]].AddHidWeapon * 5;
      for i1 := 0 to 9 do
      begin
        if (Rmagic[tgongti[i]].MoveDistance[i1] >= 40) and (Rmagic[tgongti[i]].MoveDistance[i1] < 50)  then
        begin
          value:= value * (200+Rmagic[tgongti[i]].AttDistance[i1])/200;
        end
        else if (Rmagic[tgongti[i]].MoveDistance[i1] >= 60) and (Rmagic[tgongti[i]].MoveDistance[i1] < 70)  then
        begin
          value:= value * (100+Rmagic[tgongti[i]].AttDistance[i1])/100;
        end
        else if (Rmagic[tgongti[i]].MoveDistance[i1] >= 50) and (Rmagic[tgongti[i]].MoveDistance[i1] < 60)  then
        begin
          value:= value * (200-Rmagic[tgongti[i]].AttDistance[i1])/200;
        end
      end;
      if Rmagic[tgongti[i]].BattleState > 0 then value := value + 1000;
      if mods <> 1 then
        value := round(power(value, 1.4));
      k3 := 0;
      if k2 > 0 then
      begin
        for i1 := 0 to k2 - 1 do
        begin
          for i2 := 0 to 9 do
          begin
            if i2 > 0 then
            begin
              if (Rmagic[tmagic[i1]].teshu[i2] <= 0) then break;
            end;
            if (Rmagic[tmagic[i1]].teshumod[0] = -1) or ((Rmagic[tmagic[i1]].teshu[i2] = tgongti[i]) and
              ((Rmagic[tmagic[i1]].teshumod[i2] = 0) or (Rmagic[tmagic[i1]].teshumod[i2] = mpnum))) then
            begin
              setlength(tmag, k3 + 1);
              tmag[k3] := tmagic[i1];
              setlength(tlev, k3 + 1);
              tlev[k3] := tmlev[i1];
              Inc(k3);
              break;
            end;
          end;
        end;
      end;
      if k3 > 0 then
      begin
        magicsort(tmag, tlev);
        for i1 := 0 to min(k3 - 1, 9) do
        begin
          value := value + countmagvalue(tmag[i1], tlev[i1]);
        end;
      end
      else if k2 > 0 then value := 0;

      if value > tvalue then
      begin
        tvalue := value;
        tgt := tgongti[i];
      end;
    end;
    if mods = 0 then
    begin
      setgongti(rnum, tgt);
      exit;
    end;
  end
  else if k2 > 0 then
  begin
    magicsort(tmagic, tmlev);
    tvalue:=0;
    for i1 := 0 to min(k2 - 1, 9) do
    begin
      tvalue := tvalue + countmagvalue(tmagic[i1], tmlev[i1]);
    end;
  end;
  tgt := -1;
  if mods = 0 then
  begin
    setgongti(rnum, tgt);
  end;
  Result := round(tvalue);

end;

//武功排序

procedure magicsort(var mag, lev: array of integer);
var
  i, j, key1, key2: integer;
begin
  for i := length(mag) - 2 downto 0 do
  begin
    key1 := mag[i];
    key2 := lev[i];
    for j := i + 1 to length(mag) - 1 do
    begin
      if countmagvalue(mag[j], lev[j]) > countmagvalue(key1, key2) then
      begin
        mag[j - 1] := mag[j];
        mag[j] := key1;
        lev[j - 1] := lev[j];
        lev[j] := key2;
      end;
    end;
  end;
end;

//計算武功強度值

function countmagvalue(mnum, mlev: integer): integer;
var
  i, j, k, value: integer;

begin
  if Rmagic[mnum].magictype = 6 then value := 100 * mlev div 9
  else value := CalNewHurtValue(mlev, Rmagic[mnum].MinHurt, Rmagic[mnum].MaxHurt, Rmagic[mnum].HurtModulus);
  k := 5;
  for i := 0 to 4 do
  begin
    if Rmagic[mnum].zhaoshi[i] <= 0 then
    begin
      k := i;
      break;
    end;
  end;
  Result := value * (10 + k) div 10;
end;



function randomyaopin(rate: integer): integer;
var
  i, k: integer;
  tmp: array of integer;
begin
  Result := -1;
  k := 0;
  for i := 0 to length(Ritem) - 1 do
  begin
    if (Ritem[i].ItemType = 3) and (Ritem[i].rate >= max(1, rate)) then
    begin
      setlength(tmp, k + 1);
      tmp[k] := i;
      Inc(k);

    end;
  end;
  if k > 0 then
  begin
    Result := tmp[randomf3 * k div 10000];
  end;
end;


function randomzhuangbei(rate: integer): integer;
var
  i, i1, k: integer;
  tmp: array of integer;
begin
  Result := -1;
  k := 0;
  for i := 0 to length(Ritem) - 1 do
  begin
    if (Ritem[i].ItemType = 1) and (Ritem[i].rate >= max(1, rate)) then
    begin
      for i1 := 0 to MAX_ITEM_AMOUNT - 1 do
      begin
        if Ritemlist[i1].number < 0 then
        begin
          setlength(tmp, k + 1);
          tmp[k] := i;
          Inc(k);
          break;
        end;
        if (Ritemlist[i1].number = i) and (Ritemlist[i1].amount > 0) then
        begin
          break;
        end;
      end;
    end;
  end;
  if k > 0 then
  begin
    Result := tmp[randomf3 * k div 10000];
  end;
end;

function randomxiyouzhuangbei: integer;
var
  i, i1, k: integer;
  tmp: array of integer;
begin
  Result := -1;
  k := 0;
  for i := 0 to length(Ritem) - 1 do
  begin
    if (Ritem[i].ItemType = 1) and ((Ritem[i].rate = 0) or (Ritem[i].rate = -1)) then
    begin
      for i1 := 0 to MAX_ITEM_AMOUNT - 1 do
      begin
        if Ritemlist[i1].number < 0 then
        begin
          setlength(tmp, k + 1);
          tmp[k] := i;
          Inc(k);
          break;
        end;
        if (Ritemlist[i1].number = i) and (Ritemlist[i1].amount > 0) then
        begin
          break;
        end;
      end;
    end;
  end;
  if k > 0 then
  begin
    Result := tmp[randomf3 * k div 10000];
  end;
end;

function randommiji(rate: integer): integer;
var
  i, i1, k: integer;
  tmp: array of integer;
begin
  Result := -1;
  k := 0;
  for i := 0 to length(Ritem) - 1 do
  begin
    if (Ritem[i].ItemType = 2) and (Ritem[i].rate >= max(1, rate)) then
    begin
      for i1 := 0 to MAX_ITEM_AMOUNT - 1 do
      begin
        if (Ritemlist[i1].number = i) and (Ritemlist[i1].amount > 0) then
        begin
          break;
        end;
        if (Ritemlist[i1].number < 0) or (Ritemlist[i1].number = i) then
        begin
          setlength(tmp, k + 1);
          tmp[k] := i;
          Inc(k);
          break;
        end;

      end;
    end;
  end;
  if k > 0 then
  begin
    Result := tmp[randomf3 * k div 10000];
  end;
end;

procedure airenming;
var
  i, i1: integer;
  trnum: array[0..39] of array of integer;
  k: array[0..39] of integer;
begin
  for i := 0 to 39 do
    k[i] := 0;
  for i := 0 to length(Rrole) - 1 do
  begin
    if (Rrole[i].menpai >= 0) and (Rrole[i].menpai < 40) and (Rrole[i].dtime < 5) and
      (Rmenpai[Rrole[i].menpai].zmr <> i) then
    begin
      setlength(trnum[Rrole[i].menpai], k[Rrole[i].menpai] + 1);
      trnum[Rrole[i].menpai][k[Rrole[i].menpai]] := i;
      Inc(k[Rrole[i].menpai]);
    end;
  end;

  for i := 0 to length(Rmenpai) - 1 do
  begin
    if (k[i] > 0) and ((i <> Rrole[0].menpai) or (Rmenpai[Rrole[0].menpai].zmr <> 0)) then
    begin
      shengwangandlevsort(trnum[i]);
      for i1 := 0 to min(9, k[i] - 1) do
      begin
        Rmenpai[i].zhiwu[i1] := trnum[i][i1];
      end;
    end;
  end;
end;



procedure ShengWangAndLevSort(var arr: array of integer);
var
  i, j, key: integer;
begin
  for i := length(arr) - 2 downto 0 do
  begin
    key := arr[i];
    for j := i + 1 to length(arr) - 1 do
    begin
      if Rrole[arr[j]].level * Rrole[arr[j]].Repute > Rrole[key].level * Rrole[key].Repute then
      begin
        arr[j - 1] := arr[j];
        arr[j] := key;
      end;
    end;
  end;
end;

procedure jiweiSort(var arr: array of integer; big: integer);
var
  i, j, key: integer;
begin
  for i := length(arr) - 2 downto 0 do
  begin
    key := arr[i];
    for j := i + 1 to length(arr) - 1 do
    begin
      if Rrole[arr[j]].level * Rrole[arr[j]].Repute div (Rrole[arr[j]].bssx + 1 - big) >
        Rrole[key].level * Rrole[key].Repute div (Rrole[key].bssx + 1 - big) then
      begin
        arr[j - 1] := arr[j];
        arr[j] := key;
      end;
    end;
  end;
end;


function gettips: WideString;
var
  i: integer;
begin
  if length(tipsarr) > 0 then
  begin
    Result := tipsarr[0];
    for i := 0 to length(tipsarr) - 2 do
    begin
      tipsarr[i] := tipsarr[i + 1];
    end;
    setlength(tipsarr, length(tipsarr) - 1);
  end
  else Result := '';

end;

procedure settips;
var
  i:integer;
  tipsstring:widestring;
begin
  if Showtips.num >= 5 then
    exit;
  tipsstring := gettips;
  if (tipsstring <> '') and (Showtips.num < 5) then
  begin
    inc(Showtips.num);
    setlength(Showtips.Str,Showtips.num);
    Showtips.Str[Showtips.num -1]:= tipsstring;
    setlength(Showtips.x,Showtips.num);
    Showtips.x[Showtips.num -1]:= CENTER_X * 2 + 50;
    setlength(Showtips.y,Showtips.num);
    if Showtips.num > 1 then
      Showtips.y[Showtips.num -1]:= Showtips.y[Showtips.num -2]
    else
      Showtips.y[Showtips.num -1]:= CENTER_Y * 2 - 40;
    setlength(Showtips.yadd,Showtips.num);
    Showtips.yadd[Showtips.num -1]:= Showtips.y[Showtips.num -1];
    for i:= Showtips.num - 2 downto 0 do
    begin
      Showtips.yadd[i]:= Showtips.yadd[i + 1] - 25;
    end;
  end;
end;

procedure dectips(num:integer);
var
  i:integer;
  tipsstring:widestring;
begin
  tipsstring := gettips;
  if (tipsstring <> '') and (num < Showtips.num) then
  begin
    Showtips.Str[num]:= tipsstring;
    Showtips.x[num]:= CENTER_X * 2 + 50;
  end
  else if (tipsstring = '') then
  begin
    for i:= num to Showtips.num -2 do
    begin
      Showtips.Str[i]:= Showtips.Str[i + 1];
      Showtips.x[i]:= Showtips.x[i + 1];
      Showtips.y[i]:= Showtips.y[i + 1];
      Showtips.yadd[i]:= Showtips.yadd[i + 1];
    end;
    dec(Showtips.num);
    setlength(Showtips.Str,Showtips.num);
    setlength(Showtips.x,Showtips.num);
    setlength(Showtips.y,Showtips.num);
    setlength(Showtips.yadd,Showtips.num);
    if num > Showtips.num then
    begin
      exit;
    end;
    for i:= 0 to num -1 do
    begin
      Showtips.yadd[i]:= Showtips.yadd[i] + 25;
    end;
  end;
end;

procedure addtips(str: WideString);
var
  i, k: integer;
  s1: string;
begin
  setlength(RStishi.stishi, RStishi.num + 1);
  Inc(RStishi.num);
  RStishi.stishi[RStishi.num - 1].moon := wdate[2];
  RStishi.stishi[RStishi.num - 1].day := wdate[3];
  s1 := str;
  RStishi.stishi[RStishi.num - 1].talklen := length(s1) + 2;
  setlength(RStishi.stishi[RStishi.num - 1].talk, RStishi.stishi[RStishi.num - 1].talklen);
  for i := 0 to RStishi.stishi[RStishi.num - 1].talklen - 3 do
  begin
    RStishi.stishi[RStishi.num - 1].talk[i] := s1[i + 1];
  end;
  RStishi.stishi[RStishi.num - 1].talk[RStishi.stishi[RStishi.num - 1].talklen - 2] := char(byte(0));
  RStishi.stishi[RStishi.num - 1].talk[RStishi.stishi[RStishi.num - 1].talklen - 1] := char(byte(0));
  if length(tipsarr) <= 0 then
  begin
    setlength(tipsarr, 1);
    tipsarr[0] := str + '（' + IntToStr(wdate[2]) + '．' + IntToStr(wdate[3]) + '）';
    exit;
  end
  else
  begin
    k := length(tipsarr);
    setlength(tipsarr, k + 1);
    tipsarr[k] := str + '（' + IntToStr(wdate[2]) + '．' + IntToStr(wdate[3]) + '）';
  end;

end;

procedure Jxtips;
var
  pword: array[0..1] of uint16;
  strs: WideString;
  i, grp, idx, offset, len, Count, talknum: integer;
  talkarray: array of byte;
  tp: pchar;
begin
  pword[1] := 0;
  idx := FileOpen(T1_IDX, fmopenread);
  grp := FileOpen(T1_GRP, fmopenread);
  Count := FileSeek(idx, 0, 2) div 4;
  if Count > 1 then
  begin

    for talknum := 1 to Count - 1 do
    begin
      FileSeek(idx, (talknum - 1) * 4, 0);
      FileRead(idx, offset, 4);
      FileRead(idx, len, 4);
      len := (len - offset);
      setlength(talkarray, len + 2);
      FileSeek(grp, offset, 0);
      FileRead(grp, talkarray[0], len);

      for i := 0 to len - 1 do
      begin
        talkarray[i] := talkarray[i] xor $FF;
        if (talkarray[i] = $FF) then
          talkarray[i] := 0;
      end;
      talkarray[len] := byte(0);
      talkarray[len + 1] := byte(0);
      if (talkarray[len - 2] = 126) and (talkarray[len - 1] = 96) then
        break;
      tp := @talkarray[0];
      strs := gbktounicode(tp);
      setlength(Jxarr, talknum);
      Jxarr[talknum - 1] := strs;
    end;
  end;
  FileClose(idx);
  FileClose(grp);
end;

procedure LoadRenwus;
var
  pword: array[0..1] of uint16;
  strs: WideString;
  i, i1, grp, idx, offset, len, Count, talknum, Rcount: integer;
  talkarray: array of byte;
  tp: pchar;
begin
  Rcount := length(Rrenwu);
  if Rcount > 0 then
  begin
    pword[1] := 0;
    idx := FileOpen(TALK_IDX, fmopenread);
    grp := FileOpen(TALK_GRP, fmopenread);
    Count := FileSeek(idx, 0, 2) div 4;
    if Count > 1 then
    begin
      for i := 0 to Rcount - 1 do
      begin
        if Rrenwu[i].talknum = 0 then
        begin
          offset := 0;
          FileRead(idx, len, 4);
        end
        else
        begin
          FileSeek(idx, (Rrenwu[i].talknum - 1) * 4, 0);
          FileRead(idx, offset, 4);
          FileRead(idx, len, 4);
        end;
        len := (len - offset);
        setlength(talkarray, len + 2);
        FileSeek(grp, offset, 0);
        FileRead(grp, talkarray[0], len);

        for i1 := 0 to len - 1 do
        begin
          talkarray[i1] := talkarray[i1] xor $FF;
          if (talkarray[i1] = $FF) then
            talkarray[i1] := 0;
        end;
        talkarray[len] := byte(0);
        talkarray[len + 1] := byte(0);
        if (talkarray[len - 2] = 126) and (talkarray[len - 1] = 96) then
          break;
        tp := @talkarray[0];
        Rrenwu[i].talks := gbktounicode(tp);
      end;
    end;
    FileClose(idx);
    FileClose(grp);
  end;
end;

function TalktoWidestring(num: integer; fgrp, fidx: string): WideString;
var
  pword: array[0..1] of uint16;
  strs: WideString;
  i1, grp, idx, offset, len, Count, talknum, Rcount: integer;
  talkarray: array of byte;
  tp: pchar;
begin

  pword[1] := 0;
  idx := FileOpen(FIDX, fmopenread);
  grp := FileOpen(FGRP, fmopenread);
  Count := FileSeek(idx, 0, 2) div 4;
  if Count > Rrenwu[num].talknum then
  begin
    if Rrenwu[num].talknum = 0 then
    begin
      offset := 0;
      FileRead(idx, len, 4);
    end
    else
    begin
      FileSeek(idx, (Rrenwu[num].talknum - 1) * 4, 0);
      FileRead(idx, offset, 4);
      FileRead(idx, len, 4);
    end;
    len := (len - offset);
    setlength(talkarray, len + 2);
    FileSeek(grp, offset, 0);
    FileRead(grp, talkarray[0], len);

    for i1 := 0 to len - 1 do
    begin
      talkarray[i1] := talkarray[i1] xor $FF;
      if (talkarray[i1] = $FF) then
        talkarray[i1] := 0;
    end;
    talkarray[len] := byte(0);
    talkarray[len + 1] := byte(0);
    tp := @talkarray[0];
    Result := gbktounicode(tp);

  end;
  FileClose(idx);
  FileClose(grp);
end;

procedure jisuanmenpaidata;
var
  i, j, add1, tmp, tmp2, i1, i2, i3, mpnum: integer;
  zhiwujc: array[0..9] of integer;
  now: uint32;
begin
  for i := 0 to length(Rmenpai) - 2 do
  begin
    if Rmenpai[i].zmr > -1 then
    begin
      tmp := Rrole[Rmenpai[i].zmr].Ethics - (Rmenpai[i].shane + 5) * 10;
      tmp2 := tmp div 10;
      if tmp < 0 then
      begin
        add1 := randomf1 div (100 * (100 + tmp));
        Dec(Rmenpai[i].shane, add1);
      end
      else if tmp > 0 then
      begin
        add1 := randomf1 div (100 * (100 - tmp));
        Inc(Rmenpai[i].shane, add1);
      end;

      for j := (i + 1) to length(Rmenpai) - 1 do
      begin
        if Rmenpai[i].guanxi[j] > -1 then
        begin
          if ((Rmenpai[i].shane > 0) and (Rmenpai[j].shane > 0)) or ((Rmenpai[i].shane < 0) and
            (Rmenpai[j].shane < 0)) then
          begin
            add1 := 6 - random(abs(Rmenpai[i].shane - Rmenpai[j].shane) * 3);
            changempgx(i, j, add1);
          end
          else if (Rmenpai[i].shane <> 0) and (Rmenpai[j].shane <> 0) then
          begin
            add1 := random(+(abs(Rmenpai[i].shane - Rmenpai[j].shane) - 1) * 2) - 3;
            changempgx(i, j, -add1);
          end;

          if random(50000 + 5 * Rmenpai[i].guanxi[j]) < (Rmenpai[i].guanxi[j] + 100) then
          begin
            add1 := random(1 + (abs(Rmenpai[i].shane + Rmenpai[j].shane)) * 3);
            changempgx(i, j, add1);
          end;
        end;
      end;
    end;
  end;

  mpnum := Rrole[0].MenPai;
  for i1 := 0 to 9 do
    zhiwujc[i1] := 0;
  if Rmenpai[mpnum].zhiwu[2] >= 0 then
  begin
    zhiwujc[2] := Rrole[Rmenpai[mpnum].zhiwu[2]].Repute * Rrole[Rmenpai[mpnum].zhiwu[2]].level div 300;
    zhiwujc[4] := Rrole[Rmenpai[mpnum].zhiwu[2]].Repute * Rrole[Rmenpai[mpnum].zhiwu[2]].level div 600;
    zhiwujc[5] := Rrole[Rmenpai[mpnum].zhiwu[2]].Repute * Rrole[Rmenpai[mpnum].zhiwu[2]].level div 300;
  end;
  if Rmenpai[mpnum].zhiwu[3] >= 0 then
  begin
    zhiwujc[0] := Rrole[Rmenpai[mpnum].zhiwu[3]].Repute * Rrole[Rmenpai[mpnum].zhiwu[3]].level div 300;
    zhiwujc[4] := Rrole[Rmenpai[mpnum].zhiwu[3]].Repute * Rrole[Rmenpai[mpnum].zhiwu[3]].level div 600;
    zhiwujc[7] := Rrole[Rmenpai[mpnum].zhiwu[3]].Repute * Rrole[Rmenpai[mpnum].zhiwu[3]].level div 300;
  end;
  if Rmenpai[mpnum].zhiwu[4] >= 0 then
  begin
    zhiwujc[3] := Rrole[Rmenpai[mpnum].zhiwu[4]].Repute * Rrole[Rmenpai[mpnum].zhiwu[4]].level div 300;
    zhiwujc[4] := Rrole[Rmenpai[mpnum].zhiwu[4]].Repute * Rrole[Rmenpai[mpnum].zhiwu[4]].level div 600;
    zhiwujc[6] := Rrole[Rmenpai[mpnum].zhiwu[4]].Repute * Rrole[Rmenpai[mpnum].zhiwu[4]].level div 300;
  end;
  if Rmenpai[mpnum].zhiwu[5] >= 0 then
  begin
    zhiwujc[1] := Rrole[Rmenpai[mpnum].zhiwu[5]].Repute * Rrole[Rmenpai[mpnum].zhiwu[5]].level div 300;
    zhiwujc[4] := Rrole[Rmenpai[mpnum].zhiwu[5]].Repute * Rrole[Rmenpai[mpnum].zhiwu[5]].level div 600;
    zhiwujc[8] := Rrole[Rmenpai[mpnum].zhiwu[5]].Repute * Rrole[Rmenpai[mpnum].zhiwu[5]].level div 300;
  end;

  for i1 := 0 to length(Rmenpai) - 1 do
  begin
    for i2 := 0 to 9 do
    begin
      if i1 = mpnum then
      begin
        Inc(Rmenpai[i1].ziyuan[i2], Rmenpai[i1].aziyuan[i2] * (100 + zhiwujc[i2]) div 100);
        Rmenpai[i1].ziyuan[i2] := max(-9999, Rmenpai[i1].ziyuan[i2]);
        Rmenpai[i1].ziyuan[i2] := min(9999, Rmenpai[i1].ziyuan[i2]);
        if Rmenpai[i1].ziyuan[i2] < 0 then
        begin
          for i3 := 1 to length(Rrole) - 1 do
          begin
            if (Rrole[i3].MenPai = mpnum) and (Rrole[i3].dtime < 1000) and (Rrole[i3].zhongcheng >= 0) then
            begin
              Dec(Rrole[i3].zhongcheng, random(5));
              if random(50) > Rrole[i3].zhongcheng then
                zhuchu(i3);
            end;
          end;
        end;
      end
      else
      begin
        Inc(Rmenpai[i1].ziyuan[i2], Rmenpai[i1].aziyuan[i2]);
        Rmenpai[i1].ziyuan[i2] := max(-9999, Rmenpai[i1].ziyuan[i2]);
        Rmenpai[i1].ziyuan[i2] := min(9999, Rmenpai[i1].ziyuan[i2]);
      end;
    end;
  end;
end;


procedure initialMPdiaodu;
var
  i, i1, i2, i3, i4, len, len0, n, rtotle, gtotle, k, zhiwu: integer;
  tmp: double;

begin
  n := 0;
  for i := 0 to length(Rmenpai) - 1 do
  begin
    if (Rmenpai[i].jvdian > 0) then
    begin
      if (Rrole[0].MenPai > 0) then
      begin
        if (i = Rrole[0].menpai) and (Rmenpai[Rrole[0].MenPai].zmr = 0) then
          continue;
      end;
      setlength(mpdiaodu, n + 1);
      mpdiaodu[n].mpnum := i;
      mpdiaodu[n].scount := 0;
      mpdiaodu[n].rcount := 0;
      for i1 := 1 to length(Rscene) - 1 do
      begin
        if Rscene[i1].menpai = i then
        begin
          setlength(mpdiaodu[n].sce, mpdiaodu[n].scount + 1);
          mpdiaodu[n].sce[mpdiaodu[n].scount].snum := i1;
          mpdiaodu[n].sce[mpdiaodu[n].scount].Count := 0;
          mpdiaodu[n].sce[mpdiaodu[n].scount].dmenpai := -1;
          mpdiaodu[n].sce[mpdiaodu[n].scount].dguanxi := 1001;
          mpdiaodu[n].sce[mpdiaodu[n].scount].dsnum := -1;
          for i2 := 0 to 9 do
          begin
            if (Rscene[i1].lianjie[i2] < 0) then
              break;
            if ((Rscene[Rscene[i1].lianjie[i2]].menpai = i) or (Rscene[Rscene[i1].lianjie[i2]].menpai < 0)) then
              continue;
            Inc(mpdiaodu[n].sce[mpdiaodu[n].scount].Count);
            if Rmenpai[Rscene[Rscene[i1].lianjie[i2]].menpai].guanxi[i] <
              mpdiaodu[n].sce[mpdiaodu[n].scount].dguanxi then
            begin
              mpdiaodu[n].sce[mpdiaodu[n].scount].dmenpai := Rscene[Rscene[i1].lianjie[i2]].menpai;
              mpdiaodu[n].sce[mpdiaodu[n].scount].dguanxi := Rmenpai[Rscene[Rscene[i1].lianjie[i2]].menpai].guanxi[i];
              mpdiaodu[n].sce[mpdiaodu[n].scount].dsnum := Rscene[i1].lianjie[i2];
            end;
          end;
          Inc(mpdiaodu[n].scount);
        end;
      end;
      for i1 := 1 to length(Rrole) - 1 do
      begin
        if (Rrole[i1].MenPai = i) and (Rrole[i1].dtime < 1000) then
        begin
          setlength(mpdiaodu[n].rnum, mpdiaodu[n].rcount + 1);
          setlength(mpdiaodu[n].isin, mpdiaodu[n].rcount + 1);
          mpdiaodu[n].rnum[mpdiaodu[n].rcount] := i1;
          mpdiaodu[n].isin[mpdiaodu[n].rcount] := 0;
          Inc(mpdiaodu[n].rcount);
        end;
      end;
      Inc(n);
    end;
  end;

  if n > 0 then
  begin
    for i := 0 to n - 1 do
    begin
      rtotle := 0;
      gtotle := 0;
      levsort(mpdiaodu[i].rnum);
      for i1 := 0 to mpdiaodu[i].rcount - 1 do
      begin
        rtotle := rtotle + Rrole[mpdiaodu[i].rnum[i1]].Level;
      end;
      for i1 := 0 to mpdiaodu[i].scount - 1 do
      begin
        gtotle := gtotle + ((1200 - mpdiaodu[i].sce[i1].dguanxi) * (100 + 10 * (mpdiaodu[i].sce[i1].Count - 1)));
      end;
      i2 := 0;
      i3 := mpdiaodu[i].rcount - 1;
      for i1 := 0 to mpdiaodu[i].scount - 1 do
      begin
        zhiwu := 0;
        if i2 > i3 then
          break;
        if (gtotle > 0) then
        begin
          k := 0;
          tmp := rtotle * ((1200 - mpdiaodu[i].sce[i1].dguanxi) *
            (100 + 10 * (mpdiaodu[i].sce[i1].Count - 1))) / gtotle;
          while ((tmp > 0) and (tmp > Rrole[mpdiaodu[i].rnum[i3]].Level)) do
          begin
            if i2 > i3 then
              break;
            if tmp >= Rrole[mpdiaodu[i].rnum[i2]].Level then
            begin
              if mpdiaodu[i].rnum[i2] = 0 then
              begin
                Inc(I2);
              end;
              if mpdiaodu[i].rnum[i3] = 0 then
              begin
                Dec(I3);
              end;
              i4 := 0; //检查是否掌门或者左右护法，尽量让这3人分开
              if (Rmenpai[mpdiaodu[i].mpnum].zmr <> mpdiaodu[i].rnum[i2]) then
                for i4 := 0 to 9 do
                  if Rmenpai[mpdiaodu[i].mpnum].zhiwu[i4] = mpdiaodu[i].rnum[i2] then
                    break;
              if (i4 > 9) or (zhiwu < 1) then
              begin
                if (i4 <= 9) then
                  Inc(zhiwu); //若此人有职务
                Rrole[mpdiaodu[i].rnum[i2]].weizhi := mpdiaodu[i].sce[i1].snum;
                mpdiaodu[i].isin[i2] := 1;
                tmp := tmp - Rrole[mpdiaodu[i].rnum[i2]].Level;
                Inc(i2);
                Inc(k);
              end;
            end;
            if tmp >= Rrole[mpdiaodu[i].rnum[i3]].Level then
            begin
              Rrole[mpdiaodu[i].rnum[i3]].weizhi := mpdiaodu[i].sce[i1].snum;
              mpdiaodu[i].isin[i3] := 1;
              tmp := tmp - Rrole[mpdiaodu[i].rnum[i2]].Level;
              Dec(i3);
              Inc(k);
            end;
          end;
          if (k = 0) and (i2 <= i3) then
          begin
            Rrole[mpdiaodu[i].rnum[i2]].weizhi := mpdiaodu[i].sce[i1].snum;
            mpdiaodu[i].isin[i2] := 1;
            Inc(i2);
          end;
        end;

      end;
    end;
  end;

end;

procedure AIMPBattle;
var
  i, i1, i2, i3, i4, len, len0, max0, max1, max2, battle_id: integer;
  k: double;
  jgzhanli, fyzhanli: integer;
  rolearr, rolearr1, rolearr2: array of smallint;
  str: WideString;
begin

  len := length(mpdiaodu);

  for i := 0 to length(Rmenpai) - 1 do
  begin
    if (Rmenpai[i].jvdian <= 0) or (i = Rrole[0].menpai) then
      continue;
    jgzhanli := 0;
    max0 := 0;
    for i1 := 0 to length(Rrole) - 1 do
    begin
      if (Rrole[i1].MenPai = i) and (Rrole[i1].dtime < 2) then
      begin
        setlength(rolearr, max0 + 1);
        rolearr[max0] := i1;
        Inc(max0);
      end;
    end;
    levsort(rolearr);
    if max0 > 0 then
      max0 := (max0 + 1) div 2;
    if max0 > 0 then
    begin
      for i1 := 0 to max0 - 1 do
        jgzhanli := jgzhanli + aotosetmagic(rolearr[i1], 1);
      setlength(rolearr, max0);
    end
    else
    begin
      jgzhanli := 0;
      setlength(rolearr, 0);
    end;

    for i1 := 0 to len - 1 do
    begin
      if mpdiaodu[i1].mpnum = i then
      begin
        for i2 := 0 to mpdiaodu[i1].scount - 1 do
        begin
          if (mpdiaodu[i1].sce[i2].dmenpai >= 0) and (Rscene[mpdiaodu[i1].sce[i2].dsnum].inbattle = 0) and
            (Rscene[mpdiaodu[i1].sce[i2].snum].inbattle = 0) then
          begin
            k := max(0, (800 - mpdiaodu[i1].sce[i2].dguanxi)) / (4 + mpdiaodu[i1].sce[i2].Count * 4);

            if random(4000000) < power(k, 3) then

            begin
              fyzhanli := 0;
              max1 := 0;
              max2 := 0;
              for i3 := 0 to length(Rrole) - 1 do
              begin
                if (Rrole[i3].weizhi = mpdiaodu[i1].sce[i2].dsnum) and (Rrole[i3].dtime < 10) and
                  (Rrole[i3].menpai = mpdiaodu[i1].sce[i2].dmenpai) then
                begin
                  setlength(rolearr1, max1 + 1);
                  rolearr1[max1] := i3;
                  Inc(max1);
                end;
              end;
              levsort(rolearr1);
              for i3 := 0 to length(Rrole) - 1 do
              begin
                if (Rrole[i3].MenPai = mpdiaodu[i1].sce[i2].dmenpai) and (Rrole[i3].dtime < 10) and
                  (Rrole[i3].weizhi <> mpdiaodu[i1].sce[i2].dsnum) then
                begin
                  setlength(rolearr2, max2 + 1);
                  rolearr2[max2] := i3;
                  Inc(max2);
                end;
              end;
              levsort(rolearr2);
              if max2 > 0 then
                max2 := (max2 + 1) div 2;
              if max1 > 0 then
                for i3 := 0 to max1 - 1 do
                  fyzhanli := fyzhanli + aotosetmagic(rolearr1[i3], 1);
              if max2 > 0 then
              begin
                for i3 := 0 to max2 - 1 do
                  fyzhanli := fyzhanli + aotosetmagic(rolearr2[i3], 1);
              end;

              if (random(jgzhanli * Rmenpai[i].kzq) > (fyzhanli * 250)) and (max0 > 0) then

              begin
                for i3 := 0 to 19 do
                  if mpbdata[i3].key < 0 then
                    break;
                if i3 > 19 then
                begin
                  break;
                end;
                Rscene[mpdiaodu[i1].sce[i2].dsnum].inbattle := 1;

                str := gbktounicode(@Rmenpai[i].Name);
                str := str + '向' + gbktounicode(@Rscene[mpdiaodu[i1].sce[i2].dsnum].Name) + '發動攻擊！';
                addtips(str);
                battle_id := i3;
                mpbdata[i3].key := 1;
                mpbdata[i3].daytime := timetonum + 1 +
                  (abs(Rscene[mpdiaodu[i1].sce[i2].snum].MainEntranceY1 -
                  Rscene[mpdiaodu[i1].sce[i2].dsnum].MainEntranceY1) +
                  abs(Rscene[mpdiaodu[i1].sce[i2].snum].MainEntranceX1 -
                  Rscene[mpdiaodu[i1].sce[i2].dsnum].MainEntranceX1)) div 48;
                mpbdata[i3].attmp := i;
                mpbdata[i3].defmp := mpdiaodu[i1].sce[i2].dmenpai;
                mpbdata[i3].snum := mpdiaodu[i1].sce[i2].dsnum;
                setlength(mpbdata[i3].BTeam[3].RoleArr, 1);
                mpbdata[i3].BTeam[3].RoleArr[0].rnum := (863 + i3);
                mpbdata[i3].BTeam[3].RoleArr[0].snum := mpdiaodu[i1].sce[i2].dsnum;
                mpbdata[i3].BTeam[3].RoleArr[0].isin := 0;
                mpbdata[i3].BTeam[3].RoleArr[0].mag := 0;
                len0 := 0;
                for i4 := 0 to max0 - 1 do
                begin
                  setlength(mpbdata[i3].BTeam[2].RoleArr, len0 + 1);
                  mpbdata[i3].BTeam[2].RoleArr[len0].rnum := rolearr[i4];
                  mpbdata[i3].BTeam[2].RoleArr[len0].snum := Rrole[rolearr[i4]].weizhi;
                  mpbdata[i3].BTeam[2].RoleArr[len0].isin := 0;
                  aotosetmagic(rolearr[i4]);
                  mpbdata[i3].BTeam[2].RoleArr[len0].mag := GetGeliveAblemag(rolearr[i4]);
                  Rrole[rolearr[i4]].weizhi := mpdiaodu[i1].sce[i2].dsnum;
                  Rrole[rolearr[i4]].nweizhi := 16;
                  Rrole[rolearr[i4]].dtime := 1000;
                  Inc(len0);
                end;
                len0 := 1;
                for i4 := 0 to max1 - 1 do
                begin
                  setlength(mpbdata[i3].BTeam[3].RoleArr, len0 + 1);
                  mpbdata[i3].BTeam[3].RoleArr[len0].rnum := rolearr1[i4];
                  mpbdata[i3].BTeam[3].RoleArr[len0].snum := Rrole[rolearr1[i4]].weizhi;
                  mpbdata[i3].BTeam[3].RoleArr[len0].isin := 0;
                  aotosetmagic(rolearr1[i4]);
                  mpbdata[i3].BTeam[3].RoleArr[len0].mag := GetGeliveAblemag(rolearr1[i4]);
                  Rrole[rolearr1[i4]].weizhi := mpdiaodu[i1].sce[i2].dsnum;
                  Rrole[rolearr1[i4]].nweizhi := 16;
                  Rrole[rolearr1[i4]].dtime := 1000;
                  Inc(len0);
                end;
                if mpbdata[i3].defmp <> Rrole[0].menpai then
                begin
                  for i4 := 0 to max2 - 1 do
                  begin
                    setlength(mpbdata[i3].BTeam[3].RoleArr, len0 + 1);
                    mpbdata[i3].BTeam[3].RoleArr[len0].rnum := rolearr2[i4];
                    mpbdata[i3].BTeam[3].RoleArr[len0].snum := Rrole[rolearr2[i4]].weizhi;
                    mpbdata[i3].BTeam[3].RoleArr[len0].isin := 0;
                    aotosetmagic(rolearr2[i4]);
                    mpbdata[i3].BTeam[3].RoleArr[len0].mag := GetGeliveablemag(rolearr2[i4]);
                    Rrole[rolearr2[i4]].weizhi := mpdiaodu[i1].sce[i2].dsnum;
                    Rrole[rolearr2[i4]].nweizhi := 16;
                    Rrole[rolearr2[i4]].dtime := 1000;
                    Inc(len0);
                  end;
                end;
                break;
              end;
            end;
          end;
        end;
        break;
      end;
    end;
  end;
end;

function GetGeliveAblemag(rnum: integer): integer;
var
  i, tmp, maxcount, tmagic, level, mnum: integer;

begin
  Result := -1;
  maxcount := 0;
  tmagic := -1;
  for i := 0 to 9 do
  begin
    if Rrole[rnum].jhMagic[i] >= 0 then
    begin
      if Rrole[rnum].LMagic[Rrole[rnum].jhMagic[i]] >= 0 then
      begin
        level := Rrole[rnum].MagLevel[Rrole[rnum].jhMagic[i]] div 100 + 1;
        mnum := Rrole[rnum].LMagic[Rrole[rnum].jhMagic[i]];
        tmp := CalNewHurtValue(level - 1, Rmagic[mnum].MinHurt, Rmagic[mnum].MaxHurt, Rmagic[mnum].HurtModulus);
        if tmp >= maxcount then
        begin
          maxcount := tmp;
          tmagic := Rrole[rnum].jhMagic[i];
        end;
      end;
    end;
  end;
  if tmagic >= 0 then
    Result := tmagic;

end;

procedure AIFight(id: integer);
var
  i, i1, i2, len2, len3, tmp, l2, l3, k: integer;
  str: WideString;
begin
  len2 := length(mpbdata[id].BTeam[2].rolearr);
  len3 := length(mpbdata[id].BTeam[3].rolearr);
  l2 := -1;
  l3 := -1;
  for i := 0 to len2 - 1 do
  begin
    if Rrole[mpbdata[id].BTeam[2].rolearr[i].rnum].CurrentHP > 0 then
      Inc(l2);
  end;
  for i := 0 to len3 - 1 do
  begin
    if Rrole[mpbdata[id].BTeam[3].rolearr[i].rnum].CurrentHP > 0 then
      Inc(l3);
  end;
  if (l2 < 1) and (l3 < 1) then
  begin
    mpbdata[id].key := -1;
    Rscene[mpbdata[id].snum].inbattle := 0;
    for i2 := 0 to len2 - 1 do
    begin
      if Rrole[mpbdata[id].BTeam[2].RoleArr[i2].rnum].menpai >= 0 then
        Rrole[mpbdata[id].BTeam[2].RoleArr[i2].rnum].weizhi := mpbdata[id].BTeam[2].RoleArr[i2].snum;
      Rrole[mpbdata[id].BTeam[2].RoleArr[i2].rnum].dtime := 5;
      if Rrole[mpbdata[id].BTeam[2].RoleArr[i2].rnum].TeamState in [1, 2] then
      begin
        Rrole[mpbdata[id].BTeam[2].RoleArr[i2].rnum].nweizhi := 13;
        Rrole[mpbdata[id].BTeam[2].RoleArr[i2].rnum].dtime := 1000;
      end
      else
        Rrole[mpbdata[id].BTeam[2].RoleArr[i2].rnum].nweizhi := -1;
    end;
    for i2 := 0 to len3 - 1 do
    begin
      Rrole[mpbdata[id].BTeam[3].RoleArr[i2].rnum].nweizhi := -1;
      Rrole[mpbdata[id].BTeam[3].RoleArr[i2].rnum].dtime := 0;
    end;
    str := gbktounicode(@Rmenpai[mpbdata[id].defmp].Name);
    str := str + '在' + gbktounicode(@Rscene[mpbdata[id].snum].Name);
    str := str + '戰勝' + gbktounicode(@Rmenpai[mpbdata[id].attmp].Name);
    addtips(str);
    exit;

  end;
  for i := 0 to len3 - 1 do
  begin
    if mpbdata[id].BTeam[3].rolearr[i].mag >= 0 then
    begin
      tmp := random(l2);
      for i1 := 0 to len2 - 1 do
      begin
        if Rrole[mpbdata[id].BTeam[2].rolearr[i1].rnum].CurrentHP > 0 then
          Dec(tmp);
        if tmp = -1 then
        begin
          HurtValueAI(mpbdata[id].BTeam[3].rolearr[i].rnum, mpbdata[id].BTeam[2].rolearr[i1].rnum,
            Rrole[mpbdata[id].BTeam[3].rolearr[i].rnum].lmagic[mpbdata[id].BTeam[3].rolearr[i].mag],
            Rrole[mpbdata[id].BTeam[3].rolearr[i].rnum].maglevel[mpbdata[id].BTeam[3].rolearr[i].mag] div 100);
          if Rrole[mpbdata[id].BTeam[2].rolearr[i1].rnum].CurrentHP <= 0 then
          begin
            mpbdata[id].BTeam[2].rolearr[i1].mag := -1;
            Dec(l2);
            if l2 < 0 then
            begin
              mpbdata[id].key := -1;
              Rscene[mpbdata[id].snum].inbattle := 0;
              for i2 := 0 to len2 - 1 do
              begin
                if Rrole[mpbdata[id].BTeam[2].RoleArr[i2].rnum].menpai >= 0 then
                  Rrole[mpbdata[id].BTeam[2].RoleArr[i2].rnum].weizhi := mpbdata[id].BTeam[2].RoleArr[i2].snum;
                Rrole[mpbdata[id].BTeam[2].RoleArr[i2].rnum].dtime := 5;
                if Rrole[mpbdata[id].BTeam[2].RoleArr[i2].rnum].TeamState in [1, 2] then
                begin
                  Rrole[mpbdata[id].BTeam[2].RoleArr[i2].rnum].nweizhi := 13;
                  Rrole[mpbdata[id].BTeam[2].RoleArr[i2].rnum].dtime := 1000;
                end
                else
                  Rrole[mpbdata[id].BTeam[2].RoleArr[i2].rnum].nweizhi := -1;
              end;
              for i2 := 0 to len3 - 1 do
              begin
                Rrole[mpbdata[id].BTeam[3].RoleArr[i2].rnum].nweizhi := -1;
                Rrole[mpbdata[id].BTeam[3].RoleArr[i2].rnum].dtime := 0;
              end;
              str := gbktounicode(@Rmenpai[mpbdata[id].defmp].Name);
              str := str + '在' + gbktounicode(@Rscene[mpbdata[id].snum].Name);
              str := str + '戰勝' + gbktounicode(@Rmenpai[mpbdata[id].attmp].Name);
              addtips(str);
              exit;
            end;
          end;
          break;
        end;
      end;
    end;
  end;
  for i := 0 to len2 - 1 do
  begin
    if mpbdata[id].BTeam[2].rolearr[i].mag >= 0 then
    begin
      tmp := random(l3);
      for i1 := 0 to len3 - 1 do
      begin
        if Rrole[mpbdata[id].BTeam[3].rolearr[i1].rnum].CurrentHP > 0 then
          Dec(tmp);
        if tmp = -1 then
        begin
          HurtValueAI(mpbdata[id].BTeam[2].rolearr[i].rnum, mpbdata[id].BTeam[3].rolearr[i1].rnum,
            Rrole[mpbdata[id].BTeam[2].rolearr[i].rnum].lmagic[mpbdata[id].BTeam[2].rolearr[i].mag],
            Rrole[mpbdata[id].BTeam[2].rolearr[i].rnum].maglevel[mpbdata[id].BTeam[2].rolearr[i].mag] div 100);
          if Rrole[mpbdata[id].BTeam[3].rolearr[i1].rnum].CurrentHP <= 0 then
          begin
            mpbdata[id].BTeam[3].rolearr[i1].mag := -1;
            Dec(l3);
            if l3 < 0 then
            begin

              Rscene[mpbdata[id].snum].inbattle := 0;
              zhanlin(mpbdata[id].attmp, mpbdata[id].snum);
              mpbdata[id].key := -1;
              for i2 := 0 to len3 - 1 do
              begin
                if Rrole[mpbdata[id].BTeam[3].RoleArr[i2].rnum].menpai >= 0 then
                  Rrole[mpbdata[id].BTeam[3].RoleArr[i2].rnum].weizhi :=
                    Rmenpai[Rrole[mpbdata[id].BTeam[3].RoleArr[i2].rnum].menpai].zongduo;
                Rrole[mpbdata[id].BTeam[3].RoleArr[i2].rnum].dtime := 5;

              end;
              for i2 := 0 to len2 - 1 do
              begin
                Rrole[mpbdata[id].BTeam[2].RoleArr[i2].rnum].nweizhi := -1;
                Rrole[mpbdata[id].BTeam[2].RoleArr[i2].rnum].dtime := 0;

              end;
              str := gbktounicode(@Rmenpai[mpbdata[id].attmp].Name);
              str := str + '從' + gbktounicode(@Rmenpai[mpbdata[id].defmp].Name);
              str := str + '手中奪取' + gbktounicode(@Rscene[mpbdata[id].snum].Name);
              addtips(str);
              exit;
            end;
          end;
          break;
        end;
      end;
    end;
  end;

end;

procedure HurtValueAI(Rnum1, Rnum2, mnum, level: integer);
var
  i, l1, c, mhurt, p, def, mp1, mp2, addatt, att, spd2, wpn2, spd1, wpn1, k1, k2, knowledge, dis, res: integer;
  a1, s1, m1, w1: double;
begin

  mhurt := CalNewHurtValue(level, Rmagic[mnum].MinHurt, Rmagic[mnum].MaxHurt, Rmagic[mnum].HurtModulus);

  p := Rmagic[mnum].AttackModulus * 6 + Rmagic[mnum].MPModulus + Rmagic[mnum].SpeedModulus *
    2 + Rmagic[mnum].WeaponModulus * 2;
  att := GetRoleAttack(rnum1, True) + 1;
  def := GetRoleDefence(rnum2, True) + 1;

  case Rmagic[mnum].MagicType of
    0: begin wpn1 := 0; wpn2 := 0; end;
    1: begin wpn1 := GetRoleFist(rnum1, True) + 1; wpn2 := GetRoleFist(rnum2, True) + 1; end;
    2: begin wpn1 := GetRoleSword(rnum1, True) + 1; wpn2 := GetRoleSword(rnum2, True) + 1; end;
    3: begin wpn1 := GetRoleKnife(rnum1, True) + 1; wpn2 := GetRoleKnife(rnum2, True) + 1; end;
    4: begin wpn1 := GetRoleUnusual(rnum1, True) + 1; wpn2 := GetRoleUnusual(rnum2, True) + 1; end;
  end;
  mp1 := Rrole[rnum1].CurrentMP + 1;
  mp2 := Rrole[rnum2].CurrentMP + 1;

  spd1 := GetRoleSpeed(rnum1, True) + 1;
  spd2 := GetRoleSpeed(rnum2, True) + 1;
  if CheckEquipSet(Rrole[rnum1].Equip[0], Rrole[rnum1].Equip[1], Rrole[rnum1].Equip[2], Rrole[rnum1].Equip[3]) = 5 then
  begin
    Inc(att, 50);
    Inc(spd1, 30);
  end;
  if CheckEquipSet(Rrole[rnum2].Equip[0], Rrole[rnum2].Equip[1], Rrole[rnum2].Equip[2], Rrole[rnum2].Equip[3]) = 5 then
  begin
    Inc(def, -25);
    Inc(spd2, 30);
  end;

  //showmessage(inttostr(att)+''+inttostr(def));
  res := 0;
  att := max(att, 1);
  def := max(def, 1);
  spd1 := max(spd1, 1);
  wpn1 := max(wpn1, 1);
  mp1 := max(mp1, 1);
  spd2 := max(spd2, 1);
  wpn2 := max(wpn2, 1);
  mp2 := max(mp2, 1);
  a1 := att - def;
  s1 := spd1 - spd2;
  w1 := wpn1 - wpn2;
  m1 := mp1 - mp2;
  if a1 < 5 then a1 := 5;
  if w1 < 5 then w1 := 5;
  if s1 < 5 then s1 := 5;
  if m1 < 5 then m1 := 5;
  a1 := min((a1 / att), 1);
  w1 := min((w1 / wpn1), 1);
  s1 := min((s1 / spd1), 1);
  m1 := min((m1 / mp1), 1);
  if p > 0 then
  begin
    if Rmagic[mnum].AttackModulus > 0 then
      res := res + trunc(mhurt * a1 * (Rmagic[mnum].AttackModulus * 3 * 2 / p));
    if Rmagic[mnum].MPModulus > 0 then
      res := res + trunc(mhurt * m1 * (Rmagic[mnum].MPModulus / p));
    if Rmagic[mnum].SpeedModulus > 0 then
      res := res + trunc(mhurt * s1 * (Rmagic[mnum].SpeedModulus * 2 / p));
    if Rmagic[mnum].WeaponModulus > 0 then
      res := res + trunc(mhurt * w1 * (Rmagic[mnum].WeaponModulus * 2 / p));
  end;
  res := res + random(10) - random(10);
  if res < mhurt div 20 then
    res := mhurt div 20 + random(5) - random(5);


  if (res <= 0) or (level <= 0) then
    res := random(10) + 1;
  if (res > 9999) then
    res := 9999;

  Rrole[rnum1].CurrentMP := max(0, Rrole[rnum1].CurrentMP - level * Rmagic[mnum].NeedMP);
  Rrole[rnum2].CurrentHP := max(0, Rrole[rnum2].CurrentHP - res);
end;

procedure newdizijoin;
var
  i, k, rnum, ran, mpnum: integer;
begin
  k := -1;
  if Rrole[0].menpai >= 0 then
    if Rmenpai[Rrole[0].menpai].zmr = 0 then
      k := Rrole[0].menpai;
  for i := 0 to length(Rscene) - 1 do
  begin
    if (Rscene[i].menpai >= 0) then
    begin
      mpnum := Rscene[i].menpai;
      if mpnum <> k then
      begin
        if random(20000) < (Rmenpai[mpnum].shengwang + Rmenpai[mpnum].dzq * 10 - 800 -
          Rmenpai[mpnum].dizi * 20 - random(Rmenpai[mpnum].dizi * 30)) then
        begin
          rnum := aotobuildrole(mpnum, 1, -1, -1);
          if rnum > 0 then
          begin
            joinmenpai(rnum, Rmenpai[mpnum].zmr);
            Rrole[rnum].weizhi := i;
          end;
        end;
      end;
    end;
  end;
end;

procedure dalyrestore;
var
  i, hx: integer;
begin

  for i := 0 to length(Rrole) - 1 do
  begin
    if (Rrole[i].headNum < 0) or ((Rrole[i].dtime >= 1000) and ((Rrole[i].nweizhi = 16) or (Rrole[i].nweizhi = 20))) then
    begin
      continue;
    end;
    hx := Rrole[i].rehurt;
    Rrole[i].CurrentHP := max(1, min(Rrole[i].CurrentHP + Rrole[i].MaxHP div 20 +
      (Rrole[i].MaxHP - Rrole[i].CurrentHP) div 20 - (Rrole[i].Hurt + Rrole[i].Poision) *
      Rrole[i].CurrentHP div 200, Rrole[i].MaxHP));
    Rrole[i].CurrentMP := max(1, min(Rrole[i].CurrentMP + Rrole[i].MaxMP div 20 +
      (Rrole[i].MaxMP - Rrole[i].CurrentMP) div 20 - (Rrole[i].Hurt + Rrole[i].Poision) *
      Rrole[i].CurrentMP div 200, Rrole[i].MaxMP));
    Rrole[i].PhyPower := max(1, min(100, Rrole[i].PhyPower + 3 - (Rrole[i].Hurt + Rrole[i].Poision) div 50));
    if Rrole[i].Hurt <= 33 then
      hx := hx + 2
    else if (Rrole[i].Hurt > 33) and (Rrole[i].Hurt <= 66) then
      hx := hx + 1
    else if (Rrole[i].Hurt > 66) then
      hx := hx + random(2) - 1;
    Rrole[i].Hurt := min(100, Rrole[i].Hurt - hx);
    if Rrole[i].Hurt <= 0 then
    begin
      Rrole[i].Hurt := 0;
      Rrole[i].rehurt := 0;
    end;
  end;
end;
//讀取戰場語錄

procedure initialBTalk;
var
  pword: array[0..1] of uint16;
  strs: WideString;
  i, i1, grp, idx, offset, len, Count, talknum, Rcount: integer;
  talkarray: array of byte;
  tp: pchar;
begin
  Rcount := 630;
  if Rcount > 0 then
  begin
    pword[1] := 0;
    idx := FileOpen('resource\btyulu.idx', fmopenread);
    grp := FileOpen('resource\btyulu.grp', fmopenread);
    Count := FileSeek(idx, 0, 2) div 4;
    if Count > 1 then
    begin
      for i := 1 to Rcount do
      begin
        if i = 0 then
        begin
          offset := 0;
          FileRead(idx, len, 4);
        end
        else
        begin
          FileSeek(idx, (i - 1) * 4, 0);
          FileRead(idx, offset, 4);
          FileRead(idx, len, 4);
        end;
        len := (len - offset);
        setlength(talkarray, len + 2);
        FileSeek(grp, offset, 0);
        FileRead(grp, talkarray[0], len);

        for i1 := 0 to len - 1 do
        begin
          talkarray[i1] := talkarray[i1] xor $FF;
          if (talkarray[i1] = $FF) then
            talkarray[i1] := 0;
        end;
        talkarray[len] := byte(0);
        talkarray[len + 1] := byte(0);
        if (talkarray[len - 2] = 126) and (talkarray[len - 1] = 96) then
          break;
        tp := @talkarray[0];
        if (i < 601) then
          allBTalk.talk[(i - 1) div 300][((i - 1) mod 300) div 100][(((i - 1) mod 100) div 10)][
            ((i - 1) mod 100) mod 10] := gbktounicode(tp)
        else if i >= 601 then
          allBTalk.etalk[(i - 601) div 10][(i - 601) mod 10] := gbktounicode(tp);
      end;
    end;
    FileClose(idx);
    FileClose(grp);
  end;

end;

end.
