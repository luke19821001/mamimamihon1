unit kys_battle;

interface

uses
  SysUtils,
  Windows,
  StrUtils,
  Math,
  Dialogs,
  SDL,
  SDL_TTF,
  //SDL_mixer,
  bass,
  kys_type,
  SDL_image,
  kys_main;

//战斗
//从游戏文件的命名来看, 应是'war'这个词的缩写,
//但实际上战斗的规模很小, 使用'battle'显然更合适
function Battle(battlenum, getexp, mods, id: integer): boolean; overload;
function Battle(battlenum, getexp: integer): boolean; overload;
function InitialBField(mods, id: integer): boolean; overload;
function InitialBField: boolean; overload;
function SelectTeamMembers: integer;
procedure ShowMultiMenu(max0, menu, status: integer);
procedure BattleMainControl; overload;
procedure BattleMainControl(mods, id: integer); overload;
procedure OldBattleMainControl;
function CountProgress(mods: integer): integer;
procedure CalMoveAbility;
procedure ReArrangeBRole;
function BattleStatus: integer;

function BattleMenu(bnum: integer): integer;
procedure ShowBMenu(MenuStatus, menu, max0: integer);
procedure MoveRole(bnum: integer);
procedure MoveAmination(bnum: integer);
procedure Zhuanzhu(bnum: integer);
function Selectshowstatus(bnum: integer): boolean;
function SelectAim(bnum, step,mods: integer): boolean;
function SelectRange(bnum, AttAreaType, step, range,mods: integer): boolean;
function SelectDirector(bnum, AttAreaType, step, range,mods: integer): boolean;
function SelectCross(bnum, AttAreaType, step, range,mods: integer): boolean;
function SelectFar(bnum, mnum, level,mods: integer): boolean;

procedure SeekPath(x, y, step: integer);
procedure SeekPath2(x, y, step, myteam, mode: integer);
procedure CalCanSelect(bnum, mode, step: integer);
procedure Attack(bnum: integer);
procedure AttackAction(bnum, mnum, level: integer);
procedure MedcineAction(bnum, mnum, level: integer);
procedure ShowMagicName(mnum: integer);
function SelectMagic(bnum: integer): integer;
procedure ShowMagicMenu(bnum, MenuStatus, menustatus2, menu, max0, max2, jhmnum, znum: integer);
procedure SetAminationPosition(mode, step, range: integer);
procedure PlayMagicAmination(bnum, bigami, enum, level: integer);
procedure CalHurtRole(bnum, mnum, level: integer);
procedure CalMedRole(bnum, mnum, level: integer);
function CalHurtValue(bnum1, bnum2, mnum, level: integer): integer;
function CalMedValue(bnum1, bnum2, mnum, level: integer): integer;
procedure ShowHurtValue(mode: integer); overload;
procedure ShowHurtValue(sign, color1, color2: integer); overload;
procedure ShowHurtValue(str: WideString; color1, color2: integer); overload;
procedure CalPoiHurtLife(bnum: integer);
procedure ClearDeadRolePic;
procedure ShowSimpleStatus(rnum, x, y: integer);
procedure Wait(bnum: integer);
procedure RestoreRoleStatus;
procedure AddExp; overload
procedure AddExp(mods: integer); overload
procedure CheckLevelUp;
procedure LevelUp(bnum: integer);
procedure LevelUp2(rnum: integer);
procedure CheckBook;
function CalRNum(team: integer): integer;
procedure BattleMenuItem(bnum: integer);
procedure UsePoision(bnum: integer);
procedure PlayActionAmination(bnum, mode: integer);
procedure Medcine(bnum: integer);
procedure MedFrozen(bnum: integer);
procedure MedPoision(bnum: integer);
procedure UseHiddenWeapen(bnum, inum: integer);
procedure Rest(bnum: integer);
procedure showprogress;
procedure AutoBattle(bnum: integer);
function AutoUseItem(bnum, list, mods: integer): boolean;
procedure PetEffect;
procedure AutoBattle2(bnum: integer);
procedure TryMoveAttack(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer; bnum, mnum, level: integer);
procedure calline(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer; curX, curY, bnum, mnum, level: integer);
procedure CalArea(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer; curX, curY, bnum, mnum, level: integer);
procedure calNewline(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer; curX, curY, bnum, mnum, level: integer);
procedure CalPoint(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer; curX, curY, bnum, mnum, level: integer);
procedure calcross(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer; curX, curY, bnum, mnum, level: integer);
procedure caldirdiamond(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer;
  curX, curY, bnum, mnum, level: integer);
procedure caldirangle(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer; curX, curY, bnum, mnum, level: integer);
procedure calfar(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer; curX, curY, bnum, mnum, level: integer);
procedure NearestMove(var Mmx, Mmy: integer; bnum: integer);
procedure FarthestMove(var Mmx, Mmy: integer; bnum: integer);
procedure TryMoveCure(var Mx1, My1, Ax1, Ay1: integer; bnum: integer);
procedure CureAction(bnum: integer);
procedure ShowModeMenu(menu: integer);
function SelectAutoMode: integer;
procedure ShowTeamModeMenu(menu: integer);
function TeamModeMenu: boolean;
procedure Auto(bnum: integer);
function SelectLine(bnum, AttAreaType, step, range,mods: integer): boolean;
function CalNewHurtValue(lv, min, max0, Proportion: integer): integer;
function ReMoveHurt(bnum, AttackBnum: integer): smallint;
function RetortHurt(bnum, AttackBnum: integer): smallint;
procedure Hiddenaction(bnum, inum: integer);
procedure trymoveHidden(var Mx1, My1, Ax1, Ay1: integer; bnum, inum: integer);
procedure trymoveUsePoi(var Mx1, My1, Ax1, Ay1: integer; bnum: integer);
procedure UsePoiaction(bnum: integer);
procedure trymoveMedPoi(var Mx1, My1, Ax1, Ay1: integer; bnum: integer);
procedure MedPoiaction(bnum: integer);
procedure Showzhaoshi(bnum, znum, mods: integer); //显示招式
function checkfangyu(var fmnum, fmlev, frznum: integer; rnum, znum: integer): integer; //检查选择防御招式
procedure PlayMagicAmination2(bnum, bigami, enum, level: integer); //画单人特效；

procedure diexiaoguo(bnum: integer); //死亡加成
procedure addzhuangtai(bnum, mnum, level: integer); //使用狀態武功
procedure PlayNuAmination(bnum: integer);
procedure zengyuan(mods, id: integer);
function courthurt(bnum1, bnum2, mnum, level: integer; var tzhaoshi1: integer): integer;
procedure finishmpbattle(mods, bstatus, id: integer);
//战斗中增加武功经验
procedure magicexp(bnum, mnum, level, rmnum: integer);
//查找临近某队友的可插入位置
function FindFightPos(team:integer):Tposition;
implementation

uses
  kys_event,
  kys_engine,
  kys_script,
  sty_engine,
  sty_show,
  sty_newevent;

//Battle.
//战斗, 返回值为是否胜利

function Battle(battlenum, getexp: integer): boolean; overload
begin
  Result := Battle(battlenum, getexp, -1, -1);
end;

function Battle(battlenum, getexp, mods, id: integer): boolean; overload
var
  i, i1, j, j1, k, k1, SelectTeamList, W, x, b, y, len, Count, n0: integer;
  word: WideString;
  trnum: array of smallint;
  pos1:Tposition;
begin
  for i := 0 to length(Brole) - 1 do
  begin
    Brole[i].x := -1;
    Brole[i].y := -1;
    Brole[i].Show := 1;
  end;
  Bstatus := 0;
  isbattle := True;
  b := 0; //于BRoleAmount是全局变量不同
  k1 := 0;
  W := WHERE;
  CurrentBattle := battlenum;
  SDL_EventState(SDL_MOUSEMOTION, SDL_ENABLE);
  BshowBWord.sign := 0;

  if (InitialBField(mods, id) and (mods > -2)) then
  begin
    //如果未发现自动战斗设定, 则选择人物
    if mods = -1 then SelectTeamList := SelectTeamMembers
    else if mods > -1 then SelectTeamList := 2;
    BRoleAmount := 0;
    for i := 0 to length(warsta.mate) - 1 do
    begin
      if SelectTeamList and (1 shl (i + 1)) > 0 then
      begin
        Brole[BRoleAmount].rnum := TeamList[i];
        y := warsta.mate_x[b];
        x := warsta.mate_y[b];
        Brole[BRoleAmount].Y := y;
        Brole[BRoleAmount].X := x;
        Brole[BRoleAmount].Team := 0;
        Brole[BRoleAmount].Face := 2;
        if Brole[BRoleAmount].rnum = -1 then
        begin
          Brole[BRoleAmount].Dead := 1;
          Brole[BRoleAmount].Show := 1;
        end
        else
        begin
          Brole[BRoleAmount].Dead := 0;
          Brole[BRoleAmount].Show := 0;
        end;
        Brole[BRoleAmount].Step := 0;
        Brole[BRoleAmount].Acted := 0;
        Brole[BRoleAmount].ExpGot := 0;
        Brole[BRoleAmount].Auto := -1;
        Brole[BRoleAmount].Show := 0;
        Brole[BRoleAmount].Progress := 0;
        Brole[BRoleAmount].round := 0;
        Brole[BRoleAmount].Wait := 0;
        Brole[BRoleAmount].frozen := 0;
        Brole[BRoleAmount].killed := 0;
        Brole[BRoleAmount].Knowledge := 0;
        Brole[BRoleAmount].zhuanzhu := 0;
        Brole[BRoleAmount].szhaoshi := 0;
        Brole[BRoleAmount].pozhao := 0;
        Brole[BRoleAmount].wanfang := 0;
        for j := 0 to 4 do
        begin
          n0 := 0;
          if Brole[BRoleAmount].rnum > -1 then
            for j1 := 0 to 9 do
              if Rrole[Brole[BRoleAmount].rnum].Gongti > 0 then
                if (Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].MoveDistance[j1] = 60 + j) then
                  n0 := Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].AttDistance[j1];
          Brole[BRoleAmount].zhuangtai[j] := 100;
          Brole[BRoleAmount].lzhuangtai[j] := n0;
        end;
        for j := 5 to 9 do
        begin
          n0 := 0;
          if Brole[BRoleAmount].rnum > -1 then
            for j1 := 0 to 9 do
              if Rrole[Brole[BRoleAmount].rnum].Gongti > 0 then
                if (Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].MoveDistance[j1] = 60 + j) then
                  n0 := Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].AttDistance[j1];
          Brole[BRoleAmount].zhuangtai[j] := n0;
          Brole[BRoleAmount].lzhuangtai[j] := n0;
        end;
        for j := 10 to 13 do
          Brole[BRoleAmount].zhuangtai[j] := 0;

        b := b + 1;
        BRoleAmount := BRoleAmount + 1;
      end;
    end;
  end;

  if (mods = -2) then
  begin
    Rscene[mpbdata[id].snum].inbattle := 1;
    len := 0;
    for i := 1 to length(Rrole) - 1 do
    begin
      if (((Rrole[i].menpai = Rscene[mpbdata[id].snum].menpai) and (Rrole[i].weizhi = mpbdata[id].snum) and
        (Rrole[i].dtime < 5) and (Rrole[i].CurrentHP > 0)) {or (Rrole[i].TeamState in [1, 2])}) then
      begin
        setlength(trnum, len + 1);
        trnum[len] := i;
        Inc(len);
      end;
    end;
    if len > 0 then levsort(trnum);
    len := length(mpbdata[id].BTeam[0].rolearr);
    for i := 0 to length(trnum) - 1 do
    begin
      if len < 0 then
      begin
        len := 0;
      end;
      setlength(mpbdata[id].BTeam[0].RoleArr, len + 1);
      mpbdata[id].BTeam[0].RoleArr[len].rnum := trnum[i];
      mpbdata[id].BTeam[0].RoleArr[len].snum := Rrole[trnum[i]].weizhi;
      mpbdata[id].BTeam[0].RoleArr[len].isin := 0;
      Rrole[trnum[i]].nweizhi := 16;
      Rrole[trnum[i]].dtime := 1000;
      Inc(len);
    end;
  end;
  if mods < -1 then
  begin
    k:=0;
    len := length(mpbdata[id].BTeam[0].rolearr);
    for i := 0 to len - 1 do
    begin
      if ((mods = -3) and (k >= 9)) or (k > 9) then
      begin
        break;
      end;

      if (Rrole[mpbdata[id].BTeam[0].RoleArr[i].rnum].CurrentHP <=0) then
      begin
        continue;
      end;
      Brole[BRoleAmount].rnum := mpbdata[id].BTeam[0].RoleArr[i].rnum;
      mpbdata[id].BTeam[0].RoleArr[i].isin := 1;
      if mods = -3 then
      begin
        if k1 = 4 then Inc(k1);
        Brole[BRoleAmount].X := Rscene[mpbdata[id].snum].qizhiy + k1 div 3 - 1;
        Brole[BRoleAmount].Y := Rscene[mpbdata[id].snum].qizhix + k1 mod 3 - 1;
        Inc(k1);
      end
      else if mods = -2 then
      begin
        if Rrole[Brole[BRoleAmount].rnum].HeadNum = 863 + id then
        begin
          Brole[BRoleAmount].X := Rscene[mpbdata[id].snum].qizhiy;
          Brole[BRoleAmount].Y := Rscene[mpbdata[id].snum].qizhix;
          Dec(k1);
        end
        else if k1 < 3 then
        begin
          Brole[BRoleAmount].X := Rscene[mpbdata[id].snum].lwcy[k1];
          Brole[BRoleAmount].Y := Rscene[mpbdata[id].snum].lwcx[k1] + 1;
        end
        else if k1 < 6 then
        begin
          Brole[BRoleAmount].X := Rscene[mpbdata[id].snum].cjgy[k1 - 3] + 1;
          Brole[BRoleAmount].Y := Rscene[mpbdata[id].snum].cjgx[k1 - 3];
        end
        else if k1 = 6 then
        begin
          Brole[BRoleAmount].X := Rscene[mpbdata[id].snum].bgsy + 1;
          Brole[BRoleAmount].Y := Rscene[mpbdata[id].snum].bgsx;
        end
        else if k1 = 7 then
        begin
          Brole[BRoleAmount].X := Rscene[mpbdata[id].snum].ldly;
          Brole[BRoleAmount].Y := Rscene[mpbdata[id].snum].ldlx + 1;
        end
        else if k1 = 8 then
        begin
          Brole[BRoleAmount].X := Rscene[mpbdata[id].snum].bqcy;
          Brole[BRoleAmount].Y := Rscene[mpbdata[id].snum].bqcx + 1;
        end;
        Inc(k1);
      end;
      Brole[BRoleAmount].Team := 0;
      Brole[BRoleAmount].Face := 2;
      if Brole[BRoleAmount].rnum = -1 then
      begin
        Brole[BRoleAmount].Dead := 1;
        Brole[BRoleAmount].Show := 1;
      end
      else if Rrole[Brole[BRoleAmount].rnum].CurrentHP > 0 then
      begin
        Brole[BRoleAmount].Dead := 0;
        Brole[BRoleAmount].Show := 0;

      end;
      Brole[BRoleAmount].Step := 0;
      Brole[BRoleAmount].Acted := 0;
      Brole[BRoleAmount].ExpGot := 0;
      Brole[BRoleAmount].Auto := -1;
      Brole[BRoleAmount].Show := 0;
      Brole[BRoleAmount].Progress := 0;
      Brole[BRoleAmount].round := 0;
      Brole[BRoleAmount].Wait := 0;
      Brole[BRoleAmount].frozen := 0;
      Brole[BRoleAmount].killed := 0;
      Brole[BRoleAmount].Knowledge := 0;
      Brole[BRoleAmount].Zhuanzhu := 0;

      Brole[BRoleAmount].szhaoshi := 0;
      Brole[BRoleAmount].pozhao := 0;
      Brole[BRoleAmount].wanfang := 0;
      //設置門派重器
      if Rrole[Brole[BRoleAmount].rnum].HeadNum = 863 then
        for j := 0 to 4 do
          Brole[BRoleAmount].zhuangtai[j] := 0
      else
      begin
        for j := 0 to 4 do
        begin
          n0 := 0;
          if Brole[BRoleAmount].rnum > -1 then
            for j1 := 0 to 9 do
              if Rrole[Brole[BRoleAmount].rnum].Gongti > 0 then
                if (Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].MoveDistance[j1] = 60 + j) then
                  n0 := Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].AttDistance[j1];
          Brole[BRoleAmount].zhuangtai[j] := 100;
          Brole[BRoleAmount].lzhuangtai[j] := n0;
        end;
        for j := 5 to 9 do
        begin
          n0 := 0;
          if Brole[BRoleAmount].rnum > -1 then
            for j1 := 0 to 9 do
              if Rrole[Brole[BRoleAmount].rnum].Gongti > 0 then
                if (Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].MoveDistance[j1] = 60 + j) then
                  n0 := Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].AttDistance[j1];
          Brole[BRoleAmount].zhuangtai[j] := n0;
          Brole[BRoleAmount].lzhuangtai[j] := n0;
        end;
      end;
      for j := 10 to 13 do
      begin
        Brole[BRoleAmount].zhuangtai[j] := 0;
      end;
      inc(k);
      BRoleAmount := BRoleAmount + 1;

    end;
  end
  else
  begin
    for i := 0 to length(warsta.mate) - 1 do
    begin
      if (warsta.mate[i] > 0) and (Rrole[warsta.mate[i]].TeamState <> 1) then
      begin
        y := warsta.mate_x[b];
        x := warsta.mate_y[b];
        if (mods = -1) then Brole[BRoleAmount].rnum := warsta.mate[i]
        else Brole[BRoleAmount].rnum := -1;
        Brole[BRoleAmount].Team := 0;
        Brole[BRoleAmount].Y := y;
        Brole[BRoleAmount].X := x;
        Brole[BRoleAmount].Face := 2;
        if (Brole[BRoleAmount].rnum = -1) or (mods > -1) then
        begin
          Brole[BRoleAmount].Dead := 1;
          Brole[BRoleAmount].Show := 1;
        end
        else
        begin
          Brole[BRoleAmount].Dead := 0;
          Brole[BRoleAmount].Show := 0;

        end;
        if Brole[BRoleAmount].rnum > -1 then
          if (not ((Rrole[Brole[BRoleAmount].rnum].TeamState = 1) or
            (Rrole[Brole[BRoleAmount].rnum].TeamState = 2)) and not
            (Rrole[Brole[BRoleAmount].rnum].MenPai = Rrole[0].MenPai)) then
            aotosetmagic(Brole[BRoleAmount].rnum);
        Brole[BRoleAmount].Step := 0;
        Brole[BRoleAmount].Acted := 0;
        Brole[BRoleAmount].ExpGot := 0;
        if Brole[BRoleAmount].rnum = 0 then Brole[BRoleAmount].Auto := -1
        else Brole[BRoleAmount].Auto := 3;
        Brole[BRoleAmount].Show := 0;
        Brole[BRoleAmount].Progress := 0;
        Brole[BRoleAmount].round := 0;
        Brole[BRoleAmount].Wait := 0;
        Brole[BRoleAmount].frozen := 0;
        Brole[BRoleAmount].killed := 0;
        Brole[BRoleAmount].Knowledge := 0;
        Brole[BRoleAmount].Zhuanzhu := 0;

        Brole[BRoleAmount].szhaoshi := 0;
        Brole[BRoleAmount].pozhao := 0;
        Brole[BRoleAmount].wanfang := 0;
        for j := 0 to 4 do
        begin
          n0 := 0;
          if Brole[BRoleAmount].rnum > -1 then
            for j1 := 0 to 9 do
              if Rrole[Brole[BRoleAmount].rnum].Gongti > 0 then
                if (Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].MoveDistance[j1] = 60 + j) then
                  n0 := Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].AttDistance[j1];
          Brole[BRoleAmount].zhuangtai[j] := 100;
          Brole[BRoleAmount].lzhuangtai[j] := n0;
        end;
        for j := 5 to 9 do
        begin
          n0 := 0;
          if Brole[BRoleAmount].rnum > -1 then
            for j1 := 0 to 9 do
              if Rrole[Brole[BRoleAmount].rnum].Gongti > 0 then
                if (Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].MoveDistance[j1] = 60 + j) then
                  n0 := Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].AttDistance[j1];
          Brole[BRoleAmount].zhuangtai[j] := n0;
          Brole[BRoleAmount].lzhuangtai[j] := n0;
        end;
        for j := 10 to 13 do
          Brole[BRoleAmount].zhuangtai[j] := 0;
        b := b + 1;
        BRoleAmount := BRoleAmount + 1;
      end;
    end;
  end;
  for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].rnum >= 0) then
    begin
      if (Brole[i].Dead = 0) then
      begin
        Bfield[2, Brole[i].X, Brole[i].Y] := i;
      end;
    end;
  end;
  while ((mods = -1) and (xunchou.num > 0)) do
  begin
    for i := 0 to 41 do
    begin
      if Brole[i].rnum < 0 then
      begin
        pos1:=FindFightPos(xunchou.team[xunchou.num - 1]);
        if (pos1.x < 0) or (pos1.y < 0) then
          break;
        Brole[i].rnum := xunchou.rnumlist[xunchou.num - 1];

        Brole[i].Team := xunchou.team[xunchou.num - 1];
        dec(xunchou.num);
        setlength(xunchou.rnumlist,xunchou.num);
        setlength(xunchou.team,xunchou.num);
        Brole[i].Y := pos1.y;
        Brole[i].X := pos1.x;
        Bfield[2, pos1.X, pos1.Y] := i;
        Brole[i].Face := 0;
        Brole[i].Dead := 0;
        Brole[i].Show := 0;
        aotosetmagic(Brole[i].rnum);
        Brole[i].Step := 0;
        Brole[i].Acted := 0;
        Brole[i].ExpGot := 0;
        Brole[i].Auto := 3;
        Brole[i].Show := 0;
        Brole[i].Progress := 0;
        Brole[i].round := 0;
        Brole[i].Wait := 0;
        Brole[i].frozen := 0;
        Brole[i].killed := 0;
        Brole[i].Knowledge := 0;
        Brole[i].Zhuanzhu := 0;
        Brole[i].szhaoshi := 0;
        Brole[i].pozhao := 0;
        Brole[i].wanfang := 0;
        for j := 0 to 4 do
        begin
          n0 := 0;
          if Brole[i].rnum > -1 then
            for j1 := 0 to 9 do
              if Rrole[Brole[i].rnum].Gongti > 0 then
                if (Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MoveDistance[j1] = 60 + j) then
                  n0 := Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].AttDistance[j1];
          Brole[i].zhuangtai[j] := 100;
          Brole[i].lzhuangtai[j] := n0;
        end;
        for j := 5 to 9 do
        begin
          n0 := 0;
          if Brole[i].rnum > -1 then
            for j1 := 0 to 9 do
              if Rrole[Brole[i].rnum].Gongti > 0 then
                if (Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MoveDistance[j1] = 60 + j) then
                  n0 := Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].AttDistance[j1];
          Brole[i].zhuangtai[j] := n0;
          Brole[i].lzhuangtai[j] := n0;
        end;
        for j := 10 to 13 do
          Brole[i].zhuangtai[j] := 0;
        break;
      end; //for
    end; //if

  end;
  instruct_14;
  Where := 2;
  resetpallet;
  InitialWholeBField; //初始化场景

  StopMP3;
  PlayMP3(warsta.battlemusic, -1);
  CurBrole := 0;

  if battlemode > 0 then
    BattleMainControl(mods, id)
  else
    OldBattleMainControl;
  // callevent(warsta.OperationEvent);
  RestoreRoleStatus;

  if (bstatus = 1) then
    word := '戰鬥勝利'
  else word := '戰鬥失敗';
  DrawTextWithRect(@word[1], CENTER_X - 20, 55, 90, ColColor(0, 5), ColColor(0, 7));
  WaitAnyKey;
  Redraw;

  if (bstatus = 1) or ((bstatus = 2) and (getexp = 1)) then
  begin
    for i := 0 to length(Brole) - 1 do
    begin
      Brole[i].Progress := 0;
    end;
    if (bstatus = 1) and (mods < 0) then PetEffect;
    AddExp(mods);
    CheckLevelUp;
    CheckBook;
  end;
  if mods < -1 then
  begin
    finishmpbattle(mods, bstatus, id);
  end;
  sdl_updaterect(screen, 0, 0, screen.w, screen.h);
  if RScene[CurScene].EntranceMusic >= 0 then
  begin
    StopMP3;
    PlayMP3(RScene[CurScene].EntranceMusic, -1);
  end;
  Where := W;
  resetpallet;
  if bstatus = 1 then Result := True
  else Result := False;
  isbattle := False;
  SDL_EventState(SDL_MOUSEMOTION, SDL_ignore);
  SDL_EnableKeyRepeat(30, (30 * GameSpeed) div 10);
end;

procedure finishmpbattle(mods, bstatus, id: integer);
var
  j: integer;
begin
  Rscene[mpbdata[id].snum].inbattle := 0;
  mpbdata[id].key := -1;
  if ((mods = -2) and (bstatus = 1)) or ((mods = -3) and (bstatus = 2)) then
  begin
    for j := 0 to length(mpbdata[id].BTeam[1].RoleArr) - 1 do
    begin
      Rrole[mpbdata[id].BTeam[1].RoleArr[j].rnum].weizhi := mpbdata[id].BTeam[1].RoleArr[j].snum;
      Rrole[mpbdata[id].BTeam[1].RoleArr[j].rnum].nweizhi := -1;
      if mods = -2 then
      begin
        Rrole[mpbdata[id].BTeam[1].RoleArr[j].rnum].nweizhi := 14;
        Rrole[mpbdata[id].BTeam[1].RoleArr[j].rnum].dtime := 5;
      end
      else
        Rrole[mpbdata[id].BTeam[1].RoleArr[j].rnum].dtime := 0;
    end;
    for j := 0 to length(mpbdata[id].BTeam[0].RoleArr) - 1 do
    begin
      Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].weizhi := mpbdata[id].BTeam[0].RoleArr[j].snum;
      if mods = -3 then
        Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].dtime := 5
      else
        Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].dtime := 0;
      if Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].TeamState in [1, 2] then
      begin
        Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].nweizhi := 13;
        Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].dtime := 1000;
      end
      else
        Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].nweizhi := 14;
    end;
  end
  else if (mods = -3) and (bstatus = 1) then //玩家进攻并战胜
  begin

    for j := 0 to length(mpbdata[id].BTeam[0].RoleArr) - 1 do
    begin
      Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].weizhi := mpbdata[id].snum;

      Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].dtime := 0;
      if Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].TeamState in [1, 2] then
      begin
        Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].nweizhi := 13;
        Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].dtime := 1000;
      end
      else
        Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].nweizhi := -1;
    end;
    for j := 0 to length(mpbdata[id].BTeam[1].RoleArr) - 1 do
    begin
      if Rrole[mpbdata[id].BTeam[1].RoleArr[j].rnum].menpai >= 0 then
      begin
        Rrole[mpbdata[id].BTeam[1].RoleArr[j].rnum].weizhi :=
          Rmenpai[Rrole[mpbdata[id].BTeam[1].RoleArr[j].rnum].menpai].zongduo;
      end;
      Rrole[mpbdata[id].BTeam[1].RoleArr[j].rnum].nweizhi := -1;
      Rrole[mpbdata[id].BTeam[1].RoleArr[j].rnum].dtime := 5;
    end;
    zhanlin(mpbdata[id].attmp, mpbdata[id].snum);
  end
  else if (mods = -2) and (bstatus = 2) then //玩家防守失败
  begin

    for j := 0 to length(mpbdata[id].BTeam[0].RoleArr) - 1 do
    begin
      if Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].menpai >= 0 then
      begin
        Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].weizhi := Rmenpai[mpbdata[id].BTeam[0].RoleArr[j].rnum].zongduo;
      end;
      Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].dtime := 5;
      if Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].TeamState in [1, 2] then
      begin
        Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].nweizhi := 13;
        Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].dtime := 1000;
      end
      else
        Rrole[mpbdata[id].BTeam[0].RoleArr[j].rnum].nweizhi := -1;
    end;
    for j := 0 to length(mpbdata[id].BTeam[1].RoleArr) - 1 do
    begin
      Rrole[mpbdata[id].BTeam[1].RoleArr[j].rnum].weizhi := mpbdata[id].snum;

      Rrole[mpbdata[id].BTeam[1].RoleArr[j].rnum].nweizhi := -1;
      Rrole[mpbdata[id].BTeam[1].RoleArr[j].rnum].dtime := 0;
    end;
    zhanlin(mpbdata[id].attmp, mpbdata[id].snum);
  end;
end;
//Structure of Bfield arrays:
//0: Ground; 1: Building; 2: Roles(Rrnum);

//Structure of Brole arrays:
//the 1st pointer is "Battle Num";
//The 2nd: 0: rnum, 1: Friend or enemy, 2: y, 3: x, 4: Face, 5: Dead or alive,
//         7: Acted, 8: Pic Num, 9: The number, 10, 11, 12: Auto, 13: Exp gotten.
//初始化战场

function InitialBField: boolean; overload;
begin
  Result := InitialBField(-1, -1);
end;

function InitialBField(mods, id: integer): boolean; overload;
var
  sta, grp, autocount, idx, offset, l, i, i1, i2, j, j1, x, y, k,fieldnum, k1, len0, len, n0: integer;
  p: puint16;
  cc: uint16;
  trnum: array of smallint;
  pos1:Tposition;
begin
  sta := FileOpen('resource\war.sta', fmopenread);
  offset := FileSeek(sta, 0, 2);
  if offset < currentbattle * sizeof(warsta) then currentbattle := 0;
  l := sizeof(warsta);
  offset := currentbattle * l;
  FileSeek(sta, offset, 0);
  FileRead(sta, warsta, l);
  FileClose(sta);

  fieldnum := warsta.battlemap;
  if mods > -2 then
  begin
    if fieldnum = 0 then offset := 0
    else
    begin
      idx := FileOpen('resource\warfld.idx', fmopenread);
      FileSeek(idx, (fieldnum - 1) * 4, 0);
      FileRead(idx, offset, 4);
      FileClose(idx);
    end;
    grp := FileOpen('resource\warfld.grp', fmopenread);
    FileSeek(grp, offset, 0);
    FileRead(grp, Bfield[0, 0, 0], 2 * 64 * 64 * 2);
    FileClose(grp);
  end
  else
  begin
    for i := 0 to 1 do
      for i1 := 0 to 63 do
        for i2 := 0 to 63 do
          bfield[i, i1, i2] := Sdata[mpbdata[id].snum, i, i1, i2];

  end;
  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
    begin
      Bfield[2, i1, i2] := -1;
      Bfield[5, i1, i2] := -1;
      Bfield[4, i1, i2] := -1;
    end;
  BRoleAmount := 0;
  Result := True;
  for i := 0 to length(Brole) - 1 do
  begin
    Brole[i].Team := 1;
    Brole[i].rnum := -1;
  end;
  autocount := 0;
  //我方自动参战数据
  if mods >= -1 then
  begin
    for i := 0 to length(warsta.mate) - 1 do
    begin
      y := warsta.mate_x[i];
      x := warsta.mate_y[i];
      if mods = -1 then Brole[BRoleAmount].rnum := warsta.automate[i]
      else Brole[BRoleAmount].rnum := -1;
       Brole[BRoleAmount].Team := 0;
      Brole[BRoleAmount].Y := y;
      Brole[BRoleAmount].X := x;
      Brole[BRoleAmount].Face := 2;
      if (Brole[BRoleAmount].rnum = -1) then
      begin
        Brole[BRoleAmount].Dead := 1;
        Brole[BRoleAmount].Show := 1;
      end
      else
      begin
        Brole[BRoleAmount].Dead := 0;
        Brole[BRoleAmount].Show := 0;
        if (not ((Rrole[Brole[BRoleAmount].rnum].TeamState = 1) or (Rrole[Brole[BRoleAmount].rnum].TeamState = 2)) and
          not (Rrole[Brole[BRoleAmount].rnum].MenPai = Rrole[0].MenPai)) then
          aotosetmagic(Brole[BRoleAmount].rnum);
        Inc(autocount);
      end;
      Brole[BRoleAmount].Step := 0;
      Brole[BRoleAmount].Acted := 0;
      Brole[BRoleAmount].ExpGot := 0;
      if Brole[BRoleAmount].rnum = 0 then Brole[BRoleAmount].Auto := -1
      else Brole[BRoleAmount].Auto := 3;
      Brole[BRoleAmount].Progress := 0;
      Brole[BRoleAmount].round := 0;
      Brole[BRoleAmount].Wait := 0;
      Brole[BRoleAmount].frozen := 0;
      Brole[BRoleAmount].killed := 0;
      Brole[BRoleAmount].Knowledge := 0;
      Brole[BRoleAmount].Zhuanzhu := 0;

      Brole[BRoleAmount].szhaoshi := 0;
      Brole[BRoleAmount].pozhao := 0;
      Brole[BRoleAmount].wanfang := 0;
      for j := 0 to 4 do
      begin
        n0 := 0;
        if Brole[BRoleAmount].rnum > -1 then
          for j1 := 0 to 9 do
            if Rrole[Brole[BRoleAmount].rnum].Gongti > 0 then
              if (Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].MoveDistance[j1] = 60 + j) then
                n0 := Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].AttDistance[j1];
        Brole[BRoleAmount].zhuangtai[j] := 100;
        Brole[BRoleAmount].lzhuangtai[j] := n0;
      end;
      for j := 5 to 9 do
      begin
        n0 := 0;
        if Brole[BRoleAmount].rnum > -1 then
          for j1 := 0 to 9 do
            if Rrole[Brole[BRoleAmount].rnum].Gongti > 0 then
              if (Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].MoveDistance[j1] = 60 + j) then
                n0 := Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].AttDistance[j1];
        Brole[BRoleAmount].zhuangtai[j] := n0;
        Brole[BRoleAmount].lzhuangtai[j] := n0;
      end;
      for j := 10 to 13 do
        Brole[BRoleAmount].zhuangtai[j] := 0;
      BRoleAmount := BRoleAmount + 1;
    end;
    //如有自动参战人物, 返回假, 不激活选择人物
    if (autocount > 0) and (mods = -1) then Result := False;
  end;
  if mods = -3 then
  begin
    Rscene[mpbdata[id].snum].inbattle := 1;
    len := 0;
    for i := 1 to length(Rrole) - 1 do
    begin
      if (Rrole[i].menpai = Rscene[mpbdata[id].snum].menpai) and (Rrole[i].weizhi = mpbdata[id].snum) and
        (Rrole[i].dtime < 5) and (not (Rrole[i].TeamState in [1, 2])) then
      begin
        setlength(trnum, len + 1);
        trnum[len] := i;
        Inc(len);
      end;
    end;
    if len > 0 then levsort(trnum);
    len := length(mpbdata[id].BTeam[1].rolearr);
    for i := 0 to length(trnum) - 1 do
    begin
      if len <= 0 then
      begin
        len := 0;
      end;
      setlength(mpbdata[id].BTeam[1].RoleArr, len + 1);
      mpbdata[id].BTeam[1].RoleArr[len].rnum := trnum[i];
      mpbdata[id].BTeam[1].RoleArr[len].snum := Rrole[trnum[i]].weizhi;
      mpbdata[id].BTeam[1].RoleArr[len].isin := 0;
      Rrole[trnum[i]].nweizhi := 16;
      Rrole[trnum[i]].dtime := 1000;
      Inc(len);
    end;

  end;

  k1 := 0;
  if mods < -1 then
  begin
    for i := 0 to 9 do
    begin
      if (mods = -2) and (i = 9) then
        break;


      len := length(mpbdata[id].BTeam[1].rolearr);
      if i < len then
      begin
        Brole[BRoleAmount].rnum := mpbdata[id].BTeam[1].RoleArr[i].rnum;
        mpbdata[id].BTeam[1].RoleArr[i].isin := 1;
      end;

      if mods = -2 then
      begin
        if k1 = 4 then Inc(k1);
        Brole[BRoleAmount].X := Rscene[mpbdata[id].snum].qizhiy + k1 div 3 - 1;
        Brole[BRoleAmount].Y := Rscene[mpbdata[id].snum].qizhix + k1 mod 3 - 1;

        Inc(k1);
      end

      else if mods = -3 then
      begin
        if Rrole[Brole[BRoleAmount].rnum].HeadNum = 863 + id then
        begin
          Brole[BRoleAmount].X := Rscene[mpbdata[id].snum].qizhiy;
          Brole[BRoleAmount].Y := Rscene[mpbdata[id].snum].qizhix;
          Dec(k1);
        end
        else if k1 < 3 then
        begin
          Brole[BRoleAmount].X := Rscene[mpbdata[id].snum].lwcy[k1];
          Brole[BRoleAmount].Y := Rscene[mpbdata[id].snum].lwcx[k1] + 1;
        end
        else if k1 < 6 then
        begin
          Brole[BRoleAmount].X := Rscene[mpbdata[id].snum].cjgy[k1 - 3] + 1;
          Brole[BRoleAmount].Y := Rscene[mpbdata[id].snum].cjgx[k1 - 3];
        end
        else if k1 = 6 then
        begin
          Brole[BRoleAmount].X := Rscene[mpbdata[id].snum].bgsy + 1;
          Brole[BRoleAmount].Y := Rscene[mpbdata[id].snum].bgsx;
        end
        else if k1 = 7 then
        begin
          Brole[BRoleAmount].X := Rscene[mpbdata[id].snum].ldly;
          Brole[BRoleAmount].Y := Rscene[mpbdata[id].snum].ldlx + 1;
        end
        else if k1 = 8 then
        begin
          Brole[BRoleAmount].X := Rscene[mpbdata[id].snum].bqcy;
          Brole[BRoleAmount].Y := Rscene[mpbdata[id].snum].bqcx + 1;
        end;

        Inc(k1);
      end;
      Brole[BRoleAmount].Team := 1;
      Brole[BRoleAmount].Face := 1;
      if Brole[BRoleAmount].rnum = -1 then
      begin
        Brole[BRoleAmount].Dead := 1;
        Brole[BRoleAmount].Show := 1;
      end
      else
      begin
        Brole[BRoleAmount].Dead := 0;
        Brole[BRoleAmount].Show := 0;

        aotosetmagic(Brole[BRoleAmount].rnum);
      end;
      Brole[BRoleAmount].Step := 0;
      Brole[BRoleAmount].Acted := 0;
      Brole[BRoleAmount].ExpGot := 0;
      Brole[BRoleAmount].Auto := -1;
      Brole[BRoleAmount].Show := 0;
      Brole[BRoleAmount].Progress := 0;
      Brole[BRoleAmount].round := 0;
      Brole[BRoleAmount].Wait := 0;
      Brole[BRoleAmount].frozen := 0;
      Brole[BRoleAmount].killed := 0;
      Brole[BRoleAmount].Knowledge := 0;
      Brole[BRoleAmount].Zhuanzhu := 0;

      Brole[BRoleAmount].szhaoshi := 0;
      Brole[BRoleAmount].pozhao := 0;
      Brole[BRoleAmount].wanfang := 0;
      //設置門派重器
      if Rrole[Brole[BRoleAmount].rnum].HeadNum = 863 + id then
        for j := 0 to 4 do
          Brole[BRoleAmount].zhuangtai[j] := 0
      else
      begin
        for j := 0 to 4 do
        begin
          n0 := 0;
          if Brole[BRoleAmount].rnum > -1 then
            for j1 := 0 to 9 do
              if Rrole[Brole[BRoleAmount].rnum].Gongti > 0 then
                if (Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].MoveDistance[j1] = 60 + j) then
                  n0 := Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].AttDistance[j1];
          Brole[BRoleAmount].zhuangtai[j] := 100;
          Brole[BRoleAmount].lzhuangtai[j] := n0;
        end;
        for j := 5 to 9 do
        begin
          n0 := 0;
          if Brole[BRoleAmount].rnum > -1 then
            for j1 := 0 to 9 do
              if Rrole[Brole[BRoleAmount].rnum].Gongti > 0 then
                if (Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].MoveDistance[j1] = 60 + j) then
                  n0 := Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].AttDistance[j1];
          Brole[BRoleAmount].zhuangtai[j] := n0;
          Brole[BRoleAmount].lzhuangtai[j] := n0;
        end;
      end;
      for j := 10 to 13 do
        Brole[BRoleAmount].zhuangtai[j] := 0;
      BRoleAmount := BRoleAmount + 1;
    end;
  end
  else
  begin
    for i := 0 to length(warsta.enemy) - 1 do
    begin
      y := warsta.enemy_x[i];
      x := warsta.enemy_y[i];
      if mods = -1 then Brole[BRoleAmount].rnum := warsta.enemy[i]
      else Brole[BRoleAmount].rnum := -1;
      Brole[BRoleAmount].Team := 1;
      Brole[BRoleAmount].Y := y;
      Brole[BRoleAmount].X := x;
      Brole[BRoleAmount].Face := 1;
      if Brole[BRoleAmount].rnum = -1 then
      begin
        Brole[BRoleAmount].Dead := 1;
        Brole[BRoleAmount].Show := 1;
      end
      else
      begin
        Brole[BRoleAmount].Dead := 0;
        Brole[BRoleAmount].Show := 0;
        aotosetmagic(Brole[BRoleAmount].rnum);
      end;
      Brole[BRoleAmount].Step := 0;
      Brole[BRoleAmount].Acted := 0;
      Brole[BRoleAmount].ExpGot := 0;
      Brole[BRoleAmount].Auto := -1;
      Brole[BRoleAmount].Show := 0;
      Brole[BRoleAmount].Progress := 0;
      Brole[BRoleAmount].round := 0;
      Brole[BRoleAmount].Wait := 0;
      Brole[BRoleAmount].frozen := 0;
      Brole[BRoleAmount].killed := 0;
      Brole[BRoleAmount].Knowledge := 0;
      Brole[BRoleAmount].Zhuanzhu := 0;

      Brole[BRoleAmount].szhaoshi := 0;
      Brole[BRoleAmount].pozhao := 0;
      Brole[BRoleAmount].wanfang := 0;
      for j := 0 to 4 do
      begin
        n0 := 0;
        if Brole[BRoleAmount].rnum > -1 then
          for j1 := 0 to 9 do
            if Rrole[Brole[BRoleAmount].rnum].Gongti > 0 then
              if (Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].MoveDistance[j1] = 60 + j) then
                n0 := Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].AttDistance[j1];
        Brole[BRoleAmount].zhuangtai[j] := 100;
        Brole[BRoleAmount].lzhuangtai[j] := n0;
      end;
      for j := 5 to 9 do
      begin
        n0 := 0;
        if Brole[BRoleAmount].rnum > -1 then
          for j1 := 0 to 9 do
            if Rrole[Brole[BRoleAmount].rnum].Gongti > 0 then
              if (Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].MoveDistance[j1] = 60 + j) then
                n0 := Rmagic[Rrole[Brole[BRoleAmount].rnum].LMagic[Rrole[Brole[BRoleAmount].rnum].Gongti]].AttDistance[j1];
        Brole[BRoleAmount].zhuangtai[j] := n0;
        Brole[BRoleAmount].lzhuangtai[j] := n0;
      end;
      for j := 10 to 13 do
        Brole[BRoleAmount].zhuangtai[j] := 0;
      BRoleAmount := BRoleAmount + 1;
    end;
  end;
  if mods > -1 then
  begin
    for i := length(warsta.mate) to length(warsta.mate) + length(warsta.enemy) - 1 do
    begin
      Brole[i].Dead := 1;
      Brole[i].Show := 1;
    end;
    Brole[length(warsta.mate)].rnum := mods;
    Brole[length(warsta.mate)].dead := 0;
    Brole[length(warsta.mate)].Show := 0;
    aotosetmagic(Brole[length(warsta.mate)].rnum);
    for j := 0 to 4 do
    begin
      n0 := 0;
      if Brole[length(warsta.mate)].rnum > -1 then
        for j1 := 0 to 9 do
          if Rrole[Brole[length(warsta.mate)].rnum].Gongti > 0 then
            if (Rmagic[Rrole[Brole[length(warsta.mate)].rnum].LMagic[Rrole[Brole[length(warsta.mate)].rnum].Gongti]].MoveDistance[j1] = 60 + j) then
              n0 := Rmagic[Rrole[Brole[length(warsta.mate)].rnum].LMagic[
                Rrole[Brole[length(warsta.mate)].rnum].Gongti]].AttDistance[j1];
      Brole[length(warsta.mate)].zhuangtai[j] := 100;
      Brole[length(warsta.mate)].lzhuangtai[j] := n0;
    end;
    for j := 5 to 9 do
    begin
      n0 := 0;
      for j1 := 0 to 9 do
        if Rrole[Brole[length(warsta.mate)].rnum].Gongti > 0 then
          if (Rmagic[Rrole[Brole[length(warsta.mate)].rnum].LMagic[Rrole[Brole[length(warsta.mate)].rnum].Gongti]].MoveDistance[j1] = 60 + j) then
            n0 := Rmagic[Rrole[Brole[length(warsta.mate)].rnum].LMagic[Rrole[Brole[length(warsta.mate)].rnum].Gongti]].AttDistance[j1];
      Brole[length(warsta.mate)].zhuangtai[j] := n0;
      Brole[length(warsta.mate)].lzhuangtai[j] := n0;
    end;

  end;

end;

//选择人物, 返回值为整型, 按bit表示人物是否参战

function SelectTeamMembers: integer;
var
  i, i2, menu, max0, menup, locked: integer;
begin
  SDL_EventState(SDL_MOUSEMOTION, SDL_ENABLE);
  Result := 0;
  max0 := 1;
  menu := 0;
  setlength(menuString, 0);
  setlength(menuString, 8);
  menuString[0] := '   全員出戰';
  locked := 0;
  for i := 0 to 5 do
  begin
    if Teamlist[i] >= 0 then
    begin
      menuString[i + 1] := gbktoUnicode(@Rrole[Teamlist[i]].Name);
      max0 := max0 + 1;
      for i2 := 0 to length(warsta.mate) - 1 do
        if (warsta.mate[i2] = Teamlist[i]) and (warsta.mate[i2] > 0) then
          locked := locked or (1 shl (i + 1));
    end;
  end;
  Result := Result xor locked;
  menuString[max0] := '   開始戰鬥';

  ShowMultiMenu(max0, 0, Result);
  SDL_EnableKeyRepeat(10, 100);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if ((event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE)) and
          (menu <> max0) and (menu <> 0) then
        begin
          //选中人物则反转对应bit
          Result := Result xor (1 shl menu) or locked;
          ShowMultiMenu(max0, menu, Result);
        end;
        if ((event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE)) and (menu = 0) then
        begin
          //选中人物则反转对应bit
          for i := 0 to 5 do
          begin
            if Teamlist[i] >= 0 then
            begin
              Result := Result xor (1 shl (i + 1)) or locked;
            end;
          end;
          ShowMultiMenu(max0, menu, Result);
        end;
        if ((event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE)) and (menu = max0) then
        begin
          if Result <> 0 then break;
        end;
      end;

      SDL_KEYDOWN:
      begin
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          menu := menu - 1;
          if menu < 0 then menu := max0;
          ShowMultiMenu(max0, menu, Result);
        end;
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          menu := menu + 1;
          if menu > max0 then menu := 0;
          ShowMultiMenu(max0, menu, Result);
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_LEFT) and (menu <> max0) and (menu <> 0) then
        begin
          Result := Result xor (1 shl menu) or locked;
          ShowMultiMenu(max0, menu, Result);
        end;
        if (event.button.button = SDL_BUTTON_LEFT) and (menu = max0) then
        begin
          if Result <> 0 then break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) and (menu = 0) then
        begin
          for i := 0 to 5 do
          begin
            if Teamlist[i] >= 0 then
            begin
              Result := Result xor (1 shl (i + 1)) or locked;
            end;
          end;
          ShowMultiMenu(max0, menu, Result);
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x >= CENTER_X - 75) and (event.button.x < CENTER_X + 75) and
          (event.button.y >= 100) and (event.button.y < max0 * 22 + 128) then
        begin
          menup := menu;
          menu := (event.button.y - 102) div 22;
          if menup <> menu then ShowMultiMenu(max0, menu, Result);
        end;
      end;
    end;
  end;
  SDL_EnableKeyRepeat(100, 30);
  SDL_EventState(SDL_MOUSEMOTION, SDL_ignore);
end;

//显示选择参战人物选单

procedure ShowMultiMenu(max0, menu, status: integer);
var
  i, x, y: integer;
  str, str1, str2: WideString;
begin
  x := CENTER_X - 105;
  y := 100;
  Redraw;

  str := '選擇參與戰鬥之人物';
  str1 := '參戰';
  //Drawtextwithrect(@str[1],x,y-35,200,colcolor($23),colcolor($21));
  DrawRectangle(x + 30, y, 150, max0 * 22 + 28, 0, ColColor(0, 255), 30);
  for i := 0 to max0 do
    if i = menu then
    begin
      DrawShadowText(@menuString[i][1], x + 13, y + 3 + 22 * i, ColColor(0, $64), ColColor(0, $66));
      if (status and (1 shl i)) > 0 then
        DrawShadowText(@str1[1], x + 113, y + 3 + 22 * i, ColColor(0, $64), ColColor(0, $66));
    end
    else
    begin
      DrawShadowText(@menuString[i][1], x + 13, y + 3 + 22 * i, ColColor(0, $5), ColColor(0, $7));
      if (status and (1 shl i)) > 0 then
        DrawShadowText(@str1[1], x + 113, y + 3 + 22 * i, ColColor(0, $21), ColColor(0, $23));
    end;
  SDL_UpdateRect2(screen, x + 30, y, 151, max0 * 22 + 28 + 1);
end;

function CountProgress(mods: integer): integer;
var
  i, n: integer;

begin

  Result := -1;
  //似乎KG为了避免集气超过299搞得太复杂了，这也直接影响了对点穴的判定
  {for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].rnum >= 0) and (Brole[i].Dead = 0) and (Brole[i].wait = 0) then
    begin
      if BRole[i].Progress mod 300 + trunc(Brole[i].speed / 15) >= 299 then
      begin
        a := (300 - (brole[i].Progress mod 300)) / 15;
        b := min(a, b);
        result := i;
        break;
      end;
    end;
  end; }
  for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].Progress >= 300) and (Brole[i].Wait = 0) and (Brole[i].Dead = 0) then
    begin
      Result := i;
      exit;
    end;
  end;
  for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].rnum >= 0) and (Brole[i].Dead = 0) and (Brole[i].frozen > 0) then
    begin
      Dec(Brole[i].frozen);
    end
    else if (Brole[i].rnum >= 0) and (Brole[i].Dead = 0) and (Brole[i].Wait = 0) then
    begin
      Brole[i].frozen := 0;
      Inc(Brole[i].Progress, trunc((power(Brole[i].speed / 7, 0.55) +
        power(max(1, Rrole[Brole[i].rnum].CurrentMP - 200) / 40, 0.5)) * (100 + Brole[i].zhuangtai[13]) *
        (Brole[i].zhuangtai[3] + 100) / 20000));
      if Brole[i].Progress >= 300 then
      begin
        Result := i;
      end;
    end;
  end;
  showprogress;
  Inc(jiqicount);
  if (jiqicount mod 100 = 0) and (mods < -1) then
    adddate(24);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

end;

//战斗主控制

procedure BattleMainControl; overload;
begin
  BattleMainControl(-1, -1);
end;

procedure BattleMainControl(mods, id: integer); overload;
var
  i, j, j1, j2, j3, jj, n, i1, i2, add, a, k, mpnum0, mpnum1: integer;
  zy0, zy1: array[0..2] of array[0..1] of integer;
  word: WideString;
  key: boolean;
begin
  //redraw;
  CalMoveAbility; //计算移动能力
  ReArrangeBRole;
  Bx := Brole[0].X;
  By := Brole[0].Y;
  for i := 0 to 5 do
  begin
    zy0[0][i] := -1;
    zy1[0][i] := -1;
  end;

  jiqicount := 0;
  if mods < -1 then
  begin
    if mods = -3 then
    begin
      mpnum0 := mpbdata[id].attmp;
      mpnum1 := mpbdata[id].defmp;
    end
    else if mods = -2 then
    begin
      mpnum0 := mpbdata[id].defmp;
      mpnum1 := mpbdata[id].attmp;
    end;
    if (Rmenpai[mpnum0].zmr > 0) and (Rrole[Rmenpai[mpnum0].zmr].weizhi <> mpbdata[id].snum) and
      (Rrole[Rmenpai[mpnum0].zmr].nweizhi <> 16) and (Rrole[Rmenpai[mpnum0].zmr].dtime < 1000) then
    begin
      zy0[0][0] := Rmenpai[mpnum0].zmr;
      zy0[0][1] := Rrole[Rmenpai[mpnum0].zmr].dtime * 5 + random((1000 - Rrole[Rmenpai[mpnum0].zmr].Repute) div 20);
    end;
    if (Rrole[Rmenpai[mpnum1].zmr].weizhi <> mpbdata[id].snum) and (Rrole[Rmenpai[mpnum1].zmr].nweizhi <> 16) and
      (Rrole[Rmenpai[mpnum1].zmr].dtime < 1000) then
    begin
      zy1[0][0] := Rmenpai[mpnum1].zmr;
      zy1[0][1] := Rrole[Rmenpai[mpnum1].zmr].dtime * 5 + random((1000 - Rrole[Rmenpai[mpnum1].zmr].Repute) div 20);
    end;
    for j := 0 to 1 do
    begin
      if (Rmenpai[mpnum0].zhiwu[j] > -1) then
      begin
        if (Rrole[Rmenpai[mpnum0].zhiwu[j]].weizhi <> mpbdata[id].snum) and
          (Rrole[Rmenpai[mpnum0].zhiwu[j]].nweizhi <> 16) and (Rrole[Rmenpai[mpnum0].zhiwu[j]].dtime < 1000) then
        begin
          zy0[j + 1][0] := Rmenpai[mpnum0].zhiwu[j];
          zy0[j + 1][1] := Rrole[Rmenpai[mpnum0].zhiwu[j]].dtime * 10 + random(
            (1000 - Rrole[Rmenpai[mpnum0].zhiwu[j]].Repute) div 10);
        end;
        if (Rrole[Rmenpai[mpnum1].zhiwu[j]].weizhi <> mpbdata[id].snum) and
          (Rrole[Rmenpai[mpnum1].zhiwu[j]].nweizhi <> 16) and (Rrole[Rmenpai[mpnum1].zhiwu[j]].dtime < 1000) then
        begin
          zy1[j + 1][0] := Rmenpai[mpnum1].zhiwu[j];
          zy1[j + 1][1] := Rrole[Rmenpai[mpnum1].zhiwu[j]].dtime * 10 + random(
            (1000 - Rrole[Rmenpai[mpnum1].zhiwu[j]].Repute) div 10);
        end;
      end;
    end;
  end;
  if (mods = -1) and (warsta.BoutEvent > 0) then CallEvent(warsta.BoutEvent);
  for i := 0 to length(Brole) - 1 do
  begin
    Brole[i].round := 1;
    Brole[i].LifeAdd := 0;
  end;
  //redraw;
  //战斗未分出胜负则继续
  while BStatus = 0 do
  begin

    Redraw;
    i := CountProgress(mods);
    if (i >= 0) then
    begin
      //战场序号保存至变量28005
      x50[28005] := i;
      if (jiqicount mod 5 = 0) and (mods < -1) then
        zengyuan(-1, id);
      isattack := False;
      CurBrole := i;
      //当前人物位置作为屏幕中心
      Brole[i].Acted := 0;

      Brole[i].szhaoshi := 0;
      if (mods = -1) and (warsta.BoutEvent > 0) then CallEvent(warsta.BoutEvent);

      if jiqicount > 500 then
      begin
        for j1 := 0 to 2 do
        begin
          if (zy0[j1][0] > -1) and (random(10 * zy0[j1][1] + 500 - jiqicount) < 5) then
          begin
            jj := length(mpbdata[id].BTeam[0].rolearr);
            if jj < 0 then
              jj := 0;
            setlength(mpbdata[id].BTeam[0].rolearr, jj + 1);
            mpbdata[id].BTeam[0].rolearr[jj].rnum := zy0[j1][0];
            mpbdata[id].BTeam[0].rolearr[jj].snum := Rrole[zy0[j1][0]].weizhi;
            mpbdata[id].BTeam[0].rolearr[jj].isin := 0;
            Rrole[zy0[j1][0]].weizhi := mpbdata[id].snum;
            Rrole[zy0[j1][0]].nweizhi := 16;
            Rrole[zy0[j1][0]].dtime := 1000;

            Inc(jj);
            for j2 := 1 to length(Rrole) - 1 do
            begin
              if (Rrole[j2].MenPai = mpnum0) and (Rrole[j2].weizhi <> mpbdata[id].snum) and
                (Rrole[j2].nweizhi <> 16) and (Rrole[j2].dtime < 2) then
              begin
                if ((Rmenpai[mpnum0].zhiwu[0] = j2) or (Rmenpai[mpnum0].zhiwu[1] = j2) or
                  (Rmenpai[mpnum0].zmr = j2) or (random(100) < Rrole[j2].Repute - Rrole[zy0[j1][0]].Repute)) then
                  continue;
                if (random(200) > Rrole[zy0[j1][0]].Repute - 50 * (jj - 1)) then
                  break;
                setlength(mpbdata[id].BTeam[0].rolearr, jj + 1);
                mpbdata[id].BTeam[0].rolearr[jj].rnum := j2;
                mpbdata[id].BTeam[0].rolearr[jj].snum := Rrole[j2].weizhi;
                mpbdata[id].BTeam[0].rolearr[jj].isin := 0;
                Rrole[j2].weizhi := mpbdata[id].snum;
                Rrole[j2].nweizhi := 16;
                Rrole[j2].dtime := 1000;
                Inc(jj);
              end;
            end;
            zy0[j1][0] := -1;
            zengyuan(0, id);
          end;
          if (zy1[j1][0] > -1) and (random(10 * zy1[j1][1] + 500 - jiqicount) < 5) then
          begin
            jj := length(mpbdata[id].BTeam[1].rolearr);
            if jj < 0 then
              jj := 0;
            setlength(mpbdata[id].BTeam[1].rolearr, jj + 1);
            mpbdata[id].BTeam[1].rolearr[jj].rnum := zy1[j1][0];
            mpbdata[id].BTeam[1].rolearr[jj].snum := Rrole[zy1[j1][0]].weizhi;
            mpbdata[id].BTeam[1].rolearr[jj].isin := 0;
            Rrole[zy1[j1][0]].weizhi := mpbdata[id].snum;
            Rrole[zy1[j1][0]].nweizhi := 16;
            Rrole[zy1[j1][0]].dtime := 1000;

            Inc(jj);
            for j2 := 1 to length(Rrole) - 1 do
            begin
              if (Rrole[j2].MenPai = mpnum1) and (Rrole[j2].weizhi <> mpbdata[id].snum) and
                (Rrole[j2].nweizhi <> 16) and (Rrole[j2].dtime < 2) then
              begin
                if (Rmenpai[mpnum1].zhiwu[0] = j2) or (Rmenpai[mpnum1].zhiwu[1] = j2) or
                  (Rmenpai[mpnum1].zmr = j2) or (random(100) < Rrole[j2].Repute - Rrole[zy1[j1][0]].Repute) then
                  continue;
                if (random(200) > Rrole[zy1[j1][0]].Repute - 50 * (jj - 1)) then
                  break;

                setlength(mpbdata[id].BTeam[1].rolearr, jj + 1);
                mpbdata[id].BTeam[1].rolearr[jj].rnum := j2;
                mpbdata[id].BTeam[1].rolearr[jj].snum := Rrole[j2].weizhi;
                mpbdata[id].BTeam[1].rolearr[jj].isin := 0;

                Rrole[j2].weizhi := mpbdata[id].snum;
                Rrole[j2].nweizhi := 16;
                Rrole[j2].dtime := 1000;
                Inc(jj);
              end;
            end;
            zy1[j1][0] := -1;
            zengyuan(1, id);
          end;
        end;

      end;
      Bx := Brole[i].X;
      By := Brole[i].Y;
      Tbx := Bx;
      Tby := By;
      Tstep := Brole[i].Step;
      if BStatus > 0 then break;
      Redraw;
      showprogress;
      for i1 := 0 to 63 do
      begin
        for i2 := 0 to 63 do
        begin
          bfield[4, i1, i2] := 0;
        end;
      end;
      BshowBWord.sign := BshowBWord.sign and $F0;
      for i1 := 0 to 3 do
      begin
        BshowBWord.words[i1] := '';
      end;
      while (SDL_PollEvent(@event) >= 0) do
      begin
        CheckBasicEvent;
        if ((event.key.keysym.sym = SDLK_ESCAPE) or (event.button.button = SDL_BUTTON_RIGHT)) and
          (Brole[i].Auto < 3) then
        begin
          Brole[i].Auto := -1;
          //AutoMode[i]:=-1;
          event.button.button := 0;
          event.key.keysym.sym := 0;
        end;
        break;
      end;

      //为我方且未阵亡, 非自动战斗, 则显示选单
      if (Brole[i].Dead = 0) and (Brole[i].rnum >= 0) and (Brole[i].Acted = 0) then
      begin
        CurBrole := i;

        if Brole[i].lifeAdd = 0 then
        begin
          //加成状态衰减
          if Brole[i].Zhuanzhu <= 0 then
          begin
            Brole[i].zhuangtai[5] := max(Brole[i].lzhuangtai[5], Brole[i].zhuangtai[5] - 4 -
              (400 - GetRoleAttack(Brole[i].rnum, True)) *
              (round(power((Brole[i].zhuangtai[5] - Brole[i].lzhuangtai[5]), 1.69)) + 10) div 6000);
            Brole[i].zhuangtai[6] := max(Brole[i].lzhuangtai[6], Brole[i].zhuangtai[6] - 4 -
              (400 - GetRoleAttack(Brole[i].rnum, True)) *
              (round(power((Brole[i].zhuangtai[6] - Brole[i].lzhuangtai[6]), 1.69)) + 10) div 6000);
            Brole[i].zhuangtai[7] := max(Brole[i].lzhuangtai[7], Brole[i].zhuangtai[7] - 4 -
              (400 - GetRoleSpeed(Brole[i].rnum, True)) *
              (round(power((Brole[i].zhuangtai[7] - Brole[i].lzhuangtai[7]), 1.69)) + 10) div 6000);
            Brole[i].zhuangtai[8] := max(Brole[i].lzhuangtai[8], Brole[i].zhuangtai[8] - 4 -
              (400 - GetRoleSpeed(Brole[i].rnum, True)) *
              (round(power((Brole[i].zhuangtai[8] - Brole[i].lzhuangtai[8]), 1.69)) + 10) div 6000);
            Brole[i].zhuangtai[9] := max(Brole[i].lzhuangtai[9], Brole[i].zhuangtai[9] - 4 -
              (400 - GetRoleDefence(Brole[i].rnum, True)) *
              (round(power((Brole[i].zhuangtai[9] - Brole[i].lzhuangtai[9]), 1.69)) + 10) div 6000);
          end;
          Brole[i].zhuangtai[10] := max(0, Brole[i].zhuangtai[10] - 4 - (400 - GetRoleAttack(Brole[i].rnum, True)) *
            (round(power(Brole[i].zhuangtai[10], 1.69)) + 10) div 6000);
          Brole[i].zhuangtai[11] := max(0, Brole[i].zhuangtai[11] - 4 - (400 - GetRoleDefence(Brole[i].rnum, True)) *
            (round(power(Brole[i].zhuangtai[11], 1.69)) + 10) div 6000);
          Brole[i].zhuangtai[12] := max(0, Brole[i].zhuangtai[12] - 4 - (400 - GetRoleDefence(Brole[i].rnum, True)) *
            (round(power(Brole[i].zhuangtai[12], 1.69)) + 10) div 6000);
          Brole[i].zhuangtai[13] := max(0, Brole[i].zhuangtai[13] - 4 - (400 - GetRoleSpeed(Brole[i].rnum, True)) *
            (round(power(Brole[i].zhuangtai[13], 1.69)) + 10) div 6000);
          //内功清毒
          if Rrole[Brole[i].rnum].Poision > 0 then
          begin
            Rrole[Brole[i].rnum].Poision :=
              min(100, max(0, Rrole[Brole[i].rnum].Poision -
              round(power(max(0, Rrole[Brole[i].rnum].CurrentMP - 300), 0.8) / 50) - Rrole[Brole[i].rnum].Poision *
              Rrole[Brole[i].rnum].CurrentMP div 10000));
          end;
          if Rrole[Brole[i].rnum].Gongti > 0 then
          begin
            for j := 0 to 9 do
            begin
              if Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MoveDistance[j] < 1 then
                break;
              if (Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MoveDistance[j] >= 40) and
                (Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MoveDistance[j] <= 44) then
                Brole[i].zhuangtai[Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MoveDistance[j] -
                  40] := min(100, Brole[i].zhuangtai[Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MoveDistance[j] - 40] + Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].AttDistance[j])
              else if Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MoveDistance[j] = 45 then
                Rrole[Brole[i].rnum].CurrentHP :=
                  min(Rrole[Brole[i].rnum].MAXHP, Rrole[Brole[i].rnum].CurrentHP +
                  Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].AttDistance[j])
              else if Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MoveDistance[j] = 46 then
                Rrole[Brole[i].rnum].CurrentMP :=
                  min(Rrole[Brole[i].rnum].MAXMP, Rrole[Brole[i].rnum].CurrentMP +
                  Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].AttDistance[j]);

            end;
          end;
          //門派職務恢復
          //青龍
          if (mods < -1) and (Rscene[mpbdata[id].snum].menpai = Rrole[Brole[i].rnum].MenPai) and
            (Rmenpai[Rscene[mpbdata[id].snum].menpai].zhiwu[2] >= 0) then
          begin
            add := 0;
            add := Rrole[Brole[i].rnum].MaxMP * (100 +
              Rrole[Rmenpai[Rscene[mpbdata[id].snum].menpai].zhiwu[2]].Repute *
              Rrole[Rmenpai[Rscene[mpbdata[id].snum].menpai].zhiwu[2]].level div 300) div 4000;
            if Rrole[Brole[i].rnum].MaxMP < Rrole[Brole[i].rnum].CurrentMP + add then
              add := Rrole[Brole[i].rnum].MaxMP - Rrole[Brole[i].rnum].CurrentMP;
            for a := 0 to length(Brole) - 1 do
              Brole[a].ShowNumber := -1;
            Brole[i].ShowNumber := add;
            if add > 0 then ShowHurtValue(1, ColColor(0, $50), ColColor(0, $53));
            Rrole[Brole[i].rnum].CurrentMP := Rrole[Brole[i].rnum].CurrentMP + add;
            add := 0;
            add := Rrole[Rmenpai[Rscene[mpbdata[id].snum].menpai].zhiwu[2]].Repute *
              Rrole[Rmenpai[Rscene[mpbdata[id].snum].menpai].zhiwu[2]].level div 6000;
            Brole[i].zhuangtai[2] := min(100, Brole[i].zhuangtai[2] + add);
          end;
          //白虎
          if (mods < -1) and (Rscene[mpbdata[id].snum].menpai = Rrole[Brole[i].rnum].MenPai) and
            (Rmenpai[Rscene[mpbdata[id].snum].menpai].zhiwu[3] >= 0) then
          begin
            add := 0;
            add := Rrole[Rmenpai[Rscene[mpbdata[id].snum].menpai].zhiwu[3]].Repute *
              Rrole[Rmenpai[Rscene[mpbdata[id].snum].menpai].zhiwu[3]].level div 6000;
            Rrole[Brole[i].rnum].Poision := max(0, Rrole[Brole[i].rnum].Poision - add);
            Rrole[Brole[i].rnum].Hurt := max(0, Rrole[Brole[i].rnum].Hurt - add);
            Brole[i].zhuangtai[0] := min(100, Brole[i].zhuangtai[0] + add);
          end;
          //朱雀
          if (mods < -1) and (Rscene[mpbdata[id].snum].menpai = Rrole[Brole[i].rnum].MenPai) and
            (Rmenpai[Rscene[mpbdata[id].snum].menpai].zhiwu[4] >= 0) then
          begin
            add := 0;
            add := Rrole[Rmenpai[Rscene[mpbdata[id].snum].menpai].zhiwu[4]].Repute *
              Rrole[Rmenpai[Rscene[mpbdata[id].snum].menpai].zhiwu[4]].level div 6000;
            Rrole[Brole[i].rnum].PhyPower := min(100, Rrole[Brole[i].rnum].PhyPower + add);
            Brole[i].zhuangtai[4] := min(100, Brole[i].zhuangtai[4] + add);
          end;
          //玄武
          if (mods < -1) and (Rscene[mpbdata[id].snum].menpai = Rrole[Brole[i].rnum].MenPai) and
            (Rmenpai[Rscene[mpbdata[id].snum].menpai].zhiwu[5] >= 0) then
          begin
            add := 0;
            add := Rrole[Brole[i].rnum].MaxHP * (100 +
              Rrole[Rmenpai[Rscene[mpbdata[id].snum].menpai].zhiwu[5]].Repute *
              Rrole[Rmenpai[Rscene[mpbdata[id].snum].menpai].zhiwu[5]].level div 300) div 4000;
            if Rrole[Brole[i].rnum].MaxHP < Rrole[Brole[i].rnum].CurrentHP + add then
              add := Rrole[Brole[i].rnum].MaxHP - Rrole[Brole[i].rnum].CurrentHP;
            for a := 0 to length(Brole) - 1 do
              Brole[a].ShowNumber := -1;
            Brole[i].ShowNumber := add;
            if add > 0 then ShowHurtValue(1, ColColor(0, $50), ColColor(0, $53));
            Rrole[Brole[i].rnum].CurrentHP := Rrole[Brole[i].rnum].CurrentHP + add;
            add := 0;
            add := Rrole[Rmenpai[Rscene[mpbdata[id].snum].menpai].zhiwu[5]].Repute *
              Rrole[Rmenpai[Rscene[mpbdata[id].snum].menpai].zhiwu[5]].level div 6000;
            Brole[i].zhuangtai[1] := min(100, Brole[i].zhuangtai[1] + add);
          end;

          //状态11，自动回血
          if (GetEquipState(Brole[i].rnum, 11)) or (GetGongtiState(Brole[i].rnum, 11)) then
          begin
            add := 0;
            add := Rrole[Brole[i].rnum].MaxHP div 10;
            if Rrole[Brole[i].rnum].MaxHP < Rrole[Brole[i].rnum].CurrentHP + add then
              add := Rrole[Brole[i].rnum].MaxHP - Rrole[Brole[i].rnum].CurrentHP;
            for a := 0 to length(Brole) - 1 do
              Brole[a].ShowNumber := -1;
            Brole[i].ShowNumber := add;
            if add > 0 then ShowHurtValue(3);
            Rrole[Brole[i].rnum].CurrentHP := Rrole[Brole[i].rnum].CurrentHP + add;
          end;
          //状态23，自动回内
          if (GetEquipState(Brole[i].rnum, 23)) or (GetGongtiState(Brole[i].rnum, 23)) then
          begin
            add := 0;
            add := Rrole[Brole[i].rnum].MaxMP div 20;
            if Rrole[Brole[i].rnum].MaxMP < Rrole[Brole[i].rnum].CurrentMP + add then
              add := Rrole[Brole[i].rnum].MaxMP - Rrole[Brole[i].rnum].CurrentMP;
            for a := 0 to length(Brole) - 1 do
              Brole[a].ShowNumber := -1;
            Brole[i].ShowNumber := add;
            if add > 0 then
              ShowHurtValue(1, ColColor(0, $50), ColColor(0, $53));
            Rrole[Brole[i].rnum].CurrentMP := Rrole[Brole[i].rnum].CurrentMP + add;
          end;
          CalPoiHurtLife(i); //计算中毒损血

          Brole[i].lifeAdd := 1;
        end;

        if (Brole[i].Team = 0) and (Brole[i].Auto = -1) and (Brole[i].Wait = 0) then
        begin
          while (Brole[i].Acted = 0) and (Brole[i].Auto = -1) and (Brole[i].Wait = 0) do
          begin
            for i1 := 0 to 63 do
            begin
              for i2 := 0 to 63 do
              begin
                bfield[4, i1, i2] := 0;
              end;
            end;
            case BattleMenu(i) of
              0: MoveRole(i);
              1: Attack(i);
              2: UsePoision(i);
              3: MedPoision(i);
              4: Medcine(i);
              5: MedFrozen(i);
              6: zhuanzhu(i);
              7: BattleMenuItem(i);
              8: Wait(i);
              9: Selectshowstatus(i);
              10: Rest(i);
              11: Auto(i);
            end;
          end;
        end
        else
        begin
          AutoBattle2(i);
          Brole[i].Acted := 1;
        end;
      end
      else if Brole[i].Acted = 1 then
      begin
        Brole[i].Progress := Brole[i].Progress - 300;
        showprogress;
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        SDL_Delay(50 * (10 + gamespeed));
      end
      else
      begin
        Brole[i].Acted := 1;
      end;
      ClearDeadRolePic;
      Bstatus := BattleStatus;
      if Brole[i].Acted = 1 then
      begin
        // if Brole[i].Dead = 0 then
        if (mods = -1) and (warsta.OperationEvent > 0) then CallEvent(warsta.OperationEvent);
        Inc(Brole[i].round);
        Brole[i].LifeAdd := 0;
      end;

      for i1 := 0 to 63 do
      begin
        for i2 := 0 to 63 do
        begin
          bfield[4, i1, i2] := 0;
        end;
      end;
      Redraw;
      showprogress;
      x50[28101] := BRoleAmount;
      CalMoveAbility;
      for k := 0 to length(Brole) - 1 do
      begin
        if (Brole[k].Wait = 1) and (k <> i) then
        begin
          Brole[k].Wait := 0;
          break;
        end;
      end;
      //showmessage(inttostr(i));

    end;
    // CallEvent(402);
    SDL_Delay(10 + GameSpeed);
  end;

end; //战斗主控制

procedure OldBattleMainControl;
var
  i, n, a, add: integer;
  word: WideString;
begin
  //redraw;
  for i := 0 to length(Brole) - 1 do
  begin
    Brole[i].lifeAdd := 0;
  end;
  //战斗未分出胜负则继续
  while BStatus = 0 do
  begin
    CalMoveAbility; //计算移动能力
    ReArrangeBRole; //排列角色顺序

    ClearDeadRolePic; //清除阵亡角色

    //是否已行动, 显示数字清空

    Bx := Brole[0].X;
    By := Brole[0].Y;
    for i := 0 to length(Brole) - 1 do
    begin
      Brole[i].Acted := 0;
      Brole[i].ShowNumber := 0;
    end;
    CallEvent(warsta.BoutEvent);

    for i := 0 to length(Brole) - 1 do
    begin
      Inc(Brole[i].round);
    end;

    i := 0;
    while (i < length(Brole)) and (Bstatus = 0) do
    begin

      if (Brole[i].rnum < 0) or (Brole[i].dead <> 0) then
      begin
        Inc(i);
        continue;
      end;
      CurBrole := i;
      //当前人物位置作为屏幕中心
      Bx := Brole[i].X;
      By := Brole[i].Y;
      Redraw;
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);


      if Brole[i].lifeAdd = 0 then
      begin

        //状态11，自动回血
        if (GetEquipState(Brole[i].rnum, 11)) or (GetGongtiState(Brole[i].rnum, 11)) then
        begin
          add := 0;
          add := Rrole[Brole[i].rnum].MaxHP div 10;
          if Rrole[Brole[i].rnum].MaxHP < Rrole[Brole[i].rnum].CurrentHP + add then
            add := Rrole[Brole[i].rnum].MaxHP - Rrole[Brole[i].rnum].CurrentHP;
          for a := 0 to length(Brole) - 1 do
            Brole[a].ShowNumber := -1;
          Brole[i].ShowNumber := add;
          if add > 0 then ShowHurtValue(3);
          Rrole[Brole[i].rnum].CurrentHP := Rrole[Brole[i].rnum].CurrentHP + add;
        end;
        //状态23，自动回内
        if (GetEquipState(Brole[i].rnum, 23)) or (GetGongtiState(Brole[i].rnum, 23)) then
        begin
          add := 0;
          add := Rrole[Brole[i].rnum].MaxMP div 20;
          if Rrole[Brole[i].rnum].MaxMP < Rrole[Brole[i].rnum].CurrentMP + add then
            add := Rrole[Brole[i].rnum].MaxMP - Rrole[Brole[i].rnum].CurrentMP;
          for a := 0 to length(Brole) - 1 do
            Brole[a].ShowNumber := -1;
          Brole[i].ShowNumber := add;
          if add > 0 then
            ShowHurtValue(1, ColColor(0, $50), ColColor(0, $53));
          Rrole[Brole[i].rnum].CurrentMP := Rrole[Brole[i].rnum].CurrentMP + add;
        end;
        CalPoiHurtLife(i); //计算中毒损血
        Brole[i].lifeAdd := 1;
      end;
      while (SDL_PollEvent(@event) >= 0) do
      begin
        CheckBasicEvent;
        if ((event.key.keysym.sym = SDLK_ESCAPE) or (event.button.button = SDL_BUTTON_RIGHT)) and
          (Brole[i].Auto < 3) then
        begin
          Brole[i].Auto := -1;
          //AutoMode[i]:=-1;
          event.button.button := 0;
          event.key.keysym.sym := 0;
        end;
        break;
      end;
      //战场序号保存至变量28005
      x50[28005] := i;



      //为我方且未阵亡, 非自动战斗, 则显示选单
      if Brole[i].frozen >= 100 then
      begin
        Brole[i].Acted := 1;
        Dec(Brole[i].frozen, 100);
      end
      else if (Brole[i].Dead = 0) and (Brole[i].Acted = 0) then
      begin
        Brole[i].frozen := 0;
        if (Brole[i].Team = 0) and (Brole[i].Auto = -1) then
        begin
          case BattleMenu(i) of
            0: MoveRole(i);
            1: Attack(i);
            2: UsePoision(i);
            3: MedPoision(i);
            4: Medcine(i);
            5: MedFrozen(i);
            6: zhuanzhu(i);
            7: BattleMenuItem(i);
            8: Wait(i);
            9: Selectshowstatus(i);
            10: Rest(i);
            11: Auto(i);
          end;
        end
        else
        begin
          AutoBattle2(i);
          Brole[i].Acted := 1;
        end;
      end
      else if Brole[i].Acted = 1 then
      begin
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        //sdl_delay((200 * gamespeed) div 10);
      end
      else
      begin
        Brole[i].Acted := 1;
      end;
      ClearDeadRolePic;
      Bstatus := BattleStatus;
      if Brole[i].Acted = 1 then
      begin
        Brole[i].lifeAdd := 0;
        // if Brole[i].Dead = 0 then
        CallEvent(warsta.OperationEvent);
        i := i + 1;
      end;
      Redraw;
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      SDL_Delay(10 + GameSpeed);
      //showmessage(inttostr(i));
    end;
    x50[28101] := BRoleAmount;
    // CallEvent(402);

  end;

end;

procedure showprogress;
var
  i, i1, i2, temp, s1, s2, x, y: integer;
  b: array of integer;
  str: WideString;
begin
  if battlemode = 0 then exit;
  x := 250;
  y := 30;
  setlength(b, length(Brole));
  for i := 0 to length(Brole) - 1 do
  begin
    b[i] := i;
  end;
  for i1 := 0 to length(Brole) - 2 do
  begin
    for i2 := i1 + 1 to length(Brole) - 1 do
    begin
      s1 := 0;
      s2 := 0;
      if (Brole[i1].rnum > -1) and (Brole[i2].rnum > -1) then
      begin
        s1 := Brole[i1].Progress;
        s2 := Brole[i2].Progress;
      end;
      if (s1 > s2) then
      begin
        temp := b[i1];
        b[i1] := b[i2];
        b[i2] := temp; //冒泡排序
      end;
    end;
  end;
  drawpngpic(PROGRESS_PIC, x, y, 0);
  for i := 0 to length(b) - 1 do
  begin
    if (Brole[b[i]].rnum >= 0) and (Brole[b[i]].Dead = 0) then
    begin
      if Brole[b[i]].Team = 0 then
      begin
        if Bfield[4, Brole[b[i]].X, Brole[b[i]].y] > 0 then
          drawpngpic(SELECTEDMATE_PIC, 20 + Brole[b[i]].Progress + x, y, 0)
        else
          drawpngpic(MATESIGN_PIC, 20 + Brole[b[i]].Progress + x, y, 0);
        ZoomPic(Head_Pic[Rrole[Brole[b[i]].rnum].headnum].pic, 0, 20 + Brole[b[i]].Progress + x - 10, y - 30, 29, 30);
      end
      else
      begin
        if Bfield[4, Brole[b[i]].X, Brole[b[i]].y] > 0 then
          drawpngpic(SELECTEDENEMY_PIC, 20 + Brole[b[i]].Progress + x, y, 0)
        else
          drawpngpic(ENEMYSIGN_PIC, 20 + Brole[b[i]].Progress + x, y, 0);
        ZoomPic(Head_Pic[Rrole[Brole[b[i]].rnum].headnum].pic, 0, 20 + Brole[b[i]].Progress + x - 10, y + 30, 29, 30);
      end;
    end;
  end;
  str := IntToStr(jiqicount);
  DrawShadowText(@str[1], screen.w - 50, 37, ColColor($5), ColColor($7));

end;

//按轻功重排人物(未考虑装备)

procedure ReArrangeBRole;
var
  i, n, n1, i1, i2, x, t, s1, s2: integer;
  temp: TBattleRole;
begin
  i1 := 0;
  i2 := 1;
  for i1 := 0 to length(Brole) - 2 do
    for i2 := i1 + 1 to length(Brole) - 1 do
    begin
      s1 := 0;
      s2 := 0;
      if (Brole[i1].rnum > -1) and (Brole[i1].Dead = 0) then
      begin
        s1 := GetRoleSpeed(Brole[i1].rnum, True);
        if CheckEquipSet(Rrole[Brole[i1].rnum].Equip[0], Rrole[Brole[i1].rnum].Equip[1],
          Rrole[Brole[i1].rnum].Equip[2], Rrole[Brole[i1].rnum].Equip[3]) = 5 then
          s1 := s1 + 30;
      end;
      if (Brole[i2].rnum > -1) and (Brole[i2].Dead = 0) then
      begin
        s2 := GetRoleSpeed(Brole[i2].rnum, True);
        if CheckEquipSet(Rrole[Brole[i2].rnum].Equip[0], Rrole[Brole[i2].rnum].Equip[1],
          Rrole[Brole[i2].rnum].Equip[2], Rrole[Brole[i2].rnum].Equip[3]) = 5 then
          s2 := s2 + 30;
      end;
      if (not ((GetPetSkill(5, 1) and (Brole[i1].rnum = 0)) or (GetPetSkill(5, 3) and
        (Brole[i1].Team = 0)))) and
        ((s1 < s2) or ((GetPetSkill(5, 1) and (Brole[i2].rnum = 0)) or
        (GetPetSkill(5, 3) and (Brole[i2].Team = 0)))) then
      begin
        temp := Brole[i1];
        Brole[i1] := Brole[i2];
        Brole[i2] := temp;
      end;
    end;



  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
    begin
      Bfield[2, i1, i2] := -1;
      Bfield[5, i1, i2] := -1;
    end;
  n := 0;
  for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].Dead = 0) and (Brole[i].rnum >= 0) then
    begin
      Inc(n);
    end;
  end;
  n1 := 0;
  for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].rnum >= 0) then
    begin
      if (Brole[i].Dead = 0) then
      begin
        Bfield[2, Brole[i].X, Brole[i].Y] := i;
        Bfield[5, Brole[i].X, Brole[i].Y] := -1;
        if battlemode > 0 then
          Brole[i].Progress := (n - n1) * 5;
        Inc(n1);
      end
      else
      begin
        Bfield[2, Brole[i].X, Brole[i].Y] := -1;
        Bfield[5, Brole[i].X, Brole[i].Y] := i;
      end;
    end;
  end;
  i2 := 0;
  if (battlemode > 0) then
    for i1 := 0 to length(Brole) - 1 do
      if ((GetPetSkill(5, 1) and (Brole[i1].rnum = 0)) or (GetPetSkill(5, 3) and (Brole[i1].Team = 0))) then
      begin
        Brole[i1].Progress := 299 - i2 * 5;
        i2 := i2 + 1;
      end;
end;

//计算可移动步数(考虑装备)

procedure CalMoveAbility;
var
  i, rnum, addspeed: integer;
begin
  maxspeed := 0;
  for i := 0 to length(Brole) - 1 do
  begin
    rnum := Brole[i].rnum;
    if rnum > -1 then
    begin
      addspeed := 0;
      if CheckEquipSet(Rrole[rnum].Equip[0], Rrole[rnum].Equip[1], Rrole[rnum].Equip[2], Rrole[rnum].Equip[3]) = 5 then
        Inc(addspeed, 30);
      Brole[i].speed := (GetRoleSpeed(Brole[i].rnum, True) + addspeed);
      if (Brole[i].Wait = 0) then Brole[i].Step := (Brole[i].speed * (100 + Brole[i].zhuangtai[8])) div 1500;
      maxspeed := max(maxspeed, Brole[i].speed);
      if Rrole[rnum].Moveable > 0 then Brole[i].Step := 0;
    end;
  end;

end;

//0: Continue; 1: Victory; 2:Failed.
//检查是否有一方全部阵亡

function BattleStatus: integer;
var
  i, sum0, sum1: integer;
begin
  sum0 := 0;
  sum1 := 0;
  for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].Team = 0) and (Brole[i].rnum >= 0) and (Brole[i].Dead = 0) then
      sum0 := sum0 + 1;
    if (Brole[i].Team = 1) and (Brole[i].rnum >= 0) and (Brole[i].Dead = 0) then
      sum1 := sum1 + 1;
  end;

  if (sum0 > 0) and (sum1 > 0) then Result := 0;
  if (sum0 >= 0) and (sum1 = 0) then Result := 1;
  if (sum0 = 0) and (sum1 > 0) then Result := 2;

end;

//战斗主选单, menustatus按bit保存可用项
function BattleMenu(bnum: integer): integer;
var
  i, p, MenuStatus, menu, max0, rnum, menup, i1, lv, i2: integer;
  realmenu: array[0..10] of integer;
  word: WideString;
  str: string;
begin
  SDL_EventState(SDL_MOUSEMOTION, SDL_ENABLE);
  MenuStatus := $FC0;
  max0 := 5;
  //for i:=0 to 9 do
  rnum := Brole[bnum].rnum;
  //移动是否可用
  if Brole[bnum].Step > 0 then
  begin
    MenuStatus := MenuStatus or 1;
    max0 := max0 + 1;
  end;
  SDL_EnableKeyRepeat(10, 100);
  event.key.keysym.sym := 0;
  event.button.button := 0;
  //can not attack when phisical<10
  //攻击是否可用
  if Rrole[rnum].PhyPower >= 10 then
  begin
    p := 0;
    for i := 0 to 9 do
    begin
      if (Rrole[rnum].jhMagic[i] >= 0) and (Rmagic[Rrole[rnum].lMagic[Rrole[rnum].jhmagic[i]]].NeedMP <=
        Rrole[rnum].CurrentMP) then
      begin
        lv := Rrole[Brole[bnum].rnum].MagLevel[i] div 100;
        p := 1;
        break;
      end;
    end;
    if p > 0 then
    begin
      MenuStatus := MenuStatus or 2;
      max0 := max0 + 1;
    end;
  end;
  //用毒是否可用   取消直接用毒
  {if (GetRoleUsePoi(rnum, True) > 0) and (Rrole[rnum].PhyPower >= 30) then
  begin
    MenuStatus := MenuStatus or 4;
    max0 := max0 + 1;
  end; }
  //解毒是否可用
  if (GetRoleMedPoi(rnum, True) > 0) and (Rrole[rnum].PhyPower >= 50) then
  begin
    MenuStatus := MenuStatus or 8;
    max0 := max0 + 1;
  end;
  //医疗是否可用  取消直接医疗
  {if (GetRoleMedcine(rnum, True) > 0) and (Rrole[rnum].PhyPower >= 50) then
  begin
    MenuStatus := MenuStatus or 16;
    max0 := max0 + 1;
  end;  }
  //解穴是否可用
  if (Rrole[rnum].CurrentMP + (GetRoleMedcine(rnum, True) * 5) > 200) and (Rrole[rnum].PhyPower >= 50) then
  begin
    MenuStatus := MenuStatus or 32;
    max0 := max0 + 1;
  end;
  if (BattleMode > 0) and False then
  begin
    MenuStatus := MenuStatus or 64;
    max0 := max0 + 1;
  end;

  Redraw;
  DrawRectangle(10, 50, 80, 28, 0, ColColor(0, 255), 30);
  str := '第' + IntToStr(Brole[bnum].round) + '回';
  word := GBKtoUnicode(@str[1]);
  DrawShadowText(@word[1], 10 - 17, 50 + 2, ColColor(0, 5), ColColor(0, 7));
  ShowSimpleStatus(Brole[bnum].rnum, 30, 330);
  showprogress;
  menu := 0;
  
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  ShowBMenu(MenuStatus, menu, max0);
  //SDL_UpdateRect2(screen,0,0,screen.w,screen.h);
  while (SDL_PollEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          break;
        end;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          menu := -1;
          if Bfield[2, Bx, By] = bnum then Bfield[2, Bx, By] := -1;
          Bx := TBx;
          By := TBy;
          Brole[bnum].X := TBx;
          Brole[bnum].y := TBy;
          Brole[bnum].Step := Tstep;
          if Bfield[2, Bx, By] = -1 then Bfield[2, Bx, By] := bnum;

          break;
        end;
      end;
      SDL_KEYDOWN:
      begin
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          menu := menu - 1;
          if menu < 0 then menu := max0;
          ShowBMenu(MenuStatus, menu, max0);
        end;
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          menu := menu + 1;
          if menu > max0 then menu := 0;
          ShowBMenu(MenuStatus, menu, max0);
        end;
        if (event.key.keysym.sym = SDLK_F5) then
        begin
          if FULLSCREEN = 1 then
          begin
            if HW = 0 then screen := SDL_SetVideoMode(CENTER_X * 2, CENTER_Y * 2, 32,
                SDL_HWSURFACE or SDL_DOUBLEBUF or SDL_ANYFORMAT)
            else screen := SDL_SetVideoMode(CENTER_X * 2, CENTER_Y * 2, 32, SDL_SWSURFACE or
                SDL_DOUBLEBUF or SDL_ANYFORMAT);
          end
          else
            screen := SDL_SetVideoMode(CENTER_X * 2, CENTER_Y * 2, 32, SDL_FULLSCREEN);
          FULLSCREEN := 1 - FULLSCREEN;
          Kys_ini.WriteInteger('set', 'fullscreen', FULLSCREEN);
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_LEFT) then
          break;
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          menu := -1;
          if Bfield[2, Bx, By] = bnum then Bfield[2, Bx, By] := -1;
          Bx := TBx;
          By := TBy;
          Brole[bnum].X := TBx;
          Brole[bnum].y := TBy;
          Brole[bnum].Step := Tstep;
          if Bfield[2, Bx, By] = -1 then Bfield[2, Bx, By] := bnum;

          break;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x >= 100) and (event.button.x < 147) and (event.button.y >= 50 - 22) and
          (event.button.y < max0 * 22 + 78 - 22) then
        begin
          menup := menu;
          menu := (event.button.y - 52 + 22) div 22;
          if menu > max0 then menu := max0;
          if menu < 0 then menu := 0;
          if menup <> menu then ShowBMenu(MenuStatus, menu, max0);
        end;
      end;
    end;

    if (Rrole[Brole[bnum].rnum].Poision > 0) or (Rrole[Brole[bnum].rnum].Hurt > 0) then
    begin
      ShowSimpleStatus(Brole[bnum].rnum, 30, 330);
      SDL_UpdateRect2(screen, 52, 394 - 77, 58, 60);
    end;
    event.key.keysym.sym := 0;
    event.button.button := 0;
    SDL_Delay(10 + GameSpeed);
  end;
  event.key.keysym.sym := 0;
  event.button.button := 0;
  Result := -1;
  if menu >= 0 then
  begin
    p := 0;
    for i := 0 to 10 do
    begin
      if (MenuStatus and (1 shl i)) > 0 then
      begin
        p := p + 1;
        if p > menu then break;
      end;
    end;
    Result := i;
  end;
  SDL_EnableKeyRepeat(100, 30);
  SDL_EventState(SDL_MOUSEMOTION, SDL_ignore);
end;

//显示战斗主选单

procedure ShowBMenu(MenuStatus, menu, max0: integer);
var
  i, p: integer;
  word: array[0..11] of WideString;
begin
  word[0] := '移動';
  word[1] := '武學';
  word[2] := '用毒';
  word[3] := '解毒';
  word[4] := '醫療';
  word[5] := '解穴';
  word[6] := '專注';
  word[7] := '物品';
  word[8] := '等待';
  word[9] := '狀態';
  word[10] := '休息';
  word[11] := '自動';
  Redraw;
  DrawRectangle(100, 50 - 22, 47, max0 * 22 + 28, 0, ColColor(255), 30);
  p := 0;
  for i := 0 to 11 do
  begin
    if (p = menu) and ((MenuStatus and (1 shl i) > 0)) then
    begin
      DrawShadowText(@word[i][1], 83, 53 - 22 + 22 * p, ColColor($64), ColColor($66));
      p := p + 1;
    end
    else if (p <> menu) and ((MenuStatus and (1 shl i) > 0)) then
    begin
      DrawShadowText(@word[i][1], 83, 53 - 22 + 22 * p, ColColor($21), ColColor($23));
      p := p + 1;
    end;
  end;
  SDL_UpdateRect2(screen, 100, 50 - 22, 48, max0 * 22 + 29);
end;

//移动

procedure MoveRole(bnum: integer);
var
  s, i: integer;
begin
  CalCanSelect(bnum, 0, Brole[bnum].Step);
  if SelectAim(bnum, Brole[bnum].Step,0) then
    MoveAmination(bnum);

end;

//移动动画

procedure MoveAmination(bnum: integer);
var
  s, i, a, tempx, tempy: integer;
  Xinc, Yinc: array[1..4] of integer;
begin
  if Bfield[3, Ax, Ay] > 0 then
  begin
    Xinc[1] := 1;
    Xinc[2] := -1;
    Xinc[3] := 0;
    Xinc[4] := 0;
    Yinc[1] := 0;
    Yinc[2] := 0;
    Yinc[3] := 1;
    Yinc[4] := -1;
    linex[0] := Bx;
    liney[0] := By;
    linex[Bfield[3, Ax, Ay]] := Ax;
    liney[Bfield[3, Ax, Ay]] := Ay;
    a := Bfield[3, Ax, Ay] - 1;
    while a >= 0 do
    begin
      for i := 1 to 4 do
      begin
        tempx := linex[a + 1] + Xinc[i];
        tempy := liney[a + 1] + Yinc[i];
        if Bfield[3, tempx, tempy] = Bfield[3, linex[a + 1], liney[a + 1]] - 1 then
        begin
          linex[a] := tempx;
          liney[a] := tempy;
          break;
        end;
      end;
      Dec(a);
    end;
    a := 1;
    while not ((Brole[bnum].Step = 0) or ((Bx = Ax) and (By = Ay))) do
    begin
      if sign(linex[a] - Bx) > 0 then
        Brole[bnum].Face := 3
      else if sign(linex[a] - Bx) < 0 then
        Brole[bnum].Face := 0
      else if sign(liney[a] - By) < 0 then
        Brole[bnum].Face := 2
      else Brole[bnum].Face := 1;
      if Bfield[2, Bx, By] = bnum then Bfield[2, Bx, By] := -1;
      Bx := linex[a];
      By := liney[a];
      if Bfield[2, Bx, By] = -1 then Bfield[2, Bx, By] := bnum;
      Inc(a);
      Dec(Brole[bnum].Step);
      Redraw;
      showprogress;
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      SDL_Delay(5 + GameSpeed div 3);

    end;
    Brole[bnum].Step := 0;
    Brole[bnum].X := Bx;
    Brole[bnum].Y := By;

  end;

end;

//选择查看状态的目标

function Selectshowstatus(bnum: integer): boolean;
var
  Axp, Ayp, rnum, step, range, i, i1, i2, AttAreaType: integer;
begin
  Ax := Bx;
  Ay := By;
  step := 64;
  range := 0;
  AttAreaType := 0;
  CalCanSelect(bnum, 2, 64);
  DrawBFieldWithCursor(AttAreaType, step, range,0);
  rnum := Brole[Bfield[2, Ax, Ay]].rnum;
  ShowSimpleStatus(rnum, 240, 330);
  showprogress;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  while (SDL_PollEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          if Bfield[2, Ax, Ay] >= 0 then
          begin
            if Brole[Bfield[2, Ax, Ay]].Dead = 0 then
            begin
              if GetPetSkill(5, 0) or (Brole[Bfield[2, Ax, Ay]].Team = 0) then
              begin
                rnum := Brole[Bfield[2, Ax, Ay]].rnum;
                newshowstatus(rnum);
                NewShowMagic(rnum);
                WaitAnyKey();
                Redraw;
                ShowSimpleStatus(rnum, 240, 330);
              end;
            end;
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;
        end;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          Result := False;
          break;
        end;
      end;
      SDL_KEYDown:
      begin
        if (event.key.keysym.sym = SDLK_LEFT) or (event.key.keysym.sym = SDLK_KP4) then
        begin
          Ay := Ay - 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) then Ay := Ay + 1;
        end;
        if (event.key.keysym.sym = SDLK_RIGHT) or (event.key.keysym.sym = SDLK_KP6) then
        begin
          Ay := Ay + 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) then Ay := Ay - 1;
        end;
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          Ax := Ax + 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) then Ax := Ax - 1;
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          Ax := Ax - 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) then Ax := Ax + 1;
        end;
        DrawBFieldWithCursor(AttAreaType, step, range,0);
        if (Bfield[2, Ax, Ay] >= 0) then
        begin
          if Brole[Bfield[2, Ax, Ay]].Dead = 0 then
          begin
            rnum := Brole[Bfield[2, Ax, Ay]].rnum;
            ShowSimpleStatus(rnum, 240, 330);
          end;
        end;
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          if Bfield[2, Ax, Ay] >= 0 then
          begin
            if Brole[Bfield[2, Ax, Ay]].Dead = 0 then
            begin
              if GetPetSkill(5, 0) or (Brole[Bfield[2, Ax, Ay]].Team = 0) then
              begin
                rnum := Brole[Bfield[2, Ax, Ay]].rnum;
                newshowstatus(rnum);
                NewShowMagic(rnum);
                WaitAnyKey();
                Redraw;
                ShowSimpleStatus(rnum, 240, 330);
              end;
            end;
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;
        end;
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          Result := False;
          break;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        Axp := (-event.button.x + CENTER_X + 2 * event.button.y - 2 * CENTER_Y + 18) div 36 + Bx;
        Ayp := (event.button.x - CENTER_X + 2 * event.button.y - 2 * CENTER_Y + 18) div 36 + By;
        if (abs(Axp - Bx) + abs(Ayp - By) <= step) then
        begin
          Ax := Axp;
          Ay := Ayp;
          DrawBFieldWithCursor(AttAreaType, step, range,0);

          if (Bfield[2, Ax, Ay] >= 0) then
          begin
            if Brole[Bfield[2, Ax, Ay]].Dead = 0 then
            begin
              rnum := Brole[Bfield[2, Ax, Ay]].rnum;
              ShowSimpleStatus(rnum, 240, 330);
            end;
          end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
    end;
    if (Bfield[2, Ax, Ay] >= 0) then
    begin
      if Brole[Bfield[2, Ax, Ay]].Dead = 0 then
      begin
        rnum := Brole[Bfield[2, Ax, Ay]].rnum;
        ShowSimpleStatus(rnum, 240, 330);
        SDL_UpdateRect2(screen, 352, 394 - 77, 58, 60);
      end;
    end;
    event.key.keysym.sym := 0;
    event.button.button := 0;
    SDL_Delay(5 + GameSpeed div 3);
  end;
  event.key.keysym.sym := 0;
  event.button.button := 0;
end;

//选择点

function SelectAim(bnum, step,mods: integer): boolean;
var
  Axp, Ayp: integer;
begin
  Ax := Bx;
  Ay := By;
  DrawBFieldWithCursor(0, step, 0,mods);
  ShowSimpleStatus(Brole[Bfield[2, Ax, Ay]].rnum, 240, 330);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  SDL_EnableKeyRepeat(10, 100);
  while (SDL_PollEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          Result := True;
          x50[28927] := 1;
          break;
        end;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          Result := False;
          x50[28927] := 0;
          break;
        end;
      end;
      SDL_KEYDOWN:
      begin
        if (event.key.keysym.sym = SDLK_LEFT) or (event.key.keysym.sym = SDLK_KP4) then
        begin
          Ay := Ay - 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) or (Bfield[3, Ax, Ay] < 0) then Ay := Ay + 1;
        end;
        if (event.key.keysym.sym = SDLK_RIGHT) or (event.key.keysym.sym = SDLK_KP6) then
        begin
          Ay := Ay + 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) or (Bfield[3, Ax, Ay] < 0) then Ay := Ay - 1;
        end;
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          Ax := Ax + 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) or (Bfield[3, Ax, Ay] < 0) then Ax := Ax - 1;
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          Ax := Ax - 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) or (Bfield[3, Ax, Ay] < 0) then Ax := Ax + 1;
        end;
        DrawBFieldWithCursor(0, step, 0,mods);
        if (Bfield[2, Ax, Ay] >= 0) and (Brole[Bfield[2, Ax, Ay]].Dead = 0) then
          ShowSimpleStatus(Brole[Bfield[2, Ax, Ay]].rnum, 240, 330);
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          Result := True;
          break;
        end;
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          Result := False;
          break;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        Axp := (-event.button.x + CENTER_X + 2 * event.button.y - 2 * CENTER_Y + 18) div 36 + Bx;
        Ayp := (event.button.x - CENTER_X + 2 * event.button.y - 2 * CENTER_Y + 18) div 36 + By;
        if (abs(Axp - Bx) + abs(Ayp - By) <= step) and (Bfield[3, Axp, Ayp] >= 0) then
        begin
          Ax := Axp;
          Ay := Ayp;
          DrawBFieldWithCursor(0, step, 0,mods);
          if (Bfield[2, Ax, Ay] >= 0) and (Brole[Bfield[2, Ax, Ay]].Dead = 0) then
            ShowSimpleStatus(Brole[Bfield[2, Ax, Ay]].rnum, 240, 330);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
    end;
    if (Bfield[2, Ax, Ay] >= 0) and (Brole[Bfield[2, Ax, Ay]].Dead = 0) then
    begin
      if (Rrole[Brole[Bfield[2, Ax, Ay]].rnum].Poision > 0) or (Rrole[Brole[Bfield[2, Ax, Ay]].rnum].Hurt > 0) then
      begin
        ShowSimpleStatus(Brole[Bfield[2, Ax, Ay]].rnum, 240, 330);
        SDL_UpdateRect2(screen, 352, 394 - 77, 58, 60);
      end;
    end;
    event.key.keysym.sym := 0;
    event.button.button := 0;
    SDL_Delay(5 + GameSpeed div 3);
  end;
  event.key.keysym.sym := 0;
  event.button.button := 0;
end;

//选择原地

function SelectCross(bnum, AttAreaType, step, range,mods: integer): boolean;
var
  Axp, Ayp: integer;
begin
  Ax := Bx;
  Ay := By;
  DrawBFieldWithCursor(AttAreaType, step, range,mods);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  while (SDL_PollEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          Result := True;
          break;
        end;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          Result := False;
          break;
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          Result := True;
          break;
        end;
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          Result := False;
          break;
        end;
      end;
    end;
    event.key.keysym.sym := 0;
    event.button.button := 0;
    SDL_Delay(5 + GameSpeed div 3);
  end;
  event.key.keysym.sym := 0;
  event.button.button := 0;

end;

//目标系点叉菱方型、原地系菱方型

function SelectRange(bnum, AttAreaType, step, range,mods: integer): boolean;
var
  Axp, Ayp: integer;
begin
  Ax := Bx;
  Ay := By;
  DrawBFieldWithCursor(AttAreaType, step, range,mods);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

  while (SDL_PollEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          Result := True;
          x50[28927] := 1;
          break;
        end;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          Result := False;
          x50[28927] := 0;
          break;
        end;
        if (event.key.keysym.sym = SDLK_LEFT) or (event.key.keysym.sym = SDLK_KP4) then
        begin
          Ay := Ay - 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) then Ay := Ay + 1;
        end;
        if (event.key.keysym.sym = SDLK_RIGHT) or (event.key.keysym.sym = SDLK_KP6) then
        begin
          Ay := Ay + 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) then Ay := Ay - 1;
        end;
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          Ax := Ax + 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) then Ax := Ax - 1;
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          Ax := Ax - 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) then Ax := Ax + 1;
        end;
        DrawBFieldWithCursor(AttAreaType, step, range,mods);
        if (Bfield[2, Ax, Ay] >= 0) and (Bfield[2, Ax, Ay] <> bnum) then
          ShowSimpleStatus(Brole[Bfield[2, Ax, Ay]].rnum, 240, 330);
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          Result := True;
          break;
        end;
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          Result := False;
          break;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        Axp := (-event.button.x + CENTER_X + 2 * event.button.y - 2 * CENTER_Y + 18) div 36 + Bx;
        Ayp := (event.button.x - CENTER_X + 2 * event.button.y - 2 * CENTER_Y + 18) div 36 + By;
        if (abs(Axp - Bx) + abs(Ayp - By) <= step) then
        begin
          Ax := Axp;
          Ay := Ayp;
          DrawBFieldWithCursor(AttAreaType, step, range,mods);
          if (Bfield[2, Ax, Ay] >= 0) and (Bfield[2, Ax, Ay] <> bnum) then
            ShowSimpleStatus(Brole[Bfield[2, Ax, Ay]].rnum, 240, 330);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;

    end;

    if (Bfield[2, Ax, Ay] >= 0) and (Bfield[2, Ax, Ay] <> bnum) then
    begin
      if (Rrole[Brole[Bfield[2, Ax, Ay]].rnum].Poision > 0) or (Rrole[Brole[Bfield[2, Ax, Ay]].rnum].Hurt > 0) then
      begin
        ShowSimpleStatus(Brole[Bfield[2, Ax, Ay]].rnum, 240, 330);
        SDL_UpdateRect2(screen, 352, 394 - 77, 58, 60);
      end;
    end;
    event.key.keysym.sym := 0;
    event.button.button := 0;
    SDL_Delay(5 + GameSpeed div 3);
  end;
  event.key.keysym.sym := 0;
  event.button.button := 0;

end;

//选择远程

function SelectFar(bnum, mnum, level,mods: integer): boolean;
var
  Axp, Ayp: integer;
  AttAreaType, step, range, minstep: integer;
begin

  step := Rmagic[mnum].MoveDistance[level - 1];

  if CheckEquipSet(Rrole[Brole[bnum].rnum].equip[0], Rrole[Brole[bnum].rnum].equip[1],
    Rrole[Brole[bnum].rnum].equip[2], Rrole[Brole[bnum].rnum].equip[3]) = 1 then
    Inc(step, 1);
  if GetEquipState(Brole[bnum].rnum, 22) or GetGongtiState(Brole[bnum].rnum, 22) then //增加攻击距离
    Inc(step, 1);
  range := Rmagic[mnum].AttDistance[level - 1];
  AttAreaType := Rmagic[mnum].AttAreaType;

  minstep := Rmagic[mnum].MinStep;

  Ax := Bx - minstep - 1;
  Ay := By;
  DrawBFieldWithCursor(AttAreaType, step, range,mods);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  while (SDL_PollEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          Result := True;
          x50[28927] := 1;
          break;
        end;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          Result := False;
          x50[28927] := 0;
          break;
        end;
        if (event.key.keysym.sym = SDLK_LEFT) or (event.key.keysym.sym = SDLK_KP4) then
        begin
          Ay := Ay - 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) then Ay := Ay + 1;
          if (abs(Ax - Bx) + abs(Ay - By) <= minstep) then
            if Ax >= Bx then Ax := Ax + 1
            else Ax := Ax - 1;
          DrawBFieldWithCursor(AttAreaType, step, range,mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_RIGHT) or (event.key.keysym.sym = SDLK_KP6) then
        begin
          Ay := Ay + 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) then Ay := Ay - 1;
          if (abs(Ax - Bx) + abs(Ay - By) <= minstep) then
            if Ax > Bx then Ax := Ax + 1
            else Ax := Ax - 1;
          DrawBFieldWithCursor(AttAreaType, step, range,mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          Ax := Ax + 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) then Ax := Ax - 1;
          if (abs(Ax - Bx) + abs(Ay - By) <= minstep) then
            if Ay >= By then Ay := Ay + 1
            else Ay := Ay - 1;
          DrawBFieldWithCursor(AttAreaType, step, range,mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          Ax := Ax - 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) then Ax := Ax + 1;
          if (abs(Ax - Bx) + abs(Ay - By) <= minstep) then
            if Ay > By then Ay := Ay + 1
            else Ay := Ay - 1;
          DrawBFieldWithCursor(AttAreaType, step, range,mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          Result := True;
          break;
        end;
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          Result := False;
          break;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        Axp := (-event.button.x + CENTER_X + 2 * event.button.y - 2 * CENTER_Y + 18) div 36 + Bx;
        Ayp := (event.button.x - CENTER_X + 2 * event.button.y - 2 * CENTER_Y + 18) div 36 + By;
        if (abs(Axp - Bx) + abs(Ayp - By) <= step) and (abs(Axp - Bx) + abs(Ayp - By) > minstep) then
        begin
          Ax := Axp;
          Ay := Ayp;
          DrawBFieldWithCursor(AttAreaType, step, range,mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
    end;
    event.key.keysym.sym := 0;
    event.button.button := 0;
    SDL_Delay(5 + GameSpeed div 3);
  end;
  event.key.keysym.sym := 0;
  event.button.button := 0;

end;

//选择方向

function SelectDirector(bnum, AttAreaType, step, range,mods: integer): boolean;
var
  str: WideString;
begin
  Ax := Bx - 1;
  Ay := By;
  //str := '選擇攻擊方向';
  //Drawtextwithrect(@str[1], 280, 200, 125, colcolor($23), colcolor($21));
  DrawBFieldWithCursor(AttAreaType, step, range,mods);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  Result := False;
  while (SDL_PollEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          break;
        end;
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          if (Ax <> Bx) or (Ay <> By) then Result := True;
          break;
        end;
        if (event.key.keysym.sym = SDLK_LEFT) or (event.key.keysym.sym = SDLK_KP4) then
        begin
          Ay := By - 1;
          Ax := Bx;
          DrawBFieldWithCursor(AttAreaType, step, range,mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_RIGHT) or (event.key.keysym.sym = SDLK_KP6) then
        begin
          Ay := By + 1;
          Ax := Bx;
          DrawBFieldWithCursor(AttAreaType, step, range,mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          Ax := Bx + 1;
          Ay := By;
          DrawBFieldWithCursor(AttAreaType, step, range,mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          Ax := Bx - 1;
          Ay := By;
          DrawBFieldWithCursor(AttAreaType, step, range,mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if event.button.button = SDL_BUTTON_RIGHT then
        begin
          Result := False;
          break;
        end;
        //按照所点击位置设置方向
        if event.button.button = SDL_BUTTON_LEFT then
        begin
          if (event.button.x < CENTER_X) and (event.button.y < CENTER_Y) then
          begin
            Ay := By - 1;
            Ax := Bx;
            Result := True;
            break;
          end;
          if (event.button.x < CENTER_X) and (event.button.y >= CENTER_Y) then
          begin
            Ax := Bx + 1;
            Ay := By;
            Result := True;
            break;
          end;
          if (event.button.x >= CENTER_X) and (event.button.y < CENTER_Y) then
          begin
            Ax := Bx - 1;
            Ay := By;
            Result := True;
            break;
          end;
          if (event.button.x >= CENTER_X) and (event.button.y >= CENTER_Y) then
          begin
            Ay := By + 1;
            Ax := Bx;
            Result := True;
            break;
          end;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x < CENTER_X) and (event.button.y < CENTER_Y) then
        begin
          Ay := By - 1;
          Ax := Bx;
        end;
        if (event.button.x < CENTER_X) and (event.button.y >= CENTER_Y) then
        begin
          Ax := Bx + 1;
          Ay := By;
        end;
        if (event.button.x >= CENTER_X) and (event.button.y < CENTER_Y) then
        begin
          Ax := Bx - 1;
          Ay := By;
        end;
        if (event.button.x >= CENTER_X) and (event.button.y >= CENTER_Y) then
        begin
          Ay := By + 1;
          Ax := Bx;
        end;
        DrawBFieldWithCursor(AttAreaType, step, range,mods);
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

      end;
    end;
    event.key.keysym.sym := 0;
    event.button.button := 0;
    SDL_Delay(5 + GameSpeed div 3);
  end;
  event.key.keysym.sym := 0;
  event.button.button := 0;
end;

//计算可以被选中的位置
//利用递归确定

procedure SeekPath(x, y, step: integer);
begin
  if step > 0 then
  begin
    step := step - 1;
    if Bfield[3, x, y] in [0..step] then
    begin
      Bfield[3, x, y] := step;
      if Bfield[3, x + 1, y] in [0..step] then
      begin
        SeekPath(x + 1, y, step);
      end;
      if Bfield[3, x, y + 1] in [0..step] then
      begin
        SeekPath(x, y + 1, step);
      end;
      if Bfield[3, x - 1, y] in [0..step] then
      begin
        SeekPath(x - 1, y, step);
      end;
      if Bfield[3, x, y - 1] in [0..step] then
      begin
        SeekPath(x, y - 1, step);
      end;
    end;
  end;

end;

//计算可以被选中的位置
//利用队列
//移动过程中，旁边有敌人，则不能继续移动

procedure SeekPath2(x, y, step, myteam, mode: integer);

var
  Xlist: array[0..4096] of integer;
  Ylist: array[0..4096] of integer;
  steplist: array[0..4096] of integer;
  curgrid, totalgrid: integer;
  Bgrid: array[1..4] of integer; //0空位，1建筑，2友军，3敌军，4出界，5已走过 ，6水面
  Xinc, Yinc: array[1..4] of integer;
  curX, curY, curstep, nextX, nextY: integer;
  i: integer;

begin
  Xinc[1] := 1;
  Xinc[2] := -1;
  Xinc[3] := 0;
  Xinc[4] := 0;
  Yinc[1] := 0;
  Yinc[2] := 0;
  Yinc[3] := 1;
  Yinc[4] := -1;
  curgrid := 0;
  totalgrid := 0;
  Xlist[totalgrid] := x;
  Ylist[totalgrid] := y;
  steplist[totalgrid] := 0;
  totalgrid := totalgrid + 1;
  while curgrid < totalgrid do
  begin
    curX := Xlist[curgrid];
    curY := Ylist[curgrid];
    curstep := steplist[curgrid];
    if curstep < step then
    begin
      //判断当前点四周格子的状况
      for i := 1 to 4 do
      begin
        nextX := curX + Xinc[i];
        nextY := curY + Yinc[i];
        if (nextX < 0) or (nextX > 63) or (nextY < 0) or (nextY > 63) then
          Bgrid[i] := 4
        else if Bfield[3, nextX, nextY] >= 0 then
          Bgrid[i] := 5
        else if Bfield[1, nextX, nextY] > 0 then
          Bgrid[i] := 1
        else if (Bfield[2, nextX, nextY] >= 0) and (Brole[Bfield[2, nextX, nextY]].Dead = 0) then
        begin
          if Brole[Bfield[2, nextX, nextY]].Team = myteam then
            Bgrid[i] := 2
          else
            Bgrid[i] := 3;
        end
        else if ((Bfield[0, nextX, nextY] div 2 >= 179) and (Bfield[0, nextX, nextY] div 2 <= 190)) or
          (Bfield[0, nextX, nextY] div 2 = 261) or (Bfield[0, nextX, nextY] div 2 = 511) or
          ((Bfield[0, nextX, nextY] div 2 >= 224) and (Bfield[0, nextX, nextY] div 2 <= 232)) or
          ((Bfield[0, nextX, nextY] div 2 >= 662) and (Bfield[0, nextX, nextY] div 2 <= 674)) then
          Bgrid[i] := 6
        else
          Bgrid[i] := 0;
      end;

      //移动的情况
      //若为初始位置，不考虑旁边是敌军的情况
      //在移动过程中，旁边没有敌军的情况下才继续移动
      if mode = 0 then
      begin
        if (curstep = 0) or ((Bgrid[1] <> 3) and (Bgrid[2] <> 3) and (Bgrid[3] <> 3) and (Bgrid[4] <> 3)) then
        begin
          for i := 1 to 4 do
          begin
            if Bgrid[i] = 0 then
            begin
              Xlist[totalgrid] := curX + Xinc[i];
              Ylist[totalgrid] := curY + Yinc[i];
              steplist[totalgrid] := curstep + 1;
              Bfield[3, Xlist[totalgrid], Ylist[totalgrid]] := steplist[totalgrid];
              totalgrid := totalgrid + 1;
            end;
          end;
        end;
      end
      else
        //非移动的情况，攻击、医疗等
      begin
        for i := 1 to 4 do
        begin
          if (Bgrid[i] = 0) or (Bgrid[i] = 2) or ((Bgrid[i] = 3)) then
          begin
            Xlist[totalgrid] := curX + Xinc[i];
            Ylist[totalgrid] := curY + Yinc[i];
            steplist[totalgrid] := curstep + 1;
            Bfield[3, Xlist[totalgrid], Ylist[totalgrid]] := steplist[totalgrid];
            totalgrid := totalgrid + 1;
          end;
        end;
      end;
    end;
    curgrid := curgrid + 1;
  end;

end;

//初始化范围
//mode=0移动，1攻击用毒医疗等，2查看状态

procedure CalCanSelect(bnum, mode, step: integer);
var
  i, i1, i2: integer;
begin

  if mode = 0 then
  begin
    for i1 := 0 to 63 do
      for i2 := 0 to 63 do
        Bfield[3, i1, i2] := -1;

    Bfield[3, Brole[bnum].X, Brole[bnum].Y] := 0;
    SeekPath2(Brole[bnum].X, Brole[bnum].Y, Step, Brole[bnum].Team, mode);
  end;

  if mode = 1 then
    for i1 := 0 to 63 do
      for i2 := 0 to 63 do
      begin
        Bfield[3, i1, i2] := -1;
        if abs(i1 - Brole[bnum].X) + abs(i2 - Brole[bnum].Y) <= step then
          Bfield[3, i1, i2] := 0;
      end;

  if mode = 2 then
    for i1 := 0 to 63 do
      for i2 := 0 to 63 do
      begin
        Bfield[3, i1, i2] := -1;
        if Bfield[2, i1, i2] >= 0 then
          Bfield[3, i1, i2] := 0;
      end;

end;

//无定向直线

function SelectLine(bnum, AttAreaType, step, range,mods: integer): boolean;
var
  Axp, Ayp: integer;
begin
  Ax := Bx;
  Ay := By;
  DrawBFieldWithCursor(AttAreaType, step, range,mods);

  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  while (SDL_PollEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          Result := True;
          x50[28927] := 1;
          break;
        end;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          Result := False;
          x50[28927] := 0;
          break;
        end;
      end;
      SDL_KEYDown:
      begin
        if (event.key.keysym.sym = SDLK_LEFT) or (event.key.keysym.sym = SDLK_KP4) then
        begin
          Ay := Ay - 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) then Ay := Ay + 1;
        end;
        if (event.key.keysym.sym = SDLK_RIGHT) or (event.key.keysym.sym = SDLK_KP6) then
        begin
          Ay := Ay + 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) then Ay := Ay - 1;
        end;
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          Ax := Ax + 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) then Ax := Ax - 1;
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          Ax := Ax - 1;
          if (abs(Ax - Bx) + abs(Ay - By) > step) then Ax := Ax + 1;
        end;
        DrawBFieldWithCursor(AttAreaType, step, range,mods);
        if (Bfield[2, Ax, Ay] >= 0) and (Bfield[2, Ax, Ay] <> bnum) then
          ShowSimpleStatus(Brole[Bfield[2, Ax, Ay]].rnum, 240, 330);
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          Result := True;
          break;
        end;
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          Result := False;
          break;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        Axp := (-event.button.x + CENTER_X + 2 * event.button.y - 2 * CENTER_Y + 18) div 36 + Bx;
        Ayp := (event.button.x - CENTER_X + 2 * event.button.y - 2 * CENTER_Y + 18) div 36 + By;
        if (abs(Axp - Bx) + abs(Ayp - By) <= step) then
        begin
          Ax := Axp;
          Ay := Ayp;
          DrawBFieldWithCursor(AttAreaType, step, range,mods);
          if (Bfield[2, Ax, Ay] >= 0) and (Bfield[2, Ax, Ay] <> bnum) then
            ShowSimpleStatus(Brole[Bfield[2, Ax, Ay]].rnum, 240, 330);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
    end;
    if (Bfield[2, Ax, Ay] >= 0) and (Bfield[2, Ax, Ay] <> bnum) then
    begin
      if (Rrole[Brole[Bfield[2, Ax, Ay]].rnum].Poision > 0) or (Rrole[Brole[Bfield[2, Ax, Ay]].rnum].Hurt > 0) then
      begin
        ShowSimpleStatus(Brole[Bfield[2, Ax, Ay]].rnum, 240, 330);
        SDL_UpdateRect2(screen, 352, 394 - 77, 58, 60);
      end;
    end;
    event.key.keysym.sym := 0;
    event.button.button := 0;
    SDL_Delay(5 + GameSpeed div 3);
  end;
  event.key.keysym.sym := 0;
  event.button.button := 0;

end;

{
procedure CalCanSelect(bnum, mode: integer);
var
  i, i1, i2: integer;
begin
  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
    begin
      Bfield[3, i1, i2] := 0;
      //mode为0表示移动, 这时建筑和有人物(不包括自己)的位置不可选
      if mode = 0 then
      begin
        if Bfield[1, i1, i2] > 0 then Bfield[3, i1, i2] := -1;
        if Bfield[2, i1, i2] >= 0 then Bfield[3, i1, i2] := -1;
        if Bfield[2, i1, i2] = bnum then Bfield[3, i1, i2] := 0;
      end;
    end;
  if mode = 0 then
  begin
    SeekPath(Brole[bnum].X, Brole[bnum].Y, Brole[bnum].Step + 2);
    //递归算法的问题, 步数+2参与计算
    for i1 := 0 to 63 do
      for i2 := 0 to 63 do
      begin
        if Bfield[3, i1, i2] > 0 then
          Bfield[3, i1, i2] := 0
        else
          Bfield[3, i1, i2] := 1;
      end;
  end;
end;
 }

//攻击

procedure Attack(bnum: integer);
var
  rnum, i, mnum, l1, level, step, range, AttAreaType, i1, i2, twice, r1, temp,mods,hubo: integer;
  str: string;
  str1: WideString;
  str0: pansichar;
begin

  rnum := Brole[bnum].rnum;

  i := SelectMagic(bnum);
  if i < 0 then exit;
  i := Rrole[rnum].jhmagic[i];
  mnum := Rrole[rnum].lMagic[i];
  level := Rrole[rnum].MagLevel[i] div 100 + 1;
  CurMagic := mnum;
  x50[28928] := mnum;
  x50[28929] := i;
  x50[28100] := i;
  if (Rmagic[mnum].MagicType = 6) then
  begin
    addzhuangtai(bnum, mnum, level);
    magicexp(bnum, mnum, level, i);
  end;

  if Brole[bnum].acted <> 1 then
  begin
    if (i >= 0) then
      //依据攻击范围进一步选择
      step := Rmagic[mnum].MoveDistance[level - 1];
    if CheckEquipSet(Rrole[rnum].equip[0], Rrole[rnum].equip[1], Rrole[rnum].equip[2], Rrole[rnum].equip[3]) = 1 then
      Inc(step, 1);
    if GetEquipState(rnum, 22) or GetGongtiState(rnum, 22) then //增加攻击距离
      Inc(step, 1);
    range := Rmagic[mnum].AttDistance[level - 1];
    mods:=0;
    if Rmagic[mnum].MagicType = 7 then
      mods:=1;
    AttAreaType := Rmagic[mnum].AttAreaType;

    CalCanSelect(bnum, 1, step);
    case Rmagic[mnum].AttAreaType of
      0, 3:
      begin
        if SelectRange(bnum, AttAreaType, step, range,mods) then
        begin
          SetAminationPosition(AttAreaType, step, range);
          Brole[bnum].Acted := 1;
        end;
      end;
      1, 4, 5:
      begin
        if SelectDirector(bnum, AttAreaType, step, range,mods) then
        begin
          SetAminationPosition(AttAreaType, step, range);
          Brole[bnum].Acted := 1;
        end;
      end;
      2:
      begin
        if SelectCross(bnum, AttAreaType, step, range,mods) then
        begin
          SetAminationPosition(AttAreaType, step, range);
          Brole[bnum].Acted := 1;
        end;
      end;
      6:
      begin
        if SelectFar(bnum, mnum, level,mods) then
        begin
          SetAminationPosition(AttAreaType, step, range);
          Brole[bnum].Acted := 1;
        end;
      end;
      7:
      begin
        if SelectLine(bnum, AttAreaType, step, range,mods) then
        begin
          SetAminationPosition(AttAreaType, step, range);
          Brole[bnum].Acted := 1;
        end;
      end;
      8:
      begin
        CalCanSelect(bnum, 1, step);
        SelectAim(bnum, step,mods);
        Brole[bnum].Acted := 1;
      end;
    end;
  end;
  //如果行动成功, 武功等级增加, 播放效果
  twice := 0;
  r1 := 0;
  if (GetEquipState(rnum, 14) or (GetGongtiState(rnum, 14))) then
  begin
    for i1 := 0 to 5 do
    begin
      if random(100) >= (50 div (r1 + 1) * (100 + Brole[bnum].zhuangtai[6]) * Brole[bnum].zhuangtai[4] div 10000) then
        break;
      Inc(r1);
    end;
  end;
  for i1 := 0 to 5 do
  begin
    if random(100 * (i1 + 1)) >= ((getroleattack(rnum, True) div 15 + Brole[bnum].zhuangtai[6]) *
      Brole[bnum].zhuangtai[4] div 100) then
      break;
    Inc(Twice);
  end;
  hubo:=0;
  if GetGongtiState(rnum,14) then
  begin
    if (100 - getroleaptitude(rnum,1)) > random(100) then
    begin
      hubo:=1;
    end;
  end;
  if (Brole[bnum].Acted = 1) and (Rmagic[mnum].MagicType < 5) and (Rmagic[mnum].MagicType > 0)then
  begin
    for i1 := 0 to (Rrole[rnum].Atttwice + hubo) do
    begin
      if Rmagic[mnum].NeedMP > Rrole[rnum].CurrentMP then break;
      if (i1 > 0) and (random(101) > Brole[bnum].zhuangtai[4]) then break;
      if i1 = 1 then
      begin
        BShowBWord.sign := BShowBWord.sign or 1;
        BShowBWord.words[0] := '左右互搏';
        BShowBWord.delay[0] := 20;

      end;
      if Rmagic[mnum].EventNum > 0 then
      begin
        if Rmagic[mnum].EventNum > 0 then CallEvent(Rmagic[mnum].EventNum);
        if Rmagic[mnum].NeedMP * level > Rrole[rnum].CurrentMP then
        begin
          level := Rrole[rnum].CurrentMP div Rmagic[mnum].NeedMP;
        end;
        Rrole[rnum].CurrentMP := Rrole[rnum].CurrentMP - Rmagic[mnum].NeedMP * level;
        Rrole[rnum].CurrentHP := Rrole[rnum].CurrentHP - ((Rmagic[mnum].NeedMP * level) * Rrole[rnum].Hurt) div 100;

        if Rrole[rnum].CurrentHP < 0 then Rrole[rnum].CurrentHP := 0;
        if Rrole[rnum].CurrentMP < 0 then Rrole[rnum].CurrentMP := 0;
      end
      else AttackAction(bnum, mnum, level);

      l1 := Rrole[rnum].MagLevel[i] div 100 + 1;

      if (isattack) then
      begin
        magicexp(bnum, mnum, l1, i);
      end;
      ClearDeadRolePic;
    end;
    if twice > 0 then
    begin

      for i1 := 1 to twice do
      begin
        if (Rmagic[mnum].NeedMP > Rrole[rnum].CurrentMP) then break;
        BShowBWord.sign := BShowBWord.sign or 1;
        BShowBWord.words[0] := '連擊';
        BShowBWord.delay[0] := 20;
        if Rmagic[mnum].EventNum > 0 then
        begin
          if Rmagic[mnum].EventNum > 0 then CallEvent(Rmagic[mnum].EventNum);
          if Rmagic[mnum].NeedMP * level > Rrole[rnum].CurrentMP then
          begin
            level := Rrole[rnum].CurrentMP div Rmagic[mnum].NeedMP;
          end;
          Rrole[rnum].CurrentMP := Rrole[rnum].CurrentMP - Rmagic[mnum].NeedMP * level;
          Rrole[rnum].CurrentHP := Rrole[rnum].CurrentHP - ((Rmagic[mnum].NeedMP * level) * Rrole[rnum].Hurt) div 100;

          if Rrole[rnum].CurrentHP < 0 then Rrole[rnum].CurrentHP := 0;
          if Rrole[rnum].CurrentMP < 0 then Rrole[rnum].CurrentMP := 0;
        end
        else AttackAction(bnum, mnum, level);
        Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] -
          4 - (400 - GetRoleAttack(Brole[bnum].rnum, True)) *
          (round(power((Brole[i].zhuangtai[6] - Brole[i].lzhuangtai[6]), 1.65)) + 30) div 5000);
        for i2 := 0 to Brole[bnum].Zhuanzhu - 1 do
        begin
          Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i2 + 2));
          Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] -
            round((i2 + 2) / 3 * 10));
          Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] -
            round((i2 + 2) / 3 * 10));
          Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] -
            round((i2 + 2) / 3 * 10));
          Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] -
            round((i2 + 2) / 3 * 5));
        end;

        Brole[bnum].Zhuanzhu := 0;
        l1 := Rrole[rnum].MagLevel[i] div 100 + 1;
        if (isattack) then
        begin
          magicexp(bnum, mnum, l1, i);
        end;
        ClearDeadRolePic;
      end;
    end;
    if r1 > 0 then
    begin

      for i1 := 1 to r1 do
      begin
        if Rmagic[mnum].NeedMP > Rrole[rnum].CurrentMP then break;
        BShowBWord.sign := BShowBWord.sign or 1;
        BShowBWord.words[0] := '弱點攻擊';
        BShowBWord.delay[0] := 20;
        if Rmagic[mnum].EventNum > 0 then
        begin
          if Rmagic[mnum].EventNum > 0 then CallEvent(Rmagic[mnum].EventNum);
          if Rmagic[mnum].NeedMP * level > Rrole[rnum].CurrentMP then
          begin
            level := Rrole[rnum].CurrentMP div Rmagic[mnum].NeedMP;
          end;
          Rrole[rnum].CurrentMP := Rrole[rnum].CurrentMP - Rmagic[mnum].NeedMP * level;
          Rrole[rnum].CurrentHP := Rrole[rnum].CurrentHP - ((Rmagic[mnum].NeedMP * level) * Rrole[rnum].Hurt) div 100;

          if Rrole[rnum].CurrentHP < 0 then Rrole[rnum].CurrentHP := 0;
          if Rrole[rnum].CurrentMP < 0 then Rrole[rnum].CurrentMP := 0;
        end
        else AttackAction(bnum, mnum, level);

        l1 := Rrole[rnum].MagLevel[i] div 100;


        if (isattack) then
        begin

          magicexp(bnum, mnum, l1, i);

        end;
        ClearDeadRolePic;
      end;
    end;
    Brole[bnum].Progress := Brole[bnum].Progress - 300;
    Brole[bnum].zhuangtai[0] := min(100, Brole[bnum].zhuangtai[0] + 1 + Rrole[Brole[bnum].rnum].CurrentMP *
      (50 + Brole[bnum].zhuangtai[0]) div 100000);
    Brole[bnum].zhuangtai[1] := min(100, Brole[bnum].zhuangtai[1] + 1 + GetRoleDefence(Brole[bnum].rnum, True) *
      (50 + Brole[bnum].zhuangtai[1]) div 10000);
    Brole[bnum].zhuangtai[2] := min(100, Brole[bnum].zhuangtai[2] + 1 + GetRoleSpeed(Brole[bnum].rnum, True) *
      (50 + Brole[bnum].zhuangtai[2]) div 10000);
    Brole[bnum].zhuangtai[3] := min(100, Brole[bnum].zhuangtai[3] + 1 + Rrole[Brole[bnum].rnum].CurrentHP *
      (50 + Brole[bnum].zhuangtai[3]) div 100000);
    Brole[bnum].zhuangtai[4] := min(100, Brole[bnum].zhuangtai[4] + 1 + GetRoleAttack(Brole[bnum].rnum, True) *
      (50 + Brole[bnum].zhuangtai[4]) div 10000);
    for i1 := 0 to Brole[bnum].Zhuanzhu - 1 do
    begin
      Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i1 + 2));
      Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] - round((i1 + 2) / 3 * 10));
      Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] - round((i1 + 2) / 3 * 10));
      Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] - round((i1 + 2) / 3 * 10));
      Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] - round((i1 + 2) / 3 * 5));
    end;
    Brole[bnum].Zhuanzhu := 0;
  end
  else if (Brole[bnum].Acted = 1) and (Rmagic[mnum].MagicType = 7) then
  begin
    hubo:=0;
    if GetGongtiState(rnum,14) then
    begin
      if (100 - getroleaptitude(rnum,1)) > random(100) then
      begin
        hubo:=1;
      end;
    end;
    for i1 := 0 to (Rrole[rnum].Atttwice + hubo) do
    begin
      if Rmagic[mnum].NeedMP > Rrole[rnum].CurrentMP then break;
      if (i1 > 0) and (random(101) > Brole[bnum].zhuangtai[4]) then break;
      if i1 = 1 then
      begin
        BShowBWord.sign := BShowBWord.sign or 1;
        BShowBWord.words[0] := '左右互搏';
        BShowBWord.delay[0] := 30;
      end;
      if Rmagic[mnum].EventNum > 0 then
      begin
        if Rmagic[mnum].EventNum > 0 then CallEvent(Rmagic[mnum].EventNum);
        if Rmagic[mnum].NeedMP * level > Rrole[rnum].CurrentMP then
        begin
          level := Rrole[rnum].CurrentMP div Rmagic[mnum].NeedMP;
        end;
        Rrole[rnum].CurrentMP := Rrole[rnum].CurrentMP - Rmagic[mnum].NeedMP * level;
        Rrole[rnum].CurrentHP := Rrole[rnum].CurrentHP - ((Rmagic[mnum].NeedMP * level) * Rrole[rnum].Hurt) div 100;

        if Rrole[rnum].CurrentHP < 0 then Rrole[rnum].CurrentHP := 0;
        if Rrole[rnum].CurrentMP < 0 then Rrole[rnum].CurrentMP := 0;
      end
      else MedcineAction(bnum, mnum, level);

      l1 := Rrole[rnum].MagLevel[i] div 100 + 1;

      if (isattack) then
      begin
        magicexp(bnum, mnum, l1, i);
      end;
      ClearDeadRolePic;
    end;
    Brole[bnum].Progress := Brole[bnum].Progress - 300;
    Brole[bnum].zhuangtai[0] := min(100, Brole[bnum].zhuangtai[0] + 1 + Rrole[Brole[bnum].rnum].CurrentMP *
      (50 + Brole[bnum].zhuangtai[0]) div 100000);
    Brole[bnum].zhuangtai[1] := min(100, Brole[bnum].zhuangtai[1] + 1 + GetRoleDefence(Brole[bnum].rnum, True) *
      (50 + Brole[bnum].zhuangtai[1]) div 10000);
    Brole[bnum].zhuangtai[2] := min(100, Brole[bnum].zhuangtai[2] + 1 + GetRoleSpeed(Brole[bnum].rnum, True) *
      (50 + Brole[bnum].zhuangtai[2]) div 10000);
    Brole[bnum].zhuangtai[3] := min(100, Brole[bnum].zhuangtai[3] + 1 + Rrole[Brole[bnum].rnum].CurrentHP *
      (50 + Brole[bnum].zhuangtai[3]) div 100000);
    Brole[bnum].zhuangtai[4] := min(100, Brole[bnum].zhuangtai[4] + 1 + GetRoleAttack(Brole[bnum].rnum, True) *
      (50 + Brole[bnum].zhuangtai[4]) div 10000);
    for i1 := 0 to Brole[bnum].Zhuanzhu - 1 do
    begin
      Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i1 + 2));
      Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] - round((i1 + 2) / 3 * 10));
      Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] - round((i1 + 2) / 3 * 10));
      Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] - round((i1 + 2) / 3 * 10));
      Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] - round((i1 + 2) / 3 * 5));
    end;
    Brole[bnum].Zhuanzhu := 0;
  end;

end;

//攻击效果

procedure AttackAction(bnum, mnum, level: integer);
var
  needprogress, step, range, AttAreaType, twice, t1, ax1, ay1, i, k, rnum, Aptitude, wpn,pzadd: integer;
  add: array[0..13] of integer;
begin
  //if (Brole[bnum].Team = 0) and (Brole[bnum].Auto = -1) then ShowMagicName(mnum);


  if (Brole[bnum].Team <> 0) then
  begin
    //依据攻击范围进一步选择
    step := Rmagic[mnum].MoveDistance[level - 1];
    if CheckEquipSet(Rrole[Brole[bnum].rnum].equip[0], Rrole[Brole[bnum].rnum].equip[1],
      Rrole[Brole[bnum].rnum].equip[2], Rrole[Brole[bnum].rnum].equip[3]) = 1 then
      Inc(step, 1);
    if GetEquipState(Brole[bnum].rnum, 22) or GetGongtiState(Brole[bnum].rnum, 22) then //增加攻击距离
      Inc(step, 1);
    range := Rmagic[mnum].AttDistance[level - 1];
    AttAreaType := Rmagic[mnum].AttAreaType;
    CalCanSelect(bnum, 1, step);
    DrawBFieldWithCursor(AttAreaType, step, range,0);
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    {t1 := SDL_GetTicks;
    while SDL_GetTicks < t1 + 1000 do
    begin
    end;}
  end;
  if (Rrole[Brole[bnum].rnum].Angry = 100) then
  begin
    if random(2) = 0 then
    begin
      BShowBWord.sign := BShowBWord.sign or (1 shl 4);
      BShowBWord.starttime[4] := SDL_GetTicks;
      BShowBWord.rnum[4] := Brole[bnum].rnum;
      BShowBWord.col1[4] := 204;
      BShowBWord.col1[4] := 205;
      BShowBWord.x[4] := Brole[bnum].x;
      BShowBWord.y[4] := Brole[bnum].y;
      BShowBWord.delay[4] := 30000;
      if Rrole[Brole[bnum].rnum].Sexual = 2 then
        BShowBWord.words[4] := allbtalk.etalk[0][random(5)]
      else
        BShowBWord.words[4] := allbtalk.talk[Rrole[Brole[bnum].rnum].Sexual][0]
          [Rrole[Brole[bnum].rnum].xiangxing][random(5)];
      BShowBWord.Sx[4] := sign(1 - random(4)) * (random(100) / 42 + 0.2);
      BShowBWord.Sy[4] := random(100) / 67;
    end;
    PlayNuAmination(bnum); //憤怒效果
    Brole[bnum].zhuangtai[5] := min(100, Brole[bnum].zhuangtai[5] + 40);
    Brole[bnum].zhuangtai[6] := min(100, Brole[bnum].zhuangtai[6] + 40);
    Brole[bnum].zhuangtai[10] := min(100, Brole[bnum].zhuangtai[10] + 40);

    Brole[bnum].zhuangtai[13] := min(100, Brole[bnum].zhuangtai[13] + 40);
    Brole[bnum].zhuangtai[2] := max(Brole[bnum].lzhuangtai[2], Brole[bnum].zhuangtai[2] - 5 -
      (Brole[bnum].zhuangtai[2] - Brole[bnum].lzhuangtai[2]) div 15);
    Brole[bnum].zhuangtai[4] := max(Brole[bnum].lzhuangtai[4], Brole[bnum].zhuangtai[4] - 5 -
      (Brole[bnum].zhuangtai[4] - Brole[bnum].lzhuangtai[4]) div 15);
    Rrole[Brole[bnum].rnum].Angry := 0;
  end;


  for i := 0 to 13 do
    add[i] := 0;
  k := 0;
  for i := 0 to 23 do
  begin
    if Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x < 0 then break;
    if (Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x >= 10) and (Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x <= 18) then
    begin
      add[Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x - 5] :=
        Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].y * (level - 1) div 9;
      Inc(k);
    end
    else if (Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x >= 50) and
      (Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x <= 54) then
    begin
      add[Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x - 50] :=
        -Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].y * (level - 1) div 9;
      Inc(k);
    end
    else if (Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x >= 30) and
      (Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x <= 34) then
    begin
      add[Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x - 30] :=
        Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].y * (level - 1) div 9;
      Inc(k);
    end;

  end;
  if k > 0 then
  begin
    for i := 0 to 9 do
    begin
      Brole[bnum].zhuangtai[i] := max(Brole[bnum].lzhuangtai[i], min(Brole[bnum].zhuangtai[i] + add[i], 100));
    end;
    for i := 10 to 13 do
    begin
      Brole[bnum].zhuangtai[i] := max(0, min(Brole[bnum].zhuangtai[i] + add[i], 100));
    end;
  end;
  showzhaoshi(bnum, Brole[bnum].szhaoshi, 1); //显示招式名
  rnum := Brole[bnum].rnum;
  if CheckEquipSet(Rrole[rnum].equip[0], Rrole[rnum].equip[1], Rrole[rnum].equip[2], Rrole[rnum].equip[3]) = 2 then
    Aptitude := 100
  else Aptitude := Rrole[rnum].Aptitude;
  case Rmagic[mnum].MagicType of
    1: begin wpn := Rrole[Brole[bnum].rnum].Fist; end;
    2: begin wpn := Rrole[Brole[bnum].rnum].Sword; end;
    3: begin wpn := Rrole[Brole[bnum].rnum].Knife; end;
    4: begin wpn := Rrole[Brole[bnum].rnum].Unusual; end;
  end;
  pzadd:=0;
  if (Rrole[rnum].MPType = 1) then
    pzadd:=200;
  if random(2000 - pzadd) < ((100 + Aptitude) * (100 + Brole[bnum].zhuangtai[7]) * Brole[bnum].zhuangtai[4] * wpn) div
    1000000 then
  begin
    Brole[bnum].pozhao := 1;
    BShowBWord.sign := BShowBWord.sign or (1 shl 2);
    BShowBWord.delay[2] := 10;
    BShowBWord.words[2] := '破招';

  end;
  //  PlayMagicAmination2(bnum, Rmagic[mnum].bigami, Rmagic[mnum].AmiNum, level);  //以后用于内功加力
  playsoundE(Rmagic[mnum].SoundNum, 0);
  PlayActionAmination(bnum, Rmagic[mnum].MagicType); //动画效果
  PlayMagicAmination(bnum, Rmagic[mnum].bigami, Rmagic[mnum].AmiNum, level); //武功效果
  CalHurtRole(bnum, mnum, level); //计算被打到的人物
  Brole[bnum].pozhao := 0;
end;

//攻击式医疗
procedure MedcineAction(bnum, mnum, level: integer);
var
  needprogress, step, range, AttAreaType, twice, t1, ax1, ay1, i, k, rnum, Aptitude, wpn: integer;
  add: array[0..13] of integer;
begin
  if (Brole[bnum].Team <> 0) then
  begin
    //依据攻击范围进一步选择
    step := Rmagic[mnum].MoveDistance[level - 1];
    if CheckEquipSet(Rrole[Brole[bnum].rnum].equip[0], Rrole[Brole[bnum].rnum].equip[1],
      Rrole[Brole[bnum].rnum].equip[2], Rrole[Brole[bnum].rnum].equip[3]) = 1 then
      Inc(step, 1);
    if GetEquipState(Brole[bnum].rnum, 22) or GetGongtiState(Brole[bnum].rnum, 22) then //增加攻击距离
      Inc(step, 1);
    range := Rmagic[mnum].AttDistance[level - 1];
    AttAreaType := Rmagic[mnum].AttAreaType;
    CalCanSelect(bnum, 1, step);
    DrawBFieldWithCursor(AttAreaType, step, range,1);
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  end;
  for i := 0 to 13 do
    add[i] := 0;
  k := 0;
  for i := 0 to 23 do
  begin
    if Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x < 0 then break;
    if (Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x >= 10) and (Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x <= 18) then
    begin
      add[Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x - 5] :=
        Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].y * (level - 1) div 9;
      Inc(k);
    end
    else if (Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x >= 50) and
      (Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x <= 54) then
    begin
      add[Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x - 50] :=
        -Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].y * (level - 1) div 9;
      Inc(k);
    end
    else if (Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x >= 30) and
      (Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x <= 34) then
    begin
      add[Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x - 30] :=
        Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].y * (level - 1) div 9;
      Inc(k);
    end;

  end;
  if k > 0 then
  begin
    for i := 0 to 9 do
    begin
      Brole[bnum].zhuangtai[i] := max(Brole[bnum].lzhuangtai[i], min(Brole[bnum].zhuangtai[i] + add[i], 100));
    end;
    for i := 10 to 13 do
    begin
      Brole[bnum].zhuangtai[i] := max(0, min(Brole[bnum].zhuangtai[i] + add[i], 100));
    end;
  end;
  showzhaoshi(bnum, Brole[bnum].szhaoshi, 1); //显示招式名
  rnum := Brole[bnum].rnum;
  if CheckEquipSet(Rrole[rnum].equip[0], Rrole[rnum].equip[1], Rrole[rnum].equip[2], Rrole[rnum].equip[3]) = 2 then
    Aptitude := 100
  else Aptitude := Rrole[rnum].Aptitude;
  case Rmagic[mnum].MagicType of
    1: begin wpn := Rrole[Brole[bnum].rnum].Fist; end;
    2: begin wpn := Rrole[Brole[bnum].rnum].Sword; end;
    3: begin wpn := Rrole[Brole[bnum].rnum].Knife; end;
    4: begin wpn := Rrole[Brole[bnum].rnum].Unusual; end;
    7: begin wpn := Rrole[Brole[bnum].rnum].Medcine; end;
  end;
  ShowHurtValue(3);
  playsoundE(Rmagic[mnum].SoundNum, 0);
  PlayActionAmination(bnum, Rmagic[mnum].MagicType); //动画效果
  PlayMagicAmination(bnum, Rmagic[mnum].bigami, Rmagic[mnum].AmiNum, level); //武功效果
  CalMedRole(bnum, mnum, level); //计算被打到的人物
end;
procedure ShowMagicName(mnum: integer);
var
  l: integer;
  str: WideString;
begin
  Redraw;
  str := gbktounicode(@Rmagic[mnum].Name);
  str := MidStr(str, 1, 6);
  l := length(str);
  DrawTextWithRect(@str[1], CENTER_X - l * 10, CENTER_Y - 150, l * 20 + 10, ColColor($14), ColColor($16));
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  SDL_Delay((10 + GameSpeed) * 50);
end;

//选择武功

function SelectMagic(bnum: integer): integer;
var
  i, j, k, rst, rst2, m1, m2, tm, p, lv, MenuStatus, menustatus2, tmnum, rnum, max0, max2, menu, menup, menua: integer;
  str1: string;
begin
  Bzhaoshi := -1;
  MenuStatus := 0;

  max0 := 0;
  tmnum := 0;
  setlength(menuString, 0);
  setlength(menuEngString, 0);
  SDL_EnableKeyRepeat(10, 100);
  Result := 0;
  rnum := Brole[bnum].rnum;

  for i := 0 to 9 do
  begin
    if Rrole[rnum].jhMagic[i] < 0 then break;
    if Rrole[rnum].jhMagic[i] > -1 then
    begin
      tmnum := Rrole[rnum].lmagic[Rrole[rnum].jhMagic[i]];
      if (tmnum >= 0) then
      begin
        if (Rmagic[tmnum].MagicType <> 5) then
        begin

          if (Rmagic[tmnum].NeedMP <= Rrole[rnum].CurrentMP) then
          begin
            lv := Rrole[Brole[bnum].rnum].MagLevel[Rrole[rnum].jhmagic[i]] div 100;
            setlength(menuString, max0 + 1);
            setlength(menuEngString, max0 + 1);
            MenuStatus := MenuStatus or (1 shl i);
            menuString[max0] := '';
            menuEngString[max0] := '';
            menuString[max0] := gbktoUnicode(@Rmagic[Rrole[Brole[bnum].rnum].lMagic[Rrole[rnum].jhmagic[i]]].Name[0]);
            menuEngString[max0] := format('%3d', [Rrole[Brole[bnum].rnum].MagLevel[Rrole[rnum].jhmagic[i]] div
              100 + 1]);
            max0 := max0 + 1;

          end;
        end
        else
        begin
          setlength(menuString, max0 + 1);
          setlength(menuEngString, max0 + 1);
          MenuStatus := MenuStatus or (1 shl i);
          menuString[max0] := '';
          menuEngString[max0] := '';
          menuString[max0] := gbktoUnicode(@Rmagic[Rrole[Brole[bnum].rnum].lMagic[Rrole[rnum].jhmagic[i]]].Name[0]);
          menuEngString[max0] := format('%3d', [Rrole[Brole[bnum].rnum].MagLevel[Rrole[rnum].jhmagic[i]] div 100 + 1]);
          max0 := max0 + 1;
        end;
      end;
    end;
  end;
  max0 := max0 - 1;

  Redraw;
  // SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  menu := 0;
  rst := 0;
  rst2 := 0;
  ShowMagicMenu(bnum, MenuStatus, menustatus2, menu, max0, max2, rst, rst2);
  //SDL_UpdateRect2(screen,0,0,screen.w,screen.h);
  while (SDL_PollEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin

          if menu <= 19 then
          begin
            menustatus2 := 0;
            rst := menu;
            if rst >= 0 then
            begin
              p := 0;
              for j := 0 to 9 do
              begin
                if (MenuStatus and (1 shl j)) > 0 then
                begin
                  p := p + 1;
                  if p > menu then break;
                end;
              end;
              rst := j;
            end;

            menu := menu * 10 + 20;
            max2 := 0;
            rst2 := 0;
            for j := 0 to 4 do
            begin
              tm := Rmagic[Rrole[rnum].lmagic[Rrole[rnum].jhmagic[rst]]].zhaoshi[j];
              if ((tm > 0) and ((Rrole[rnum].lzhaoshi[Rrole[rnum].jhmagic[rst]] and (1 shl j)) > 0) and
                (Rzhaoshi[tm].ygongji = 1)) then
              begin
                setlength(menustring2, max2 + 1);
                menustatus2 := menustatus2 or (1 shl j);
                menustring2[max2] := '';
                menustring2[max2] := gbktoUnicode(@Rzhaoshi[tm].Name[0]);
                max2 := max2 + 1;
              end;
            end;
            max2 := max2 - 1;
            ShowMagicMenu(bnum, MenuStatus, menustatus2, menu, max0, max2, rst, rst2);
          end
          else
          begin
            m2 := menu mod 10;
            rst2 := m2;
            if rst2 >= 0 then
            begin
              p := 0;
              for j := 0 to 4 do
              begin
                if (menustatus2 and (1 shl j)) > 0 then
                begin
                  p := p + 1;
                  if p > m2 then break;
                end;
              end;
              if j <= 4 then
                rst2 := j
              else
                rst2 := 0; //防止5个招式都没有匹配而赋值出界
            end;
            break;
          end;
        end;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          if menu < 19 then
          begin
            menu := -1;
            break;
          end
          else
          begin
            menu := trunc((menu - 20) div 10);
            max2 := 0;
            menustatus2 := 0;
            ShowMagicMenu(bnum, MenuStatus, menustatus2, menu, max0, max2, rst, rst2);
          end;
        end;
      end;
      SDL_KEYDOWN:
      begin
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          menu := menu - 1;
          if menu < 0 then menu := max0
          else if ((menu > 18) and ((menu mod 10) > max2)) then menu := menu + 1 + max2;
          if menu > 19 then
          begin
            m2 := menu mod 10;
            rst2 := m2;
            if rst2 >= 0 then
            begin
              p := 0;
              for j := 0 to 4 do
              begin
                if (menustatus2 and (1 shl j)) > 0 then
                begin
                  p := p + 1;
                  if p > m2 then break;
                end;
              end;
              if j <= 4 then
                rst2 := j
              else
                rst2 := 0; //防止5个招式都没有匹配而赋值出界
            end;
          end;
          ShowMagicMenu(bnum, MenuStatus, menustatus2, menu, max0, max2, rst, rst2);
        end;
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          menu := menu + 1;
          if ((menu > max0) and (menu <= 20)) then menu := 0
          else if ((menu > 20) and ((menu mod 10) > max2)) then menu := 10 * (trunc(menu div 10));
          if menu > 19 then
          begin
            m2 := menu mod 10;
            rst2 := m2;
            if rst2 >= 0 then
            begin
              p := 0;
              for j := 0 to 4 do
              begin
                if (menustatus2 and (1 shl j)) > 0 then
                begin
                  p := p + 1;
                  if p > m2 then break;
                end;
              end;
              if j <= 4 then
                rst2 := j
              else
                rst2 := 0; //防止5个招式都没有匹配而赋值出界
            end;
          end;
          ShowMagicMenu(bnum, MenuStatus, menustatus2, menu, max0, max2, rst, rst2);
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          if menu < 19 then
          begin
            menustatus2 := 0;
            rst := menu;
            if rst >= 0 then
            begin
              p := 0;
              for j := 0 to 9 do
              begin
                if (MenuStatus and (1 shl j)) > 0 then
                begin
                  p := p + 1;
                  if p > menu then break;
                end;
              end;
              rst := j;
            end;

            menu := menu * 10 + 20;
            max2 := 0;
            for j := 0 to 4 do
            begin
              tm := Rmagic[Rrole[rnum].lmagic[Rrole[rnum].jhmagic[rst]]].zhaoshi[j];
              if ((tm > 0) and ((Rrole[rnum].lzhaoshi[Rrole[rnum].jhmagic[rst]] and (1 shl j)) > 0) and
                (Rzhaoshi[tm].ygongji = 1)) then
              begin
                setlength(menustring2, max2 + 1);
                menustatus2 := menustatus2 or (1 shl j);
                menustring2[max2] := '';
                menustring2[max2] := gbktoUnicode(@Rzhaoshi[tm].Name[0]);
                max2 := max2 + 1;
              end;
            end;
            max2 := max2 - 1;
            ShowMagicMenu(bnum, MenuStatus, menustatus2, menu, max0, max2, rst, rst2);
          end
          else
          begin
            m2 := menu mod 10;
            rst2 := m2;
            if rst2 >= 0 then
            begin
              p := 0;
              for j := 0 to 4 do
              begin
                if (menustatus2 and (1 shl j)) > 0 then
                begin
                  p := p + 1;
                  if p > m2 then break;
                end;
              end;
              if j <= 4 then
                rst2 := j
              else
                rst2 := 0; //防止5个招式都没有匹配而赋值出界
            end;
            break;
          end;

        end;
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          if menu < 19 then
          begin
            menu := -1;
            break;
          end
          else
          begin
            menu := trunc((menu - 20) div 10);
            max2 := 0;
            menustatus2 := 0;
            ShowMagicMenu(bnum, MenuStatus, menustatus2, menu, max0, max2, rst, rst2);
          end;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if menu <= 19 then
        begin
          if (event.button.x >= 100) and (event.button.x < 267) and (event.button.y >= 50) and
            (event.button.y < max0 * 22 + 78) then
          begin
            menup := menu;
            menu := (event.button.y - 52) div 22;
            if menu > max0 then menu := max0;
            if menu < 0 then menu := 0;
            if menup <> menu then ShowMagicMenu(bnum, MenuStatus, menustatus2, menu, max0, max2, rst, rst2);
          end;
        end
        else if menu > 19 then
        begin
          if (event.button.x >= 270) and (event.button.x < 437) and (event.button.y >= 50) and
            (event.button.y < max2 * 22 + 78) then
          begin
            menup := menu;
            menua := (event.button.y - 52) div 22;
            if (menua < 0) then menua := 0;
            if (menua > max2) then menua := max2;
            menu := trunc(menup div 10) * 10 + menua;
            if menu > 19 then
            begin
              m2 := menu mod 10;
              rst2 := m2;
              if rst2 >= 0 then
              begin
                p := 0;
                for j := 0 to 4 do
                begin
                  if (menustatus2 and (1 shl j)) > 0 then
                  begin
                    p := p + 1;
                    if p > m2 then break;
                  end;
                end;
                if j <= 4 then
                  rst2 := j
                else
                  rst2 := 0; //防止5个招式都没有匹配而赋值出界
              end;
            end;

            if menup <> menu then ShowMagicMenu(bnum, MenuStatus, menustatus2, menu, max0, max2, rst, rst2);
          end;
        end;

      end;
    end;
    SDL_Delay(5 + GameSpeed div 3);
    event.key.keysym.sym := 0;
    event.button.button := 0;
  end;
  event.key.keysym.sym := 0;
  event.button.button := 0;
  Result := menu;
  if Result >= 0 then
  begin
    Result := rst;
    Brole[bnum].szhaoshi := Rmagic[Rrole[rnum].lmagic[Rrole[rnum].jhmagic[Result]]].zhaoshi[rst2];
  end;
  SDL_EnableKeyRepeat(100, 30);

end;

//显示武功选单

procedure ShowMagicMenu(bnum, MenuStatus, menustatus2, menu, max0, max2, jhmnum, znum: integer);
var
  i, i1, j, k, n, p, m1, m2, rnum, mnum: integer;
  words: array[0..5] of WideString;
  strs: array[0..68] of WideString;
  str: WideString;
begin
  Redraw;
  DrawRectangle(100, 50, 167, max0 * 22 + 28, 0, ColColor(255), 30);
  p := 0;
  k := 0;
  rnum := Brole[bnum].rnum;
  mnum := Rrole[rnum].LMagic[Rrole[rnum].jhmagic[jhmnum]];
  words[0] := '超';
  words[1] := '強';
  words[2] := '中';
  words[3] := '弱';
  words[4] := '微';
  words[5] := '....';
  strs[0] := '削气';
  strs[1] := '削硬';
  strs[2] := '削靈';
  strs[3] := '削行';
  strs[4] := '削身';
  strs[10] := '奮發';
  strs[11] := '戰意';
  strs[12] := '精准';
  strs[13] := '急速';
  strs[14] := '躲閃';
  strs[15] := '憤力';
  strs[16] := '免疫';
  strs[17] := '儲力';
  strs[18] := '機敏';
  strs[20] := '禦气';
  strs[21] := '禦硬';
  strs[22] := '禦靈';
  strs[23] := '禦行';
  strs[24] := '禦身';
  strs[25] := ' ';
  strs[30] := '加气';
  strs[31] := '加硬';
  strs[32] := '加靈';
  strs[33] := '加行';
  strs[34] := '加身';
  strs[40] := '回气';
  strs[41] := '回硬';
  strs[42] := '回靈';
  strs[43] := '回行';
  strs[44] := '回身';
  strs[45] := '回命';
  strs[46] := '回內';
  strs[50] := '耗气';
  strs[51] := '耗硬';
  strs[52] := '耗靈';
  strs[53] := '耗行';
  strs[54] := '耗身';
  strs[60] := '抬气';
  strs[61] := '抬硬';
  strs[62] := '抬靈';
  strs[63] := '抬行';
  strs[64] := '抬身';
  strs[65] := '抬奮';
  strs[66] := '抬戰';
  strs[67] := '抬精';
  strs[68] := '抬急';

  if ((menu > 19) and (max2 >= 0)) then
  begin
    m1 := trunc((menu - 20) div 10);
    m2 := menu mod 10;
    DrawRectangle(270, 50, 167, max2 * 22 + 28, 0, ColColor(255), 30);

    for j := 0 to max0 do
    begin

      if (k <> m1) and ((MenuStatus and (1 shl j) > 0)) then
      begin
        if (Rmagic[Rrole[Brole[bnum].rnum].lMagic[Rrole[rnum].jhmagic[j]]].MagicType = 5) then
          DrawShadowText(@menuString[j][1], 83, 53 + 22 * k, ColColor($5), ColColor($7))
        else
        begin
          DrawShadowText(@menuString[j][1], 83, 53 + 22 * k, ColColor($21), ColColor($23));
          DrawEngShadowText(@menuEngString[j][1], 223, 53 + 22 * k, ColColor($21), ColColor($23));
        end;
        k := k + 1;
      end
      else if (k = m1) and ((MenuStatus and (1 shl j) > 0)) then
      begin
        DrawShadowText(@menuString[j][1], 83, 53 + 22 * k, ColColor($64), ColColor($66));
        if (Rmagic[Rrole[Brole[bnum].rnum].lMagic[Rrole[rnum].jhmagic[j]]].MagicType <> 5) then
          DrawEngShadowText(@menuEngString[j][1], 223, 53 + 22 * k, ColColor($64), ColColor($66));
        k := k + 1;
      end;
    end;

    k := 0;
    for j := 0 to max2 do
    begin
      if (k <> m2) {and ((menustatus2 and (1 shl j) > 0))} then
      begin

        DrawShadowText(@menustring2[j][1], 283, 53 + 22 * k, ColColor($21), ColColor($23));
        k := k + 1;
      end
      else if (k = m2) {and ((menustatus2 and (1 shl j) > 0))} then
      begin
        DrawShadowText(@menustring2[j][1], 283, 53 + 22 * k, ColColor($64), ColColor($66));
        if wujishu[mnum] > 99 then
        begin
          DrawRectangle(440, 52, 197, 68, 0, ColColor(255), 30);
          n := 0;
          for i1 := 0 to 23 do
          begin
            if Rzhaoshi[Rmagic[mnum].zhaoshi[znum]].texiao[i1].x < 0 then break;
            if n < 8 then
            begin
              if (Rzhaoshi[Rmagic[mnum].zhaoshi[znum]].texiao[i1].x < 0) or
                (Rzhaoshi[Rmagic[mnum].zhaoshi[znum]].texiao[i1].x > 69) then
                continue;
              DrawShadowText(@strs[Rzhaoshi[Rmagic[mnum].zhaoshi[znum]].texiao[i1].x][1],
                288 + 142 + 65 * (i1 mod 3), 53 + 22 * (i1 div 3), ColColor(5), ColColor(7));
              if Rzhaoshi[Rmagic[mnum].zhaoshi[znum]].texiao[i1].y <= 10 then str := words[4]
              else if Rzhaoshi[Rmagic[mnum].zhaoshi[znum]].texiao[i1].y <= 20 then str := words[3]
              else if Rzhaoshi[Rmagic[mnum].zhaoshi[znum]].texiao[i1].y <= 30 then str := words[2]
              else if Rzhaoshi[Rmagic[mnum].zhaoshi[znum]].texiao[i1].y <= 40 then str := words[1]
              else str := words[0];
              DrawShadowText(@str[1], 288 + 180 + 65 * (i1 mod 3), 53 + 22 * (i1 div 3),
                ColColor(0, $30), ColColor(0, $32));
              Inc(n);
            end
            else
            begin
              DrawShadowText(@words[4][1], 288 + 142 + 65 * (i1 mod 3), 53 + 22 * (i1 div 3),
                ColColor(5), ColColor(7));
              break;
            end;
          end;
        end;
        k := k + 1;
      end;
    end;
  end
  else if ((menu > 19) and (max2 < 0)) then menu := trunc((menu - 20) div 10)
  else
  begin
    for i := 0 to 9 do
    begin
      if (p <> menu) and ((MenuStatus and (1 shl i) > 0)) then
      begin
        if (Rmagic[Rrole[Brole[bnum].rnum].lMagic[Rrole[rnum].jhmagic[i]]].MagicType = 5) then
          DrawShadowText(@menuString[i][1], 83, 53 + 22 * p, ColColor($5), ColColor($7))
        else
        begin
          DrawShadowText(@menuString[i][1], 83, 53 + 22 * p, ColColor($21), ColColor($23));
          DrawEngShadowText(@menuEngString[i][1], 223, 53 + 22 * p, ColColor($21), ColColor($23));
        end;
        p := p + 1;
      end
      else if (p = menu) and ((MenuStatus and (1 shl i) > 0)) then
      begin
        DrawShadowText(@menuString[i][1], 83, 53 + 22 * p, ColColor($64), ColColor($66));
        if (Rmagic[Rrole[Brole[bnum].rnum].lMagic[Rrole[rnum].jhmagic[i]]].MagicType <> 5) then
          DrawEngShadowText(@menuEngString[i][1], 223, 53 + 22 * p, ColColor($64), ColColor($66));
        p := p + 1;
      end;
    end;
  end;
  SDL_UpdateRect2(screen, 100, 50, screen.w - 100, 10 * 22 + 29);

end;

//设定攻击范围

procedure SetAminationPosition(mode, step, range: integer);
var
  i, i1, i2: integer;
begin
  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
    begin
      Bfield[4, i1, i2] := 0;
      //按攻击类型判断是否在范围内
      case mode of
        0, 6: //目标系点型、目标系十型、目标系菱型、原地系菱型、远程
        begin
          if (abs(i1 - Ax) + abs(i2 - Ay)) <= range then Bfield[4, i1, i2] := 1;
        end;
        3: //目标系方型、原地系方型
        begin
          if (abs(i1 - Ax) <= range) and (abs(i2 - Ay) <= range) then Bfield[4, i1, i2] := 1;
        end;
        1: //方向系线型
        begin
          if ((i1 = Bx) or (i2 = By)) and (sign(Ax - Bx) = sign(i1 - Bx)) and (abs(i1 - Bx) <= step) and
            (sign(Ay - By) = sign(i2 - By)) and (abs(i2 - By) <= step) then
            Bfield[4, i1, i2] := 1;
        end;
        2: //原地系十型、原地系叉型、原地系米型
        begin
          if (abs(i1 - Bx) = abs(i2 - By)) and (abs(i1 - Bx) <= range) or
            ((i1 = Bx) and (abs(i2 - By) <= step)) or ((i2 = By) and (abs(i1 - Bx) <= step)) then
            Bfield[4, i1, i2] := 1;
          if ((i1 = Bx) and (i2 = By)) then Bfield[4, i1, i2] := 1;
          Ax := Bx;
          Ay := By;
        end;
        4: //方向系菱型
        begin
          if ((abs(i1 - Bx) + abs(i2 - By) <= step) and (abs(i1 - Bx) <> abs(i2 - By))) and
            ((((i1 - Bx) * (Ax - Bx) > 0) and (abs(i1 - Bx) > abs(i2 - By))) or
            (((i2 - By) * (Ay - By) > 0) and (abs(i1 - Bx) < abs(i2 - By)))) then Bfield[4, i1, i2] := 1;
        end;
        5: //方向系角型
        begin
          if ((abs(i1 - Bx) <= step) and (abs(i2 - By) <= step) and (abs(i1 - Bx) <> abs(i2 - By))) and
            ((((i1 - Bx) * (Ax - Bx) > 0) and (abs(i1 - Bx) > abs(i2 - By))) or
            (((i2 - By) * (Ay - By) > 0) and (abs(i1 - Bx) < abs(i2 - By)))) then Bfield[4, i1, i2] := 1;
        end;

        7: //无定向直线
        begin
          if not ((i1 = Bx) and (i2 = By)) and (abs(i1 - Bx) + abs(i2 - By) <= step) then
          begin
            if ((abs(i1 - Bx) <= abs(Ax - Bx)) and (abs(i2 - By) <= abs(Ay - By))) then
            begin
              if (abs(Ax - Bx) > abs(Ay - By)) and (((i1 - Bx) / (Ax - Bx)) > 0) and
                (i2 = round(((i1 - Bx) * (Ay - By)) / (Ax - Bx)) + By) then
              begin
                Bfield[4, i1, i2] := 1;
              end
              else if (abs(Ax - Bx) <= abs(Ay - By)) and (((i2 - By) / (Ay - By)) > 0) and
                (i1 = round(((i2 - By) * (Ax - Bx)) / (Ay - By)) + Bx) then
              begin
                Bfield[4, i1, i2] := 1;
              end;
            end;
          end;
        end;
      end;
    end;

end;

//显示武功效果

procedure PlayMagicAmination(bnum, bigami, enum, level: integer);
var
  i, grp, Count, len: integer;
  filename, fn: string;
  dest, dest1: TSDL_Rect;
begin
  //含音效

  filename := format('%3d', [enum]);

  for i := 1 to length(filename) do
    if filename[i] = ' ' then filename[i] := '0';
  //fn := 'eft\eft'+ filename + '.pic';

  if (FileExists('eft\eft' + filename + '.pic')) then
  begin
    grp := FileOpen('eft\eft' + filename + '.pic', fmopenread);

    dest.x := 0;
    dest.y := 0;
    FileSeek(grp, 0, 0);
    FileRead(grp, Count, 4);
    for i := 0 to Count - 1 do
    begin
      SDL_PollEvent(@event);
      DrawBFieldWithEft(grp, i, bigami, level);
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      SDL_Delay(5 + gamespeed div 2);
    end;
    FileClose(grp);
  end;

end;


//显示憤怒效果

procedure PlayNuAmination(bnum: integer);
var
  i, grp, Count, len: integer;
  filename, fn: string;
  dest, dest1: TSDL_Rect;
begin
  //含音效

  filename := 'eft\nu.pic';

  if (FileExists(filename)) then
  begin
    grp := FileOpen(filename, fmopenread);

    dest.x := 0;
    dest.y := 0;
    FileSeek(grp, 0, 0);
    FileRead(grp, Count, 4);
    for i := 0 to Count - 1 do
    begin
      DrawBFieldWithEft(grp, i, 1, 0);
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      SDL_Delay(5 + gamespeed div 2);
    end;
    FileClose(grp);
  end;

end;

//显示单人武功效果

procedure PlayMagicAmination2(bnum, bigami, enum, level: integer);
var
  i, grp, Count, len, x, y: integer;
  filename, fn: string;
  dest, dest1: TSDL_Rect;
begin
  x := -(Brole[bnum].X - Bx) * 18 + (Brole[bnum].Y - By) * 18 + CENTER_X - 10;
  y := (Brole[bnum].X - Bx) * 9 + (Brole[bnum].Y - By) * 9 + CENTER_Y - 70;
  while ((BShowBWord.sign and (1 shl 1)) > 0) and (BShowBWord.delay[1] > 10) do
  begin
    Dec(BShowBWord.delay[1]);
    DrawShadowText(@BShowBWord.words[1][1], x - 80, y + i * 2, ColColor($23), ColColor($21));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay(5 + gamespeed div 2);
  end;
  x := -(Brole[bnum].X - Bx) * 18 + (Brole[bnum].Y - By) * 18 + CENTER_X - 10;
  y := (Brole[bnum].X - Bx) * 9 + (Brole[bnum].Y - By) * 9 + CENTER_Y - 90;
  while ((BShowBWord.sign and (1 shl 2)) > 0) and (BShowBWord.delay[2] > 10) do
  begin
    Dec(BShowBWord.delay[2]);
    DrawShadowText(@BShowBWord.words[2][1], x - 30, y + i * 2, ColColor(0, $10), ColColor(0, $14));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay(5 + gamespeed div 2);
  end;
  x := -(Brole[bnum].X - Bx) * 18 + (Brole[bnum].Y - By) * 18 + CENTER_X - 10;
  y := (Brole[bnum].X - Bx) * 9 + (Brole[bnum].Y - By) * 9 + CENTER_Y - 90;
  while ((BShowBWord.sign and (1 shl 3)) > 0) and (BShowBWord.delay[3] > 10) do
  begin
    Dec(BShowBWord.delay[3]);
    DrawShadowText(@BShowBWord.words[3][1], x - 30, y + i * 2, ColColor(0, $30), ColColor(0, $32));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay(5 + gamespeed div 2);
  end;



  //含音效

  filename := format('%3d', [enum]);

  for i := 1 to length(filename) do
    if filename[i] = ' ' then filename[i] := '0';
  //fn := 'eft\eft'+ filename + '.pic';

  if (FileExists('eft\eft' + filename + '.pic')) then
  begin
    grp := FileOpen('eft\eft' + filename + '.pic', fmopenread);

    dest.x := 0;
    dest.y := 0;
    FileSeek(grp, 0, 0);
    FileRead(grp, Count, 4);
    for i := 0 to Count - 1 do
    begin
      SDL_PollEvent(@event);
      DrawBFieldWithEft2(grp, i, bigami, Brole[bnum].x, Brole[bnum].y, level);
      if ((BShowBWord.sign and (1 shl 1)) > 0) then
      begin
        x := -(Brole[bnum].X - Bx) * 18 + (Brole[bnum].Y - By) * 18 + CENTER_X - 10;
        y := (Brole[bnum].X - Bx) * 9 + (Brole[bnum].Y - By) * 9 + CENTER_Y - 70;
        if (BShowBWord.delay[1] > 0) then
        begin
          Dec(BShowBWord.delay[1]);
          DrawShadowText(@BShowBWord.words[1][1], x - 80, y + i * 2, ColColor($23), ColColor($21));
        end
        else
          BShowBWord.sign := BShowBWord.sign and $FD;
      end;
      if ((BShowBWord.sign and (1 shl 2)) > 0) then
      begin

        x := -(Brole[bnum].X - Bx) * 18 + (Brole[bnum].Y - By) * 18 + CENTER_X - 10;
        y := (Brole[bnum].X - Bx) * 9 + (Brole[bnum].Y - By) * 9 + CENTER_Y - 90;
        if (BShowBWord.delay[2] > 0) then
        begin
          Dec(BShowBWord.delay[2]);
          DrawShadowText(@BShowBWord.words[2][1], x - 30, y + i * 2, ColColor(0, $10), ColColor(0, $14));
        end
        else
          BShowBWord.sign := BShowBWord.sign and $FB;
      end;
      if ((BShowBWord.sign and (1 shl 3)) > 0) then
      begin
        x := -(Brole[bnum].X - Bx) * 18 + (Brole[bnum].Y - By) * 18 + CENTER_X - 10;
        y := (Brole[bnum].X - Bx) * 9 + (Brole[bnum].Y - By) * 9 + CENTER_Y - 90;
        if (BShowBWord.delay[3] > 0) then
        begin
          Dec(BShowBWord.delay[3]);
          DrawShadowText(@BShowBWord.words[3][1], x - 30, y + i * 2, ColColor(0, $30), ColColor(0, $32));
        end
        else
          BShowBWord.sign := BShowBWord.sign and $F7;
      end;

      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      SDL_Delay(5 + gamespeed div 2);
    end;
    FileClose(grp);
  end;

end;

//判断是否有非行动方角色在攻击范围之内

procedure CalHurtRole(bnum, mnum, level: integer);
var
  i, j1, j2, frozen, rnum, dodge, bang, hurt, addpoi, needmp, n, hurtmp, hurt1, addmpvalue,
  addhpvalue, injury, angry, ztfytmp, fmnum, fmlev, frznum, wpn,wfadd: integer;
begin
  dodge := 0;
  fmnum := -1;
  fmlev := -1;
  frznum := -1;
  MaxFist := 0;
  MaxSword := 0;
  MaxKnife := 0;
  MaxUnusual := 0;
  //战斗状态
  //1 体力不减
  //2 女性武功加成
  //3 饮酒功效加倍
  //4 转移伤害
  //5 反弹伤害
  //6 内伤免疫
  //7 杀伤体力
  //8 闪躲+30%
  //9 攻击力随机增减50%或正常
  //10 内功消耗-20%
  //11 回合回复生命
  //12 负面状态免疫
  //13 全部武功加成
  //14 左右互博
  //15 拳掌加成
  //16 御剑加成
  //17 耍刀加成
  //18 特殊加成
  //19 增加内伤几率
  //20 增加封穴几率
  //21 吸血
  //22 攻击距离+1
  //23 回合回复内力
  //24 暗器距离+1
  //25 吸杀内力
  addhpvalue := 0;
  addmpvalue := 0;
  rnum := Brole[bnum].rnum;
  for i := 0 to length(Brole) - 1 do
  begin
    Brole[i].ShowNumber := -1;
    Brole[i].wanfang := 0;
  end;
  if Rrole[rnum].CurrentMP < Rmagic[mnum].NeedMP * level then level := Rrole[rnum].CurrentMP div Rmagic[mnum].NeedMP;
  if level > 10 then level := 10;
  needmp := Rmagic[mnum].NeedMP * level;
  for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].Dead = 0) and (Brole[i].rnum >= 0) then
    begin
      if (Bfield[4, Brole[i].X, Brole[i].Y] <> 0) and (Brole[bnum].Team <> Brole[i].Team) and
        (Brole[i].Dead = 0) and (bnum <> i) then
      begin
        if Rrole[Brole[i].rnum].Fist > MaxFist then
          MaxFist := Rrole[Brole[i].rnum].Fist;
        if Rrole[Brole[i].rnum].Sword > MaxSword then
          MaxSword := Rrole[Brole[i].rnum].Sword;
        if Rrole[Brole[i].rnum].Knife > MaxKnife then
          MaxKnife := Rrole[Brole[i].rnum].Knife;
        if Rrole[Brole[i].rnum].Unusual > MaxUnusual then
          MaxUnusual := Rrole[Brole[i].rnum].Unusual;
        hurt := CalHurtValue(bnum, i, mnum, level);
        hurt := (hurt * (400 + Rrole[Brole[i].rnum].Hurt)) div 400;
        hurt := (hurt * (400 - Rrole[rnum].Hurt)) div 400;
        //生命伤害
        if (Rmagic[mnum].HurtType = 0) then
        begin
          //某些状态增加伤害   15-18 加成某类型，13 加成所有，2 女性加成所有
          if (GetGongtiState(rnum, 14 + Rmagic[mnum].MagicType)) or (GetGongtiState(rnum, 13)) or
            ((GetEquipState(rnum, 2) or (GetGongtiState(rnum, 2))) and (Rrole[rnum].sexual = 1)) or
            GetEquipState(rnum, 14 + Rmagic[mnum].MagicType) or GetEquipState(rnum, 13) then
          begin
            hurt := trunc(hurt * 1.3);
          end;
          //某些状态伤害改变   9 随机增减50%或不变
          if GetEquipState(rnum, 9) or (GetGongtiState(rnum, 9)) then
            hurt := trunc((hurt * (7 + ((Rrole[rnum].level - 1) mod 10))) / 10);
          n := i;
          //转换伤害对象  4 乾坤大挪移 5斗转星移
          if GetEquipState(Brole[i].rnum, 4) or (GetGongtiState(Brole[i].rnum, 4)) then n := ReMoveHurt(i, bnum);
          if GetEquipState(Brole[i].rnum, 5) or (GetGongtiState(Brole[i].rnum, 5)) then n := RetortHurt(i, bnum);
          //計算招式加成
          hurt := trunc((hurt * (200 - Brole[n].zhuangtai[1])) div 100);
          hurt := (hurt * (100 + Brole[bnum].zhuangtai[5])) div 100;
          hurt := hurt * (100 - Brole[n].zhuangtai[11]) div 100;
          hurt := hurt + Brole[bnum].zhuangtai[12];

          Brole[bnum].zhuangtai[12] := 0;

          //计算攻击招式加成，自动选择、播放防御招式
          if (Brole[bnum].szhaoshi >= 0) then
          begin
            Brole[n].szhaoshi := checkfangyu(fmnum, fmlev, frznum, Brole[n].rnum, Brole[bnum].szhaoshi);
            for j1 := 0 to 23 do
            begin
              if Rzhaoshi[Brole[n].szhaoshi].texiao[j1].x < 0 then break;
              if (Rzhaoshi[Brole[n].szhaoshi].texiao[j1].x >= 10) and
                (Rzhaoshi[Brole[n].szhaoshi].texiao[j1].x <= 18) then
              begin
                Brole[n].zhuangtai[Rzhaoshi[Brole[n].szhaoshi].texiao[j1].x - 5] :=
                  min(100, Brole[n].zhuangtai[Rzhaoshi[Brole[n].szhaoshi].texiao[j1].x - 5] +
                  Brole[n].zhuangtai[Rzhaoshi[Brole[n].szhaoshi].texiao[j1].y]);
              end;
              if (Rzhaoshi[Brole[n].szhaoshi].texiao[j1].x >= 70) and
                (Rzhaoshi[Brole[n].szhaoshi].texiao[j1].x <= 89) and (Rrole[rnum].Gongti > -1) then
              begin
                for j2 := 0 to 9 do
                begin
                  if (Rmagic[Rrole[rnum].LMagic[Rrole[rnum].Gongti]].MoveDistance[j2] =
                    Rzhaoshi[Brole[n].szhaoshi].texiao[j1].x) then
                  begin
                    hurt := hurt * (100 + Rzhaoshi[Brole[n].szhaoshi].texiao[j1].y) div 100;
                  end;
                end;
              end;
            end;
            showzhaoshi(n, Brole[n].szhaoshi, 2);
            Brole[n].wanfang := 0;
            case Rmagic[mnum].MagicType of
              1: begin wpn := Rrole[Brole[n].rnum].Fist - Rrole[rnum].Fist; end;
              2: begin wpn := Rrole[Brole[n].rnum].Sword - Rrole[rnum].Sword; end;
              3: begin wpn := Rrole[Brole[n].rnum].Knife - Rrole[rnum].Knife; end;
              4: begin wpn := Rrole[Brole[n].rnum].Unusual - Rrole[rnum].Unusual; end;
            end;
            if (Brole[bnum].pozhao = 1) and (wpn < 0) then
              wpn := wpn * 2;
            wfadd:=0;
            if Rrole[Brole[n].rnum].MPType = 0 then
              wfadd := 200;
            if random(4000 - wfadd) < ((100 + Rrole[Brole[n].rnum].fuyuan) * (100 +
              Brole[n].zhuangtai[8] + Brole[n].zhuangtai[13] + Rrole[Brole[bnum].rnum].angry) * (100 + wpn) div 10000) then
            begin
              Brole[n].wanfang := 1;
              BShowBWord.sign := BShowBWord.sign or (1 shl 3);
              BShowBWord.delay[3] := 10;
              BShowBWord.words[3] := '完防';
            end;
            //PlayActionAmination(n, Rmagic[Rzhaoshi[brole[n].szhaoshi].congshu].MagicType);
            PlayMagicAmination2(n, Rmagic[Rzhaoshi[Brole[n].szhaoshi].congshu].bigami,
              Rmagic[Rzhaoshi[Brole[n].szhaoshi].congshu].AmiNum, 10);
            hurt := trunc(hurt * (900 + Rzhaoshi[Brole[bnum].szhaoshi].gongji * (level - 1) -
              Rzhaoshi[Brole[n].szhaoshi].fangyu * (fmlev - 1)) div 900);
            if random(3) = 1 then
              magicexp(n, fmnum, fmlev, frznum);
          end;
          if (Rrole[Brole[bnum].rnum].Angry = 100) then bang := 100
          else bang := Brole[bnum].zhuangtai[10];
          dodge := max(1, Brole[n].zhuangtai[9] + (GetRoleDefence(Brole[n].rnum, True) div 15)); //增加闪躲率状态
          bang := bang + Rrole[rnum].Angry div 5; //根据愤怒值计算暴击率
          dodge := dodge + Rrole[Brole[n].rnum].Angry div 10; //根据愤怒值计算闪躲率
          bang := min(bang, 100);
          dodge := min(dodge, 100);
          dodge := dodge * Brole[n].zhuangtai[2] div 100;
          //计算愤怒值
          angry := (hurt * 100) div Rrole[Brole[n].rnum].MaxHP;
          if angry <= 0 then
            angry := 0;
          Rrole[Brole[n].rnum].Angry := Rrole[Brole[n].rnum].Angry + angry;
          Rrole[Brole[n].rnum].Angry := min(Rrole[Brole[n].rnum].Angry, 100);
          if random(100) < bang - 1 then hurt := trunc(hurt * 1.5);
          if (random(100) + Brole[bnum].zhuangtai[7]) < dodge then hurt := 0;
          if (Brole[bnum].szhaoshi > 0) and (hurt > 0) and (Brole[n].wanfang = 0) then
          begin
            for j1 := 0 to 23 do
            begin
              if Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x < 0 then break
              else if (Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x >= 70) and
                (Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x <= 89) and (Rrole[rnum].Gongti > -1) then
              begin
                for j2 := 0 to 9 do
                begin
                  if (Rmagic[Rrole[rnum].LMagic[Rrole[rnum].Gongti]].MoveDistance[j2] =
                    Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x) then
                  begin
                    hurt := hurt * (100 + Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].y) div 100;
                  end;
                end;
              end
              else if (Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x <= 9) and (Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].y <> 0) then
              begin
                ztfytmp := 0;
                if (Brole[n].szhaoshi > 0) then
                begin
                  for j2 := 0 to 23 do
                  begin
                    if Rzhaoshi[Brole[n].szhaoshi].texiao[j2].x < 0 then break;
                    if (Rzhaoshi[Brole[n].szhaoshi].texiao[j2].x < 20) or
                      (Rzhaoshi[Brole[n].szhaoshi].texiao[j2].x > 24) then continue;
                    if ((Rzhaoshi[Brole[n].szhaoshi].texiao[j2].x - 20) =
                      Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x) and
                      (Rzhaoshi[Brole[n].szhaoshi].texiao[j2].y <> 0) then
                    begin
                      ztfytmp := (Rzhaoshi[Brole[n].szhaoshi].texiao[j2].y * (level - 1)) div 9;
                      break;
                    end;
                  end;
                end;
                Brole[n].zhuangtai[Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x] :=
                  Brole[n].zhuangtai[Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x] -
                  max(0, round(Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].y * (level - 1) *
                  (1 + Brole[bnum].pozhao / 10) / 9) - ztfytmp);
                Brole[n].zhuangtai[Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x] :=
                  max(Brole[n].lzhuangtai[Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x],
                  Brole[n].zhuangtai[Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x]);
                Brole[n].zhuangtai[Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x] :=
                  min(100, Brole[n].zhuangtai[Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x]);
              end;

            end;
          end;
          Brole[n].ShowNumber := hurt;
          hurt := min(Rrole[Brole[n].rnum].CurrentHP, hurt);
          Rrole[Brole[n].rnum].CurrentHP := max(0, Rrole[Brole[n].rnum].CurrentHP - hurt);
          if Rrole[Brole[n].rnum].CurrentHP <= 0 then
          begin
            Inc(Brole[bnum].killed);
            diexiaoguo(n);
            Brole[bnum].ExpGot := Brole[bnum].ExpGot + round(
              (70 + 2 * (Rrole[Brole[n].rnum].Level - Rrole[rnum].Level)) * 2.5);
          end
          else
          begin
            Brole[bnum].ExpGot := Brole[bnum].ExpGot +
              round(max(1, (25 + 4 * (Rrole[Brole[n].rnum].Level - Rrole[rnum].Level))) * hurt / 1500);
          end;
        end
        else if (Rmagic[mnum].HurtType = 1) then
        begin
          //某些状态增加伤害   15-18 加成某类型，13 加成所有，2 女性加成所有
          if (GetGongtiState(rnum, 15 + Rmagic[mnum].MagicType)) or (GetGongtiState(rnum, 13)) or
            ((GetEquipState(rnum, 2) or (GetGongtiState(rnum, 2))) and (Rrole[rnum].sexual = 1)) or
            GetEquipState(rnum, 15 + Rmagic[mnum].MagicType) or GetEquipState(rnum, 13) then
          begin
            hurt := trunc(hurt * 1.3);
          end;
          //某些状态增加闪躲率   8 增加50%闪躲率
          if GetEquipState(Brole[i].rnum, 8) or (GetGongtiState(Brole[i].rnum, 8)) then Inc(dodge, 30);
          //某些状态伤害改变   9 随机增减50%或不变
          if GetEquipState(rnum, 9) or (GetGongtiState(rnum, 9)) then
            hurt := trunc(hurt * (1 + ((random(3) - 1) * 0.5)));
          n := i;
          //转换伤害对象  4 乾坤大挪移 5斗转星移
          if GetEquipState(Brole[i].rnum, 4) or (GetGongtiState(Brole[i].rnum, 4)) then n := ReMoveHurt(i, bnum);
          if GetEquipState(Brole[i].rnum, 5) or (GetGongtiState(Brole[i].rnum, 5)) then n := RetortHurt(i, bnum);
          //計算招式加成
          hurt := trunc((hurt * (200 - Brole[n].zhuangtai[0])) div 100);
          hurt := (hurt * (100 + Brole[bnum].zhuangtai[5])) div 100;
          hurt := hurt * (100 - Brole[n].zhuangtai[11]) div 100;
          //计算攻击招式加成，自动选择、播放防御招式
          if (Brole[bnum].szhaoshi >= 0) then
          begin
            Brole[n].szhaoshi := checkfangyu(fmnum, fmlev, frznum, Brole[n].rnum, Brole[bnum].szhaoshi);
            for j2 := 0 to 23 do
            begin
              if Rzhaoshi[Brole[n].szhaoshi].texiao[j2].x < 0 then break;
              if (Rzhaoshi[Brole[n].szhaoshi].texiao[j2].x >= 10) and
                (Rzhaoshi[Brole[n].szhaoshi].texiao[j2].x <= 18) then
              begin
                Brole[n].zhuangtai[Rzhaoshi[Brole[n].szhaoshi].texiao[j2].x - 5] :=
                  min(100, Brole[n].zhuangtai[Rzhaoshi[Brole[n].szhaoshi].texiao[j2].x - 5] +
                  Brole[n].zhuangtai[Rzhaoshi[Brole[n].szhaoshi].texiao[j2].y]);
              end;
            end;
            showzhaoshi(n, Brole[n].szhaoshi, 2);
            Brole[n].wanfang := 0;
            if random(4000) < ((100 + Rrole[Brole[n].rnum].fuyuan) * (100 +
              Brole[n].zhuangtai[8] + Brole[n].zhuangtai[13] + Rrole[Brole[bnum].rnum].angry) div 10000) then
            begin
              Brole[n].wanfang := 1;
              BShowBWord.sign := BShowBWord.sign or (1 shl 3);
              BShowBWord.delay[3] := 10;
              BShowBWord.words[3] := '完防';
            end;
            //PlayActionAmination(n, Rmagic[Rzhaoshi[brole[n].szhaoshi].congshu].MagicType);
            PlayMagicAmination2(n, Rmagic[Rzhaoshi[Brole[n].szhaoshi].congshu].bigami,
              Rmagic[Rzhaoshi[Brole[n].szhaoshi].congshu].AmiNum, 10);
            hurt := trunc(hurt * (900 + Rzhaoshi[Brole[bnum].szhaoshi].gongji * (level - 1) -
              Rzhaoshi[Brole[n].szhaoshi].fangyu * (fmlev - 1)) div 900);
          end;
          if (Rrole[Brole[bnum].rnum].Angry = 100) then bang := 100
          else bang := Brole[bnum].zhuangtai[10];
          dodge := max(1, Brole[n].zhuangtai[9] + (GetRoleDefence(Brole[n].rnum, True) div 15)); //增加闪躲率状态

          //计算愤怒值
          bang := bang + Rrole[rnum].Angry div 5; //根据愤怒值计算暴击率
          dodge := dodge + Rrole[Brole[n].rnum].Angry div 10; //根据愤怒值计算闪躲率
          bang := min(bang, 100);
          dodge := min(dodge, 100);
          dodge := dodge * Brole[n].zhuangtai[2] div 100;
          angry := random((hurt * 100) div Rrole[Brole[n].rnum].MaxHP);
          if angry <= 0 then
            angry := 1;
          Rrole[Brole[n].rnum].Angry := Rrole[Brole[n].rnum].Angry + angry;
          Rrole[Brole[n].rnum].Angry := min(Rrole[Brole[n].rnum].Angry, 100);
          if random(100) < bang - 1 then hurt := trunc(hurt * 1.5);
          if (random(100) + Brole[bnum].zhuangtai[7]) < dodge then hurt := 0;
          if (Brole[bnum].szhaoshi > 0) and (hurt > 0) and (Brole[n].wanfang = 0) then
          begin
            for j1 := 0 to 23 do
            begin
              if Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x < 0 then break;
              if Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x > 9 then continue;
              if Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].y <> 0 then
              begin
                ztfytmp := 0;
                if (Brole[n].szhaoshi > 0) then
                begin
                  for j2 := 0 to 23 do
                  begin
                    if Rzhaoshi[Brole[n].szhaoshi].texiao[j2].x < 0 then break;
                    if (Rzhaoshi[Brole[n].szhaoshi].texiao[j2].x < 20) or
                      (Rzhaoshi[Brole[n].szhaoshi].texiao[j2].x > 24) then continue;
                    if ((Rzhaoshi[Brole[n].szhaoshi].texiao[j2].x - 20) =
                      Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x) and
                      (Rzhaoshi[Brole[n].szhaoshi].texiao[j2].y <> 0) then
                    begin
                      ztfytmp := (Rzhaoshi[Brole[n].szhaoshi].texiao[j2].y * (level - 1)) div 9;
                      break;
                    end;
                  end;
                end;
                Brole[n].zhuangtai[Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x] :=
                  Brole[n].zhuangtai[Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x] -
                  max(0, round(Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].y * (level - 1) *
                  (1 + Brole[bnum].pozhao / 10) / 9) - ztfytmp);
                Brole[n].zhuangtai[Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x] :=
                  max(Brole[n].lzhuangtai[Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x],
                  Brole[n].zhuangtai[Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x]);
                Brole[n].zhuangtai[Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x] :=
                  min(100, Brole[n].zhuangtai[Rzhaoshi[Brole[bnum].szhaoshi].texiao[j1].x]);
              end;
            end;
          end;
          Brole[n].ShowNumber := hurt;
          hurt := min(Rrole[Brole[n].rnum].CurrentMP, hurt);
          Rrole[Brole[n].rnum].CurrentMP := max(0, Rrole[Brole[n].rnum].CurrentMP - hurt);
        end;
        //增加己方内力
        addmpvalue := addmpvalue + (Rmagic[mnum].AddMpScale * hurt) div 100;
        //如功体有吸内力效果
        if (Rrole[rnum].Gongti >= 0) and (Rmagic[Rrole[rnum].LMagic[Rrole[rnum].Gongti]].NeedExp[Rmagic[Rrole[rnum].LMagic[Rrole[rnum].Gongti]].MaxLevel] <= GetMagicLevel(rnum, Rrole[rnum].Gongti)) and
          (Rmagic[Rrole[rnum].LMagic[Rrole[rnum].Gongti]].AddMpScale > 0) then
        begin
          hurtmp := (hurt * Rmagic[Rrole[rnum].LMagic[Rrole[rnum].Gongti]].AddMpScale) div 100;
          if (hurtmp > Rrole[Brole[i].rnum].CurrentMP) then hurt := hurtmp - Rrole[Brole[i].rnum].CurrentMP;
          //增加己方内力
          Rrole[Brole[i].rnum].CurrentMP := max(0, Rrole[Brole[i].rnum].CurrentMP - hurtmp);
          addmpvalue := addmpvalue + hurtmp;
        end;
        //增加己方生命
        addhpvalue := addhpvalue + (Rmagic[mnum].AddHpScale * hurt) div 100;
        //如装备有吸血效果
        if GetEquipState(rnum, 21) or GetGongtiState(rnum, 21) then
          addhpvalue := addhpvalue + hurt div 10;
        //如功体有吸血效果
        if (Rrole[rnum].Gongti >= 0) and (Rmagic[Rrole[rnum].LMagic[Rrole[rnum].Gongti]].MaxLevel =
          GetGongtiLevel(rnum, Rrole[rnum].Gongti)) and
          (Rmagic[Rrole[rnum].LMagic[Rrole[rnum].Gongti]].AddHpScale > 0) then
          addhpvalue := addhpvalue + (Rmagic[mnum].AddHpScale * hurt) div 100;
        if hurt > 0 then
        begin
          //中毒，某些状态免疫   12 免除所有负面状态 ,套装4 免除所有负面状态
          if (not GetGongtiState(Brole[n].rnum, 12)) and (not GetEquipState(Brole[n].rnum, 12)) and
            (CheckEquipSet(Rrole[Brole[n].rnum].equip[0], Rrole[Brole[n].rnum].equip[1],
            Rrole[Brole[n].rnum].equip[2], Rrole[Brole[n].rnum].equip[3]) <> 4) and
            (random(110) > Brole[n].zhuangtai[0]) then
          begin
            addpoi := GetroleAttPoi(rnum, True) + Rmagic[mnum].Poision * level - GetRoleDefPoi(Brole[n].rnum, True);
            if addpoi + Rrole[Brole[n].rnum].Poision > 99 then addpoi := 99 - Rrole[Brole[n].rnum].Poision;
            if addpoi < 0 then addpoi := 0;
            if GetRoleDefPoi(Brole[n].rnum, True) >= 99 then addpoi := 0;
            Rrole[Brole[n].rnum].Poision := Rrole[Brole[n].rnum].Poision + addpoi;
          end;
          //内伤 ，某些状态免疫   12 免除所有负面状态，6 免除内伤  ,套装4 免除所有负面状态
          if (not GetGongtiState(Brole[n].rnum, 12)) and (not GetEquipState(Brole[n].rnum, 12)) and
            (CheckEquipSet(Rrole[Brole[n].rnum].equip[0], Rrole[Brole[n].rnum].equip[1],
            Rrole[Brole[n].rnum].equip[2], Rrole[Brole[n].rnum].equip[3]) <> 4) and
            (not GetGongtiState(Brole[n].rnum, 6)) and (not GetEquipState(Brole[n].rnum, 6)) then
          begin
            injury := ((Rmagic[mnum].MaxInjury - Rmagic[mnum].MinInjury) * (level - 1)) div
              9 + Rmagic[mnum].MinInjury + 5;
            //内伤 ，某些状态增加内伤率   19增加内伤率  套装3必然内伤
            if GetEquipState(rnum, 19) or (GetGongtiState(rnum, 19)) then injury := injury + 30;
            if CheckEquipSet(Rrole[rnum].equip[0], Rrole[rnum].equip[1], Rrole[rnum].equip[2],
              Rrole[rnum].equip[3]) = 3 then
              injury := 100;
            if random(101) > Brole[n].zhuangtai[0] then
              if random(101) < injury then Inc(Rrole[Brole[n].rnum].Hurt, round(hurt / 10));
            if Rrole[Brole[n].rnum].Hurt > 100 then Rrole[Brole[n].rnum].Hurt := 100;
          end;
          //封穴 ，某些状态免疫   12 免除所有负面状态 ,套装4 免除所有负面状态
          if (not GetGongtiState(Brole[n].rnum, 12)) and (not GetEquipState(Brole[n].rnum, 12)) and
            (CheckEquipSet(Rrole[Brole[n].rnum].equip[0], Rrole[Brole[n].rnum].equip[1],
            Rrole[Brole[n].rnum].equip[2], Rrole[Brole[n].rnum].equip[3]) <> 4) then
          begin
            frozen := (((Rmagic[mnum].MaxPeg - Rmagic[mnum].MinPeg) * (level - 1)) div 9 + Rmagic[mnum].MinPeg);
            //封穴 ，某些状态增加封穴率   20增加封穴率
            if GetEquipState(rnum, 20) or (GetGongtiState(rnum, 20)) then frozen := frozen + 10;
            //氣防
            frozen := (frozen * (150 - Brole[n].zhuangtai[0])) div 100;
            if random(100) < frozen then
            begin
              frozen := round(((Rrole[rnum].CurrentMP - (Rrole[Brole[n].rnum].CurrentMP div 2)) /
                (Rrole[Brole[n].rnum].CurrentMP + 1)) * 20);
              Inc(Brole[n].frozen, frozen);
            end;
            Brole[n].frozen := min(50, Brole[n].frozen);
          end;

          //某些状态杀伤体力  7 杀伤体力
          if (GetGongtiState(rnum, 7)) or GetEquipState(rnum, 7) then
          begin
            Rrole[Brole[n].rnum].PhyPower := Rrole[Brole[n].rnum].PhyPower - 5;
            if Rrole[Brole[n].rnum].PhyPower <= 0 then Rrole[Brole[n].rnum].PhyPower := 0;
          end;

          //某些状态吸杀内力  25 吸杀内力
          if (GetGongtiState(rnum, 25)) or GetEquipState(rnum, 25) then
          begin
            hurtmp := hurt div 10;
            if (hurtmp > Rrole[Brole[n].rnum].CurrentMP) then hurtmp := hurtmp - Rrole[Brole[n].rnum].CurrentMP;
            //增加己方内力
            Rrole[Brole[n].rnum].CurrentMP := max(0, Rrole[Brole[n].rnum].CurrentMP - hurtmp);
            addmpvalue := addmpvalue + hurtmp;
          end;
          isattack := True;
        end;
        BShowBWord.sign := BShowBWord.sign and $F7;

      end;
    end;
  end;

  ShowHurtValue(Rmagic[mnum].HurtType); //显示数字


  //某些状态耗费内力减少  10 耗费内力-20%
  if GetEquipState(rnum, 10) or (GetGongtiState(rnum, 10)) then needmp := (needmp * 4) div 5;
  Rrole[rnum].CurrentMP := Rrole[rnum].CurrentMP - needmp;
  Rrole[rnum].CurrentHP := Rrole[rnum].CurrentHP - (needmp * Rrole[rnum].Hurt) div 100;

  //某些状态不耗费体力  1 不耗费体力
  if (not GetGongtiState(rnum, 1)) and (not GetEquipState(rnum, 1)) then
    Rrole[rnum].PhyPower := Rrole[rnum].PhyPower - 3;

  //消耗自身生命
  Rrole[rnum].CurrentHP := Rrole[rnum].CurrentHP - Rmagic[mnum].NeedHP * ((level + 1) div 2);
  if Rrole[rnum].CurrentHP < 0 then Rrole[rnum].CurrentHP := 0;
  if Rrole[rnum].CurrentHP > Rrole[rnum].MaxHP then Rrole[rnum].CurrentHP := Rrole[rnum].MaxHP;

  //攻击者增加1愤怒值 luke取消
  {if (battlemode > 1) then
  begin
    Rrole[rnum].Angry := Rrole[rnum].Angry + 1;
    if Rrole[rnum].Angry > 100 then Rrole[rnum].Angry := 100;
  end;}
  //增加己方内力
  if (addmpvalue > 0) then
  begin
    Brole[bnum].ShowNumber := addmpvalue;
    Rrole[rnum].CurrentMP := Rrole[rnum].CurrentMP + addmpvalue;
    Rrole[rnum].CurrentMP := min(Rrole[rnum].MaxMP, Rrole[rnum].CurrentMP);
    ShowHurtValue(1, ColColor(0, $50), ColColor(0, $53));
  end;
  //增加己方生命
  if (addhpvalue > 0) then
  begin
    Brole[bnum].ShowNumber := addhpvalue;
    Rrole[rnum].CurrentHP := Rrole[rnum].CurrentHP + addhpvalue;
    Rrole[rnum].CurrentHP := min(Rrole[rnum].MaxHP, Rrole[rnum].CurrentHP);
    ShowHurtValue(3);
  end;

end;
//攻击式医疗计算人物
procedure CalMedRole(bnum, mnum, level: integer);
var
  i, j1, j2, rnum, hurt, addpoi, needmp, n, hurtmp, hurt1, addmpvalue,
  addhpvalue, injury, angry, ztfytmp, fmnum, fmlev, frznum, wpn: integer;
begin
  fmnum := -1;
  fmlev := -1;
  frznum := -1;
  MaxFist := 0;
  MaxSword := 0;
  MaxKnife := 0;
  MaxUnusual := 0;
  addhpvalue := 0;
  addmpvalue := 0;
  rnum := Brole[bnum].rnum;
  for i := 0 to length(Brole) - 1 do
  begin
    Brole[i].ShowNumber := -1;
  end;
  if Rrole[rnum].CurrentMP < Rmagic[mnum].NeedMP * level then level := Rrole[rnum].CurrentMP div Rmagic[mnum].NeedMP;
  if level > 10 then level := 10;
  needmp := Rmagic[mnum].NeedMP * level;
  for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].Dead = 0) and (Brole[i].rnum >= 0) then
    begin
      if (Bfield[4, Brole[i].X, Brole[i].Y] <> 0) and (Brole[bnum].Team = Brole[i].Team) and
        (Brole[i].Dead = 0) then
      begin
        MaxMedcine:=0;
        n:=i;
        hurt := CalMedValue(bnum, i, mnum, level);
        hurt := (hurt * (100 - Rrole[Brole[i].rnum].Hurt)) div 100;
        hurt := (hurt * max(0,(80 - Rrole[rnum].Hurt))) div 100;
        hurt := hurt * (100 - Brole[n].zhuangtai[11]) div 100;
        Brole[n].ShowNumber := hurt;
        hurt := min(Rrole[Brole[n].rnum].MaxHP -Rrole[Brole[n].rnum].CurrentHP, hurt);
        Rrole[Brole[n].rnum].CurrentHP := min(Rrole[Brole[n].rnum].MaxHP, Rrole[Brole[n].rnum].CurrentHP + hurt);
        Brole[bnum].ExpGot := Brole[bnum].ExpGot +
         round(max(1, (25 + 4 * (Rrole[Brole[n].rnum].Level - Rrole[rnum].Level))) * hurt / 1500);
        if hurt > 0 then
        begin
          isattack := True;
        end;
        BShowBWord.sign := BShowBWord.sign and $F7;

      end;
    end;
  end;

  ShowHurtValue(3); //显示数字
  //某些状态耗费内力减少  10 耗费内力-20%
  if GetEquipState(rnum, 10) or (GetGongtiState(rnum, 10)) then needmp := (needmp * 4) div 5;
  Rrole[rnum].CurrentMP := Rrole[rnum].CurrentMP - needmp;
  Rrole[rnum].CurrentHP := Rrole[rnum].CurrentHP - (needmp * Rrole[rnum].Hurt) div 100;

  //某些状态不耗费体力  1 不耗费体力
  if (not GetGongtiState(rnum, 1)) and (not GetEquipState(rnum, 1)) then
    Rrole[rnum].PhyPower := Rrole[rnum].PhyPower - 3;

  //消耗自身生命
  Rrole[rnum].CurrentHP := Rrole[rnum].CurrentHP - Rmagic[mnum].NeedHP * ((level + 1) div 2);
  if Rrole[rnum].CurrentHP < 0 then Rrole[rnum].CurrentHP := 0;
  if Rrole[rnum].CurrentHP > Rrole[rnum].MaxHP then Rrole[rnum].CurrentHP := Rrole[rnum].MaxHP;

end;
//乾坤大挪移的效果

function ReMoveHurt(bnum, AttackBnum: integer): smallint;
var
  i1, i2, x, y, i, n, realhurt: integer;
  str: WideString;
  temp: array of integer;
begin
  Result := bnum;
  setlength(temp, 0);
  n := 0;
  if (Random(100) < 30 + Rrole[Brole[bnum].rnum].Aptitude div 5) then
  begin
    for i := 0 to length(Brole) - 1 do
      if (Brole[i].Dead = 0) and (Brole[i].rnum >= 0) and (i <> bnum) and (i <> Attackbnum) and
        (Brole[i].Team <> Brole[bnum].Team) and ((abs(Brole[i].X - Brole[bnum].X) +
        abs(Brole[i].Y - Brole[bnum].Y)) <= 5) then
      begin
        setlength(temp, n + 1);
        temp[n] := i;
        Inc(n);
      end;
    if n > 0 then
    begin
      i := temp[random(n)];
      Result := i;
      x := -(Brole[bnum].X - Bx) * 18 + (Brole[bnum].Y - By) * 18 + CENTER_X - 10;
      y := (Brole[bnum].X - Bx) * 9 + (Brole[bnum].Y - By) * 9 + CENTER_Y - 60;

      str := '轉移';
      for i1 := 0 to 10 do
      begin
        Redraw;
        DrawShadowText(@str[1], x - 30, y - i1 * 2, ColColor(0, $10), ColColor(0, $14));
        SDL_Delay(5 + GameSpeed div 3);
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end;
    end;
  end;
end;

// 反弹攻击

function RetortHurt(bnum, AttackBnum: integer): smallint;
var
  i1, i2, x, y, i, realhurt: integer;
  str: WideString;
begin

  Result := bnum;
  if (Random(100) < 30 + Rrole[Brole[bnum].rnum].Aptitude div 5) then
  begin
    Result := AttackBnum;
    x := -(Brole[bnum].X - Bx) * 18 + (Brole[bnum].Y - By) * 18 + CENTER_X - 10;
    y := (Brole[bnum].X - Bx) * 9 + (Brole[bnum].Y - By) * 9 + CENTER_Y - 60;
    str := '反噬';
    for i1 := 0 to 10 do
    begin
      Redraw;
      DrawShadowText(@str[1], x - 30, y - i1 * 2, ColColor(0, $10), ColColor(0, $14));
      SDL_Delay(5 + GameSpeed div 3);
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    end;
  end;
end;

//计算伤害值, 所谓“武功威力3”即武功威力成长值，1000为基准，大于1000则越高级增长速度越快，反之增长速度越慢

function CalNewHurtValue(lv, min, max0, Proportion: integer): integer;
var
  p, n: double;
begin
  if proportion = 0 then proportion := 100;
  p := Proportion / 1000;
  n := Power((max0 - min), 1 / p) / 9;
  Result := round(Power((lv * n), p)) + min;
end;

function CalHurtValue(bnum1, bnum2, mnum, level: integer): integer;
var
  i, rnum1, l1, c, rnum2, mhurt, p, def, mp1, mp2, addatt, att, spd2, wpn2, spd1, wpn1, k1,
  k2, knowledge, dis: integer;
  a1, s1, m1, w1: double;
begin
  //计算双方武学常识
  k1 := 0;
  k2 := 0;
  l1 := 0;
  c := 0;
  for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].Team = Brole[bnum1].Team) and (Brole[i].Dead = 0) and (Brole[i].Knowledge > MIN_KNOWLEDGE) then
      k1 := k1 + Brole[i].Knowledge;
    if (Brole[i].Team = Brole[bnum2].Team) and (Brole[i].Dead = 0) and (Brole[i].Knowledge > MIN_KNOWLEDGE) then
      k2 := k2 + Brole[i].Knowledge;
    if (Brole[i].Team = 0) and (Brole[i].rnum >= 0) then
    begin
      Inc(l1, Rrole[Brole[i].rnum].Level);
      Inc(c);
    end;
  end;
  if c = 0 then
    l1 := Rrole[0].Level
  else
    l1 := l1 div c;
  if (Brole[bnum1].Team <> 0) then k1 := k1 + l1 * Rrole[0].difficulty div 50;
  if (Brole[bnum2].Team <> 0) then k2 := k2 + l1 * Rrole[0].difficulty div 50;
  knowledge := k1 - k2;
  knowledge := min(k1 - k2, 100);
  knowledge := max(k1 - k2, -100);

  rnum1 := Brole[bnum1].rnum;
  rnum2 := Brole[bnum2].rnum;
  // mhurt := Rmagic[mnum].Attack[level - 1];
  mhurt := (CalNewHurtValue(level - 1, Rmagic[mnum].MinHurt, Rmagic[mnum].MaxHurt, Rmagic[mnum].HurtModulus) *
    (100 + (knowledge * 4) div 5)) div 100;

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
  Result := 0;
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

  a1 := max(0.1, min((1 + a1) / (5 + att), 1));
  w1 := max(0.1, min((1 + w1) / (5 + wpn1), 1));
  s1 := max(0.1, min((1 + s1) / (5 + spd1), 1));
  m1 := max(0.1, min((1 + m1) / (5 + mp1), 1));

  if p > 0 then
  begin
    if Rmagic[mnum].AttackModulus > 0 then
      Result := Result + trunc(mhurt * a1 * (Rmagic[mnum].AttackModulus * 3 * 2 / (1.2 * p)));
    if Rmagic[mnum].MPModulus > 0 then
      Result := Result + trunc(mhurt * m1 * (Rmagic[mnum].MPModulus / (1.2 * p)));
    if Rmagic[mnum].SpeedModulus > 0 then
      Result := Result + trunc(mhurt * s1 * (Rmagic[mnum].SpeedModulus * 2 / (1.2 * p)));
    if Rmagic[mnum].WeaponModulus > 0 then
      Result := Result + trunc(mhurt * w1 * (Rmagic[mnum].WeaponModulus * 2 / (1.2 * p)));
  end;
  Result := Result + random(10) - random(10);
  if Result < mhurt div 20 then
    Result := mhurt div 20 + random(5) - random(5);

  dis := abs(Brole[bnum1].X - Brole[bnum2].X) + abs(Brole[bnum1].Y - Brole[bnum2].Y);
  if dis > 10 then dis := 10;
  Result := Result * (100 - (dis - 1) * 3) div 100;
  if (Result <= 0) or (level <= 0) then
    Result := random(10) + 1;
  if (Result > 9999) then
    Result := 9999;

end;
//攻击式医疗，计算治疗量
function CalMedValue(bnum1, bnum2, mnum, level: integer): integer;
var
  i, rnum1, l1, c, rnum2, mhurt, p, def, mp1, mp2, addatt, att, spd2, wpn2, spd1, wpn1, k1,
  k2, knowledge, dis: integer;
  a1, s1, m1, w1: double;
begin
  l1 := 0;
  c := 0;
  rnum1 := Brole[bnum1].rnum;
  rnum2 := Brole[bnum2].rnum;
  mhurt := CalNewHurtValue(level - 1, Rmagic[mnum].MinHurt, Rmagic[mnum].MaxHurt, Rmagic[mnum].HurtModulus);

  p := Rmagic[mnum].MPModulus + Rmagic[mnum].SpeedModulus * 2 + Rmagic[mnum].WeaponModulus * 9;
  wpn1 := GetRoleMedcine(rnum1, True) + 1;
  wpn2 := GetRoleDefPoi(rnum2, True) + 1;

  mp1 := Rrole[rnum1].CurrentMP + 1;
  mp2 := Rrole[rnum2].CurrentMP + 1;

  spd1 := GetRoleSpeed(rnum1, True) + 1;
  spd2 := GetRoleSpeed(rnum2, True) + 1;
  if CheckEquipSet(Rrole[rnum1].Equip[0], Rrole[rnum1].Equip[1], Rrole[rnum1].Equip[2], Rrole[rnum1].Equip[3]) = 5 then
  begin
    Inc(spd1, 30);
  end;
  if CheckEquipSet(Rrole[rnum2].Equip[0], Rrole[rnum2].Equip[1], Rrole[rnum2].Equip[2], Rrole[rnum2].Equip[3]) = 5 then
  begin
    Inc(spd2, 30);
  end;
  Result := 0;
  spd1 := max(spd1, 1);
  wpn1 := max(wpn1, 1);
  mp1 := max(mp1, 1);
  spd2 := max(spd2, 1);
  wpn2 := max(wpn2, 1);
  mp2 := max(mp2, 1);
  s1 := spd1 - spd2;
  w1 := wpn1 - wpn2;
  m1 := mp1 - mp2;
  w1 := max(0.1, min((1 + w1) / (5 + 200), 1));
  s1 := max(0.1, min((1 + s1) / (5 + spd1), 1));
  m1 := max(0.1, min((1 + m1) / (5 + mp1), 1));

  if p > 0 then
  begin
    if Rmagic[mnum].MPModulus > 0 then
      Result := Result + trunc(mhurt * m1 * (Rmagic[mnum].MPModulus / (1.2 * p)));
    if Rmagic[mnum].SpeedModulus > 0 then
      Result := Result + trunc(mhurt * s1 * (Rmagic[mnum].SpeedModulus * 2 / (1.2 * p)));
    if Rmagic[mnum].WeaponModulus > 0 then
      Result := Result + trunc(mhurt * w1 * (Rmagic[mnum].WeaponModulus * 9 / (1.2 * p)));
  end;
  Result := Result + random(10) - random(10);
  if Result < mhurt div 20 then
    Result := mhurt div 20 + random(5) - random(5);

  dis := abs(Brole[bnum1].X - Brole[bnum2].X) + abs(Brole[bnum1].Y - Brole[bnum2].Y);
  if dis > 10 then dis := 10;
  Result := Result * (100 - (dis - 1) * 3) div 100;
  if (Result <= 0) or (level <= 0) then
    Result := random(10) + 1;
  if (Result > 9999) then
    Result := 9999;

end;
//0: red. 1: purple, 2: green
//显示数字

procedure ShowHurtValue(mode: integer); overload;
var
  i: integer;
  color1, color2: uint32;
begin
  color1 := 0;
  color2 := 0;
  case mode of
    0:
    begin
      color1 := ColColor(0, $10);
      color2 := ColColor(0, $14);
      i := -1;
    end;
    1:
    begin
      color1 := ColColor(0, $50);
      color2 := ColColor(0, $53);
      i := -1;
    end;
    2:
    begin
      color1 := ColColor(0, $30);
      color2 := ColColor(0, $32);
      i := -1;
    end;
    3:
    begin
      color1 := ColColor(0, $5);
      color2 := ColColor(0, $7);
      i := 1;
    end;
    4:
    begin
      color1 := ColColor(0, $91);
      color2 := ColColor(0, $93);
      i := -1;
    end;
  end;
  ShowHurtValue(i, color1, color2);

end;

procedure ShowHurtValue(sign, color1, color2: integer); overload;
var
  i, i1, x, a, y: integer;
  word: array of WideString;
  str: string;
begin
  a := 0;
  str := '+%d';
  if sign < 0 then
    str := '-%d';

  setlength(word, length(Brole));
  for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].ShowNumber >= 0) and (Brole[i].Dead = 0) and (Brole[i].rnum >= 0) then
    begin
      //x := -(Brole[i].X - Bx) * 18 + (Brole[i].Y - By) * 18 + CENTER_X - 10;
      //y := (Brole[i].X - Bx) * 9 + (Brole[i].Y - By) * 9 + CENTER_Y - 40;
      if Brole[i].ShowNumber = 0 then word[i] := 'Miss'
      else word[i] := format(str, [Brole[i].ShowNumber]);
    end
    else
      word[i] := '0';
  end;
  for i1 := 0 to 10 do
  begin
    Redraw;
    for i := 0 to length(Brole) - 1 do
    begin
      if (Brole[i].ShowNumber >= 0) and (Brole[i].Dead = 0) and (Brole[i].rnum >= 0) then
      begin
        x := -(Brole[i].X - Bx) * 18 + (Brole[i].Y - By) * 18 + CENTER_X - 10;
        y := (Brole[i].X - Bx) * 9 + (Brole[i].Y - By) * 9 + CENTER_Y - 60;
        DrawEngShadowText(@word[i, 1], x, y - i1 * 2, color1, color2);
      end;
    end;
    SDL_Delay(20 + 2 * GameSpeed);
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  end;
  Redraw;
  for i := 0 to length(Brole) - 1 do
  begin
    Brole[i].ShowNumber := -1;
  end;
  Redraw;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
end;

procedure Showzhaoshi(bnum, znum, mods: integer);
var
  i, i1, x, a, y: integer;
  word: WideString;
begin
  if (znum >= 0) and (Brole[bnum].Dead = 0) and (Brole[bnum].rnum >= 0) then
  begin
    BShowBWord.sign := BShowBWord.sign or (1 shl 1);
    BShowBWord.delay[1] := 10;
    if mods = 1 then BShowBWord.words[1] := '攻擊：' + gbktounicode(@rzhaoshi[znum].Name)
    else if mods = 2 then BShowBWord.words[1] := '防禦：' + gbktounicode(@rzhaoshi[znum].Name)
    else BShowBWord.words[1] := '奇術：' + gbktounicode(@rzhaoshi[znum].Name);

  end;
end;


procedure ShowHurtValue(str: WideString; color1, color2: integer); overload;
var
  i, i1, x, a, y: integer;
  word: array of WideString;
begin
  a := 0;
  for i1 := 0 to 10 do
  begin
    Redraw;
    for i := 0 to length(Brole) - 1 do
    begin
      if (Brole[i].ShowNumber >= 0) and (Brole[i].Dead = 0) and (Brole[i].rnum >= 0) then
      begin
        x := -(Brole[i].X - Bx) * 18 + (Brole[i].Y - By) * 18 + CENTER_X - 10;
        y := (Brole[i].X - Bx) * 9 + (Brole[i].Y - By) * 9 + CENTER_Y - 60;
        DrawShadowText(@str[1], x - 20, y - i1 * 2, color1, color2);
      end;
    end;
    SDL_Delay(20 + 2 * GameSpeed);
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  end;
  Redraw;
  for i := 0 to length(Brole) - 1 do
  begin
    Brole[i].ShowNumber := -1;
  end;
  Redraw;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
end;

//计算中毒减少的生命

procedure CalPoiHurtLife(bnum: integer);
var
  i, hurt: integer;
  p: boolean;
begin
  p := False;
  for i := 0 to length(Brole) - 1 do
  begin
    Brole[i].ShowNumber := -1;
  end;

  if (Rrole[Brole[bnum].rnum].Poision > 0) and (Brole[bnum].Dead = 0) then
  begin
    hurt := Rrole[Brole[bnum].rnum].CurrentHP * Rrole[Brole[bnum].rnum].Poision div 200;
    Rrole[Brole[bnum].rnum].CurrentHP := Rrole[Brole[bnum].rnum].CurrentHP - hurt;
    Rrole[Brole[bnum].rnum].CurrentHP := max(Rrole[Brole[bnum].rnum].CurrentHP, 1);
    if hurt > 0 then
    begin
      Brole[bnum].ShowNumber := hurt;
      //p := true;
      ShowHurtValue(2);
    end;
  end;
  if (Rrole[Brole[bnum].rnum].Hurt > 0) and (Brole[bnum].Dead = 0) then
  begin
    Brole[bnum].ShowNumber := Rrole[Brole[bnum].rnum].Hurt;
    //p := true;
    ShowHurtValue('內傷', ColColor(0, $10), ColColor(0, $14));
  end;
  if (Brole[bnum].frozen > 100) and (Brole[bnum].Dead = 0) then
  begin
    Brole[bnum].ShowNumber := Brole[bnum].frozen;
    //p := true;
    ShowHurtValue('封穴', ColColor(0, $64), ColColor(0, $66));
  end;
  //luke取消
  {if (Brole[bnum].AddAtt > 0) and (Brole[bnum].Dead = 0) then
  begin
    Brole[bnum].ShowNumber := Brole[bnum].frozen;
       //p := true;
    showhurtvalue('金剛', colcolor(0, $5), colcolor(0, $7));
  end;
  if (Brole[bnum].AddSpd > 0) and (Brole[bnum].Dead = 0) then
  begin
    Brole[bnum].ShowNumber := Brole[bnum].frozen;
       //p := true;
    showhurtvalue('飛仙', colcolor(0, $5), colcolor(0, $7));
  end;
  if (Brole[bnum].AddDef > 0) and (Brole[bnum].Dead = 0) then
  begin
    Brole[bnum].ShowNumber := Brole[bnum].frozen;
       //p := true;
    showhurtvalue('忘憂', colcolor(0, $5), colcolor(0, $7));
  end;
  if (Brole[bnum].AddStep > 0) and (Brole[bnum].Dead = 0) then
  begin
    Brole[bnum].ShowNumber := Brole[bnum].frozen;
       //p := true;
    showhurtvalue('神行', colcolor(0, $5), colcolor(0, $7));
  end;}

  //luke取消
  {if (Brole[bnum].PerfectDodge > 0) and (Brole[bnum].Dead = 0) then
  begin
    Brole[bnum].ShowNumber := Brole[bnum].frozen;
       //p := true;
    showhurtvalue('迷蹤', colcolor(0, $5), colcolor(0, $7));
  end
  else if (Brole[bnum].AddDodge > 0) and (Brole[bnum].Dead = 0) then
  begin
    Brole[bnum].ShowNumber := Brole[bnum].frozen;
       //p := true;
    showhurtvalue('閃身', colcolor(0, $5), colcolor(0, $7));
  end;}
end;

//设置生命低于0的人物为已阵亡, 主要是清除所占的位置

procedure ClearDeadRolePic;
var
  i: integer;
begin
  for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].rnum >= 0) and (Rrole[Brole[i].rnum].CurrentHP <= 0) then
    begin
      Brole[i].Dead := 1;
      Brole[i].Show := 1;
      bfield[5, Brole[i].X, Brole[i].Y] := i;
      bfield[2, Brole[i].X, Brole[i].Y] := -1;
      //bmount
    end;
  end;
  for i := 0 to length(Brole) - 1 do
    if Brole[i].Dead = 0 then
    begin
      bfield[2, Brole[i].X, Brole[i].Y] := i;
      bfield[5, Brole[i].X, Brole[i].Y] := -1;

    end;
end;

//显示简单状态(x, y表示位置)

procedure ShowSimpleStatus(rnum, x, y: integer);
var
  i, bnum, n, l, c: integer;
  p: array[0..10] of integer;
  eft: array of integer;
  str: WideString;
  strs: WideString;
  color1, color2: uint32;
  nt, nt2: longint;
  zhuangtai: array[0..9] of WideString;
begin
  strs := '專注';
  zhuangtai[0] := '氣防';
  zhuangtai[1] := '硬功';
  zhuangtai[2] := '靈活';
  zhuangtai[3] := '行氣';
  zhuangtai[4] := '身法';
  zhuangtai[5] := '奮發';
  zhuangtai[6] := '戰意';
  zhuangtai[7] := '精准';
  zhuangtai[8] := '急速';
  zhuangtai[9] := '躲閃';
  y := y - 20;
  DrawRectangle(x, y, 400, 115, 0, ColColor(255), 30);
  drawpngpic(battlepic, x, y, 0);

  c := 0;
  setlength(eft, 0);
  for i := 0 to length(Brole) - 1 do
    if Brole[i].rnum = rnum then
    begin
      bnum := i;
      break;
    end;
  if Rrole[rnum].Poision > 0 then
  begin
    Inc(c);
    setlength(eft, c);
    eft[c - 1] := 0;
  end;
  if Rrole[rnum].Hurt > 0 then
  begin
    Inc(c);
    setlength(eft, c);
    eft[c - 1] := 1;
  end;
  if Brole[bnum].frozen > 0 then
  begin
    Inc(c);
    setlength(eft, c);
    eft[c - 1] := 2;
  end;
  if c > 0 then
  begin
    nt := SDL_GetTicks();
    nt2 := nt div 10;
    nt := nt2 mod 200 * c;
    nt2 := (nt div 100) mod 2;

    if (nt < 200) then
    begin
      case eft[0] of
        0: green := ((Rrole[rnum].Poision) * (100 * nt2 + trunc(power(-1, nt2)) * (nt mod 100))) div 100;
        1: red := ((Rrole[rnum].Hurt) * (100 * nt2 + trunc(power(-1, nt2)) * (nt mod 100))) div 100;
        2: gray := ((Brole[bnum].frozen) * (100 * nt2 + trunc(power(-1, nt2)) * (nt mod 100))) div 50;
      end;
    end
    else if (nt < 400) then
    begin
      case eft[1] of
        0: green := ((Rrole[rnum].Poision) * (100 * nt2 + trunc(power(-1, nt2)) * (nt mod 100))) div 150;
        1: red := ((Rrole[rnum].Hurt) * (100 * nt2 + trunc(power(-1, nt2)) * (nt mod 100))) div 150;
        2: gray := ((Brole[bnum].frozen) * (100 * nt2 + trunc(power(-1, nt2)) * (nt mod 100))) div 50;
      end;
    end
    else if (nt < 600) then
    begin
      case eft[2] of
        0: green := ((Rrole[rnum].Poision) * (100 * nt2 + trunc(power(-1, nt2)) * (nt mod 100))) div 100;
        1: red := ((Rrole[rnum].Hurt) * (100 * nt2 + trunc(power(-1, nt2)) * (nt mod 100))) div 100;
        2: gray := ((Brole[bnum].frozen) * (100 * nt2 + trunc(power(-1, nt2)) * (nt mod 100))) div 50;
      end;
    end;
  end;
  //drawheadpic(Rrole[rnum].HeadNum, x + 22, y + 64);
  ZoomPic(head_pic[Rrole[rnum].HeadNum].pic, 0, x + 22, y + 64 - 60, 58, 60);
  str := gbktounicode(@Rrole[rnum].Name);
  showHPMP(rnum, x + 77, y + 5);
  green := 0;
  red := 0;
  gray := 0;
  DrawShadowText(@str[1], x + 30 - length(pchar(@Rrole[rnum].Name)) * 5, y + 69, ColColor($63), ColColor($66));
  DrawShadowText(@strs[1], x + 77, y + 5, ColColor($21), ColColor($23));
  if (battlemode > 0) then
  begin
    for i := 0 to length(Brole) - 1 do
    begin
      if Brole[i].rnum = rnum then
      begin
        for n := 0 to Brole[i].zhuanzhu - 1 do
        begin
          drawpngpic(nowprogress_pic, n * 19 + x + 77 + 58, y + 5, 0);
        end;
      end;
    end;
    if (battlemode = 2) then
    begin
      drawpngpic(angryprogress_pic, x, y, 0);
      if Rrole[rnum].Angry < 100 then
        drawpngpic(angrycollect_pic, 0, 0, 27 + Rrole[rnum].Angry, angrycollect_pic.pic.h, x, y, 0)
      else
        drawpngpic(angryfull_pic, x, y, 0);
    end;
  end;
  {str := format('%d', [Rrole[rnum].Level]);
  drawengshadowtext(@str[1], x + 143, y + 5, colcolor($5), colcolor($7)); }
  for i := 0 to 9 do
  begin
    DrawShadowText(@zhuangtai[i][1], x + 220 + (i div 5) * 90, y + 5 + (i mod 5) * 21,
      ColColor(68 - (i div 5) * 21), ColColor(70 - (i div 5) * 21));
    str := IntToStr(Brole[bnum].zhuangtai[i]);
    DrawEngShadowText(@str[1], x + 275 + (i div 5) * 90, y + 5 + (i mod 5) * 21, ColColor($66), ColColor($68));
  end;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

end;

//等待, 似乎不太完善

procedure Wait(bnum: integer);
var
  i, i1, i2, x: integer;
  Temp: Tbattlerole;
begin
  if battlemode > 0 then
  begin
    Brole[bnum].Wait := 1;
  end
  else
  begin
    temp := Brole[bnum];

    for i := bnum to length(Brole) - 2 do
      Brole[i] := Brole[i + 1];
    Brole[length(Brole) - 1] := temp;
    for i := 0 to length(Brole) - 1 do
    begin
      if Brole[i].Dead = 0 then
        Bfield[2, Brole[i].X, Brole[i].Y] := i
      else
        Bfield[2, Brole[i].X, Brole[i].Y] := -1;
    end;

  end;
end;

procedure Zhuanzhu(bnum: integer);
var
  i: integer;
begin
  Brole[bnum].Acted := 1;

  Brole[bnum].zhuangtai[0] := min(100, Brole[bnum].zhuangtai[0] + 2 + Rrole[Brole[bnum].rnum].CurrentMP *
    (50 + Brole[bnum].zhuangtai[0]) div 50000);
  Brole[bnum].zhuangtai[1] := min(100, Brole[bnum].zhuangtai[1] + 2 + GetRoleDefence(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[1]) div 5000);
  Brole[bnum].zhuangtai[2] := min(100, Brole[bnum].zhuangtai[2] + 2 + GetRoleSpeed(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[2]) div 5000);
  Brole[bnum].zhuangtai[3] := min(100, Brole[bnum].zhuangtai[3] + 2 + Rrole[Brole[bnum].rnum].CurrentHP *
    (50 + Brole[bnum].zhuangtai[3]) div 50000);
  Brole[bnum].zhuangtai[4] := min(100, Brole[bnum].zhuangtai[4] + 2 + GetRoleAttack(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[4]) div 5000);
  if Brole[bnum].Zhuanzhu < 5 then
  begin
    Brole[bnum].zhuangtai[5] := min(100, Brole[bnum].zhuangtai[5] + round(Brole[bnum].Zhuanzhu + 2));
    Brole[bnum].zhuangtai[6] := min(100, Brole[bnum].zhuangtai[6] + round((Brole[bnum].Zhuanzhu + 2) / 3 * 10));
    Brole[bnum].zhuangtai[7] := min(100, Brole[bnum].zhuangtai[7] + round((Brole[bnum].Zhuanzhu + 2) / 3 * 10));
    Brole[bnum].zhuangtai[8] := min(100, Brole[bnum].zhuangtai[8] + round((Brole[bnum].Zhuanzhu + 2) / 3 * 10));
    Brole[bnum].zhuangtai[9] := min(100, Brole[bnum].zhuangtai[9] + round((Brole[bnum].Zhuanzhu + 2) / 3 * 5));

  end;
  Brole[bnum].Zhuanzhu := min(5, Brole[bnum].Zhuanzhu + 1);
  Brole[bnum].Progress := Brole[bnum].Progress - 300;
end;

//战斗结束恢复人物状态

procedure RestoreRoleStatus;
var
  i, rnum: integer;
begin
  for i := 0 to length(Brole) - 1 do
  begin
    rnum := Brole[i].rnum;
    if rnum >= 0 then
    begin
      //我方恢复部分生命, 内力; 敌方恢复全部
      if Rrole[rnum].TeamState in [1, 2] then
      begin
        Rrole[rnum].CurrentHP := Rrole[rnum].CurrentHP + Rrole[rnum].MaxHP div 2;
        if Rrole[rnum].CurrentHP <= 0 then Rrole[rnum].CurrentHP := 1;
        if Rrole[rnum].CurrentHP > Rrole[rnum].MaxHP then Rrole[rnum].CurrentHP := Rrole[rnum].MaxHP;
        Rrole[rnum].CurrentMP := Rrole[rnum].CurrentMP + Rrole[rnum].MaxMP div 20;
        if Rrole[rnum].CurrentMP > Rrole[rnum].MaxMP then Rrole[rnum].CurrentMP := Rrole[rnum].MaxMP;
        Rrole[rnum].PhyPower := Rrole[rnum].PhyPower + MAX_PHYSICAL_POWER div 10;
        if Rrole[rnum].PhyPower > MAX_PHYSICAL_POWER then Rrole[rnum].PhyPower := MAX_PHYSICAL_POWER;
        //luke增加
        Rrole[rnum].Angry := 0;
      end
      else
      begin
        Rrole[rnum].Angry := 0;
        Rrole[rnum].Hurt := 0;
        Rrole[rnum].Poision := 0;
        Rrole[rnum].CurrentHP := Rrole[rnum].MaxHP;
        Rrole[rnum].CurrentMP := Rrole[rnum].MaxMP;
        Rrole[rnum].PhyPower := MAX_PHYSICAL_POWER * 9 div 10;
      end;
    end;
  end;
end;

//增加经验

procedure AddExp; overload;
begin
  AddExp(-1);
end;

procedure AddExp(mods: integer); overload;
var
  i, rnum, basicvalue1, basicvalue2, amount1, amount2, levels1, levels2: integer;
  add1, additem1, add2, additem2, zhiwujc6, mpnum: integer;
  str: WideString;
begin
  levels1 := 0;
  amount1 := 0;
  levels2 := 0;
  amount2 := 0;
  mpnum := Rrole[0].MenPai;
  if Rmenpai[mpnum].zhiwu[6] >= 0 then zhiwujc6 :=
      Rrole[Rmenpai[mpnum].zhiwu[6]].Repute * Rrole[Rmenpai[mpnum].zhiwu[6]].level div 300
  else zhiwujc6 := 0;
  for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].Team = 0) and (Brole[i].Dead = 0) and (Brole[i].rnum >= 0) and (Brole[i].rnum < length(Rrole)) then
    begin
      levels1 := levels1 + Rrole[Brole[i].rnum].Level;
      amount1 := amount1 + 1;
    end
    else if (Brole[i].Team = 1) and (Brole[i].Dead = 0) and (Brole[i].rnum >= 0) and
      (Brole[i].rnum < length(Rrole)) then
    begin
      levels2 := levels2 + Rrole[Brole[i].rnum].Level;
      amount2 := amount2 + 1;
    end;
  end;
  for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].rnum >= 0) and (Brole[i].rnum < length(Rrole)) then
    begin
      rnum := Brole[i].rnum;
      if (Brole[i].Team = 0) then
      begin
        basicvalue1 := Brole[i].ExpGot;
        additem1 := 0;
        if Brole[i].Dead = 0 then
        begin
          if amount1 = 1 then
          begin
            if mods < 0 then Inc(basicvalue1, warsta.exp)
            else Inc(basicvalue1, 100);
          end
          else if levels1 > 0 then
            Inc(basicvalue1, trunc((1 - Rrole[rnum].Level / levels1) / (amount1 - 1) *
              warsta.exp * (100 + 20 * amount1) / 100));

        end
        else if mods > -1 then
          Inc(basicvalue1, 10 + random(20));
        add1 := basicvalue1;
        additem1 := basicvalue1 * 4 div 5;
        if GetPetSkill(1, 3) then
        begin
          add1 := trunc(basicvalue1 * 1.5);
          additem1 := trunc(basicvalue1 * 1.5);
        end
        else if GetPetSkill(1, 1) and (Brole[i].rnum = 0) then
        begin
          add1 := trunc(basicvalue1 * 1.5);
          additem1 := trunc(basicvalue1 * 1.5);
        end;
        Rrole[rnum].Exp := Rrole[rnum].Exp + add1 * (100 + zhiwujc6) div 100;
        Rrole[rnum].Exp := min(Rrole[rnum].Exp, 35000);

        //if not ((Rrole[rnum].PracticeBook >= 0) and (ritem[Rrole[rnum].PracticeBook].Magic >= 0) and (rmagic[ritem[Rrole[rnum].PracticeBook].Magic].MagicType = 5)) then
        //Rrole[rnum].GongtiExam := Rrole[rnum].GongtiExam + add1 * 2 *(100+zhiwujc6)div 500;
        //Rrole[rnum].GongtiExam := min(Rrole[rnum].GongtiExam, 50000);

        Rrole[rnum].ExpForBook := Rrole[rnum].ExpForBook + additem1 * (100 + zhiwujc6) div 100;
        Rrole[rnum].ExpForBook := min(Rrole[rnum].ExpForBook, 30000);
        //    Rrole[rnum].ExpForItem := Rrole[rnum].ExpForItem + basicvalue div 5 * 3;
        DrawRectangle(100, 235, 145, 25, 0, ColColor(255), 25);
        str := '得經驗';
        DrawShadowText(@str[1], 83, 237, ColColor($21), ColColor($23));
        str := format('%5d', [add1]);
        DrawEngShadowText(@str[1], 178, 237, ColColor($64), ColColor($66));
        ShowSimpleStatus(rnum, 30, 50);
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        while (SDL_PollEvent(@event) >= 0) do
        begin
          CheckBasicEvent;
          case event.type_ of
            SDL_KEYUP:
              if event.key.keysym.sym > 0 then break;
            SDL_MOUSEBUTTONUP:
              if event.button.button > 0 then break;
          end;
          if (Rrole[rnum].Poision > 0) or (Rrole[rnum].Hurt > 0) then
          begin
            ShowSimpleStatus(rnum, 30, 50);
            SDL_UpdateRect2(screen, 52, 114 - 77, 58, 60);
          end;
          event.key.keysym.sym := 0;
          event.button.button := 0;
          SDL_Delay(20 + 2 * GameSpeed);
        end;
        event.key.keysym.sym := 0;
        event.button.button := 0;
      end
      else if (Brole[i].Team = 1) then
      begin
        basicvalue2 := Brole[i].ExpGot;
        additem2 := 0;
        if Brole[i].Dead = 0 then
        begin
          if amount2 = 1 then
          begin
            if mods < 0 then Inc(basicvalue2, warsta.exp);
          end
          else if levels2 > 0 then
            Inc(basicvalue2, trunc((1 - Rrole[rnum].Level / levels2) / (amount2 - 1) *
              warsta.exp * (100 + 20 * amount2) / 100));
        end
        else if mods > -1 then
          Inc(basicvalue2, 10 + random(20));

        basicvalue2 := basicvalue2 div 3 + 1; //减慢同门练级速度
        add2 := basicvalue2;
        additem2 := basicvalue2 * 4 div 5;
        if GetPetSkill(1, 3) then
        begin
          add2 := trunc(basicvalue2 * 1.5);
          additem2 := trunc(basicvalue2 * 1.5);
        end
        else if GetPetSkill(1, 1) and (Brole[i].rnum = 0) then
        begin
          add2 := trunc(basicvalue2 * 1.5);
          additem2 := trunc(basicvalue2 * 1.5);
        end;
        Rrole[rnum].Exp := Rrole[rnum].Exp + add2;
        Rrole[rnum].Exp := min(Rrole[rnum].Exp, 35000);

        //if not ((Rrole[rnum].PracticeBook >= 0) and (ritem[Rrole[rnum].PracticeBook].Magic >= 0) and (rmagic[ritem[Rrole[rnum].PracticeBook].Magic].MagicType = 5)) then
        //Rrole[rnum].GongtiExam := Rrole[rnum].GongtiExam + add2 * 2 div 5;
        //Rrole[rnum].GongtiExam := min(Rrole[rnum].GongtiExam, 50000);

        Rrole[rnum].ExpForBook := Rrole[rnum].ExpForBook + additem2;
        //    Rrole[rnum].ExpForItem := Rrole[rnum].ExpForItem + basicvalue div 5 * 3;
      end;
      Redraw;
    end;
  end;
end;

//检查是否能够升级

procedure CheckLevelUp;
var
  i, rnum: integer;
begin
  for i := 0 to length(Brole) - 1 do
  begin
    rnum := Brole[i].rnum;
    if rnum >= 0 then
      while (Rrole[rnum].Level < MAX_LEVEL) and (uint16(Rrole[rnum].Exp) >=
          uint16(LevelUplist[Rrole[rnum].Level - 1])) do
      begin
        Rrole[rnum].Exp := Rrole[rnum].Exp - LevelUplist[Rrole[rnum].Level - 1];
        Rrole[rnum].Level := Rrole[rnum].Level + 1;
        if Brole[i].Team = 0 then
          LevelUp(i)
        else LevelUp2(rnum);
      end;

  end;

end;

//升级, 如是我方人物显示状态

procedure LevelUp(bnum: integer);
var
  i, rnum, add, r: integer;
  str: WideString;
begin
  rnum := Brole[bnum].rnum;
  if rnum >= 0 then
  begin
    r := random(Rrole[rnum].IncLife);
    Rrole[rnum].MaxHP := Rrole[rnum].MaxHP + (170 + 17 * r) div 10;
    if Rrole[rnum].MaxHP > MAX_HP then Rrole[rnum].MaxHP := MAX_HP;
    Rrole[rnum].CurrentHP := Rrole[rnum].MaxHP;

    Rrole[rnum].MaxMP := Rrole[rnum].MaxMP + (340 - 17 * r) div 10;
    if Rrole[rnum].MaxMP > MAX_MP then Rrole[rnum].MaxMP := MAX_MP;
    Rrole[rnum].CurrentMP := Rrole[rnum].MaxMP;

    Rrole[rnum].Attack := Rrole[rnum].Attack + 1;
    Rrole[rnum].Speed := Rrole[rnum].Speed + 1;
    Rrole[rnum].Defence := Rrole[rnum].Defence + 1;

    {if GetRoleMedcine(rnum, false) >= 20 then inc(Rrole[rnum].Medcine, 1);
    if GetRoleUsePoi(rnum, false) >= 20 then inc(Rrole[rnum].UsePoi, 1);
    if GetRoleMedPoi(rnum, false) >= 20 then inc(Rrole[rnum].MedPoi, 1);
    if GetRoleFist(rnum, false) >= 20 then inc(Rrole[rnum].Fist, 1);
    if GetRoleSword(rnum, false) >= 20 then inc(Rrole[rnum].Sword, 1);
    if GetRoleKnife(rnum, false) >= 20 then inc(Rrole[rnum].Knife, 1);
    if GetRoleUnusual(rnum, false) >= 20 then inc(Rrole[rnum].Unusual, 1);
    if GetRoleHidWeapon(rnum, false) >= 20 then inc(Rrole[rnum].HidWeapon, 1);}

    Rrole[rnum].PhyPower := MAX_PHYSICAL_POWER;
    Rrole[rnum].Hurt := 0;
    Rrole[rnum].Poision := 0;
    for i := 43 to 54 do
      Rrole[rnum].Data[i] := min(Rrole[rnum].Data[i], MaxProList[i]);
    if Brole[bnum].Team = 0 then
    begin
      Redraw;
      NewShowStatus(rnum);
      //str := '升級';
      //Drawshadowtext(@str[1], 195, 94, colcolor($21), colcolor($23));
      //SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      //waitanykey;
    end;
  end;

end;
//升级但不显示升级窗口

procedure LevelUp2(rnum: integer);
var
  i, add, r: integer;
  str: WideString;
begin
  if rnum >= 0 then
  begin
    r := random(Rrole[rnum].IncLife);
    Rrole[rnum].MaxHP := Rrole[rnum].MaxHP + (170 + 17 * r) div 10;
    if Rrole[rnum].MaxHP > MAX_HP then Rrole[rnum].MaxHP := MAX_HP;
    Rrole[rnum].CurrentHP := Rrole[rnum].MaxHP;

    Rrole[rnum].MaxMP := Rrole[rnum].MaxMP + (340 - 17 * r) div 10;
    if Rrole[rnum].MaxMP > MAX_MP then Rrole[rnum].MaxMP := MAX_MP;
    Rrole[rnum].CurrentMP := Rrole[rnum].MaxMP;

    Rrole[rnum].Attack := Rrole[rnum].Attack + 1;
    Rrole[rnum].Speed := Rrole[rnum].Speed + 1;
    Rrole[rnum].Defence := Rrole[rnum].Defence + 1;

    {if GetRoleMedcine(rnum, false) >= 20 then inc(Rrole[rnum].Medcine, 1);
    if GetRoleUsePoi(rnum, false) >= 20 then inc(Rrole[rnum].UsePoi, 1);
    if GetRoleMedPoi(rnum, false) >= 20 then inc(Rrole[rnum].MedPoi, 1);
    if GetRoleFist(rnum, false) >= 20 then inc(Rrole[rnum].Fist, 1);
    if GetRoleSword(rnum, false) >= 20 then inc(Rrole[rnum].Sword, 1);
    if GetRoleKnife(rnum, false) >= 20 then inc(Rrole[rnum].Knife, 1);
    if GetRoleUnusual(rnum, false) >= 20 then inc(Rrole[rnum].Unusual, 1);
    if GetRoleHidWeapon(rnum, false) >= 20 then inc(Rrole[rnum].HidWeapon, 1);}

    Rrole[rnum].PhyPower := MAX_PHYSICAL_POWER;
    Rrole[rnum].Hurt := 0;
    Rrole[rnum].Poision := 0;
    for i := 43 to 54 do
      Rrole[rnum].Data[i] := min(Rrole[rnum].Data[i], MaxProList[i]);
    if Rrole[rnum].menpai = Rrole[0].menpai then
    begin
      Redraw;
      //NewShowStatus(rnum);
      str := '【門派公告】' + gbktounicode(@Rrole[rnum].Name) + '升級為' + IntToStr(Rrole[rnum].level) + '級';
      addtips(str);
      //waitanykey;
    end;
    if (Rrole[rnum].TeamState = 1) or (Rrole[rnum].TeamState = 2) then
    begin
      Redraw;
      NewShowStatus(rnum);
    end;
  end;

end;

//检查身上秘笈

procedure CheckBook;
var
  i, i1, i2, Aptitude, p, rnum, inum, mnum, mlevel, needexp, needitem, needitemamount, itemamount: integer;
  str: WideString;

begin

  for i := 0 to length(Brole) - 1 do
  begin
    rnum := Brole[i].rnum;
    if (rnum >= 0) and (rnum < length(Rrole) - 1) then
    begin
      inum := Rrole[rnum].PracticeBook;
      if inum >= 0 then
      begin
        mlevel := 1;
        mnum := Ritem[inum].Magic;
        if mnum > 0 then
          for i1 := 0 to 29 do
            if Rrole[rnum].lMagic[i1] = mnum then
            begin

              mlevel := Rrole[rnum].MagLevel[i1] div 100 + 1;
              break;
            end;
        if CheckEquipSet(Rrole[rnum].equip[0], Rrole[rnum].equip[1], Rrole[rnum].equip[2],
          Rrole[rnum].equip[3]) = 2 then
          Aptitude := 100
        else Aptitude := Rrole[rnum].Aptitude;
        if Ritem[inum].NeedExp > 0 then needexp := mlevel * (Ritem[inum].NeedExp * (800 - Aptitude * 6)) div 200
        else needexp := mlevel * ((-Ritem[inum].NeedExp) * (200 + Aptitude * 6)) div 200;

        while (Rrole[rnum].PracticeBook >= 0) and (Rrole[rnum].ExpForBook >= needexp) and (mlevel < 10) do
        begin
          if ((Rmagic[mnum].MagicType = 5) and (mlevel > 1)) or (mlevel > 2) then break;

          Redraw;
          EatOneItem(rnum, inum, True);

          if mnum > 0 then
          begin
            instruct_33(rnum, mnum, 1);
            str := IntToStr(GetMagicLevel(rnum, mnum) div 100 + 1);
            DrawRectangle(100, 70 - 30, 200, 25, 0, ColColor(255), 25);

            DrawShadowText(@str[1], 240, 72 - 30, ColColor($64), ColColor($66));
            str := '升為   級';
            DrawShadowText(@str[1], 183, 72 - 30, ColColor($21), ColColor($23));
            Drawgbkshadowtext(@Rmagic[mnum].Name, 83, 72 - 30, ColColor($64), ColColor($66));
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            WaitAnyKey;


            mlevel := GetMagicLevel(rnum, mnum) div 100 + 1;


            Redraw;
          end;
          Rrole[rnum].ExpForBook := Rrole[rnum].ExpForBook - needexp;
          if Ritem[inum].NeedExp > 0 then needexp := mlevel * (Ritem[inum].NeedExp * (800 - Aptitude * 6)) div 200
          else needexp := mlevel * ((-Ritem[inum].NeedExp) * (200 + Aptitude * 6)) div 200;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          //ShowStatus(rnum);
          //waitanykey;
          if (GetMagicLevel(rnum, mnum) >= 100) or (Rmagic[mnum].MagicType = 5) then
          begin
            Rrole[rnum].PracticeBook := -1;
            instruct_32(inum, 1);
            break;
          end;
        end;
      end;
    end;
  end;

end;

//统计一方人数

function CalRNum(team: integer): integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].rnum > -1) and (Brole[i].Team = team) and (Brole[i].Dead = 0) then Result := Result + 1;
  end;

end;

//战斗中物品选单

procedure BattleMenuItem(bnum: integer);
var
  rnum, inum, mode, i: integer;
  str: WideString;
begin
  CurItem := -1;
  MenuItem(3);
  inum := CurItem;
  if inum < 0 then exit;
  rnum := Brole[bnum].rnum;
  mode := Ritem[inum].ItemType;
  case mode of
    3:
    begin
      Ax := Brole[bnum].X;
      Ay := Brole[bnum].Y;
      if Ritem[inum].EventNum <= 0 then
      begin
        Redraw;
        EatOneItem(rnum, inum, True);
        instruct_32(inum, -1);
        Brole[bnum].Acted := 1;
        WaitAnyKey;
        Brole[bnum].Progress := Brole[bnum].Progress - 240;
        Brole[bnum].zhuangtai[0] := min(100, Brole[bnum].zhuangtai[0] + 1 +
          Rrole[Brole[bnum].rnum].CurrentMP * (50 + Brole[bnum].zhuangtai[0]) div 100000);
        Brole[bnum].zhuangtai[1] := min(100, Brole[bnum].zhuangtai[1] + 1 +
          GetRoleDefence(Brole[bnum].rnum, True) * (50 + Brole[bnum].zhuangtai[1]) div 10000);
        Brole[bnum].zhuangtai[2] := min(100, Brole[bnum].zhuangtai[2] + 1 +
          GetRoleSpeed(Brole[bnum].rnum, True) * (50 + Brole[bnum].zhuangtai[2]) div 10000);
        Brole[bnum].zhuangtai[3] := min(100, Brole[bnum].zhuangtai[3] + 1 +
          Rrole[Brole[bnum].rnum].CurrentHP * (50 + Brole[bnum].zhuangtai[3]) div 100000);
        Brole[bnum].zhuangtai[4] := min(100, Brole[bnum].zhuangtai[4] + 1 +
          GetRoleAttack(Brole[bnum].rnum, True) * (50 + Brole[bnum].zhuangtai[4]) div 10000);
        for i := 0 to Brole[bnum].Zhuanzhu - 1 do
        begin
          Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i + 2));
          Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] -
            round((i + 2) / 3 * 10));
          Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] -
            round((i + 2) / 3 * 10));
          Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] -
            round((i + 2) / 3 * 10));
          Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] -
            round((i + 2) / 3 * 5));
        end;
        Brole[bnum].Zhuanzhu := 0;
      end
      else
      begin
        if Ritem[inum].EventNum > 0 then CallEvent(Ritem[inum].EventNum);
      end;
    end;
    4:
    begin
      UseHiddenWeapen(bnum, inum);
    end;
  end;
end;

//动作动画

procedure PlayActionAmination(bnum, mode: integer);
var
  d1, d2, dm, rnum, i, i1, i2, Count, grp, beginpic, endpic, idx, tnum, len, x, y: integer;
  filename, fn, modestr, rolestr: string;
begin

  d1 := Ax - Bx;
  d2 := Ay - By;
  dm := abs(d1) - abs(d2);
  if (dm > 0) then
    if d1 < 0 then Brole[bnum].Face := 0 else Brole[bnum].Face := 3
  else if (dm < 0) then
    if d2 < 0 then Brole[bnum].Face := 2 else Brole[bnum].Face := 1;

  Redraw;
  rnum := Brole[bnum].rnum;

  rolestr := format('%3d', [Rrole[rnum].HeadNum]);
  for i := 1 to length(rolestr) do
    if rolestr[i] = ' ' then rolestr[i] := '0';

  modestr := format('%2d', [mode]);
  for i := 1 to length(modestr) do
    if modestr[i] = ' ' then modestr[i] := '0';

  filename := 'fight\' + rolestr + '\' + modestr;

  if ((BShowBWord.sign and 1) > 0) and (BShowBWord.delay[0] > 1) then
  begin

    bshowbword.sign := bshowbword.sign and $FE;
    DrawRectangle(CENTER_X - 12 * length(BShowBWord.words[0]) + 20, 70 - 30, 50, 25, 0, ColColor(255), 25);
    DrawShadowText(@BShowBWord.words[0][1], CENTER_X - 12 * length(BShowBWord.words[0]) + 5,
      72 - 30, ColColor($21), ColColor($23));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay((5 + GameSpeed) * 2 * bshowbword.delay[0]);

  end;


  if ((BShowBWord.sign and (1 shl 1)) > 0) and (BShowBWord.delay[1] > 10) then
  begin
    x := -(Brole[bnum].X - Bx) * 18 + (Brole[bnum].Y - By) * 18 + CENTER_X - 10;
    y := (Brole[bnum].X - Bx) * 9 + (Brole[bnum].Y - By) * 9 + CENTER_Y - 70;
    DrawShadowText(@BShowBWord.words[1][1], x - 80, y + (i - beginpic) * 2, ColColor($23), ColColor($21));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay((5 + GameSpeed div 2)*(BShowBWord.delay[1]-10));
    BShowBWord.delay[1]:=10;
  end;


  if ((BShowBWord.sign and (1 shl 2)) > 0) and (BShowBWord.delay[2] > 10) then
  begin
    x := -(Brole[bnum].X - Bx) * 18 + (Brole[bnum].Y - By) * 18 + CENTER_X - 10;
    y := (Brole[bnum].X - Bx) * 9 + (Brole[bnum].Y - By) * 9 + CENTER_Y - 90;
    DrawShadowText(@BShowBWord.words[2][1], x - 30, y + (i - beginpic) * 2, ColColor(0, $10), ColColor(0, $14));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay((5 + GameSpeed div 2)*(BShowBWord.delay[2]-10));
    BShowBWord.delay[2]:=10;
  end;


  while ((BShowBWord.sign and (1 shl 3)) > 0) and (BShowBWord.delay[3] > 10) do
  begin
    x := -(Brole[bnum].X - Bx) * 18 + (Brole[bnum].Y - By) * 18 + CENTER_X - 10;
    y := (Brole[bnum].X - Bx) * 9 + (Brole[bnum].Y - By) * 9 + CENTER_Y - 90;
    DrawShadowText(@BShowBWord.words[3][1], x - 30, y + (i - beginpic) * 2, ColColor(0, $30), ColColor(0, $32));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay((5 + GameSpeed div 2)*(BShowBWord.delay[3]-10));
    BShowBWord.delay[3]:=10;
  end;


  if (FileExists(filename + '.pic')) then
  begin
    grp := FileOpen(filename + '.pic', fmopenread);
    FileSeek(grp, 0, 0);
    FileRead(grp, Count, 4);

    beginpic := Brole[bnum].Face * (Count div 4);
    endpic := beginpic + (Count div 4) - 1;

    for i := beginpic to endpic do
    begin
      SDL_PollEvent(@event);
      DrawBFieldWithAction(grp, bnum, i);
      if ((BShowBWord.sign and (1 shl 1)) > 0) then
      begin
        x := -(Brole[bnum].X - Bx) * 18 + (Brole[bnum].Y - By) * 18 + CENTER_X - 10;
        y := (Brole[bnum].X - Bx) * 9 + (Brole[bnum].Y - By) * 9 + CENTER_Y - 70;
        if (BShowBWord.delay[1] > 0) then
        begin
          Dec(BShowBWord.delay[1]);
          DrawShadowText(@BShowBWord.words[1][1], x - 80, y + (i - beginpic) * 2, ColColor($23), ColColor($21));
        end
        else
          BShowBWord.sign := BShowBWord.sign and $FD;
      end;
      if ((BShowBWord.sign and (1 shl 2)) > 0) then
      begin

        x := -(Brole[bnum].X - Bx) * 18 + (Brole[bnum].Y - By) * 18 + CENTER_X - 10;
        y := (Brole[bnum].X - Bx) * 9 + (Brole[bnum].Y - By) * 9 + CENTER_Y - 90;
        if (BShowBWord.delay[2] > 0) then
        begin
          Dec(BShowBWord.delay[2]);
          DrawShadowText(@BShowBWord.words[2][1], x - 30, y + (i - beginpic) * 2, ColColor(0, $10), ColColor(0, $14));
        end
        else
          BShowBWord.sign := BShowBWord.sign and $FB;
      end;
      if ((BShowBWord.sign and (1 shl 3)) > 0) then
      begin
        x := -(Brole[bnum].X - Bx) * 18 + (Brole[bnum].Y - By) * 18 + CENTER_X - 10;
        y := (Brole[bnum].X - Bx) * 9 + (Brole[bnum].Y - By) * 9 + CENTER_Y - 90;
        if (BShowBWord.delay[3] > 0) then
        begin
          Dec(BShowBWord.delay[3]);
          DrawShadowText(@BShowBWord.words[3][1], x - 30, y + (i - beginpic) * 2, ColColor(0, $30), ColColor(0, $32));
        end
        else
          BShowBWord.sign := BShowBWord.sign and $F7;
      end;
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      SDL_Delay(5 + GameSpeed div 2);
    end;
    FileClose(grp);
  end
  else
  begin
    for i1 := 0 to 4 do
    begin
      modestr := format('%2d', [i1]);
      for i := 1 to length(modestr) do
        if modestr[i] = ' ' then modestr[i] := '0';
      filename := 'fight\' + rolestr + '\' + modestr;
      if (FileExists(filename + '.pic')) then
      begin
        grp := FileOpen(filename + '.pic', fmopenread);
        FileSeek(grp, 0, 0);
        FileRead(grp, Count, 4);
        beginpic := Brole[bnum].Face * (Count div 4);
        endpic := beginpic + (Count div 4) - 1;
        for i := beginpic to endpic do
        begin
          SDL_PollEvent(@event);
          DrawBFieldWithAction(grp, bnum, i);
          if ((BShowBWord.sign and (1 shl 1)) > 0) then
          begin
            x := -(Brole[bnum].X - Bx) * 18 + (Brole[bnum].Y - By) * 18 + CENTER_X - 10;
            y := (Brole[bnum].X - Bx) * 9 + (Brole[bnum].Y - By) * 9 + CENTER_Y - 70;
            if (BShowBWord.delay[1] > 0) then
            begin
              Dec(BShowBWord.delay[1]);

              DrawShadowText(@BShowBWord.words[1][1], x - 80, y + (i - beginpic) * 2, ColColor($23), ColColor($21));

            end
            else
              BShowBWord.sign := BShowBWord.sign and $FD;
          end;
          if ((BShowBWord.sign and (1 shl 2)) > 0) then
          begin

            x := -(Brole[bnum].X - Bx) * 18 + (Brole[bnum].Y - By) * 18 + CENTER_X - 10;
            y := (Brole[bnum].X - Bx) * 9 + (Brole[bnum].Y - By) * 9 + CENTER_Y - 90;
            if (BShowBWord.delay[2] > 0) then
            begin
              Dec(BShowBWord.delay[2]);
              DrawShadowText(@BShowBWord.words[2][1], x - 30, y + (i - beginpic) * 2,
                ColColor(0, $10), ColColor(0, $14));
            end
            else
              BShowBWord.sign := BShowBWord.sign and $FB;
          end;
          if ((BShowBWord.sign and (1 shl 3)) > 0) then
          begin
            x := -(Brole[bnum].X - Bx) * 18 + (Brole[bnum].Y - By) * 18 + CENTER_X - 10;
            y := (Brole[bnum].X - Bx) * 9 + (Brole[bnum].Y - By) * 9 + CENTER_Y - 90;
            if (BShowBWord.delay[3] > 0) then
            begin
              Dec(BShowBWord.delay[3]);
              DrawShadowText(@BShowBWord.words[3][1], x - 30, y + (i - beginpic) * 2,
                ColColor(0, $30), ColColor(0, $32));
            end
            else
              BShowBWord.sign := BShowBWord.sign and $F7;
          end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 + GameSpeed div 2);
        end;
        FileClose(grp);
        break;
      end;
    end;
  end;
end;

//用毒

procedure UsePoision(bnum: integer);
var
  rnum, bnum1, rnum1, poi, step, addpoi, i: integer;
  select: boolean;
begin
  rnum := Brole[bnum].rnum;
  poi := GetRoleUsePoi(rnum, True);
  step := poi div 15 + 1;
  CalCanSelect(bnum, 1, step);
  if (Brole[bnum].Team = 0) and (Brole[bnum].Auto = -1) then
    select := SelectAim(bnum, step,0);
  if (bfield[2, Ax, Ay] >= 0) and (select = True) then
  begin
    bnum1 := bfield[2, Ax, Ay];
    if Brole[bnum1].Team <> Brole[bnum].Team then
    begin
      //转换伤害对象  4 乾坤大挪移 5斗转星移
      if GetEquipState(Brole[bnum1].rnum, 4) or (GetGongtiState(Brole[bnum1].rnum, 4)) then
        bnum1 := ReMoveHurt(bnum1, bnum);
      if GetEquipState(Brole[bnum1].rnum, 5) or (GetGongtiState(Brole[bnum1].rnum, 5)) then
        bnum1 := RetortHurt(bnum1, bnum);
      Brole[bnum].Acted := 1;
      if (not GetEquipState(rnum, 1)) and (not GetGongtiState(rnum, 1)) then
        Rrole[rnum].PhyPower := Rrole[rnum].PhyPower - 3;
      rnum1 := Brole[bnum1].rnum;
      addpoi := GetRoleUsePoi(rnum, True) div 3 - GetRoleDefPoi(rnum1, True) div 4;
      if addpoi < 0 then addpoi := 0;
      addpoi := min(addpoi, GetRoleUsePoi(rnum, True) - Rrole[rnum1].Poision);

      if Brole[bnum].Team = 0 then
        addpoi := addpoi * (200 - Rrole[0].difficulty) div 200;
      if Brole[bnum].Team = 1 then
        addpoi := addpoi * (200 + Rrole[0].difficulty) div 200;

      //      if brole[bnum1].PerfectDodge > 0 then addpoi := 0;

      if GetGongtiState(Brole[bnum1].rnum, 12) or GetEquipState(Brole[bnum1].rnum, 12) or
        (CheckEquipSet(Rrole[Brole[bnum1].rnum].equip[0], Rrole[Brole[bnum1].rnum].equip[1],
        Rrole[Brole[bnum1].rnum].equip[2], Rrole[Brole[bnum1].rnum].equip[3]) = 4) then
        addpoi := 0;

      if addpoi > 0 then Inc(Brole[bnum].ExpGot, max(0, addpoi div 5));

      Rrole[rnum1].Poision := Rrole[rnum1].Poision + addpoi;
      Brole[bnum1].ShowNumber := addpoi;
      SetAminationPosition(0, 0, 0);
      playsoundE(34, 0);
      PlayActionAmination(bnum, 0);
      PlayMagicAmination(bnum, 0, 34, 0);
      ShowHurtValue(2);
      Brole[bnum].Progress := Brole[bnum].Progress - 240;
      Brole[bnum].zhuangtai[0] := min(100, Brole[bnum].zhuangtai[0] + 1 + Rrole[Brole[bnum].rnum].CurrentMP *
        (50 + Brole[bnum].zhuangtai[0]) div 100000);
      Brole[bnum].zhuangtai[1] := min(100, Brole[bnum].zhuangtai[1] + 1 + GetRoleDefence(Brole[bnum].rnum, True) *
        (50 + Brole[bnum].zhuangtai[1]) div 10000);
      Brole[bnum].zhuangtai[2] := min(100, Brole[bnum].zhuangtai[2] + 1 + GetRoleSpeed(Brole[bnum].rnum, True) *
        (50 + Brole[bnum].zhuangtai[2]) div 10000);
      Brole[bnum].zhuangtai[3] := min(100, Brole[bnum].zhuangtai[3] + 1 + Rrole[Brole[bnum].rnum].CurrentHP *
        (50 + Brole[bnum].zhuangtai[3]) div 100000);
      Brole[bnum].zhuangtai[4] := min(100, Brole[bnum].zhuangtai[4] + 1 + GetRoleAttack(Brole[bnum].rnum, True) *
        (50 + Brole[bnum].zhuangtai[4]) div 10000);
      for i := 0 to Brole[bnum].Zhuanzhu - 1 do
      begin
        Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i + 2));
        Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] - round((i + 2) / 3 * 10));
        Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] - round((i + 2) / 3 * 10));
        Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] - round((i + 2) / 3 * 10));
        Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] - round((i + 2) / 3 * 5));
      end;
      Brole[bnum].Zhuanzhu := 0;
    end;
  end;
end;

//医疗

procedure Medcine(bnum: integer);
var
  rnum, bnum1, rnum1, med, step, i, addlife: integer;
  select: boolean;
begin
  rnum := Brole[bnum].rnum;
  med := GetRoleMedcine(rnum, True);
  step := med div 15 + 1;
  select := True;
  CalCanSelect(bnum, 1, step);
  if (Brole[bnum].Team = 0) and (Brole[bnum].Auto = -1) then
    select := SelectAim(bnum, step,0)
  else
  begin
    Ax := Bx;
    Ay := By;
  end;
  if (bfield[2, Ax, Ay] >= 0) and (select = True) then
  begin
    bnum1 := bfield[2, Ax, Ay];
    if Brole[bnum1].Team = Brole[bnum].Team then
    begin
      Brole[bnum].Acted := 1;
      if (not GetEquipState(rnum, 1)) and (not GetGongtiState(rnum, 1)) then
        Rrole[rnum].PhyPower := Rrole[rnum].PhyPower - 5;
      rnum1 := Brole[bnum1].rnum;
      addlife := GetRoleMedcine(rnum, True) * (10 - Rrole[rnum1].Hurt div 8) div 5; //calculate the value
      if Rrole[rnum1].Hurt - GetRoleMedcine(rnum, True) > 20 then addlife := 0;
      if addlife < 0 then addlife := 0;
      addlife := min(addlife, Rrole[rnum1].MaxHP - Rrole[rnum1].CurrentHP);

      if addlife > 0 then Inc(Brole[bnum].ExpGot, max(0, addlife div 5));
      Inc(Brole[bnum].ExpGot, max(0, addlife div 10));

      Rrole[rnum1].CurrentHP := Rrole[rnum1].CurrentHP + addlife;
      Rrole[rnum1].Hurt := Rrole[rnum1].Hurt - (addlife + 10) div LIFE_HURT;
      if Rrole[rnum1].Hurt < 0 then Rrole[rnum1].Hurt := 0;
      Brole[bnum1].ShowNumber := addlife;
      SetAminationPosition(0, 0, 0);
      if getpetskill(5, 2) then
      begin
        for i := 0 to length(Brole) - 1 do
        begin
          if (Brole[i].Dead = 0) and (Brole[i].rnum >= 0) and (i <> bnum1) and
            (Brole[i].Team = Brole[bnum1].Team) and (Brole[i].X in [Brole[bnum1].X -
            3..Brole[bnum1].X + 3]) and (Brole[i].Y in [Brole[bnum1].Y - 3..Brole[bnum1].Y + 3]) then
          begin
            addlife := 0;
            rnum1 := Brole[i].rnum;
            addlife := GetRoleMedcine(rnum, True) * (10 - Rrole[rnum1].Hurt div 8) div 5; //calculate the value
            if Rrole[rnum1].Hurt - GetRoleMedcine(rnum, True) > 20 then addlife := 0;
            if addlife < 0 then addlife := 0;
            addlife := min(addlife, Rrole[rnum1].MaxHP - Rrole[rnum1].CurrentHP);

            if addlife > 0 then Inc(Brole[bnum].ExpGot, max(0, addlife div 10));

            Rrole[rnum1].CurrentHP := Rrole[rnum1].CurrentHP + addlife;
            Rrole[rnum1].Hurt := Rrole[rnum1].Hurt - (addlife + 10) div LIFE_HURT;
            if Rrole[rnum1].Hurt < 0 then Rrole[rnum1].Hurt := 0;
            Brole[i].ShowNumber := addlife;

            Bfield[4, Brole[i].X, Brole[i].Y] := 1;
          end;
        end;
      end;
      playsoundE(31, 0);
      PlayActionAmination(bnum, 0);
      PlayMagicAmination(bnum, 0, 31, 0);
      ShowHurtValue(3);
      Brole[bnum].Progress := Brole[bnum].Progress - 240;
      Brole[bnum].zhuangtai[0] := min(100, Brole[bnum].zhuangtai[0] + 1 + Rrole[Brole[bnum].rnum].CurrentMP *
        (50 + Brole[bnum].zhuangtai[0]) div 100000);
      Brole[bnum].zhuangtai[1] := min(100, Brole[bnum].zhuangtai[1] + 1 + GetRoleDefence(Brole[bnum].rnum, True) *
        (50 + Brole[bnum].zhuangtai[1]) div 10000);
      Brole[bnum].zhuangtai[2] := min(100, Brole[bnum].zhuangtai[2] + 1 + GetRoleSpeed(Brole[bnum].rnum, True) *
        (50 + Brole[bnum].zhuangtai[2]) div 10000);
      Brole[bnum].zhuangtai[3] := min(100, Brole[bnum].zhuangtai[3] + 1 + Rrole[Brole[bnum].rnum].CurrentHP *
        (50 + Brole[bnum].zhuangtai[3]) div 100000);
      Brole[bnum].zhuangtai[4] := min(100, Brole[bnum].zhuangtai[4] + 1 + GetRoleAttack(Brole[bnum].rnum, True) *
        (50 + Brole[bnum].zhuangtai[4]) div 10000);
      for i := 0 to Brole[bnum].Zhuanzhu - 1 do
      begin
        Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i + 2));
        Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] - round((i + 2) / 3 * 10));
        Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] - round((i + 2) / 3 * 10));
        Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] - round((i + 2) / 3 * 10));
        Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] - round((i + 2) / 3 * 5));
      end;
      Brole[bnum].Zhuanzhu := 0;
    end;
  end;
end;

//解穴

procedure MedFrozen(bnum: integer);
var
  rnum, bnum1, rnum1, med, step, addlife, i: integer;
  select: boolean;
begin
  rnum := Brole[bnum].rnum;
  med := Rrole[rnum].CurrentMP;
  step := med div 200 + 1;
  CalCanSelect(bnum, 1, step);
  if (Brole[bnum].Team = 0) and (Brole[bnum].Auto = -1) then
    select := SelectAim(bnum, step,0)
  else
  begin
    Ax := Bx;
    Ay := By;
  end;
  if (bfield[2, Ax, Ay] >= 0) and (select = True) then
  begin
    bnum1 := bfield[2, Ax, Ay];
    if Brole[bnum1].Team = Brole[bnum].Team then
    begin
      Brole[bnum].Acted := 1;
      if (not GetEquipState(rnum, 1)) and (not GetGongtiState(rnum, 1)) then
        Rrole[rnum].PhyPower := Rrole[rnum].PhyPower - 5;
      rnum1 := Brole[bnum1].rnum;
      addlife := min((Rrole[rnum].CurrentMP + GetRoleMedcine(rnum, True) * 5) div 30, Brole[bnum1].frozen);
      Dec(Brole[bnum1].frozen, addlife);
      Brole[bnum1].frozen := max(0, Brole[bnum1].frozen);
      Brole[bnum1].ShowNumber := addlife;
      SetAminationPosition(0, 0, 0);
      playsoundE(32, 0);
      PlayActionAmination(bnum, 0);
      PlayMagicAmination(bnum, 0, 32, 0);
      ShowHurtValue(4);
      Brole[bnum].Progress := Brole[bnum].Progress - 240;
      Brole[bnum].zhuangtai[0] := min(100, Brole[bnum].zhuangtai[0] + 1 + Rrole[Brole[bnum].rnum].CurrentMP *
        (50 + Brole[bnum].zhuangtai[0]) div 100000);
      Brole[bnum].zhuangtai[1] := min(100, Brole[bnum].zhuangtai[1] + 1 + GetRoleDefence(Brole[bnum].rnum, True) *
        (50 + Brole[bnum].zhuangtai[1]) div 10000);
      Brole[bnum].zhuangtai[2] := min(100, Brole[bnum].zhuangtai[2] + 1 + GetRoleSpeed(Brole[bnum].rnum, True) *
        (50 + Brole[bnum].zhuangtai[2]) div 10000);
      Brole[bnum].zhuangtai[3] := min(100, Brole[bnum].zhuangtai[3] + 1 + Rrole[Brole[bnum].rnum].CurrentHP *
        (50 + Brole[bnum].zhuangtai[3]) div 100000);
      Brole[bnum].zhuangtai[4] := min(100, Brole[bnum].zhuangtai[4] + 1 + GetRoleAttack(Brole[bnum].rnum, True) *
        (50 + Brole[bnum].zhuangtai[4]) div 10000);
      for i := 0 to Brole[bnum].Zhuanzhu - 1 do
      begin
        Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i + 2));
        Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] - round((i + 2) / 3 * 10));
        Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] - round((i + 2) / 3 * 10));
        Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] - round((i + 2) / 3 * 10));
        Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] - round((i + 2) / 3 * 5));
      end;
      Brole[bnum].Zhuanzhu := 0;
    end;
  end;
end;



//解毒

procedure MedPoision(bnum: integer);
var
  rnum, bnum1, i, rnum1, medpoi, step, minuspoi: integer;
  select: boolean;
begin
  rnum := Brole[bnum].rnum;
  medpoi := GetRoleMedPoi(rnum, True);
  step := medpoi div 15 + 1;
  CalCanSelect(bnum, 1, step);
  if (Brole[bnum].Team = 0) and (Brole[bnum].Auto = -1) then
    select := SelectAim(bnum, step,0)
  else
  begin
    Ax := Bx;
    Ay := By;
  end;
  if (bfield[2, Ax, Ay] >= 0) and (select = True) then
  begin
    bnum1 := bfield[2, Ax, Ay];
    if Brole[bnum1].Team = Brole[bnum].Team then
    begin
      Brole[bnum].Acted := 1;
      if (not GetEquipState(rnum, 1)) and (not GetGongtiState(rnum, 1)) then
        Rrole[rnum].PhyPower := Rrole[rnum].PhyPower - 5;
      rnum1 := Brole[bnum1].rnum;
      minuspoi := GetRoleMedPoi(rnum, True);

      if minuspoi < (Rrole[rnum1].Poision div 2) then
        minuspoi := 0
      else if minuspoi > Rrole[rnum1].Poision then
        minuspoi := Rrole[rnum1].Poision;

      if minuspoi < 0 then minuspoi := 0;
      minuspoi := min(minuspoi, Rrole[rnum1].Poision);
      if minuspoi > 0 then Inc(Brole[bnum].ExpGot, max(0, minuspoi div 5));

      Rrole[rnum1].Poision := Rrole[rnum1].Poision - minuspoi;
      Brole[bnum1].ShowNumber := minuspoi;
      SetAminationPosition(0, 0, 0);
      if getpetskill(5, 2) then
      begin
        for i := 0 to length(Brole) - 1 do
        begin
          if (Brole[i].Dead = 0) and (Brole[i].rnum >= 0) and (i <> bnum1) and
            (Brole[i].Team = Brole[bnum1].Team) and (Brole[i].X in [Brole[bnum1].X -
            3..Brole[bnum1].X + 3]) and (Brole[i].Y in [Brole[bnum1].Y - 3..Brole[bnum1].Y + 3]) then
          begin
            rnum1 := Brole[i].rnum;
            minuspoi := GetRoleMedPoi(rnum, True);

            if minuspoi < (Rrole[rnum1].Poision div 2) then
              minuspoi := 0
            else if minuspoi > Rrole[rnum1].Poision then
              minuspoi := Rrole[rnum1].Poision;

            if minuspoi < 0 then minuspoi := 0;
            minuspoi := min(minuspoi, Rrole[rnum1].Poision);
            if minuspoi > 0 then Inc(Brole[bnum].ExpGot, max(0, minuspoi div 5));

            Rrole[rnum1].Poision := Rrole[rnum1].Poision - minuspoi;
            Brole[i].ShowNumber := minuspoi;

            Bfield[4, Brole[i].X, Brole[i].Y] := 1;
          end;
        end;
      end;
      playsoundE(33, 0);
      PlayActionAmination(bnum, 0);
      PlayMagicAmination(bnum, 0, 33, 0);
      ShowHurtValue(4);
      Brole[bnum].Progress := Brole[bnum].Progress - 240;
      Brole[bnum].zhuangtai[0] := min(100, Brole[bnum].zhuangtai[0] + 1 + Rrole[Brole[bnum].rnum].CurrentMP *
        (50 + Brole[bnum].zhuangtai[0]) div 100000);
      Brole[bnum].zhuangtai[1] := min(100, Brole[bnum].zhuangtai[1] + 1 + GetRoleDefence(Brole[bnum].rnum, True) *
        (50 + Brole[bnum].zhuangtai[1]) div 10000);
      Brole[bnum].zhuangtai[2] := min(100, Brole[bnum].zhuangtai[2] + 1 + GetRoleSpeed(Brole[bnum].rnum, True) *
        (50 + Brole[bnum].zhuangtai[2]) div 10000);
      Brole[bnum].zhuangtai[3] := min(100, Brole[bnum].zhuangtai[3] + 1 + Rrole[Brole[bnum].rnum].CurrentHP *
        (50 + Brole[bnum].zhuangtai[3]) div 100000);
      Brole[bnum].zhuangtai[4] := min(100, Brole[bnum].zhuangtai[4] + 1 + GetRoleAttack(Brole[bnum].rnum, True) *
        (50 + Brole[bnum].zhuangtai[4]) div 10000);
      for i := 0 to Brole[bnum].Zhuanzhu - 1 do
      begin
        Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i + 2));
        Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] - round((i + 2) / 3 * 10));
        Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] - round((i + 2) / 3 * 10));
        Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] - round((i + 2) / 3 * 10));
        Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] - round((i + 2) / 3 * 5));
      end;
      Brole[bnum].Zhuanzhu := 0;
    end;
  end;
end;

//使用暗器

procedure UseHiddenWeapen(bnum, inum: integer);
var
  rnum, i, bnum1, rnum1, hidden, step, poi, hurt: integer;
  select: boolean;
begin
  rnum := Brole[bnum].rnum;
  hidden := GetRoleHidWeapon(rnum, True);
  step := hidden div 15 + 1;

  if (GetEquipState(Brole[bnum].rnum, 24)) or (GetGongtiState(Brole[bnum].rnum, 24)) then
    Inc(step);

  CalCanSelect(bnum, 1, step);
  if Ritem[inum].EventNum > 0 then
    CallEvent(Ritem[inum].EventNum)
  else
  begin
    event.key.keysym.sym := 0;
    event.button.button := 0;
    if (Brole[bnum].Team = 0) and (Brole[bnum].Auto = -1) then
      select := SelectAim(bnum, step,0);
    if (bfield[2, Ax, Ay] >= 0) and (select = True) and (Brole[bfield[2, Ax, Ay]].Team <> 0) then
    begin

      bnum1 := bfield[2, Ax, Ay];
      if Brole[bnum1].Team <> Brole[bnum].Team then
      begin
        Brole[bnum].Acted := 1;
        instruct_32(inum, -1);
        rnum1 := Brole[bnum1].rnum;


        hurt := -(hidden * Ritem[inum].AddCurrentHP) div 100;
        hurt := max(hurt, 25);

        if Brole[bnum].Team = 0 then
          hurt := hurt * (200 - Rrole[0].difficulty) div 200;
        if Brole[bnum].Team = 1 then
          hurt := hurt * (200 + Rrole[0].difficulty) div 200;

        Rrole[rnum1].CurrentHP := Rrole[rnum1].CurrentHP - hurt;
        poi := max(0, (hidden * Ritem[inum].AddPoi) div 100 - GetRoleDefPoi(rnum1, True));

        if Brole[bnum].Team = 0 then
          poi := poi * (200 - Rrole[0].difficulty) div 200;
        if Brole[bnum].Team = 1 then
          poi := poi * (200 + Rrole[0].difficulty) div 200;

        if GetGongtiState(Brole[bnum1].rnum, 12) or GetEquipState(Brole[bnum1].rnum, 12) or
          (CheckEquipSet(Rrole[Brole[bnum1].rnum].equip[0], Rrole[Brole[bnum1].rnum].equip[1],
          Rrole[Brole[bnum1].rnum].equip[2], Rrole[Brole[bnum1].rnum].equip[3]) = 4) then
          poi := 0;

        Rrole[rnum1].Poision := Rrole[rnum1].Poision + poi;


        Brole[bnum1].ShowNumber := hurt;
        SetAminationPosition(0, 0, 0);
        playsoundE(Ritem[inum].AmiNum, 0);
        PlayActionAmination(bnum, 0);
        PlayMagicAmination(bnum, 0, Ritem[inum].AmiNum, 0);
        ShowHurtValue(0);
        Brole[bnum].Progress := Brole[bnum].Progress - 240;
        ClearDeadRolePic;
        Brole[bnum].zhuangtai[0] := min(100, Brole[bnum].zhuangtai[0] + 1 + Rrole[Brole[bnum].rnum].CurrentMP *
          (50 + Brole[bnum].zhuangtai[0]) div 100000);
        Brole[bnum].zhuangtai[1] := min(100, Brole[bnum].zhuangtai[1] + 1 +
          GetRoleDefence(Brole[bnum].rnum, True) * (50 + Brole[bnum].zhuangtai[1]) div 10000);
        Brole[bnum].zhuangtai[2] := min(100, Brole[bnum].zhuangtai[2] + 1 +
          GetRoleSpeed(Brole[bnum].rnum, True) * (50 + Brole[bnum].zhuangtai[2]) div 10000);
        Brole[bnum].zhuangtai[3] := min(100, Brole[bnum].zhuangtai[3] + 1 + Rrole[Brole[bnum].rnum].CurrentHP *
          (50 + Brole[bnum].zhuangtai[3]) div 100000);
        Brole[bnum].zhuangtai[4] := min(100, Brole[bnum].zhuangtai[4] + 1 +
          GetRoleAttack(Brole[bnum].rnum, True) * (50 + Brole[bnum].zhuangtai[4]) div 10000);
        for i := 0 to Brole[bnum].Zhuanzhu - 1 do
        begin
          Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i + 2));
          Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] -
            round((i + 2) / 3 * 10));
          Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] -
            round((i + 2) / 3 * 10));
          Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] -
            round((i + 2) / 3 * 10));
          Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] -
            round((i + 2) / 3 * 5));
        end;
        Brole[bnum].Zhuanzhu := 0;
      end;
    end;
  end;

end;

//休息

procedure Rest(bnum: integer);
var
  rnum, i: integer;
begin
  Brole[bnum].Acted := 1;
  rnum := Brole[bnum].rnum;

  Rrole[rnum].CurrentHP := Rrole[rnum].CurrentHP + ((100 - Rrole[rnum].Hurt) * Rrole[rnum].MaxHP) div 2000;
  if Rrole[rnum].CurrentHP > Rrole[rnum].MaxHP then Rrole[rnum].CurrentHP := Rrole[rnum].MaxHP;

  Rrole[rnum].CurrentMP := Rrole[rnum].CurrentMP + ((100 - Rrole[rnum].Hurt) * Rrole[rnum].MaxMP) div 2000;
  if Rrole[rnum].CurrentMP > Rrole[rnum].MaxMP then Rrole[rnum].CurrentMP := Rrole[rnum].MaxMP;
  Rrole[rnum].PhyPower := Rrole[rnum].PhyPower + ((100 - Rrole[rnum].Hurt) * MAX_PHYSICAL_POWER) div 2000;
  if Rrole[rnum].PhyPower > MAX_PHYSICAL_POWER then Rrole[rnum].PhyPower := MAX_PHYSICAL_POWER;
  Brole[bnum].Progress := Brole[bnum].Progress - 300;

  Brole[bnum].zhuangtai[0] := min(100, Brole[bnum].zhuangtai[0] + 2 + Rrole[Brole[bnum].rnum].CurrentMP *
    (50 + Brole[bnum].zhuangtai[0]) div 50000);
  Brole[bnum].zhuangtai[1] := min(100, Brole[bnum].zhuangtai[1] + 2 + GetRoleDefence(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[1]) div 5000);
  Brole[bnum].zhuangtai[2] := min(100, Brole[bnum].zhuangtai[2] + 2 + GetRoleSpeed(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[2]) div 5000);
  Brole[bnum].zhuangtai[3] := min(100, Brole[bnum].zhuangtai[3] + 2 + Rrole[Brole[bnum].rnum].CurrentHP *
    (50 + Brole[bnum].zhuangtai[3]) div 50000);
  Brole[bnum].zhuangtai[4] := min(100, Brole[bnum].zhuangtai[4] + 2 + GetRoleAttack(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[4]) div 5000);
  for i := 0 to Brole[bnum].Zhuanzhu - 1 do
  begin
    Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i + 2));
    Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] - round((i + 2) / 3 * 10));
    Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] - round((i + 2) / 3 * 10));
    Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] - round((i + 2) / 3 * 10));
    Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] - round((i + 2) / 3 * 5));
  end;
  Brole[bnum].Zhuanzhu := 0;

  //luke取消
  //BRole[bnum].Progress := BRole[bnum].Progress + ((BRole[bnum].Step * 120) div max(1, (BRole[bnum].speed div 15)));
end;

//The AI.

procedure AutoBattle(bnum: integer);
var
  i, p, a, h, temp, rnum, inum, eneamount, aim, mnum, level, Ax1, Ay1, i1, i2, step, step1, dis0, dis: integer;
  str: WideString;
begin
  rnum := Brole[bnum].rnum;
  ShowSimpleStatus(rnum, 30, 330);
  SDL_Delay(400 + 40 * gamespeed);
  //showmessage('');
  //Life is less than 20%, 70% probality to medcine or eat a pill.
  //生命低于20%, 70%可能医疗或吃药
  if (Brole[bnum].Acted = 0) and (Rrole[rnum].CurrentHP < Rrole[rnum].MaxHP div 5) then
  begin
    if random(100) < 70 then
    begin
      //医疗大于50, 且体力大于50才对自身医疗
      if (GetRoleMedcine(rnum, True) >= 50) and (Rrole[rnum].PhyPower >= 50) and (random(100) < 50) then
      begin
        Medcine(bnum);
      end
      else
      begin
        // if can't medcine, eat the item which can add the most life on its body.
        //无法医疗则选择身上加生命最多的药品, 我方从物品栏选择
        AutoUseItem(bnum, 45, 0);
      end;
    end;
  end;

  //MP is less than 20%, 60% probality to eat a pill.
  //内力低于20%, 60%可能吃药
  if (Brole[bnum].Acted = 0) and (Rrole[rnum].CurrentMP < Rrole[rnum].MaxMP div 5) then
  begin
    if random(100) < 60 then
    begin
      AutoUseItem(bnum, 50, 0);
    end;
  end;

  //Physical power is less than 20%, 80% probality to eat a pill.
  //体力低于20%, 80%可能吃药
  if (Brole[bnum].Acted = 0) and (Rrole[rnum].PhyPower < MAX_PHYSICAL_POWER div 5) then
  begin
    if random(100) < 80 then
    begin
      AutoUseItem(bnum, 48, 0);
    end;
  end;

  //如未能吃药且体力大于10, 则尝试攻击
  if (Brole[bnum].Acted = 0) and (Rrole[rnum].PhyPower >= 10) then
  begin
    //在敌方选择一个人物
    eneamount := CalRNum(1 - Brole[bnum].Team);
    aim := random(eneamount) + 1;
    //showmessage(inttostr(eneamount));
    for i := 0 to length(Brole) - 1 do
    begin
      if (Brole[bnum].Team <> Brole[i].Team) and (Brole[i].rnum >= 0) and (Brole[i].Dead = 0) then
      begin
        aim := aim - 1;
        if aim <= 0 then break;
      end;
    end;
    //Seclect one enemy randomly and try to close it.
    //尝试走到离敌人最近的位置
    Ax := Bx;
    Ay := By;
    Ax1 := Brole[i].X;
    Ay1 := Brole[i].Y;
    CalCanSelect(bnum, 0, Brole[bnum].step);
    dis0 := abs(Ax1 - Bx) + abs(Ay1 - By);
    for i1 := min(Ax1, Bx) to max(Ax1, Bx) do
      for i2 := min(Ay1, By) to max(Ay1, By) do
      begin
        if Bfield[3, i1, i2] >= 0 then
        begin
          dis := abs(Ax1 - i1) + abs(Ay1 - i2);
          if (dis < dis0) and (abs(i1 - Bx) + abs(i2 - By) <= Brole[bnum].Step) then
          begin
            Ax := i1;
            Ay := i2;
            dis0 := dis;
          end;
        end;
      end;
    if Bfield[3, Ax, Ay] >= 0 then MoveAmination(bnum);
    Ax := Brole[i].X;
    Ay := Brole[i].Y;

    //Try to attack it. select the best WUGONG.
    //使用目前最强的武功攻击
    p := 0;
    a := 0;
    temp := 0;
    h := 0;
    for i1 := 0 to 9 do
    begin
      mnum := Rrole[rnum].lMagic[Rrole[rnum].jhmagic[i1]];
      if mnum > 0 then
      begin
        a := a + 1;
        level := Rrole[rnum].MagLevel[Rrole[rnum].jhmagic[i1]] div 100 + 1;
        if Rrole[rnum].CurrentMP < Rmagic[mnum].NeedMP * level then
          level := Rrole[rnum].CurrentMP div Rmagic[mnum].NeedMP;
        if level > 10 then level := 10;
        if level < 0 then level := 1;
        if level = 0 then continue;
        h := CalNewHurtValue(level - 1, Rmagic[mnum].MinHurt, Rmagic[mnum].MaxHurt, Rmagic[mnum].HurtModulus);
        if h > temp then
        begin
          p := i1;
          temp := h;
        end;
      end;
    end;
    //5% probility to re-select WUGONG randomly.
    //5%的可能重新选择武功
    if random(100) < 5 then p := random(a);

    //If the most powerful Wugong can't attack the aim,
    //re-select the one which has the longest attatck-distance.
    //如最强武功打不到, 选择攻击距离最远的武功
    if abs(Ax - Bx) + abs(Ay - By) > step then
    begin
      p := 0;
      a := 0;
      temp := 0;
      for i1 := 0 to 9 do
      begin
        mnum := Rrole[rnum].lMagic[Rrole[rnum].jhmagic[i1]];
        if mnum > 0 then
        begin
          level := Rrole[rnum].MagLevel[Rrole[rnum].jhmagic[i1]] div 100 + 1;
          a := Rmagic[mnum].MoveDistance[level - 1];
          if CheckEquipSet(Rrole[rnum].equip[0], Rrole[rnum].equip[1], Rrole[rnum].equip[2],
            Rrole[rnum].equip[3]) = 1 then
            Inc(a, 1);
          if GetEquipState(rnum, 22) or GetGongtiState(rnum, 22) then //增加攻击距离
            Inc(a, 1);
          if Rmagic[mnum].AttAreaType = 3 then a := a + Rmagic[mnum].AttDistance[level - 1];
          if a > temp then
          begin
            p := i1;
            temp := a;
          end;
        end;
      end;
    end;

    mnum := Rrole[rnum].lMagic[Rrole[rnum].jhmagic[p]];
    level := Rrole[rnum].MagLevel[Rrole[rnum].jhmagic[p]] div 100 + 1;
    step := Rmagic[mnum].MoveDistance[level - 1];
    if CheckEquipSet(Rrole[rnum].equip[0], Rrole[rnum].equip[1], Rrole[rnum].equip[2], Rrole[rnum].equip[3]) = 1 then
      Inc(step, 1);
    if GetEquipState(rnum, 22) or GetGongtiState(rnum, 22) then //增加攻击距离
      Inc(step, 1);
    step1 := 0;
    if Rmagic[mnum].AttAreaType = 3 then step1 := Rmagic[mnum].AttDistance[level - 1];
    if abs(Ax - Bx) + abs(Ay - By) <= step + step1 then
    begin
      //step := Rmagic[mnum, 28+level-1];
      if (Rmagic[mnum].AttAreaType = 3) then
      begin
        //step1 := Rmagic[mnum, 38+level-1];
        dis := 0;
        Ax1 := Bx;
        Ay1 := By;
        for i1 := min(Ax, Bx) to max(Ax, Bx) do
          for i2 := min(Ay, By) to max(Ay, By) do
          begin
            if (abs(i1 - Ax) <= step1) and (abs(i2 - Ay) <= step1) and
              (abs(i1 - Bx) + abs(i2 - By) <= step + step1) then
            begin
              if dis < abs(i1 - Bx) + abs(i2 - By) then
              begin
                dis := abs(i1 - Bx) + abs(i2 - By);
                Ax1 := i1;
                Ay1 := i2;
              end;
            end;
          end;
        Ax := Ax1;
        Ay := Ay1;
      end;
      if Rmagic[mnum].AttAreaType <> 3 then
        SetAminationPosition(Rmagic[mnum].AttAreaType, step, step1)
      else
        SetAminationPosition(Rmagic[mnum].AttAreaType, step, step1);

      if bfield[4, Ax, Ay] <> 0 then
      begin
        Rrole[rnum].AttTwice := 0;
        if (GetEquipState(rnum, 14) or (GetGongtiState(rnum, 14))) and (random(100) > 30) then
          Rrole[rnum].AttTwice := 1;
        Brole[bnum].Acted := 1;
        for i1 := 0 to Rrole[rnum].AttTwice do
        begin
          Rrole[rnum].MagLevel[Rrole[rnum].jhmagic[p]] := Rrole[rnum].MagLevel[Rrole[rnum].jhmagic[p]] + 2;
          if Rrole[rnum].MagLevel[Rrole[rnum].jhmagic[p]] > 999 then
            Rrole[rnum].MagLevel[Rrole[rnum].jhmagic[p]] := 999;
          if Rmagic[mnum].EventNum > 0 then CallEvent(Rmagic[mnum].EventNum)
          else AttackAction(bnum, mnum, level);
        end;
      end;
    end;
  end;

  //If all other actions fail, rest.
  //如果上面行动全部失败则休息
  if Brole[bnum].Acted = 0 then Rest(bnum);

  //检查是否有esc被按下
  if SDL_PollEvent(@event) >= 0 then
  begin
    CheckBasicEvent;
    if (event.key.keysym.sym = SDLK_ESCAPE) and (Brole[bnum].Auto < 3) then
    begin
      Brole[bnum].Auto := -1;
    end;
  end;
end;

//自动使用list的值最大的物品

function AutoUseItem(bnum, list, mods: integer): boolean;
var
  i, p, temp, rnum, inum: integer;
  str: WideString;
begin
  Result := False;
  rnum := Brole[bnum].rnum;
  if Brole[bnum].Team <> 0 then
  begin
    temp := 0;
    p := -1;
    for i := 0 to 3 do
    begin
      if (Rrole[rnum].TakingItem[i] >= 0) and (Ritem[Rrole[rnum].TakingItem[i]].EventNum <= 0) then
      begin
        if Ritem[Rrole[rnum].TakingItem[i]].Data[list] > temp then
        begin
          temp := Ritem[Rrole[rnum].TakingItem[i]].Data[list];
          p := i;
        end;
      end;
    end;
  end
  else
  begin
    temp := 0;
    p := -1;
    for i := 0 to MAX_ITEM_AMOUNT - 1 do
    begin
      if (RItemList[i].Amount > 0) and (Ritem[RItemList[i].Number].ItemType = 3) and
        (Ritem[RItemList[i].Number].EventNum <= 0) then
      begin
        if Ritem[RItemList[i].Number].Data[list] > temp then
        begin
          temp := Ritem[RItemList[i].Number].Data[list];
          p := i;
        end;
      end;
    end;
  end;

  if p >= 0 then
  begin
    if Brole[bnum].Team <> 0 then
      inum := Rrole[rnum].TakingItem[p]
    else
      inum := RItemList[p].Number;
    Redraw;
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    Result := True;
    if mods = 1 then
      exit;
    EatOneItem(rnum, inum, True);
    Brole[bnum].Progress := Brole[bnum].Progress - 240;
    Brole[bnum].zhuangtai[0] := min(100, Brole[bnum].zhuangtai[0] + 1 + Rrole[Brole[bnum].rnum].CurrentMP *
      (50 + Brole[bnum].zhuangtai[0]) div 100000);
    Brole[bnum].zhuangtai[1] := min(100, Brole[bnum].zhuangtai[1] + 1 + GetRoleDefence(Brole[bnum].rnum, True) *
      (50 + Brole[bnum].zhuangtai[1]) div 10000);
    Brole[bnum].zhuangtai[2] := min(100, Brole[bnum].zhuangtai[2] + 1 + GetRoleSpeed(Brole[bnum].rnum, True) *
      (50 + Brole[bnum].zhuangtai[2]) div 10000);
    Brole[bnum].zhuangtai[3] := min(100, Brole[bnum].zhuangtai[3] + 1 + Rrole[Brole[bnum].rnum].CurrentHP *
      (50 + Brole[bnum].zhuangtai[3]) div 100000);
    Brole[bnum].zhuangtai[4] := min(100, Brole[bnum].zhuangtai[4] + 1 + GetRoleAttack(Brole[bnum].rnum, True) *
      (50 + Brole[bnum].zhuangtai[4]) div 10000);
    for i := 0 to Brole[bnum].Zhuanzhu - 1 do
    begin
      Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i + 2));
      Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] - round((i + 2) / 3 * 10));
      Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] - round((i + 2) / 3 * 10));
      Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] - round((i + 2) / 3 * 10));
      Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] - round((i + 2) / 3 * 5));
    end;
    Brole[bnum].Zhuanzhu := 0;
    if Brole[bnum].Team <> 0 then
      instruct_41(rnum, Rrole[rnum].TakingItem[p], -1)
    else
      instruct_32(RItemList[p].Number, -1);
    Brole[bnum].Acted := 1;
    SDL_Delay((10 + GameSpeed) * 40);
  end;

end;

//自动战斗AI，加強版

procedure AutoBattle2(bnum: integer);
var
  i, j, j1, k, k1, tzhaoshi, tzhaoshi1, szhaoshi1, maxzhuangtai, tzhuangtai, mzhuangtai, tmnum1,
  p, a, temp, rnum, inum, eneamount, aim, mnum, l1, level, Ax1, h, Ay1, i1, i2, step, step1, dis0, dis: integer;
  twice, r1, max2, tm, Cmnum, Cmlevel, Cmtype, Cmdis, Cmrange,hubo: integer;
  p1, Cmnum1, Cmlevel1, Cmtype1, Cmdis1, Cmrange1: integer;
  Mmx, Mmy, Mx1, My1, tempmaxhurt, maxhurt, tempminHP: integer;
  str, str1: WideString;
  words: string;
  tmagic, tlev, kmnum: array[0..9] of integer;

begin
  cmnum := 0;
  tzhaoshi := 0;
  maxzhuangtai := 0;
  tzhaoshi1 := -1;
  szhaoshi1 := -1;
  rnum := Brole[bnum].rnum;
  if Brole[bnum].Team = 0 then ShowSimpleStatus(rnum, 30, 330)
  else ShowSimpleStatus(rnum, 30, 330);
  SDL_Delay(200 + 20 * gamespeed);

  //showmessage('');
  //Life is less than 20%, 70% probality to medcine or eat a pill.
  //生命低于20%, 70%可能医疗或吃药
  if (Brole[bnum].Acted = 0) and (Rrole[rnum].CurrentHP < Rrole[rnum].MaxHP div 5) then
  begin
    if (Brole[bnum].Team <> 0) or ((Brole[bnum].Team = 0) and (Brole[bnum].Auto > 0)) then
    begin
      if (random(100) < 70) and (AutoUseItem(bnum, 45, 1)) then
      begin
        FarthestMove(Mmx, Mmy, bnum);
        Ax := Mmx;
        Ay := Mmy;
        MoveAmination(bnum);
        //医疗大于50, 且体力大于50才对自身医疗
        if (GetRoleMedcine(rnum, True) >= 50) and (Rrole[rnum].PhyPower >= 50) and (random(100) < 50) then
        begin
          Medcine(bnum);
        end
        else if (Brole[bnum].Team <> 0) or ((Brole[bnum].Team = 0) and (Brole[bnum].Auto in [1])) then
        begin
          // if can't medcine, eat the item which can add the most life on its body.
          //无法医疗则选择身上加生命最多的药品, 我方从物品栏选择
          AutoUseItem(bnum, 45, 0);
        end;
      end;
    end;
  end;

  //MP is less than 20%, 60% probality to eat a pill.
  //内力低于20%, 60%可能吃药
  if (Brole[bnum].Acted = 0) and (Rrole[rnum].CurrentMP < Rrole[rnum].MaxMP div 5) then
  begin
    if (Brole[bnum].Team <> 0) or ((Brole[bnum].Team = 0) and (Brole[bnum].Auto in [1])) then
    begin
      if (random(100) < 60) and AutoUseItem(bnum, 50, 1) then
      begin
        FarthestMove(Mmx, Mmy, bnum);
        Ax := Mmx;
        Ay := Mmy;
        MoveAmination(bnum);
        AutoUseItem(bnum, 50, 0);
      end;
    end;
  end;

  //Physical power is less than 20%, 80% probality to eat a pill.
  //体力低于20%, 80%可能吃药
  if (Brole[bnum].Acted = 0) and (Rrole[rnum].PhyPower < MAX_PHYSICAL_POWER div 5) then
  begin
    if (Brole[bnum].Team <> 0) or ((Brole[bnum].Team = 0) and (Brole[bnum].Auto in [1])) then
    begin
      if (random(100) < 80) and AutoUseItem(bnum, 48, 1) then
      begin
        FarthestMove(Mmx, Mmy, bnum);
        Ax := Mmx;
        Ay := Mmy;
        MoveAmination(bnum);
        AutoUseItem(bnum, 48, 0);
      end;
    end;
  end;

  //自身医疗大于60，寻找生命低于50％的队友进行医疗
  {if (Brole[bnum].Acted = 0) and (GetRoleMedcine(rnum, True) >= 60) and (Rrole[rnum].PhyPower > 50) then
  begin
    if (Brole[bnum].Team <> 0) or ((Brole[bnum].Team = 0) and (Brole[bnum].Auto > 0)) then
    begin
      Mx1 := -1;
      Ax1 := -1;
      TryMoveCure(Mx1, My1, Ax1, Ay1, bnum);
      if Ax1 <> -1 then
      begin
        //移动
        Ax := Mx1;
        Ay := My1;
        MoveAmination(bnum);

        //医疗
        Ax := Ax1;
        Ay := Ay1;
        CureAction(bnum);
        Brole[bnum].Acted := 1;
      end;
    end;
  end; }

  //尝试攻击
  if (Brole[bnum].Acted = 0) and (Rrole[rnum].PhyPower >= 10) then
  begin
    Mmx := -1;
    Ax := -1;
    mnum := 0;
    Cmlevel := 0;
    Cmtype := 0;
    Cmdis := 0;
    Cmrange := 0;

    p := 0;
    a := 0;
    tempmaxhurt := 0;
    maxhurt := 0;
    Brole[bnum].szhaoshi := 0;
    for i := 0 to 9 do
    begin
      if Rrole[rnum].jhmagic[i] < 0 then break;
      mnum := Rrole[rnum].lMagic[Rrole[rnum].jhmagic[i]];
      if mnum < 0 then break;
      if Rmagic[Rrole[rnum].lMagic[Rrole[rnum].jhmagic[i]]].MagicType = 5 then continue;
      if Rmagic[Rrole[rnum].lMagic[Rrole[rnum].jhmagic[i]]].EventNum > 0 then continue;
      a := a + 1;
      level := Rrole[rnum].MagLevel[Rrole[rnum].jhmagic[i]] div 100 + 1;
      if Rmagic[mnum].NeedMP > 0 then level := min(Rrole[rnum].CurrentMP div Rmagic[mnum].NeedMP, level);
      if level > 10 then level := 10;
      if level = 0 then continue;

      for i1 := 0 to 63 do
        for i2 := 0 to 63 do
          Bfield[3, i1, i2] := -1;

      Bfield[3, Brole[bnum].X, Brole[bnum].Y] := 0;

      TryMoveAttack(Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi, bnum, mnum, level);

      if (tempmaxhurt > maxhurt) then
      begin
        p := i;
        Cmnum := mnum;
        Cmtype := Rmagic[mnum].AttAreaType;
        Cmdis := Rmagic[mnum].MoveDistance[level - 1];
        if CheckEquipSet(Rrole[rnum].equip[0], Rrole[rnum].equip[1], Rrole[rnum].equip[2],
          Rrole[rnum].equip[3]) = 1 then
          Inc(Cmdis, 1);
        if GetEquipState(rnum, 22) or GetGongtiState(rnum, 22) then //增加攻击距离
          Inc(Cmdis, 1);
        Cmrange := Rmagic[mnum].AttDistance[level - 1];
        Mmx := Mx1;
        Mmy := My1;
        Ax := Ax1;
        Ay := Ay1;
        cmlevel := level;
        maxhurt := tempmaxhurt;
        Brole[bnum].szhaoshi := tzhaoshi;
      end;
    end;
    //使用奇术
    if (Brole[bnum].Acted = 0) and (Brole[bnum].Zhuanzhu < 1) then
    begin
      k:=0;
      for i := 0 to 9 do
      begin
        if Rrole[rnum].jhMagic[i] < 0 then break;
        if Rmagic[Rrole[rnum].LMagic[Rrole[rnum].jhMagic[i]]].MagicType = 6 then
        begin
          tmagic[k] := Rrole[rnum].LMagic[Rrole[rnum].jhMagic[i]];
          tlev[k] := Rrole[rnum].maglevel[Rrole[rnum].jhMagic[i]] div 100 + 1;
          kmnum[k] := Rrole[rnum].jhMagic[i];
          if Rrole[rnum].CurrentMP < Rmagic[Rrole[rnum].LMagic[Rrole[rnum].jhMagic[i]]].NeedMP * tlev[k] then
            tlev[k] := Rrole[rnum].CurrentMP div Rmagic[Rrole[rnum].LMagic[Rrole[rnum].jhMagic[i]]].NeedMP;
          mzhuangtai := 0;
          tzhaoshi := -1;
          tzhaoshi1 := -1;
          for j := 0 to 4 do
          begin
            if Rmagic[tmagic[k]].zhaoshi[j] < 1 then break;
            if ((Rrole[rnum].lzhaoshi[Rrole[rnum].jhMagic[i]] and (1 shl j)) = 0) then
              continue;
            tzhuangtai := 0;
            for j1 := 0 to 23 do
            begin
              if Rzhaoshi[Rmagic[tmagic[k]].zhaoshi[j]].texiao[j1].x < 0 then break;
              if (Rzhaoshi[Rmagic[tmagic[k]].zhaoshi[j]].texiao[j1].x >= 10) and
                (Rzhaoshi[Rmagic[tmagic[k]].zhaoshi[j]].texiao[j1].x <= 19) then
              begin
                tzhuangtai := tzhuangtai + Rzhaoshi[Rmagic[tmagic[k]].zhaoshi[j]].texiao[j1].y *
                  (tlev[k] - 1) div 9 * (100 -
                  Brole[bnum].zhuangtai[Rzhaoshi[Rmagic[tmagic[k]].zhaoshi[j]].texiao[j1].x - 5]) div
                  (200000 div (Rrole[Brole[bnum].rnum].CurrentMP + 2000)) *
                  (10 * Rrole[Brole[bnum].rnum].CurrentMP - (Rrole[Brole[bnum].rnum].MaxMP -
                  Rrole[Brole[bnum].rnum].CurrentMP) * 3) div (10 * Rrole[Brole[bnum].rnum].MaxMP) *
                  Rrole[Brole[bnum].rnum].CurrentHP div Rrole[Brole[bnum].rnum].MaxHP;
              end
              else if (Rzhaoshi[Rmagic[tmagic[k]].zhaoshi[j]].texiao[j1].x >= 50) and
                (Rzhaoshi[Rmagic[tmagic[k]].zhaoshi[j]].texiao[j1].x <= 59) then
              begin
                tzhuangtai := tzhuangtai - min(Rzhaoshi[Rmagic[tmagic[k]].zhaoshi[j]].texiao[j1].y *
                  (tlev[k] - 1) div 9, Brole[bnum].zhuangtai[Rzhaoshi[Rmagic[tmagic[k]].zhaoshi[j]].texiao[j1].x -
                  50]) * Rrole[Brole[bnum].rnum].CurrentHP div Rrole[Brole[bnum].rnum].MaxHP;
              end;
            end;
            if tzhuangtai > mzhuangtai then
            begin
              mzhuangtai := tzhuangtai;
              tzhaoshi1 := Rmagic[tmagic[k]].zhaoshi[j];
            end;
          end;
          if (mzhuangtai > maxzhuangtai) and (random(50) < mzhuangtai) then
          begin
            maxzhuangtai := mzhuangtai;
            tmnum1 := k;
            szhaoshi1 := tzhaoshi1;
          end;
          Inc(k);
        end;
      end;

      if ((Ax = -1) or (Mmx = -1)) or (random(maxhurt + 10 * maxzhuangtai) < 10 * maxzhuangtai) then
      begin
        if (szhaoshi1 > 0) and (tmnum1 >= 0) then
        begin
          Ax := Mmx;
          Ay := Mmy;
          NearestMove(Mmx, Mmy, bnum);
          MoveAmination(bnum);
          Brole[bnum].szhaoshi := szhaoshi1;
          addzhuangtai(bnum, tmagic[tmnum1], tlev[tmnum1]);
          magicexp(bnum, tmagic[tmnum1], tlev[tmnum1], kmnum[tmnum1]);
        end;
      end;
    end;
    //移动并攻击
    if (Ax <> -1) and (Mmx <> -1) and (Brole[bnum].Acted = 0) then
    begin
      //移动


      Ax1 := Ax;
      Ay1 := Ay;
      Ax := Mmx;
      Ay := Mmy;
      MoveAmination(bnum);

      //攻击
      Ax := Ax1;
      Ay := Ay1;
      SetAminationPosition(Rmagic[Cmnum].AttAreaType, Cmdis, Cmrange);
      Brole[bnum].Acted := 1;

      twice := 0;
      r1 := 0;

      if (GetEquipState(rnum, 14) or (GetGongtiState(rnum, 14))) then
      begin
        for i1 := 0 to 5 do
        begin
          if random(100) >= (50 div (r1 + 1) * (100 + Brole[bnum].zhuangtai[6]) div 100) then break;
          Inc(r1);
        end;
      end;

      for i1 := 0 to 5 do
      begin
        if random(100 * (i1 + 1)) >= (getroleattack(rnum, True) div 15 + Brole[bnum].zhuangtai[6]) *
          Brole[bnum].zhuangtai[4] div 100 then break;
        Inc(Twice);
      end;
      hubo:=0;
      if GetGongtiState(rnum,14) then
      begin
        if (100 - getroleaptitude(rnum,1)) > random(100) then
        begin
          hubo:=1;
        end;
      end;
      for i1 := 0 to (Rrole[rnum].AttTwice + hubo) do
      begin
        if Rmagic[Rrole[rnum].lMagic[Rrole[rnum].jhmagic[p]]].NeedMP > Rrole[rnum].CurrentMP then break;
        if (i1 > 0) and (random(101) > Brole[bnum].zhuangtai[4]) then break;
        if i1 = 1 then
        begin
          BShowBWord.sign := BShowBWord.sign or 1;
          BShowBWord.words[0] := '左右互搏';
          BShowBWord.delay[0] := 20;
          {str1 := '左右互博';
          DrawRectangle(center_x-12*length(str1)+20, 70 - 30, 87, 25, 0, colcolor(255), 25);
          Drawshadowtext(@str1[1], center_x-12*length(str1), 72 - 30, colcolor($21), colcolor($23));
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay((10 + GameSpeed)*20);}
        end;
        if Rmagic[Cmnum].EventNum > 0 then CallEvent(Rmagic[Cmnum].EventNum)
        else AttackAction(bnum, Cmnum, cmlevel);
        l1 := Rrole[rnum].MagLevel[Rrole[rnum].jhmagic[p]] div 100 + 1;


        if (isattack) then
        begin

          magicexp(bnum, Cmnum, l1, Rrole[rnum].jhmagic[p]);

        end;
        ClearDeadRolePic;
      end;
      if twice > 0 then
      begin
        for i1 := 1 to Twice do
        begin
          if (Rmagic[Rrole[rnum].lMagic[Rrole[rnum].jhmagic[p]]].NeedMP > Rrole[rnum].CurrentMP) then break;
          BShowBWord.sign := BShowBWord.sign or 1;
          BShowBWord.words[0] := '連擊';
          BShowBWord.delay[0] := 20;
          {str1 := '連擊';
          DrawRectangle(center_x-12*length(str1)+20, 70 - 30, 50, 25, 0, colcolor(255), 25);
          Drawshadowtext(@str1[1], center_x-12*length(str1)+5, 72 - 30, colcolor($21), colcolor($23));
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay((10 + GameSpeed)*20); }

          if Rmagic[Cmnum].EventNum > 0 then CallEvent(Rmagic[Cmnum].EventNum)
          else AttackAction(bnum, Cmnum, cmlevel);
          Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] -
            4 - (400 - GetRoleAttack(Brole[bnum].rnum, True)) *
            (round(power((Brole[i].zhuangtai[6] - Brole[i].lzhuangtai[6]), 1.65)) + 30) div 5000);
          for i2 := 0 to Brole[bnum].Zhuanzhu - 1 do
          begin
            Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i2 + 2));
            Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] -
              round((i2 + 2) / 3 * 10));
            Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] -
              round((i2 + 2) / 3 * 10));
            Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] -
              round((i2 + 2) / 3 * 10));
            Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] -
              round((i2 + 2) / 3 * 5));
          end;
          Brole[bnum].Zhuanzhu := 0;
          l1 := Rrole[rnum].MagLevel[Rrole[rnum].jhmagic[p]] div 100 + 1;


          if (isattack) then
          begin
            magicexp(bnum, Cmnum, l1, Rrole[rnum].jhmagic[p]);
          end;
          ClearDeadRolePic;
        end;
      end;
      if r1 > 0 then
      begin

        for i1 := 1 to r1 do
        begin
          if (Rmagic[Rrole[rnum].lMagic[Rrole[rnum].jhmagic[p]]].NeedMP > Rrole[rnum].CurrentMP) then break;
          BShowBWord.sign := BShowBWord.sign or 1;
          BShowBWord.words[0] := '弱點攻擊';
          BShowBWord.delay[0] := 20;
          {str1 := '弱點攻擊';
          DrawRectangle(center_x-12*length(str1)+15, 70 - 30, 87, 25, 0, colcolor(255), 25);
          Drawshadowtext(@str1[1], center_x-20*length(str1), 72 - 30, colcolor($21), colcolor($23));
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay((10 + GameSpeed)*20);}
          if Rmagic[Cmnum].EventNum > 0 then CallEvent(Rmagic[Cmnum].EventNum)
          else AttackAction(bnum, Cmnum, cmlevel);

          l1 := Rrole[rnum].MagLevel[Rrole[rnum].jhmagic[p]] div 100 + 1;


          if (isattack) then
          begin

            magicexp(bnum, Cmnum, l1, Rrole[rnum].jhmagic[p]);

          end;
          ClearDeadRolePic;
        end;
      end;
      Brole[bnum].Progress := Brole[bnum].Progress - 300;
      Brole[bnum].zhuangtai[0] := min(100, Brole[bnum].zhuangtai[0] + 1 + Rrole[Brole[bnum].rnum].CurrentMP *
        (50 + Brole[bnum].zhuangtai[0]) div 100000);
      Brole[bnum].zhuangtai[1] := min(100, Brole[bnum].zhuangtai[1] + 1 + GetRoleDefence(Brole[bnum].rnum, True) *
        (50 + Brole[bnum].zhuangtai[1]) div 10000);
      Brole[bnum].zhuangtai[2] := min(100, Brole[bnum].zhuangtai[2] + 1 + GetRoleSpeed(Brole[bnum].rnum, True) *
        (50 + Brole[bnum].zhuangtai[2]) div 10000);
      Brole[bnum].zhuangtai[3] := min(100, Brole[bnum].zhuangtai[3] + 1 + Rrole[Brole[bnum].rnum].CurrentHP *
        (50 + Brole[bnum].zhuangtai[3]) div 100000);
      Brole[bnum].zhuangtai[4] := min(100, Brole[bnum].zhuangtai[4] + 1 + GetRoleAttack(Brole[bnum].rnum, True) *
        (50 + Brole[bnum].zhuangtai[4]) div 10000);
      for i2 := 0 to Brole[bnum].Zhuanzhu - 1 do
      begin
        Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i2 + 2));
        Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] -
          round((i2 + 2) / 3 * 10));
        Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] -
          round((i2 + 2) / 3 * 10));
        Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] -
          round((i2 + 2) / 3 * 10));
        Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] - round((i2 + 2) / 3 * 5));
      end;
      Brole[bnum].Zhuanzhu := 0;
    end;
  end;

  //暗器大于30找人打
  if (Brole[bnum].Acted = 0) and (GetRoleHidWeapon(rnum, True) >= 30) then
  begin
    if (Brole[bnum].Team <> 0) or ((Brole[bnum].Team = 0) and (Brole[bnum].Auto > 0)) then
    begin
      Mx1 := -1;
      Ax1 := -1;
      for h := 0 to 3 do
        if (Rrole[Brole[bnum].rnum].TakingItem[h] > -1) and
          (Rrole[Brole[bnum].rnum].TakingItemAmount[h] > 0) and
          (Ritem[Rrole[Brole[bnum].rnum].TakingItem[h]].ItemType = 4) then
        begin
          inum := Rrole[Brole[bnum].rnum].TakingItem[h];
          trymoveHidden(Mx1, My1, Ax1, Ay1, bnum, inum);
          if Ax1 <> -1 then
          begin
            //移动
            Ax := Mx1;
            Ay := My1;
            MoveAmination(bnum);
            //放暗器
            Ax := Ax1;
            Ay := Ay1;
            Hiddenaction(bnum, inum);
            //Brole[bnum].Acted := 1;
          end;
        end;
    end;
  end;



  //自身用毒大于20，寻找敌人放毒
  {if (Brole[bnum].Acted = 0) and (GetRoleUsePoi(rnum, True) >= 20) and (Rrole[rnum].PhyPower > 30) then
  begin
    if (Brole[bnum].Team <> 0) or (Brole[bnum].Team = 0) then
    begin
      Mx1 := -1;
      Ax1 := -1;
      trymoveUsepoi(Mx1, My1, Ax1, Ay1, bnum);
      if Ax1 <> -1 then
      begin
        //移动
        Ax := Mx1;
        Ay := My1;
        MoveAmination(bnum);

        //医疗
        Ax := Ax1;
        Ay := Ay1;
        Usepoiaction(bnum);
        //Brole[bnum].Acted := 1;
      end;
    end;
  end;  }

  //自身解毒大于20，寻找队友解毒
  if (Brole[bnum].Acted = 0) and (GetRoleMedPoi(rnum, True) >= 20) and (Rrole[rnum].PhyPower > 50) then
  begin
    if (Brole[bnum].Team <> 0) or ((Brole[bnum].Team = 0) and (Brole[bnum].Auto > 0)) then
    begin
      Mx1 := -1;
      Ax1 := -1;
      trymoveMedpoi(Mx1, My1, Ax1, Ay1, bnum);
      if Ax1 <> -1 then
      begin
        //移动
        Ax := Mx1;
        Ay := My1;
        MoveAmination(bnum);

        //解毒
        Ax := Ax1;
        Ay := Ay1;
        Medpoiaction(bnum);
        //Brole[bnum].Acted := 1;
      end;
    end;
  end;
  k := 0;
  tmnum1 := -1;

  //If all other actions fail, rest.
  //如果上面行动全部失败，则移动到离敌人最近的地方，休息
  if Brole[bnum].Acted = 0 then
  begin
    NearestMove(Mmx, Mmy, bnum);
    MoveAmination(bnum);
    Ax := Mmx;
    Ay := Mmy;
    if (Random(50) + Brole[bnum].Zhuanzhu * 8 > (Rrole[Brole[bnum].rnum].MaxHP - Rrole[Brole[bnum].rnum].CurrentHP) *
      100 div Rrole[Brole[bnum].rnum].MaxHP) and (Random(50) + Brole[bnum].Zhuanzhu * 8 >
      (Rrole[Brole[bnum].rnum].MaxMP - Rrole[Brole[bnum].rnum].CurrentMP) * 100 div Rrole[Brole[bnum].rnum].MaxMP) and
      (Random(50) + Brole[bnum].Zhuanzhu * 8 > (100 - Rrole[Brole[bnum].rnum].PhyPower)) then
      Zhuanzhu(bnum)
    else Rest(bnum);
  end;

  //检查是否有esc被按下

  CheckBasicEvent;

  if ((event.key.keysym.sym = SDLK_ESCAPE) or (event.button.button = SDL_BUTTON_RIGHT)) and (Brole[bnum].Auto < 3) then
  begin
    Brole[bnum].Auto := -1;
    event.key.keysym.sym := 0;
    event.button.button := 0;
  end;
end;

//尝试移动并攻击，step为最大移动步数
//武功已经事先选好，distance为武功距离，range为武功范围，AttAreaType为武功类型
//尝试每一个可以移动到的点，考察在该点攻击的情况，选择最合适的目标点

procedure TryMoveAttack(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer; bnum, mnum, level: integer);
var
  Xlist: array[0..4096] of integer;
  Ylist: array[0..4096] of integer;
  steplist: array[0..4096] of integer;
  curgrid, totalgrid: integer;
  Bgrid: array[1..4] of integer; //0空位，1建筑，2友军，3敌军，4出界，5已走过
  Xinc, Yinc: array[1..4] of integer;
  curX, curY, curstep, nextX, nextY: integer;
  i, i1, i2, eneamount, aim: integer;
  tempX, tempY, tempdis: integer;
  step, distance, range, AttAreaType, myteam: integer;
begin
  step := Brole[bnum].Step;
  distance := Rmagic[mnum].MoveDistance[level - 1];
  if CheckEquipSet(Rrole[Brole[bnum].rnum].equip[0], Rrole[Brole[bnum].rnum].equip[1],
    Rrole[Brole[bnum].rnum].equip[2], Rrole[Brole[bnum].rnum].equip[3]) = 1 then
    Inc(distance, 1);
  if GetEquipState(Brole[bnum].rnum, 22) or GetGongtiState(Brole[bnum].rnum, 22) then //增加攻击距离
    Inc(distance, 1);

  range := Rmagic[mnum].AttDistance[level - 1];
  AttAreaType := Rmagic[mnum].AttAreaType;
  myteam := Brole[bnum].Team;

  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
      Bfield[3, i1, i2] := -1;
  Bfield[3, Brole[bnum].X, Brole[bnum].Y] := 0;
  Mx1 := -1;
  My1 := -1;
  Xinc[1] := 1;
  Xinc[2] := -1;
  Xinc[3] := 0;
  Xinc[4] := 0;
  Yinc[1] := 0;
  Yinc[2] := 0;
  Yinc[3] := 1;
  Yinc[4] := -1;
  curgrid := 0;
  totalgrid := 0;
  Xlist[totalgrid] := Bx;
  Ylist[totalgrid] := By;
  steplist[totalgrid] := 0;
  totalgrid := totalgrid + 1;
  while curgrid < totalgrid do
  begin
    curX := Xlist[curgrid];
    curY := Ylist[curgrid];

    //根据武功类型不同，分别计算
    case AttAreaType of
      0:
        CalPoint(Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi, curX, curY, bnum, mnum, level);
      1:
        calline(Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi, curX, curY, bnum, mnum, level);
      2:
        calcross(Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi, curX, curY, bnum, mnum, level);
      3:
        CalArea(Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi, curX, curY, bnum, mnum, level);
      4:
        caldirdiamond(Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi, curX, curY, bnum, mnum, level);
      5:
        caldirangle(Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi, curX, curY, bnum, mnum, level);
      6:
        calfar(Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi, curX, curY, bnum, mnum, level);
      7:
        calNewLine(Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi, curX, curY, bnum, mnum, level);

    end;

    curstep := steplist[curgrid];
    if curstep < step then
    begin
      //判断当前点四周格子的状况
      for i := 1 to 4 do
      begin
        nextX := curX + Xinc[i];
        nextY := curY + Yinc[i];
        if (nextX < 0) or (nextX > 63) or (nextY < 0) or (nextY > 63) then
          Bgrid[i] := 4
        else if Bfield[3, nextX, nextY] >= 0 then
          Bgrid[i] := 5
        else if Bfield[1, nextX, nextY] > 0 then
          Bgrid[i] := 1
        else if Bfield[2, nextX, nextY] >= 0 then
        begin
          if Brole[Bfield[2, nextX, nextY]].Team = myteam then
            Bgrid[i] := 2
          else
            Bgrid[i] := 3;
        end
        else if ((Bfield[0, nextX, nextY] div 2 >= 179) and (Bfield[0, nextX, nextY] div 2 <= 190)) or
          (Bfield[0, nextX, nextY] div 2 = 261) or (Bfield[0, nextX, nextY] div 2 = 511) or
          ((Bfield[0, nextX, nextY] div 2 >= 224) and (Bfield[0, nextX, nextY] div 2 <= 232)) or
          ((Bfield[0, nextX, nextY] div 2 >= 662) and (Bfield[0, nextX, nextY] div 2 <= 674)) then
          Bgrid[i] := 6
        else
          Bgrid[i] := 0;
      end;

      if (curstep = 0) or ((Bgrid[1] <> 3) and (Bgrid[2] <> 3) and (Bgrid[3] <> 3) and (Bgrid[4] <> 3)) then
      begin
        for i := 1 to 4 do
        begin
          if Bgrid[i] = 0 then
          begin
            Xlist[totalgrid] := curX + Xinc[i];
            Ylist[totalgrid] := curY + Yinc[i];
            steplist[totalgrid] := curstep + 1;
            Bfield[3, Xlist[totalgrid], Ylist[totalgrid]] := steplist[totalgrid];
            totalgrid := totalgrid + 1;
          end;
        end;
      end;

    end;
    curgrid := curgrid + 1;
  end;

  //无论怎样移动，也无法攻击到敌人，则随机选择一个敌人，并向他移动
 { if (Mx1=-1) and (tempmaxhurt=0) then
  begin
    //不攻击
    Ax1:=-1;

    //在敌方随机选择一个人物
    eneamount := Calrnum(1 - myteam);
    aim := random(eneamount) + 1;
    //showmessage(inttostr(eneamount));
    for i := 0 to length(brole) - 1 do
    begin
      if (myteam <> Brole[i].Team) and (Brole[i].Dead = 0) then
      begin
        aim := aim - 1;
        if aim <= 0 then break;
      end;
    end;

    //把移动目标点设在到离目标人物最近的地方
    nextX:=Brole[i].X;
    nextY:=Brole[i].Y;
    tempdis:=abs(nextX-Bx)+abs(nextY-By);
    for curgrid := totalgrid-1 downto 0 do
      begin
        tempX:=Xlist[curgrid];
        tempY:=Ylist[curgrid];
        if abs(nextX-tempX)+abs(nextY-tempY)<tempdis then
        begin
          Mmx:=tempX;
          Mmy:=tempY;
          tempdis:=abs(nextX-tempX)+abs(nextY-tempY);
        end;
      end;

  end;    }
end;

//线型攻击的情况，分四个方向考虑，分别计算伤血量

procedure calline(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer; curX, curY, bnum, mnum, level: integer);
var
  i, tempX, tempY, ebnum, rnum, tempHP, temphurt, tzhaoshi1, k: integer;
  distance, range, AttAreaType, myteam: integer;

begin
  distance := Rmagic[mnum].MoveDistance[level - 1];
  if CheckEquipSet(Rrole[Brole[bnum].rnum].equip[0], Rrole[Brole[bnum].rnum].equip[1],
    Rrole[Brole[bnum].rnum].equip[2], Rrole[Brole[bnum].rnum].equip[3]) = 1 then
    Inc(distance, 1);
  if GetEquipState(Brole[bnum].rnum, 22) or GetGongtiState(Brole[bnum].rnum, 22) then //增加攻击距离
    Inc(distance, 1);

  range := Rmagic[mnum].AttDistance[level - 1];
  AttAreaType := Rmagic[mnum].AttAreaType;
  myteam := Brole[bnum].Team;

  tzhaoshi1 := 0;

  temphurt := 0;
  for i := curX - 1 downto curX - distance do
  begin
    if (i > 63) or (i < 0) or (curY > 63) or (curY < 0) then
      continue;
    ebnum := Bfield[2, i, curY];
    if (ebnum >= 0) and (Brole[ebnum].Dead = 0) and (Brole[ebnum].Team <> myteam) then
    begin
      k := ebnum;

      temphurt := temphurt + courthurt(bnum, k, mnum, level, tzhaoshi1);
    end;
  end;
  if temphurt > tempmaxhurt then
  begin
    tempmaxhurt := temphurt;
    tzhaoshi := tzhaoshi1;
    Mx1 := curX;
    My1 := curY;
    Ax1 := curX - 1;
    Ay1 := curY;
  end;

  temphurt := 0;
  for i := curX + 1 to curX + distance do
  begin
    if (i > 63) or (i < 0) or (curY > 63) or (curY < 0) then
      continue;
    ebnum := Bfield[2, i, curY];
    if (ebnum >= 0) and (Brole[ebnum].Dead = 0) and (Brole[ebnum].Team <> myteam) then
    begin
      k := ebnum;
      temphurt := temphurt + courthurt(bnum, k, mnum, level, tzhaoshi1);
    end;
  end;
  if temphurt > tempmaxhurt then
  begin
    tempmaxhurt := temphurt;
    tzhaoshi := tzhaoshi1;
    Mx1 := curX;
    My1 := curY;
    Ax1 := curX + 1;
    Ay1 := curY;
  end;

  temphurt := 0;
  for i := curY - 1 downto curY - distance do
  begin
    if (i > 63) or (i < 0) or (curx > 63) or (curx < 0) then
      continue;
    ebnum := Bfield[2, curX, i];
    if (ebnum >= 0) and (Brole[ebnum].Dead = 0) and (Brole[ebnum].Team <> myteam) then
    begin
      k := ebnum;
      temphurt := temphurt + courthurt(bnum, k, mnum, level, tzhaoshi1);
    end;
  end;
  if temphurt > tempmaxhurt then
  begin
    tempmaxhurt := temphurt;
    tzhaoshi := tzhaoshi1;
    Mx1 := curX;
    My1 := curY;
    Ax1 := curX;
    Ay1 := curY - 1;
  end;

  temphurt := 0;
  for i := curY + 1 to curY + distance do
  begin
    if (i > 63) or (i < 0) or (curx > 63) or (curx < 0) then
      continue;
    ebnum := Bfield[2, curX, i];
    if (ebnum >= 0) and (Brole[ebnum].Dead = 0) and (Brole[ebnum].Team <> myteam) then
    begin
      k := ebnum;
      temphurt := temphurt + courthurt(bnum, k, mnum, level, tzhaoshi1);
    end;
  end;
  if temphurt > tempmaxhurt then
  begin
    tempmaxhurt := temphurt;
    tzhaoshi := tzhaoshi1;
    Mx1 := curX;
    My1 := curY;
    Ax1 := curX;
    Ay1 := curY + 1;
  end;
end;

//无定向方向

procedure calNewline(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer; curX, curY, bnum, mnum, level: integer);
var
  i, j, k, m, n, tempX, tempY, temphurt, tzhaoshi1: integer;
  distance, range, AttAreaType, myteam: integer;
begin
  distance := Rmagic[mnum].MoveDistance[level - 1];
  if CheckEquipSet(Rrole[Brole[bnum].rnum].equip[0], Rrole[Brole[bnum].rnum].equip[1],
    Rrole[Brole[bnum].rnum].equip[2], Rrole[Brole[bnum].rnum].equip[3]) = 1 then
    Inc(distance, 1);
  if GetEquipState(Brole[bnum].rnum, 22) or GetGongtiState(Brole[bnum].rnum, 22) then //增加攻击距离
    Inc(distance, 1);

  range := Rmagic[mnum].AttDistance[level - 1];
  AttAreaType := Rmagic[mnum].AttAreaType;
  myteam := Brole[bnum].Team;


  tzhaoshi1 := 0;

  for i := curX - distance to curX + distance do
  begin
    m := (distance - sign(i - curX) * (i - curX));
    for j := curY - m to curY + m do
    begin
      temphurt := 0;
      for k := 0 to length(Brole) - 1 do
      begin
        if (myteam <> Brole[k].Team) and (Brole[k].rnum >= 0) and (Brole[k].Dead = 0) then
        begin
          tempX := Brole[k].X;
          tempY := Brole[k].Y;
          if (abs(tempX - curX) + abs(tempY - cury) <= distance) then
          begin
            if ((abs(tempX - curX) <= abs(i - curX)) and (abs(tempY - cury) <= abs(j - cury))) then
            begin
              if (abs(i - curX) > abs(j - cury)) and (((tempX - curx) / (i - curx)) > 0) and
                (tempY = round(((tempX - curx) * (j - cury)) / (i - curx)) + cury) then
              begin

                temphurt := temphurt + courthurt(bnum, k, mnum, level, tzhaoshi1);
              end


              else if (abs(i - curX) < abs(j - cury)) and (((tempy - cury) / (j - cury)) > 0) and
                (tempx = round(((tempy - cury) * (i - curx)) / (j - cury)) + curx) then
              begin

                temphurt := temphurt + courthurt(bnum, k, mnum, level, tzhaoshi1);
              end;
            end;
          end;
          if temphurt > tempmaxhurt then
          begin
            Ax1 := i;
            Ay1 := j;
            Mx1 := curX;
            My1 := curY;
            tempmaxhurt := temphurt;
            tzhaoshi := tzhaoshi1;
          end;
        end;
      end;
    end;
  end;
end;

//方向系菱型

procedure caldirdiamond(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer;
  curX, curY, bnum, mnum, level: integer);
var
  i, tempX, tempY, k: integer;
  temphurt, tzhaoshi1: array[1..4] of integer;
  distance, range, AttAreaType, myteam: integer;
begin
  distance := Rmagic[mnum].MoveDistance[level - 1];
  range := Rmagic[mnum].AttDistance[level - 1];
  if CheckEquipSet(Rrole[Brole[bnum].rnum].equip[0], Rrole[Brole[bnum].rnum].equip[1],
    Rrole[Brole[bnum].rnum].equip[2], Rrole[Brole[bnum].rnum].equip[3]) = 1 then
    Inc(distance, 1);
  if GetEquipState(Brole[bnum].rnum, 22) or GetGongtiState(Brole[bnum].rnum, 22) then //增加攻击距离
    Inc(distance, 1);

  AttAreaType := Rmagic[mnum].AttAreaType;
  myteam := Brole[bnum].Team;

  temphurt[1] := 0;
  temphurt[2] := 0;
  temphurt[3] := 0;
  temphurt[4] := 0;

  tzhaoshi1[1] := 0;
  tzhaoshi1[2] := 0;
  tzhaoshi1[3] := 0;
  tzhaoshi1[4] := 0;



  for i := 0 to length(Brole) - 1 do
  begin
    if (myteam <> Brole[i].Team) and (Brole[i].Dead = 0) and (Brole[i].rnum >= 0) then
    begin
      tempX := Brole[i].X;
      tempY := Brole[i].Y;
      if (abs(tempX - curX) + abs(tempY - curY) <= distance) and (abs(tempX - curX) <> abs(tempY - curY)) then
      begin
        k := i;
        if (tempX - curX > 0) and (abs(tempX - curX) > abs(tempY - curY)) then
        begin

          temphurt[1] := temphurt[1] + courthurt(bnum, k, mnum, level, tzhaoshi1[1]);
        end
        else
        if (tempX - curX < 0) and (abs(tempX - curX) > abs(tempY - curY)) then
        begin

          temphurt[2] := temphurt[2] + courthurt(bnum, k, mnum, level, tzhaoshi1[2]);
        end
        else
        if (tempY - curY > 0) and (abs(tempX - curX) < abs(tempY - curY)) then
        begin

          temphurt[3] := temphurt[3] + courthurt(bnum, k, mnum, level, tzhaoshi1[3]);
        end
        else
        if (tempY - curY < 0) and (abs(tempX - curX) < abs(tempY - curY)) then
        begin

          temphurt[4] := temphurt[4] + courthurt(bnum, k, mnum, level, tzhaoshi1[4]);
        end;

      end;
    end;
  end;

  if temphurt[1] > tempmaxhurt then
  begin
    tempmaxhurt := temphurt[1];
    tzhaoshi := tzhaoshi1[1];
    Mx1 := curX;
    My1 := curY;
    Ax1 := curX + 1;
    Ay1 := curY;
  end;
  if temphurt[2] > tempmaxhurt then
  begin
    tempmaxhurt := temphurt[2];
    tzhaoshi := tzhaoshi1[2];
    Mx1 := curX;
    My1 := curY;
    Ax1 := curX - 1;
    Ay1 := curY;
  end;
  if temphurt[3] > tempmaxhurt then
  begin
    tempmaxhurt := temphurt[3];
    tzhaoshi := tzhaoshi1[3];
    Mx1 := curX;
    My1 := curY;
    Ax1 := curX;
    Ay1 := curY + 1;
  end;
  if temphurt[4] > tempmaxhurt then
  begin
    tempmaxhurt := temphurt[4];
    tzhaoshi := tzhaoshi1[4];
    Mx1 := curX;
    My1 := curY;
    Ax1 := curX;
    Ay1 := curY - 1;
  end;
end;

//方向系角型

procedure caldirangle(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer; curX, curY, bnum, mnum, level: integer);
var
  i, tempX, tempY, k: integer;
  temphurt, tzhaoshi1: array[1..4] of integer;
  distance, range, AttAreaType, myteam: integer;
begin
  distance := Rmagic[mnum].MoveDistance[level - 1];
  if CheckEquipSet(Rrole[Brole[bnum].rnum].equip[0], Rrole[Brole[bnum].rnum].equip[1],
    Rrole[Brole[bnum].rnum].equip[2], Rrole[Brole[bnum].rnum].equip[3]) = 1 then
    Inc(distance, 1);
  if GetEquipState(Brole[bnum].rnum, 22) or GetGongtiState(Brole[bnum].rnum, 22) then //增加攻击距离
    Inc(distance, 1);

  range := Rmagic[mnum].AttDistance[level - 1];
  AttAreaType := Rmagic[mnum].AttAreaType;
  myteam := Brole[bnum].Team;

  temphurt[1] := 0;
  temphurt[2] := 0;
  temphurt[3] := 0;
  temphurt[4] := 0;

  tzhaoshi1[1] := 0;
  tzhaoshi1[2] := 0;
  tzhaoshi1[3] := 0;
  tzhaoshi1[4] := 0;


  for i := 0 to length(Brole) - 1 do
  begin
    if (myteam <> Brole[i].Team) and (Brole[i].rnum >= 0) and (Brole[i].Dead = 0) then
    begin
      tempX := Brole[i].X;
      tempY := Brole[i].Y;
      if (abs(tempX - curX) <= distance) and (abs(tempY - curY) <= distance) and
        (abs(tempX - curX) <> abs(tempY - curY)) then
      begin
        k := i;
        if (tempX - curX > 0) and (abs(tempX - curX) > abs(tempY - curY)) then
        begin

          temphurt[1] := temphurt[1] + courthurt(bnum, k, mnum, level, tzhaoshi1[1]);

        end
        else
        if (tempX - curX < 0) and (abs(tempX - curX) > abs(tempY - curY)) then
        begin

          temphurt[2] := temphurt[2] + courthurt(bnum, k, mnum, level, tzhaoshi1[2]);

        end
        else
        if (tempY - curY > 0) and (abs(tempX - curX) < abs(tempY - curY)) then
        begin

          temphurt[3] := temphurt[3] + courthurt(bnum, k, mnum, level, tzhaoshi1[3]);

        end
        else
        if (tempY - curY < 0) and (abs(tempX - curX) < abs(tempY - curY)) then
        begin

          temphurt[4] := temphurt[4] + courthurt(bnum, k, mnum, level, tzhaoshi1[4]);

        end;
      end;
    end;
  end;

  if temphurt[1] > tempmaxhurt then
  begin
    tempmaxhurt := temphurt[1];
    tzhaoshi := tzhaoshi1[1];
    Mx1 := curX;
    My1 := curY;
    Ax1 := curX + 1;
    Ay1 := curY;
  end;
  if temphurt[2] > tempmaxhurt then
  begin
    tempmaxhurt := temphurt[2];
    tzhaoshi := tzhaoshi1[2];
    Mx1 := curX;
    My1 := curY;
    Ax1 := curX - 1;
    Ay1 := curY;
  end;
  if temphurt[3] > tempmaxhurt then
  begin
    tempmaxhurt := temphurt[3];
    tzhaoshi := tzhaoshi1[3];
    Mx1 := curX;
    My1 := curY;
    Ax1 := curX;
    Ay1 := curY + 1;
  end;
  if temphurt[4] > tempmaxhurt then
  begin
    tempmaxhurt := temphurt[4];
    tzhaoshi := tzhaoshi1[4];
    Mx1 := curX;
    My1 := curY;
    Ax1 := curX;
    Ay1 := curY - 1;
  end;
end;

//目标系方、原地系方

procedure CalArea(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer; curX, curY, bnum, mnum, level: integer);
var
  i, j, a1, a2, k, m, n, tempX, tempY, temphurt, tzhaoshi1: integer;
  distance, range, AttAreaType, myteam: integer;
begin
  distance := Rmagic[mnum].MoveDistance[level - 1];
  if CheckEquipSet(Rrole[Brole[bnum].rnum].equip[0], Rrole[Brole[bnum].rnum].equip[1],
    Rrole[Brole[bnum].rnum].equip[2], Rrole[Brole[bnum].rnum].equip[3]) = 1 then
    Inc(distance, 1);
  if GetEquipState(Brole[bnum].rnum, 22) or GetGongtiState(Brole[bnum].rnum, 22) then //增加攻击距离
    Inc(distance, 1);

  range := Rmagic[mnum].AttDistance[level - 1];
  AttAreaType := Rmagic[mnum].AttAreaType;
  myteam := Brole[bnum].Team;

  tzhaoshi1 := 0;

  for i := curX - distance to curX + distance do
  begin
    m := (distance - sign(i - curX) * (i - curX));
    for j := curY - m to curY + m do
    begin
      temphurt := 0;
      for k := 0 to length(Brole) - 1 do
      begin
        if (myteam <> Brole[k].Team) and (Brole[k].rnum >= 0) and (Brole[k].Dead = 0) then
        begin
          tempX := Brole[k].X;
          tempY := Brole[k].Y;
          if (abs(tempX - i) <= range) and (abs(tempY - j) <= range) then
          begin

            temphurt := temphurt + courthurt(bnum, k, mnum, level, tzhaoshi1); ;
          end;
        end;
      end;
      if temphurt > tempmaxhurt then
      begin
        Ax1 := i;
        Ay1 := j;
        Mx1 := curX;
        My1 := curY;
        tempmaxhurt := temphurt;
        tzhaoshi := tzhaoshi1;
      end;
    end;
  end;
end;

//目标系点十菱，原地系菱

procedure CalPoint(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer; curX, curY, bnum, mnum, level: integer);
var
  i, j, k, m, n, tempX, tempY, temphurt, ebnum, ernum, tempHP, tzhaoshi1: integer;
  distance, range, AttAreaType, myteam: integer;
begin
  distance := Rmagic[mnum].MoveDistance[level - 1];
  if CheckEquipSet(Rrole[Brole[bnum].rnum].equip[0], Rrole[Brole[bnum].rnum].equip[1],
    Rrole[Brole[bnum].rnum].equip[2], Rrole[Brole[bnum].rnum].equip[3]) = 1 then
    Inc(distance, 1);
  if GetEquipState(Brole[bnum].rnum, 22) or GetGongtiState(Brole[bnum].rnum, 22) then //增加攻击距离
    Inc(distance, 1);

  range := Rmagic[mnum].AttDistance[level - 1];
  AttAreaType := Rmagic[mnum].AttAreaType;
  myteam := Brole[bnum].Team;

  tzhaoshi1 := 0;

  for i := curX - distance to curX + distance do
  begin
    m := (distance - sign(i - curX) * (i - curX));
    for j := curY - m to curY + m do
    begin
      temphurt := 0;
      for k := 0 to length(Brole) - 1 do
      begin
        if (myteam <> Brole[k].Team) and (Brole[k].rnum >= 0) and (Brole[k].Dead = 0) then
        begin
          tempX := Brole[k].X;
          tempY := Brole[k].Y;
          if abs(tempX - i) + abs(tempY - j) <= range then
          begin

            temphurt := temphurt + courthurt(bnum, k, mnum, level, tzhaoshi1);

          end;
        end;
      end;
      if temphurt > tempmaxhurt then
      begin
        Ax1 := i;
        Ay1 := j;
        Mx1 := curX;
        My1 := curY;
        tempmaxhurt := temphurt;
        tzhaoshi := tzhaoshi1;
      end;
    end;
  end;
end;

//原地系十叉米

procedure calcross(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer; curX, curY, bnum, mnum, level: integer);
var
  i, k, tempX, tempY, temphurt, ebnum, rnum, tzhaoshi1: integer;
  distance, range, AttAreaType, myteam: integer;
begin
  distance := Rmagic[mnum].MoveDistance[level - 1];
  if CheckEquipSet(Rrole[Brole[bnum].rnum].equip[0], Rrole[Brole[bnum].rnum].equip[1],
    Rrole[Brole[bnum].rnum].equip[2], Rrole[Brole[bnum].rnum].equip[3]) = 1 then
    Inc(distance, 1);
  if GetEquipState(Brole[bnum].rnum, 22) or GetGongtiState(Brole[bnum].rnum, 22) then //增加攻击距离
    Inc(distance, 1);

  range := Rmagic[mnum].AttDistance[level - 1];
  AttAreaType := Rmagic[mnum].AttAreaType;
  myteam := Brole[bnum].Team;

  tzhaoshi1 := 0;

  temphurt := 0;
  for i := -range to range do
  begin
    if (curX + i > 63) or (curX + i < 0) or (curY + i > 63) or (curY + i < 0) then
      continue;
    ebnum := Bfield[2, curX + i, curY + i];
    if (ebnum >= 0) and (Brole[ebnum].Dead = 0) and (Brole[ebnum].Team <> myteam) then
    begin
      k := ebnum;

      temphurt := temphurt + courthurt(bnum, k, mnum, level, tzhaoshi1);

    end;
  end;

  for i := -range to range do
  begin
    if (curX + i > 63) or (curX + i < 0) or (curY - i > 63) or (curY - i < 0) then
      continue;
    bnum := Bfield[2, curX + i, curY - i];
    if (bnum >= 0) and (Brole[bnum].Dead = 0) and (Brole[bnum].Team <> myteam) then
    begin
      k := ebnum;

      temphurt := temphurt + courthurt(bnum, k, mnum, level, tzhaoshi1);
    end;
  end;

  for i := curX - distance to curX + distance do
  begin
    if (i > 63) or (i < 0) or (curY > 63) or (curY < 0) then
      continue;
    bnum := Bfield[2, i, curY];
    if (bnum >= 0) and (Brole[bnum].Dead = 0) and (Brole[bnum].Team <> myteam) then
    begin
      k := ebnum;

      temphurt := temphurt + courthurt(bnum, k, mnum, level, tzhaoshi1);
    end;
  end;

  for i := curY - distance to curY + distance do
  begin
    if (curX > 63) or (curX < 0) or (i > 63) or (i < 0) then
      continue;
    bnum := Bfield[2, curX, i];
    if (bnum >= 0) and (Brole[bnum].Dead = 0) and (Brole[bnum].Team <> myteam) then
    begin
      k := ebnum;

      temphurt := temphurt + courthurt(bnum, k, mnum, level, tzhaoshi1);
    end;
  end;

  if temphurt > tempmaxhurt then
  begin
    tempmaxhurt := temphurt;
    tzhaoshi := tzhaoshi1;
    Mx1 := curX;
    My1 := curY;
    Ax1 := curX;
    Ay1 := curY;
  end;
end;

//远程系

procedure calfar(var Mx1, My1, Ax1, Ay1, tempmaxhurt, tzhaoshi: integer; curX, curY, bnum, mnum, level: integer);
var
  i, j, k, m, n, tempX, tempY, temphurt, tzhaoshi1: integer;
  minstep: integer;
  distance, range, AttAreaType, myteam: integer;
begin
  distance := Rmagic[mnum].MoveDistance[level - 1];
  if CheckEquipSet(Rrole[Brole[bnum].rnum].equip[0], Rrole[Brole[bnum].rnum].equip[1],
    Rrole[Brole[bnum].rnum].equip[2], Rrole[Brole[bnum].rnum].equip[3]) = 1 then
    Inc(distance, 1);
  if GetEquipState(Brole[bnum].rnum, 22) or GetGongtiState(Brole[bnum].rnum, 22) then //增加攻击距离
    Inc(distance, 1);

  range := Rmagic[mnum].AttDistance[level - 1];
  AttAreaType := Rmagic[mnum].AttAreaType;
  myteam := Brole[bnum].Team;
  minstep := Rmagic[mnum].MinStep;

  tzhaoshi1 := 0;

  for i := curX - distance to curX + distance do
  begin
    m := (distance - sign(i - curX) * (i - curX));
    for j := curY - m to curY + m do
    begin
      if abs(j - curY) + abs(i - curX) <= minstep then continue;
      temphurt := 0;
      for k := 0 to length(Brole) - 1 do
      begin
        if (myteam <> Brole[k].Team) and (Brole[k].rnum >= 0) and (Brole[k].Dead = 0) then
        begin
          tempX := Brole[k].X;
          tempY := Brole[k].Y;
          if abs(tempX - i) + abs(tempY - j) <= range then
          begin

            temphurt := temphurt + courthurt(bnum, k, mnum, level, tzhaoshi1);
          end;
        end;
      end;
      if temphurt > tempmaxhurt then
      begin
        Ax1 := i;
        Ay1 := j;
        Mx1 := curX;
        My1 := curY;
        tempmaxhurt := temphurt;
        tzhaoshi := tzhaoshi1;
      end;
    end;
  end;
end;

//移动到离最近的敌人最近的地方

procedure NearestMove(var Mmx, Mmy: integer; bnum: integer);
var
  i, i1, i2, tempdis, mindis: integer;
  aimX, aimY: integer;
  step, myteam: integer;

  Xlist: array[0..4096] of integer;
  Ylist: array[0..4096] of integer;
  steplist: array[0..4096] of integer;
  curgrid, totalgrid: integer;
  Bgrid: array[1..4] of integer; //0空位，1建筑，2友军，3敌军，4出界，5已走过
  Xinc, Yinc: array[1..4] of integer;
  curX, curY, curstep, nextX, nextY: integer;

begin
  myteam := Brole[bnum].Team;
  mindis := 9999;

  //选择一个最近的敌人
  for i := 0 to length(Brole) - 1 do
  begin
    if (myteam <> Brole[i].Team) and (Brole[i].rnum >= 0) and (Brole[i].Dead = 0) then
    begin
      tempdis := abs(Brole[i].X - Bx) + abs(Brole[i].Y - By);
      if tempdis < mindis then
      begin
        mindis := tempdis;
        Ax := Brole[i].X;
        Ay := Brole[i].Y;
      end;
    end;
  end;

  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
      Bfield[3, i1, i2] := -1;
  Bfield[3, Brole[bnum].X, Brole[bnum].Y] := 0;

  step := Brole[bnum].Step;
  Mmx := Bx;
  Mmy := By;
  Xinc[1] := 1;
  Xinc[2] := -1;
  Xinc[3] := 0;
  Xinc[4] := 0;
  Yinc[1] := 0;
  Yinc[2] := 0;
  Yinc[3] := 1;
  Yinc[4] := -1;
  curgrid := 0;
  totalgrid := 0;
  Xlist[totalgrid] := Bx;
  Ylist[totalgrid] := By;
  steplist[totalgrid] := 0;
  totalgrid := totalgrid + 1;
  while curgrid < totalgrid do
  begin
    curX := Xlist[curgrid];
    curY := Ylist[curgrid];
    curstep := steplist[curgrid];

    //判断当前点四周格子的状况
    for i := 1 to 4 do
    begin
      nextX := curX + Xinc[i];
      nextY := curY + Yinc[i];
      if (nextX < 0) or (nextX > 63) or (nextY < 0) or (nextY > 63) then
        Bgrid[i] := 4
      else if Bfield[3, nextX, nextY] >= 0 then
        Bgrid[i] := 5
      else if Bfield[1, nextX, nextY] > 0 then
        Bgrid[i] := 1
      else if Bfield[2, nextX, nextY] >= 0 then
      begin
        if Brole[Bfield[2, nextX, nextY]].Team = myteam then
          Bgrid[i] := 2
        else
          Bgrid[i] := 3;
      end
      else if ((Bfield[0, nextX, nextY] div 2 >= 179) and (Bfield[0, nextX, nextY] div 2 <= 190)) or
        (Bfield[0, nextX, nextY] div 2 = 261) or (Bfield[0, nextX, nextY] div 2 = 511) or
        ((Bfield[0, nextX, nextY] div 2 >= 224) and (Bfield[0, nextX, nextY] div 2 <= 232)) or
        ((Bfield[0, nextX, nextY] div 2 >= 662) and (Bfield[0, nextX, nextY] div 2 <= 674)) then
        Bgrid[i] := 6
      else
        Bgrid[i] := 0;
    end;


    for i := 1 to 4 do
    begin
      if (Bgrid[i] = 0) then
      begin
        Xlist[totalgrid] := curX + Xinc[i];
        Ylist[totalgrid] := curY + Yinc[i];
        steplist[totalgrid] := curstep + 1;
        Bfield[3, Xlist[totalgrid], Ylist[totalgrid]] := steplist[totalgrid];
        totalgrid := totalgrid + 1;
      end;
    end;
    curgrid := curgrid + 1;
  end;
  aimX := Ax;
  aimY := Ay;
  mindis := 9999;
  for i := 1 to 4 do
  begin
    i1 := Ax + Xinc[i];
    i2 := Ay + Yinc[i];
    tempdis := Bfield[3, i1, i2];
    if (tempdis > 0) and (mindis > tempdis) then
    begin
      mindis := tempdis;
      aimX := i1;
      aimy := i2;
    end;
  end;
  Ax := aimX;
  Ay := aimY;
end;

//移动到离敌人最远的地方（与每一个敌人的距离之和最大）

procedure FarthestMove(var Mmx, Mmy: integer; bnum: integer);
var
  i, i1, i2, k, tempdis, maxdis: integer;
  aimX, aimY: integer;
  step, myteam: integer;

  Xlist: array[0..4096] of integer;
  Ylist: array[0..4096] of integer;
  steplist: array[0..4096] of integer;
  curgrid, totalgrid: integer;
  Bgrid: array[1..4] of integer; //0空位，1建筑，2友军，3敌军，4出界，5已走过
  Xinc, Yinc: array[1..4] of integer;
  curX, curY, curstep, nextX, nextY: integer;

begin
  step := Brole[bnum].Step;
  myteam := Brole[bnum].Team;
  maxdis := 0;

  Mmx := Bx;
  Mmy := By;
  Xinc[1] := 1;
  Xinc[2] := -1;
  Xinc[3] := 0;
  Xinc[4] := 0;
  Yinc[1] := 0;
  Yinc[2] := 0;
  Yinc[3] := 1;
  Yinc[4] := -1;
  curgrid := 0;
  totalgrid := 0;
  Xlist[totalgrid] := Bx;
  Ylist[totalgrid] := By;
  steplist[totalgrid] := 0;
  totalgrid := totalgrid + 1;

  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
      Bfield[3, i1, i2] := -1;
  Bfield[3, Brole[bnum].X, Brole[bnum].Y] := 0;

  while curgrid < totalgrid do
  begin
    curX := Xlist[curgrid];
    curY := Ylist[curgrid];
    tempdis := 0;
    for k := 0 to length(Brole) - 1 do
    begin
      if (Brole[k].Team <> myteam) and (Brole[k].rnum >= 0) and (Brole[k].Dead = 0) then
        tempdis := tempdis + abs(curX - Brole[k].X) + abs(curY - Brole[k].Y);
    end;
    if tempdis > maxdis then
    begin
      maxdis := tempdis;
      Mmx := curX;
      Mmy := curY;
    end;

    curstep := steplist[curgrid];
    if curstep < step then
    begin
      //判断当前点四周格子的状况
      for i := 1 to 4 do
      begin
        nextX := curX + Xinc[i];
        nextY := curY + Yinc[i];
        if (nextX < 0) or (nextX > 63) or (nextY < 0) or (nextY > 63) then
          Bgrid[i] := 4
        else if Bfield[3, nextX, nextY] >= 0 then
          Bgrid[i] := 5
        else if Bfield[1, nextX, nextY] > 0 then
          Bgrid[i] := 1
        else if Bfield[2, nextX, nextY] >= 0 then
        begin
          if Brole[Bfield[2, nextX, nextY]].Team = myteam then
            Bgrid[i] := 2
          else
            Bgrid[i] := 3;
        end
        else if ((Bfield[0, nextX, nextY] div 2 >= 179) and (Bfield[0, nextX, nextY] div 2 <= 190)) or
          (Bfield[0, nextX, nextY] div 2 = 261) or (Bfield[0, nextX, nextY] div 2 = 511) or
          ((Bfield[0, nextX, nextY] div 2 >= 224) and (Bfield[0, nextX, nextY] div 2 <= 232)) or
          ((Bfield[0, nextX, nextY] div 2 >= 662) and (Bfield[0, nextX, nextY] div 2 <= 674)) then
          Bgrid[i] := 6
        else

          Bgrid[i] := 0;
      end;

      if (curstep = 0) or ((Bgrid[1] <> 3) and (Bgrid[2] <> 3) and (Bgrid[3] <> 3) and (Bgrid[4] <> 3)) then
      begin
        for i := 1 to 4 do
        begin
          if Bgrid[i] = 0 then
          begin
            Xlist[totalgrid] := curX + Xinc[i];
            Ylist[totalgrid] := curY + Yinc[i];
            steplist[totalgrid] := curstep + 1;
            Bfield[3, Xlist[totalgrid], Ylist[totalgrid]] := steplist[totalgrid];
            totalgrid := totalgrid + 1;
          end;
        end;
      end;

    end;
    curgrid := curgrid + 1;
  end;
end;

//在可医疗范围内，寻找生命不足一半的生命最少的友军，

procedure TryMoveCure(var Mx1, My1, Ax1, Ay1: integer; bnum: integer);
var
  Xlist: array[0..4096] of integer;
  Ylist: array[0..4096] of integer;
  steplist: array[0..4096] of integer;
  curgrid, totalgrid: integer;
  Bgrid: array[1..4] of integer; //0空位，1建筑，2友军，3敌军，4出界，5已走过,6水面
  Xinc, Yinc: array[1..4] of integer;
  curX, curY, curstep, nextX, nextY: integer;
  i, i1, i2, eneamount, aim: integer;
  tempX, tempY, tempdis: integer;
  step, myteam, curedis, rnum: integer;
  tempminHP: integer;

begin
  step := Brole[bnum].Step;
  myteam := Brole[bnum].Team;
  curedis := GetRoleMedcine(Brole[bnum].rnum, True) div 15 + 1;

  tempminHP := MAX_HP;

  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
      Bfield[3, i1, i2] := -1;
  Bfield[3, Brole[bnum].X, Brole[bnum].Y] := 0;

  Xinc[1] := 1;
  Xinc[2] := -1;
  Xinc[3] := 0;
  Xinc[4] := 0;
  Yinc[1] := 0;
  Yinc[2] := 0;
  Yinc[3] := 1;
  Yinc[4] := -1;
  curgrid := 0;
  totalgrid := 0;
  Xlist[totalgrid] := Bx;
  Ylist[totalgrid] := By;
  steplist[totalgrid] := 0;
  totalgrid := totalgrid + 1;
  while curgrid < totalgrid do
  begin
    curX := Xlist[curgrid];
    curY := Ylist[curgrid];

    for i := 0 to length(Brole) - 1 do
    begin
      rnum := Brole[i].rnum;
      if (Brole[i].Team = myteam) and (Brole[i].rnum >= 0) and (Brole[i].dead = 0) and
        (abs(Brole[i].X - curX) + abs(Brole[i].Y - curY) < curedis) and (Rrole[rnum].CurrentHP <
        Rrole[rnum].MaxHP div 2) then
      begin
        if Rrole[rnum].Hurt - GetRoleMedcine(rnum, True) <= 20 then
        begin
          if (GetRoleMedcine(Brole[bnum].rnum, True) * (10 - Rrole[rnum].Hurt div 15) div 10) < tempminHP then
          begin
            tempminHP := GetRoleMedcine(Brole[bnum].rnum, True) * (10 - Rrole[rnum].Hurt div 15) div 10;
            Mx1 := curX;
            My1 := curY;
            Ax1 := Brole[i].X;
            Ay1 := Brole[i].Y;
          end;
        end;
      end;
    end;

    curstep := steplist[curgrid];
    if curstep < step then
    begin
      //判断当前点四周格子的状况
      for i := 1 to 4 do
      begin
        nextX := curX + Xinc[i];
        nextY := curY + Yinc[i];
        if (nextX < 0) or (nextX > 63) or (nextY < 0) or (nextY > 63) then
          Bgrid[i] := 4
        else if Bfield[3, nextX, nextY] >= 0 then
          Bgrid[i] := 5
        else if Bfield[1, nextX, nextY] > 0 then
          Bgrid[i] := 1
        else if ((Bfield[0, nextX, nextY] div 2 >= 179) and (Bfield[0, nextX, nextY] div 2 <= 190)) or
          (Bfield[0, nextX, nextY] div 2 = 261) or (Bfield[0, nextX, nextY] div 2 = 511) or
          ((Bfield[0, nextX, nextY] div 2 >= 224) and (Bfield[0, nextX, nextY] div 2 <= 232)) or
          ((Bfield[0, nextX, nextY] div 2 >= 662) and (Bfield[0, nextX, nextY] div 2 <= 674)) then
          Bgrid[i] := 6
        else if Bfield[2, nextX, nextY] >= 0 then
        begin
          if Brole[Bfield[2, nextX, nextY]].Team = myteam then
            Bgrid[i] := 2
          else
            Bgrid[i] := 3;
        end
        else
          Bgrid[i] := 0;
      end;

      if (curstep = 0) or ((Bgrid[1] <> 3) and (Bgrid[2] <> 3) and (Bgrid[3] <> 3) and (Bgrid[4] <> 3)) then
      begin
        for i := 1 to 4 do
        begin
          if Bgrid[i] = 0 then
          begin
            Xlist[totalgrid] := curX + Xinc[i];
            Ylist[totalgrid] := curY + Yinc[i];
            steplist[totalgrid] := curstep + 1;
            Bfield[3, Xlist[totalgrid], Ylist[totalgrid]] := steplist[totalgrid];
            totalgrid := totalgrid + 1;
          end;
        end;
      end;
    end;
    curgrid := curgrid + 1;
  end;
end;

procedure CureAction(bnum: integer);
var
  rnum, i, bnum1, rnum1, addlife: integer;
begin
  rnum := Brole[bnum].rnum;
  if (not GetEquipState(rnum, 1)) and (not GetGongtiState(rnum, 1)) then
    Rrole[rnum].PhyPower := Rrole[rnum].PhyPower - 5;
  bnum1 := bfield[2, Ax, Ay];
  rnum1 := Brole[bnum1].rnum;
  addlife := GetRoleMedcine(rnum, True) * (10 - Rrole[rnum1].Hurt div 8) div 5; //calculate the value

  if Rrole[rnum1].Hurt - GetRoleMedcine(rnum, True) > 20 then
    addlife := 0;
  if addlife < 0 then addlife := 0;
  addlife := min(addlife, Rrole[rnum1].MaxHP - Rrole[rnum1].CurrentHP);

  if addlife > 0 then Inc(Brole[bnum].ExpGot, max(0, addlife div 5));

  Rrole[rnum1].CurrentHP := Rrole[rnum1].CurrentHP + addlife;
  Rrole[rnum1].Hurt := Rrole[rnum1].Hurt - (addlife + 10) div LIFE_HURT;
  if Rrole[rnum1].Hurt < 0 then Rrole[rnum1].Hurt := 0;
  Brole[bnum1].ShowNumber := addlife;
  SetAminationPosition(0, 0, 0);

  if getpetskill(5, 2) and (Brole[bnum].Team = 0) then
  begin
    for i := 0 to length(Brole) - 1 do
    begin
      if (Brole[i].Dead = 0) and (Brole[i].rnum >= 0) and (i <> bnum1) and
        (Brole[i].Team = Brole[bnum1].Team) and (Brole[i].X in [Brole[bnum1].X - 3..Brole[bnum1].X + 3]) and
        (Brole[i].Y in [Brole[bnum1].Y - 3..Brole[bnum1].Y + 3]) then
      begin
        addlife := 0;
        rnum1 := Brole[i].rnum;
        addlife := GetRoleMedcine(rnum, True) * (10 - Rrole[rnum1].Hurt div 8) div 5; //calculate the value
        if Rrole[rnum1].Hurt - GetRoleMedcine(rnum, True) > 20 then addlife := 0;
        if addlife < 0 then addlife := 0;
        addlife := min(addlife, Rrole[rnum1].MaxHP - Rrole[rnum1].CurrentHP);

        if addlife > 0 then Inc(Brole[bnum].ExpGot, max(0, addlife div 10));

        Rrole[rnum1].CurrentHP := Rrole[rnum1].CurrentHP + addlife;
        Rrole[rnum1].Hurt := Rrole[rnum1].Hurt - (addlife + 10) div LIFE_HURT;
        if Rrole[rnum1].Hurt < 0 then Rrole[rnum1].Hurt := 0;
        Brole[i].ShowNumber := addlife;

        Bfield[4, Brole[i].X, Brole[i].Y] := 1;
      end;
    end;
  end;

  playsoundE(31, 0);
  PlayActionAmination(bnum, 0);
  PlayMagicAmination(bnum, 0, 31, 0);
  Dec(Brole[bnum].Progress, 240);
  Brole[bnum].zhuangtai[0] := min(100, Brole[bnum].zhuangtai[0] + 1 + Rrole[Brole[bnum].rnum].CurrentMP *
    (50 + Brole[bnum].zhuangtai[0]) div 100000);
  Brole[bnum].zhuangtai[1] := min(100, Brole[bnum].zhuangtai[1] + 1 + GetRoleDefence(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[1]) div 10000);
  Brole[bnum].zhuangtai[2] := min(100, Brole[bnum].zhuangtai[2] + 1 + GetRoleSpeed(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[2]) div 10000);
  Brole[bnum].zhuangtai[3] := min(100, Brole[bnum].zhuangtai[3] + 1 + Rrole[Brole[bnum].rnum].CurrentHP *
    (50 + Brole[bnum].zhuangtai[3]) div 100000);
  Brole[bnum].zhuangtai[4] := min(100, Brole[bnum].zhuangtai[4] + 1 + GetRoleAttack(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[4]) div 10000);
  for i := 0 to Brole[bnum].Zhuanzhu - 1 do
  begin
    Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i + 2));
    Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] - round((i + 2) / 3 * 10));
    Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] - round((i + 2) / 3 * 10));
    Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] - round((i + 2) / 3 * 10));
    Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] - round((i + 2) / 3 * 5));
  end;
  Brole[bnum].Zhuanzhu := 0;
  ShowHurtValue(3);
end;

procedure PetEffect;
var
  kf, i, n: integer;
  word1: WideString;
begin
  if GetPetSkill(3, 0) then
  begin
    n := random(100);
    if n < 60 then
    begin
      word1 := '林廚子收集藥材成功';
      DrawTextWithRect(@word1[1], CENTER_X - 70, 55, 190, ColColor(0, 5), ColColor(0, 7));
      WaitAnyKey;
      instruct_2(291, 5);
      Redraw;
    end;
    n := random(100);
    if n < 60 then
    begin
      word1 := '林廚子收集食材成功';
      DrawTextWithRect(@word1[1], CENTER_X - 70, 55, 190, ColColor(0, 5), ColColor(0, 7));
      WaitAnyKey;
      instruct_2(269, 5);
      Redraw;
    end;
  end;
  if GetPetSkill(3, 2) then
  begin
    n := random(100);
    if n < 30 then
    begin
      word1 := '林廚子收集材料成功';
      DrawTextWithRect(@word1[1], CENTER_X - 70, 55, 190, ColColor(0, 5), ColColor(0, 7));
      WaitAnyKey;
      n := random(18);
      n := n + 270;
      instruct_2(n, 1);
      Redraw;
    end;
  end;
  if GetPetSkill(4, 0) then
  begin
    n := random(100);
    if n < 60 then
    begin
      word1 := '孔八拉搜刮礦石成功';
      DrawTextWithRect(@word1[1], CENTER_X - 70, 55, 190, ColColor(0, 5), ColColor(0, 7));
      WaitAnyKey;
      instruct_2(267, 5);
      Redraw;
    end;
    n := random(100);
    if n < 60 then
    begin
      word1 := '孔八拉搜刮硝石成功';
      DrawTextWithRect(@word1[1], CENTER_X - 70, 55, 190, ColColor(0, 5), ColColor(0, 7));
      WaitAnyKey;
      instruct_2(268, 5);
      Redraw;
    end;
  end;
  if GetPetSkill(1, 0) or GetPetSkill(1, 2) or GetPetSkill(1, 4) then
  begin
    if GetPetSkill(1, 4) then kf := 100
    else if GetPetSkill(1, 2) then kf := 60
    else if GetPetSkill(1, 0) then kf := 30;
    word1 := '阿賢記錄武功成功';
    for i := 0 to length(warsta.GetKongfu) - 1 do
    begin
      if (warsta.GetKongfu[i] > -1) then
      begin
        n := random(100);
        if n < kf then
        begin
          DrawTextWithRect(@word1[1], CENTER_X - 60, 55, 170, ColColor(0, 5), ColColor(0, 7));
          WaitAnyKey;
          instruct_2(warsta.GetKongfu[i], 1);
          Redraw;
        end;
      end;
    end;
  end;
  if GetPetSkill(2, 2) then
  begin
    kf := 50;
    word1 := '阿醜偷竊物品成功';
    for i := 0 to length(warsta.GetItems) - 1 do
    begin
      if (warsta.GetItems[i] > -1) then
      begin
        n := random(100);
        if n < kf then
        begin
          DrawTextWithRect(@word1[1], CENTER_X - 60, 55, 170, ColColor(0, 5), ColColor(0, 7));
          WaitAnyKey;
          instruct_2(warsta.GetItems[i], 1);
          Redraw;
        end;
      end;
    end;
  end;
  if GetPetSkill(2, 0) then
  begin
    word1 := '阿醜偷竊金錢成功';
    n := warsta.GetMoney div 2 + random(warsta.GetMoney div 2);
    if n > 0 then
    begin
      DrawTextWithRect(@word1[1], CENTER_X - 60, 55, 170, ColColor(0, 5), ColColor(0, 7));
      WaitAnyKey;
      instruct_2(MONEY_ID, n);
      Redraw;
    end;
  end;
end;


//显示模式选单

function SelectAutoMode: integer;
var
  i, p, MenuStatus, max0, menu, menup: integer;
begin
  MenuStatus := 0;
  max0 := 0;
  setlength(menuString, 0);
  setlength(menuString, 3);
  setlength(menuEngString, 0);
  //SDL_EnableKeyRepeat(20, 100);
  menuString[0] := '強攻型';
  menuString[1] := '嗑藥型';
  menuString[2] := '治療型';
  Redraw;

  SDL_UpdateRect2(screen, 169, 96, screen.w, screen.h);
  menu := 0;
  showModemenu(menu);
  //SDL_UpdateRect2(screen,0,0,screen.w,screen.h);
  while (SDL_PollEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          break;
        end;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          menu := -1;
          break;
        end;
      end;
      SDL_KEYDOWN:
      begin
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          menu := menu - 1;
          if menu < 0 then menu := 2;
          showModemenu(menu);
        end;
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          menu := menu + 1;
          if menu > 2 then menu := 0;
          showModemenu(menu);
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_LEFT) and (menu <> -1) then
        begin
          break;
        end;
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          menu := -1;
          break;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x >= 100) and (event.button.x < 267) and (event.button.y >= 50) and
          (event.button.y < 3 * 22 + 78) then
        begin
          menup := menu;
          menu := (event.button.y - 52) div 22;
          if menu > 2 then menu := 2;
          if menu < 0 then menu := 0;
          if menup <> menu then showModemenu(menu);
        end
        else menu := -1;
      end;
    end;
    event.key.keysym.sym := 0;
    event.button.button := 0;
    SDL_Delay(2 * (GameSpeed + 10));
  end;
  event.key.keysym.sym := 0;
  event.button.button := 0;

  Result := menu;
  Redraw;
  setlength(menuString, 0);
  setlength(menuEngString, 0);
  //SDL_EnableKeyRepeat(30,35);
end;

//显示模式选单

procedure ShowModeMenu(menu: integer);
var
  i, x, y: integer;
begin
  Redraw;
  x := 157;
  y := 50;
  DrawRectangle(x, y, 75, 74, 0, ColColor(255), 30);
  for i := 0 to 2 do
  begin
    if (i = menu) then
    begin
      DrawShadowText(@menuString[i][1], x - 17, 53 + 22 * i, ColColor($64), ColColor($66));
    end
    else
    begin
      DrawShadowText(@menuString[i][1], x - 17, 53 + 22 * i, ColColor($21), ColColor($23));
    end;
  end;
  SDL_UpdateRect2(screen, x, y, 169, 96);

end;

function TeamModeMenu: boolean;
var
  menup, x, y, w, menu, i, amount: integer;
  a: array of smallint;
begin
  x := 154;
  y := 50;
  w := 190;
  //SDL_EnableKeyRepeat(20, 100);
  Result := True;
  amount := 0;
  for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].Team = 0) and (Brole[i].rnum >= 0) and (Brole[i].Dead = 0) and (Brole[i].Auto < 3) then
    begin
      amount := amount + 1;
      setlength(a, amount);
      a[amount - 1] := i;
    end;
  end;
  menu := 0;
  ShowTeamModeMenu(menu);
  while (SDL_PollEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          break;
        end;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          Result := False;
          break;
        end;
      end;
      SDL_KEYDOWN:
      begin
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          menu := menu - 1;
          if menu = -1 then menu := -2;
          if menu = -3 then menu := amount - 1;
          ShowTeamModeMenu(menu);
        end;
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          menu := menu + 1;
          if menu = amount then menu := -2;
          if menu = -1 then menu := 0;
          ShowTeamModeMenu(menu);
        end;
        if (event.key.keysym.sym = SDLK_LEFT) or (event.key.keysym.sym = SDLK_KP4) then
        begin
          Brole[a[menu]].Auto := Brole[a[menu]].Auto - 1;
          if Brole[a[menu]].Auto < -1 then Brole[a[menu]].Auto := 2;
          ShowTeamModeMenu(menu);
        end;
        if (event.key.keysym.sym = SDLK_RIGHT) or (event.key.keysym.sym = SDLK_KP6) then
        begin
          Brole[a[menu]].Auto := Brole[a[menu]].Auto + 1;
          if Brole[a[menu]].Auto > 2 then Brole[a[menu]].Auto := -1;
          ShowTeamModeMenu(menu);
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          if (menu > -1) then
          begin
            Brole[a[menu]].Auto := Brole[a[menu]].Auto + 1;
            if Brole[a[menu]].Auto > 2 then Brole[a[menu]].Auto := -1;
            ShowTeamModeMenu(menu);
          end
          else if (menu = -2) then
          begin
            break;
          end;
        end;
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          Result := False;
          break;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x >= x) and (event.button.x < x + w) and (event.button.y >= y) and
          (event.button.y < amount * 22 + 78) then
        begin
          menup := menu;
          menu := (event.button.y - y) div 22;
          if menu < 0 then menu := 0;
          if menu >= amount then menu := -2;
          if menup <> menu then ShowTeamModeMenu(menu);
        end
        else menu := -1;
      end;
    end;

    event.key.keysym.sym := 0;
    event.button.button := 0;
    SDL_Delay(2 * (GameSpeed + 10));
  end;
  event.key.keysym.sym := 0;
  event.button.button := 0;
  //SDL_EnableKeyRepeat(30,35);
  Redraw;
end;

procedure ShowTeamModeMenu(menu: integer);
var
  i, amount, x, y, w, h: integer;
  modestring: array[-1..2] of WideString;
  namestr: array of WideString;
  str: WideString;
  a: array of smallint;
begin
  amount := 0;
  x := 154;
  y := 50;
  w := 190;
  modestring[0] := '強攻型';
  modestring[1] := '嗑藥型';
  modestring[2] := '治療型';
  modestring[-1] := '手动';
  str := ' 确定';
  for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].Team = 0) and (Brole[i].rnum >= 0) and (Brole[i].Dead = 0) and (Brole[i].Auto < 3) then
    begin
      amount := amount + 1;
      setlength(namestr, amount);
      setlength(a, amount);
      namestr[amount - 1] := '' + gbktounicode(@Rrole[Brole[i].rnum].Name[0]);
      a[amount - 1] := Brole[i].Auto;
    end;
  end;
  h := amount * 22 + 32;
  Redraw;
  DrawRectangle(x, y, w, h, 0, ColColor(255), 30);
  for i := 0 to amount - 1 do
  begin
    if (i = menu) then
    begin
      DrawShadowText(@namestr[i][1], x - 17, 53 + 22 * i, ColColor($64), ColColor($66));
      //SDL_UpdateRect2(screen, x, y,w+2, h+2);
      DrawShadowText(@modestring[a[i]][1], x + 100 - 17, 53 + 22 * i, ColColor($64), ColColor($66));
      //SDL_UpdateRect2(screen, x, y,w+2, h+2);
    end
    else
    begin
      DrawShadowText(@namestr[i][1], x - 17, 53 + 22 * i, ColColor($21), ColColor($23));
      //SDL_UpdateRect2(screen, x, y,w+2, h+2);
      DrawShadowText(@modestring[a[i]][1], x + 100 - 17, 53 + 22 * i, ColColor($21), ColColor($23));
      //SDL_UpdateRect2(screen, x, y,w+2, h+2);
    end;

  end;
  if menu = -2 then
    DrawShadowText(@str[1], x - 17, 53 + 22 * amount, ColColor($64), ColColor($66))
  else
    DrawShadowText(@str[1], x - 17, 53 + 22 * amount, ColColor($21), ColColor($23));
  SDL_UpdateRect2(screen, x, y, w + 2, h + 2);

end;

procedure Auto(bnum: integer);
var
  a, i, menu: integer;
begin
  setlength(menuString, 0);
  setlength(menuString, 2);
  menuString[1] := '單人';
  menuString[0] := '全體';
  menu := CommonMenu2(157, 50, 98);
  SDL_EnableKeyRepeat(20, 100);
  if menu = -1 then
    exit;

  Redraw;
  SDL_UpdateRect2(screen, 157, 50, 100, 35);

  if menu = 1 then Brole[bnum].Auto := SelectAutoMode;
  if menu = 0 then
    if not TeamModeMenu then exit;

  if Brole[bnum].Auto = -1 then
  begin
    exit;
  end
  else
  begin
    if Brole[bnum].Auto > -1 then
    begin
      AutoBattle2(bnum);
      Brole[bnum].Acted := 1;
    end;
  end;

end;

//在可医疗范围内，寻找生命不足一半的生命最少的友军，

procedure trymoveHidden(var Mx1, My1, Ax1, Ay1: integer; bnum, inum: integer);
var
  Xlist: array[0..4096] of integer;
  Ylist: array[0..4096] of integer;
  steplist: array[0..4096] of integer;
  curgrid, totalgrid: integer;
  Bgrid: array[1..4] of integer; //0空位，1建筑，2友军，3敌军，4出界，5已走过
  Xinc, Yinc: array[1..4] of integer;
  curX, curY, curstep, nextX, nextY: integer;
  i, i1, i2, eneamount, aim: integer;
  tempX, tempY, tempdis: integer;
  step, myteam, rnum: integer;
  tempminHP, hidden, hurt: integer;

begin
  rnum := Brole[bnum].rnum;
  hidden := GetRoleHidWeapon(rnum, True);
  myteam := Brole[bnum].Team;

  tempminHP := 9999;

  hurt := -(hidden * Ritem[inum].AddCurrentHP) div 100;
  step := hidden div 15 + 1;
  if (GetEquipState(Brole[bnum].rnum, 24)) or (GetGongtiState(Brole[bnum].rnum, 24)) then
    Inc(step);
  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
      Bfield[3, i1, i2] := -1;
  Bfield[3, Brole[bnum].X, Brole[bnum].Y] := 0;

  Xinc[1] := 1;
  Xinc[2] := -1;
  Xinc[3] := 0;
  Xinc[4] := 0;
  Yinc[1] := 0;
  Yinc[2] := 0;
  Yinc[3] := 1;
  Yinc[4] := -1;
  curgrid := 0;
  totalgrid := 0;
  Xlist[totalgrid] := Bx;
  Ylist[totalgrid] := By;
  steplist[totalgrid] := 0;
  totalgrid := totalgrid + 1;
  while curgrid < totalgrid do
  begin
    curX := Xlist[curgrid];
    curY := Ylist[curgrid];

    for i := 0 to length(Brole) - 1 do
    begin
      rnum := Brole[i].rnum;
      if (Brole[i].Team <> myteam) and (Brole[i].rnum >= 0) and (Brole[i].dead = 0) and
        (abs(Brole[i].X - curX) + abs(Brole[i].Y - curY) < step) then
      begin
        if (Rrole[rnum].CurrentHP - hurt < tempminHP) then
        begin
          tempminHP := Rrole[rnum].CurrentHP - hurt;
          Mx1 := curX;
          My1 := curY;
          Ax1 := Brole[i].X;
          Ay1 := Brole[i].Y;
        end;
      end;
    end;

    curstep := steplist[curgrid];
    if curstep < step then
    begin
      //判断当前点四周格子的状况
      for i := 1 to 4 do
      begin
        nextX := curX + Xinc[i];
        nextY := curY + Yinc[i];
        if (nextX < 0) or (nextX > 63) or (nextY < 0) or (nextY > 63) then
          Bgrid[i] := 4
        else if Bfield[3, nextX, nextY] >= 0 then
          Bgrid[i] := 5
        else if Bfield[1, nextX, nextY] > 0 then
          Bgrid[i] := 1
        else if Bfield[2, nextX, nextY] >= 0 then
        begin
          if Brole[Bfield[2, nextX, nextY]].Team = myteam then
            Bgrid[i] := 2
          else
            Bgrid[i] := 3;
        end
        else if ((Bfield[0, nextX, nextY] div 2 >= 179) and (Bfield[0, nextX, nextY] div 2 <= 190)) or
          (Bfield[0, nextX, nextY] div 2 = 261) or (Bfield[0, nextX, nextY] div 2 = 511) or
          ((Bfield[0, nextX, nextY] div 2 >= 224) and (Bfield[0, nextX, nextY] div 2 <= 232)) or
          ((Bfield[0, nextX, nextY] div 2 >= 662) and (Bfield[0, nextX, nextY] div 2 <= 674)) then
          Bgrid[i] := 6
        else
          Bgrid[i] := 0;
      end;

      if (curstep = 0) or ((Bgrid[1] <> 3) and (Bgrid[2] <> 3) and (Bgrid[3] <> 3) and (Bgrid[4] <> 3)) then
      begin
        for i := 1 to 4 do
        begin
          if Bgrid[i] = 0 then
          begin
            Xlist[totalgrid] := curX + Xinc[i];
            Ylist[totalgrid] := curY + Yinc[i];
            steplist[totalgrid] := curstep + 1;
            Bfield[3, Xlist[totalgrid], Ylist[totalgrid]] := steplist[totalgrid];
            totalgrid := totalgrid + 1;
          end;
        end;
      end;
    end;
    curgrid := curgrid + 1;
  end;
end;

procedure Hiddenaction(bnum, inum: integer);
var
  rnum, bnum1, rnum1, poi, addlife, hurt, hidden, i: integer;
begin
  Brole[bnum].Acted := 1;
  instruct_32(inum, -1);
  bnum1 := bfield[2, Ax, Ay];
  rnum1 := Brole[bnum1].rnum;
  rnum := Brole[bnum].rnum;
  hidden := GetRoleHidWeapon(rnum, True);

  hurt := -(hidden * Ritem[inum].AddCurrentHP) div 100;
  hurt := max(hurt, 25);

  if Brole[bnum].Team = 0 then
    hurt := hurt * (200 - Rrole[0].difficulty) div 200;
  if Brole[bnum].Team = 1 then
    hurt := hurt * (200 + Rrole[0].difficulty) div 200;

  Rrole[rnum1].CurrentHP := Rrole[rnum1].CurrentHP - hurt;
  poi := max(0, (hidden * Ritem[inum].AddPoi) div 100 - GetRoleDefPoi(rnum1, True));

  if Brole[bnum].Team = 0 then
    poi := poi * (200 - Rrole[0].difficulty) div 200;
  if Brole[bnum].Team = 1 then
    poi := poi * (200 + Rrole[0].difficulty) div 200;

  if GetGongtiState(Brole[bnum1].rnum, 12) or GetEquipState(Brole[bnum1].rnum, 12) or
    (CheckEquipSet(Rrole[Brole[bnum1].rnum].equip[0], Rrole[Brole[bnum1].rnum].equip[1],
    Rrole[Brole[bnum1].rnum].equip[2], Rrole[Brole[bnum1].rnum].equip[3]) = 4) then
    poi := 0;

  Rrole[rnum1].Poision := Rrole[rnum1].Poision + poi;

  Brole[bnum1].ShowNumber := hurt;
  SetAminationPosition(0, 0, 0);
  playsoundE(Ritem[inum].AmiNum, 0);
  PlayActionAmination(bnum, 0);
  PlayMagicAmination(bnum, 0, Ritem[inum].AmiNum, 0);
  ShowHurtValue(0);
  Brole[bnum].Progress := Brole[bnum].Progress - 240;
  ClearDeadRolePic;
  Brole[bnum].zhuangtai[0] := min(100, Brole[bnum].zhuangtai[0] + 1 + Rrole[Brole[bnum].rnum].CurrentMP *
    (50 + Brole[bnum].zhuangtai[0]) div 100000);
  Brole[bnum].zhuangtai[1] := min(100, Brole[bnum].zhuangtai[1] + 1 + GetRoleDefence(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[1]) div 10000);
  Brole[bnum].zhuangtai[2] := min(100, Brole[bnum].zhuangtai[2] + 1 + GetRoleSpeed(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[2]) div 10000);
  Brole[bnum].zhuangtai[3] := min(100, Brole[bnum].zhuangtai[3] + 1 + Rrole[Brole[bnum].rnum].CurrentHP *
    (50 + Brole[bnum].zhuangtai[3]) div 100000);
  Brole[bnum].zhuangtai[4] := min(100, Brole[bnum].zhuangtai[4] + 1 + GetRoleAttack(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[4]) div 10000);
  for i := 0 to Brole[bnum].Zhuanzhu - 1 do
  begin
    Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i + 2));
    Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] - round((i + 2) / 3 * 10));
    Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] - round((i + 2) / 3 * 10));
    Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] - round((i + 2) / 3 * 10));
    Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] - round((i + 2) / 3 * 5));
  end;
  Brole[bnum].Zhuanzhu := 0;
end;




procedure trymoveUsePoi(var Mx1, My1, Ax1, Ay1: integer; bnum: integer);
var
  Xlist: array[0..4096] of integer;
  Ylist: array[0..4096] of integer;
  steplist: array[0..4096] of integer;
  curgrid, totalgrid: integer;
  Bgrid: array[1..4] of integer; //0空位，1建筑，2友军，3敌军，4出界，5已走过
  Xinc, Yinc: array[1..4] of integer;
  curX, curY, curstep, nextX, nextY: integer;
  i, i1, i2, eneamount, aim: integer;
  tempX, tempY, tempdis: integer;
  step, myteam, curedis, rnum: integer;
  tempminHP: integer;

begin
  step := Brole[bnum].Step;
  myteam := Brole[bnum].Team;
  curedis := GetRoleUsePoi(Brole[bnum].rnum, True) div 15 + 1;

  tempminHP := 0;

  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
      Bfield[3, i1, i2] := -1;
  Bfield[3, Brole[bnum].X, Brole[bnum].Y] := 0;

  Xinc[1] := 1;
  Xinc[2] := -1;
  Xinc[3] := 0;
  Xinc[4] := 0;
  Yinc[1] := 0;
  Yinc[2] := 0;
  Yinc[3] := 1;
  Yinc[4] := -1;
  curgrid := 0;
  totalgrid := 0;
  Xlist[totalgrid] := Bx;
  Ylist[totalgrid] := By;
  steplist[totalgrid] := 0;
  totalgrid := totalgrid + 1;
  while curgrid < totalgrid do
  begin
    curX := Xlist[curgrid];
    curY := Ylist[curgrid];

    for i := 0 to length(Brole) - 1 do
    begin
      rnum := Brole[i].rnum;
      if (Brole[i].Team <> myteam) and (Brole[i].rnum >= 0) and (Brole[i].dead = 0) and
        (abs(Brole[i].X - curX) + abs(Brole[i].Y - curY) < curedis) then
      begin
        if (Rrole[rnum].CurrentHP > tempminHP) then
        begin
          tempminHP := Rrole[rnum].CurrentHP;
          Mx1 := curX;
          My1 := curY;
          Ax1 := Brole[i].X;
          Ay1 := Brole[i].Y;
        end;
      end;
    end;

    curstep := steplist[curgrid];
    if curstep < step then
    begin
      //判断当前点四周格子的状况
      for i := 1 to 4 do
      begin
        nextX := curX + Xinc[i];
        nextY := curY + Yinc[i];
        if (nextX < 0) or (nextX > 63) or (nextY < 0) or (nextY > 63) then
          Bgrid[i] := 4
        else if Bfield[3, nextX, nextY] >= 0 then
          Bgrid[i] := 5
        else if Bfield[1, nextX, nextY] > 0 then
          Bgrid[i] := 1
        else if Bfield[2, nextX, nextY] >= 0 then
        begin
          if Brole[Bfield[2, nextX, nextY]].Team = myteam then
            Bgrid[i] := 2
          else
            Bgrid[i] := 3;
        end
        else if ((Bfield[0, nextX, nextY] div 2 >= 179) and (Bfield[0, nextX, nextY] div 2 <= 190)) or
          (Bfield[0, nextX, nextY] div 2 = 261) or (Bfield[0, nextX, nextY] div 2 = 511) or
          ((Bfield[0, nextX, nextY] div 2 >= 224) and (Bfield[0, nextX, nextY] div 2 <= 232)) or
          ((Bfield[0, nextX, nextY] div 2 >= 662) and (Bfield[0, nextX, nextY] div 2 <= 674)) then
          Bgrid[i] := 6
        else
          Bgrid[i] := 0;
      end;

      if (curstep = 0) or ((Bgrid[1] <> 3) and (Bgrid[2] <> 3) and (Bgrid[3] <> 3) and (Bgrid[4] <> 3)) then
      begin
        for i := 1 to 4 do
        begin
          if Bgrid[i] = 0 then
          begin
            Xlist[totalgrid] := curX + Xinc[i];
            Ylist[totalgrid] := curY + Yinc[i];
            steplist[totalgrid] := curstep + 1;
            Bfield[3, Xlist[totalgrid], Ylist[totalgrid]] := steplist[totalgrid];
            totalgrid := totalgrid + 1;
          end;
        end;
      end;
    end;
    curgrid := curgrid + 1;
  end;
end;

procedure UsePoiaction(bnum: integer);
var
  rnum, addpoi, bnum1, rnum1, addlife, i: integer;
begin
  bnum1 := bfield[2, Ax, Ay];
  if Brole[bnum1].Team <> Brole[bnum].Team then
  begin
    Brole[bnum].Acted := 1;
    //转换伤害对象  4 乾坤大挪移 5斗转星移
    if GetEquipState(Brole[bnum1].rnum, 4) or (GetGongtiState(Brole[bnum1].rnum, 4)) then
      bnum1 := ReMoveHurt(bnum1, bnum);
    if GetEquipState(Brole[bnum1].rnum, 5) or (GetGongtiState(Brole[bnum1].rnum, 5)) then
      bnum1 := RetortHurt(bnum1, bnum);

    rnum := Brole[bnum].rnum;
    if (not GetEquipState(rnum, 1)) and (not GetGongtiState(rnum, 1)) then
      Rrole[rnum].PhyPower := Rrole[rnum].PhyPower - 3;
    rnum1 := Brole[bnum1].rnum;
    addpoi := GetRoleUsePoi(rnum, True) div 3 - GetRoleDefPoi(rnum1, True) div 4;
    if addpoi < 0 then addpoi := 0;

    addpoi := min(addpoi, GetRoleUsePoi(rnum, True) - Rrole[rnum1].Poision);

    if Brole[bnum].Team = 0 then
      addpoi := addpoi * (200 - Rrole[0].difficulty) div 200;
    if Brole[bnum].Team = 1 then
      addpoi := addpoi * (200 + Rrole[0].difficulty) div 200;



    if GetGongtiState(Brole[bnum1].rnum, 12) or GetEquipState(Brole[bnum1].rnum, 12) or
      (CheckEquipSet(Rrole[Brole[bnum1].rnum].equip[0], Rrole[Brole[bnum1].rnum].equip[1],
      Rrole[Brole[bnum1].rnum].equip[2], Rrole[Brole[bnum1].rnum].equip[3]) = 4) then
      addpoi := 0;

    if addpoi > 0 then Inc(Brole[bnum].ExpGot, max(0, addpoi div 5));

    Rrole[rnum1].Poision := Rrole[rnum1].Poision + addpoi;
    Brole[bnum1].ShowNumber := addpoi;
    SetAminationPosition(0, 0, 0);
    playsoundE(34, 0);
    PlayActionAmination(bnum, 0);
    PlayMagicAmination(bnum, 0, 34, 0);
    ShowHurtValue(2);
    Brole[bnum].Progress := Brole[bnum].Progress - 240;
    Brole[bnum].zhuangtai[0] := min(100, Brole[bnum].zhuangtai[0] + 1 + Rrole[Brole[bnum].rnum].CurrentMP *
      (50 + Brole[bnum].zhuangtai[0]) div 100000);
    Brole[bnum].zhuangtai[1] := min(100, Brole[bnum].zhuangtai[1] + 1 + GetRoleDefence(Brole[bnum].rnum, True) *
      (50 + Brole[bnum].zhuangtai[1]) div 10000);
    Brole[bnum].zhuangtai[2] := min(100, Brole[bnum].zhuangtai[2] + 1 + GetRoleSpeed(Brole[bnum].rnum, True) *
      (50 + Brole[bnum].zhuangtai[2]) div 10000);
    Brole[bnum].zhuangtai[3] := min(100, Brole[bnum].zhuangtai[3] + 1 + Rrole[Brole[bnum].rnum].CurrentHP *
      (50 + Brole[bnum].zhuangtai[3]) div 100000);
    Brole[bnum].zhuangtai[4] := min(100, Brole[bnum].zhuangtai[4] + 1 + GetRoleAttack(Brole[bnum].rnum, True) *
      (50 + Brole[bnum].zhuangtai[4]) div 10000);
    for i := 0 to Brole[bnum].Zhuanzhu - 1 do
    begin
      Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i + 2));
      Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] - round((i + 2) / 3 * 10));
      Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] - round((i + 2) / 3 * 10));
      Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] - round((i + 2) / 3 * 10));
      Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] - round((i + 2) / 3 * 5));
    end;
    Brole[bnum].Zhuanzhu := 0;
  end;
end;

procedure trymoveMedPoi(var Mx1, My1, Ax1, Ay1: integer; bnum: integer);
var
  Xlist: array[0..4096] of integer;
  Ylist: array[0..4096] of integer;
  steplist: array[0..4096] of integer;
  curgrid, totalgrid: integer;
  Bgrid: array[1..4] of integer; //0空位，1建筑，2友军，3敌军，4出界，5已走过,6水面
  Xinc, Yinc: array[1..4] of integer;
  curX, curY, curstep, nextX, nextY: integer;
  i, i1, i2, eneamount, aim: integer;
  tempX, tempY, tempdis: integer;
  step, myteam, curedis, rnum: integer;
  tempminHP: integer;

begin
  step := Brole[bnum].Step;
  myteam := Brole[bnum].Team;
  curedis := GetRoleMedPoi(Brole[bnum].rnum, True) div 15 + 1;

  tempminHP := 0;

  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
      Bfield[3, i1, i2] := -1;
  Bfield[3, Brole[bnum].X, Brole[bnum].Y] := 0;

  Xinc[1] := 1;
  Xinc[2] := -1;
  Xinc[3] := 0;
  Xinc[4] := 0;
  Yinc[1] := 0;
  Yinc[2] := 0;
  Yinc[3] := 1;
  Yinc[4] := -1;
  curgrid := 0;
  totalgrid := 0;
  Xlist[totalgrid] := Bx;
  Ylist[totalgrid] := By;
  steplist[totalgrid] := 0;
  totalgrid := totalgrid + 1;
  while curgrid < totalgrid do
  begin
    curX := Xlist[curgrid];
    curY := Ylist[curgrid];

    for i := 0 to length(Brole) - 1 do
    begin
      rnum := Brole[i].rnum;
      if (Brole[i].Team = myteam) and (Brole[i].rnum >= 0) and (Brole[i].dead = 0) and
        (abs(Brole[i].X - curX) + abs(Brole[i].Y - curY) < curedis) and (Rrole[rnum].Poision > 0) then
      begin
        if (Rrole[rnum].Poision > tempminHP) then
        begin
          if GetRoleMedPoi(Brole[bnum].rnum, True) >= (Rrole[rnum].Poision div 2) then
          begin
            tempminHP := Rrole[rnum].Poision;
            Mx1 := curX;
            My1 := curY;
            Ax1 := Brole[i].X;
            Ay1 := Brole[i].Y;
          end;
        end;
      end;
    end;

    curstep := steplist[curgrid];
    if curstep < step then
    begin
      //判断当前点四周格子的状况
      for i := 1 to 4 do
      begin
        nextX := curX + Xinc[i];
        nextY := curY + Yinc[i];
        if (nextX < 0) or (nextX > 63) or (nextY < 0) or (nextY > 63) then
          Bgrid[i] := 4
        else if Bfield[3, nextX, nextY] >= 0 then
          Bgrid[i] := 5
        else if Bfield[1, nextX, nextY] > 0 then
          Bgrid[i] := 1
        else if ((Bfield[0, nextX, nextY] div 2 >= 179) and (Bfield[0, nextX, nextY] div 2 <= 190)) or
          (Bfield[0, nextX, nextY] div 2 = 261) or (Bfield[0, nextX, nextY] div 2 = 511) or
          ((Bfield[0, nextX, nextY] div 2 >= 224) and (Bfield[0, nextX, nextY] div 2 <= 232)) or
          ((Bfield[0, nextX, nextY] div 2 >= 662) and (Bfield[0, nextX, nextY] div 2 <= 674)) then
          Bgrid[i] := 6
        else if Bfield[2, nextX, nextY] >= 0 then
        begin
          if Brole[Bfield[2, nextX, nextY]].Team = myteam then
            Bgrid[i] := 2
          else
            Bgrid[i] := 3;
        end
        else
          Bgrid[i] := 0;
      end;

      if (curstep = 0) or ((Bgrid[1] <> 3) and (Bgrid[2] <> 3) and (Bgrid[3] <> 3) and (Bgrid[4] <> 3)) then
      begin
        for i := 1 to 4 do
        begin
          if Bgrid[i] = 0 then
          begin
            Xlist[totalgrid] := curX + Xinc[i];
            Ylist[totalgrid] := curY + Yinc[i];
            steplist[totalgrid] := curstep + 1;
            Bfield[3, Xlist[totalgrid], Ylist[totalgrid]] := steplist[totalgrid];
            totalgrid := totalgrid + 1;
          end;
        end;
      end;
    end;
    curgrid := curgrid + 1;
  end;
end;

procedure MedPoiaction(bnum: integer);
var
  rnum, bnum1, rnum1, i, medpoi, step, minuspoi: integer;
  select: boolean;
begin
  rnum := Brole[bnum].rnum;
  medpoi := GetRoleMedPoi(rnum, True);
  step := medpoi div 15 + 1;

  bnum1 := bfield[2, Ax, Ay];
  Brole[bnum].Acted := 1;
  if (not GetEquipState(rnum, 1)) and (not GetGongtiState(rnum, 1)) then
    Rrole[rnum].PhyPower := Rrole[rnum].PhyPower - 5;
  rnum1 := Brole[bnum1].rnum;
  minuspoi := GetRoleMedPoi(rnum, True);
  if minuspoi < (Rrole[rnum1].Poision div 2) then
    minuspoi := 0
  else if minuspoi > Rrole[rnum1].Poision then
    minuspoi := Rrole[rnum1].Poision;

  if minuspoi < 0 then minuspoi := 0;
  minuspoi := min(minuspoi, Rrole[rnum1].Poision);
  if minuspoi > 0 then Inc(Brole[bnum].ExpGot, max(0, minuspoi div 5));

  if minuspoi < 0 then minuspoi := 0;
  if Rrole[rnum1].Poision - minuspoi <= 0 then minuspoi := Rrole[rnum1].Poision;
  Rrole[rnum1].Poision := Rrole[rnum1].Poision - minuspoi;
  Brole[bnum1].ShowNumber := minuspoi;
  SetAminationPosition(0, 0, 0);

  if getpetskill(5, 2) and (Brole[bnum].Team = 0) then
  begin
    for i := 0 to length(Brole) - 1 do
    begin
      if (Brole[i].Dead = 0) and (Brole[i].rnum >= 0) and (i <> bnum1) and
        (Brole[i].Team = Brole[bnum1].Team) and (Brole[i].X in [Brole[bnum1].X - 3..Brole[bnum1].X + 3]) and
        (Brole[i].Y in [Brole[bnum1].Y - 3..Brole[bnum1].Y + 3]) then
      begin
        rnum1 := Brole[i].rnum;
        minuspoi := GetRoleMedPoi(rnum, True);

        if minuspoi < (Rrole[rnum1].Poision div 2) then
          minuspoi := 0
        else if minuspoi > Rrole[rnum1].Poision then
          minuspoi := Rrole[rnum1].Poision;

        if minuspoi < 0 then minuspoi := 0;
        minuspoi := min(minuspoi, Rrole[rnum1].Poision);
        if minuspoi > 0 then Inc(Brole[bnum].ExpGot, max(0, minuspoi div 5));

        Rrole[rnum1].Poision := Rrole[rnum1].Poision - minuspoi;
        Brole[i].ShowNumber := minuspoi;

        Bfield[4, Brole[i].X, Brole[i].Y] := 1;
      end;
    end;
  end;
  playsoundE(33, 0);
  PlayActionAmination(bnum, 0);
  PlayMagicAmination(bnum, 0, 33, 0);
  ShowHurtValue(4);
  Brole[bnum].Progress := Brole[bnum].Progress - 240;
  Brole[bnum].zhuangtai[0] := min(100, Brole[bnum].zhuangtai[0] + 1 + Rrole[Brole[bnum].rnum].CurrentMP *
    (50 + Brole[bnum].zhuangtai[0]) div 100000);
  Brole[bnum].zhuangtai[1] := min(100, Brole[bnum].zhuangtai[1] + 1 + GetRoleDefence(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[1]) div 10000);
  Brole[bnum].zhuangtai[2] := min(100, Brole[bnum].zhuangtai[2] + 1 + GetRoleSpeed(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[2]) div 10000);
  Brole[bnum].zhuangtai[3] := min(100, Brole[bnum].zhuangtai[3] + 1 + Rrole[Brole[bnum].rnum].CurrentHP *
    (50 + Brole[bnum].zhuangtai[3]) div 100000);
  Brole[bnum].zhuangtai[4] := min(100, Brole[bnum].zhuangtai[4] + 1 + GetRoleAttack(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[4]) div 10000);
  for i := 0 to Brole[bnum].Zhuanzhu - 1 do
  begin
    Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i + 2));
    Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] - round((i + 2) / 3 * 10));
    Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] - round((i + 2) / 3 * 10));
    Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] - round((i + 2) / 3 * 10));
    Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] - round((i + 2) / 3 * 5));
  end;
  Brole[bnum].Zhuanzhu := 0;
end;

function checkfangyu(var fmnum, fmlev, frznum: integer; rnum, znum: integer): integer;
var
  max2, tm, i, j, j1, k, mnum, ztmp, zttmp1, zttmp2: integer;
  zlist, mlevlist, mnumlist, frznumlist: array of integer;
begin

  max2 := 0;
  ztmp := 0;
  zttmp1 := 0;
  zttmp2 := 0;
  for i := 0 to 9 do
  begin
    if Rrole[rnum].jhmagic[i] < 0 then break;
    mnum := Rrole[rnum].lMagic[Rrole[rnum].jhmagic[i]];
    if (mnum > 0) then
    begin
      if (Rmagic[mnum].MagicType <> 5) then
      begin
        for j := 0 to 4 do
        begin
          tm := Rmagic[mnum].zhaoshi[j];
          if (tm < 1) then break;
          if ((Rrole[rnum].lzhaoshi[Rrole[rnum].jhmagic[i]] and (1 shl j)) <= 0) or (Rzhaoshi[tm].yfangyu < 1) then
            continue;
          setlength(zlist, max2 + 1);
          setlength(mlevlist, max2 + 1);
          setlength(mnumlist, max2 + 1);
          setlength(frznumlist, max2 + 1);
          zlist[max2] := tm;
          mlevlist[max2] := Rrole[rnum].maglevel[Rrole[rnum].jhmagic[i]] div 100 + 1;
          mnumlist[max2] := mnum;
          frznumlist[max2] := Rrole[rnum].jhmagic[i];
          max2 := max2 + 1;
        end;
      end;
    end;
  end;
  if max2 > 0 then
  begin
    k := 0;
    repeat
      begin
        zttmp1 := 0;
        for j := 0 to 23 do
        begin
          if Rzhaoshi[znum].texiao[j].x < 0 then break;
          if (Rzhaoshi[znum].texiao[j].x > 9) then continue;
          if Rzhaoshi[znum].texiao[j].y <> 0 then
          begin
            zttmp1 := zttmp1 - Rzhaoshi[znum].texiao[j].y;
            for j1 := 0 to 23 do
            begin
              if Rzhaoshi[zlist[k]].texiao[j1].x < 0 then break;
              if (Rzhaoshi[zlist[k]].texiao[j1].x >= 30) and (Rzhaoshi[zlist[k]].texiao[j1].x <= 39) then
                Inc(zttmp1, Rzhaoshi[zlist[k]].texiao[j1].y * 10)
              else if (Rzhaoshi[zlist[k]].texiao[j1].x >= 20) and (Rzhaoshi[zlist[k]].texiao[j1].x <= 29) then
                if ((Rzhaoshi[zlist[k]].texiao[j1].x - 20) = Rzhaoshi[znum].texiao[j].x) and
                  (Rzhaoshi[zlist[k]].texiao[j1].y <> 0) then
                  zttmp1 := zttmp1 + round(power(min(Rzhaoshi[znum].texiao[j].y,
                    Rzhaoshi[zlist[k]].texiao[j1].y * (mlevlist[k] - 1) div 9), 1.1));
            end;
          end;
        end;

        if ztmp > 0 then
        begin
          if ((900 + rzhaoshi[zlist[k]].fangyu * (mlevlist[k] - 1)) div 9 * (100 + zttmp1)) >
            ((900 + rzhaoshi[ztmp].fangyu * (fmlev - 1)) div 9 * (100 + zttmp2)) then
          begin
            zttmp2 := zttmp1;
            ztmp := zlist[k];
            fmnum := mnumlist[k];
            fmlev := mlevlist[k];
            frznum := frznumlist[k];
          end;
        end
        else
        begin
          zttmp2 := zttmp1;
          ztmp := zlist[k];
          fmnum := mnumlist[k];
          fmlev := mlevlist[k];
          frznum := frznumlist[k];
        end;
        k := k + 1;
      end;
    until k > max2 - 1;
  end;

  Result := ztmp;
end;



procedure diexiaoguo(bnum: integer);
var
  i: integer;
begin

  BShowBWord.sign := BShowBWord.sign or (1 shl 5);
  BShowBWord.starttime[5] := SDL_GetTicks;
  BShowBWord.rnum[5] := Brole[bnum].rnum;
  BShowBWord.col1[5] := 121;
  BShowBWord.col1[5] := 120;
  BShowBWord.x[5] := Brole[bnum].x;
  BShowBWord.y[5] := Brole[bnum].y;
  BShowBWord.delay[5] := 30000;
  if Rrole[Brole[bnum].rnum].Sexual = 2 then
    BShowBWord.words[5] := allbtalk.etalk[1][random(5)]
  else
    BShowBWord.words[5] := allbtalk.talk[Rrole[Brole[bnum].rnum].Sexual][1]
      [Rrole[Brole[bnum].rnum].xiangxing][random(5)];

  BShowBWord.Sx[5] := sign(1 - random(4)) * (random(100) / 41 + 0.2);
  BShowBWord.Sy[5] := random(100) / 67;

  for i := 0 to length(Brole) - 1 do
  begin
    if (Brole[i].dead = 0) and (Brole[i].rnum >= 0) and (Rrole[Brole[i].rnum].CurrentHP > 0) and
      (Brole[i].Team = Brole[bnum].Team) then
    begin
      Inc(Rrole[Brole[i].rnum].Angry, (10 + random(10)));
      Rrole[Brole[i].rnum].Angry := min(100, Rrole[Brole[i].rnum].Angry);
      if random(3) = 0 then
      begin
        BShowBWord.sign := BShowBWord.sign or (1 shl 6);
        BShowBWord.starttime[6] := SDL_GetTicks;
        BShowBWord.rnum[6] := Brole[i].rnum;
        BShowBWord.col1[6] := 79;
        BShowBWord.col1[6] := 78;
        BShowBWord.x[6] := Brole[i].x;
        BShowBWord.y[6] := Brole[i].y;
        BShowBWord.delay[6] := 30000;
        if Rrole[Brole[bnum].rnum].Sexual = 2 then
          BShowBWord.words[6] := allbtalk.etalk[2][random(5)]
        else
          BShowBWord.words[6] := allbtalk.talk[Rrole[Brole[bnum].rnum].Sexual][2]
            [Rrole[Brole[bnum].rnum].xiangxing][random(5)];

        BShowBWord.Sx[6] := sign(1 - random(4)) * (random(100) / 41 + 0.2);
        BShowBWord.Sy[6] := random(100) / 67;
      end;
    end;
  end;
end;

procedure addzhuangtai(bnum, mnum, level: integer);
var
  i, k, i1, i2, rnum: integer;
  add: array[0..13] of integer;
begin
  rnum := Brole[bnum].rnum;
  if Rrole[rnum].CurrentMP < Rmagic[mnum].NeedMP * level then
    level := Rrole[rnum].CurrentMP div Rmagic[mnum].NeedMP;
  for i := 0 to 13 do
    add[i] := 0;
  k := 0;
  for i := 0 to 23 do
  begin
    if Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x < 0 then break;
    if (Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x >= 10) and (Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x <= 18) then
    begin
      add[Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x - 5] :=
        Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].y * (level - 1) div 9;
      Inc(k);
    end
    else if (Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x >= 50) and
      (Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x <= 54) then
    begin
      add[Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].x - 50] :=
        -Rzhaoshi[Brole[bnum].szhaoshi].texiao[i].y * (level - 1) div 9;
      Inc(k);
    end;
  end;
  if k > 0 then
  begin
    for i := 0 to 9 do
    begin
      Brole[bnum].zhuangtai[i] := max(Brole[bnum].lzhuangtai[i], min(Brole[bnum].zhuangtai[i] + add[i], 100));
    end;
    for i := 10 to 13 do
    begin
      Brole[bnum].zhuangtai[i] := max(0, min(Brole[bnum].zhuangtai[i] + add[i], 100));
    end;
  end;

  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
      Bfield[4, i1, i2] := 0;
  Bfield[4, Brole[bnum].x, Brole[bnum].y] := 1;
  ShowMagicName(mnum);
  playsoundE(Rmagic[mnum].SoundNum, 0);
  Ax := Brole[bnum].x;
  Ay := Brole[bnum].y;
  PlayActionAmination(bnum, Rmagic[mnum].MagicType); //动画效果
  PlayMagicAmination(bnum, Rmagic[mnum].bigami, Rmagic[mnum].AmiNum, 10); //武功效果
  Bfield[4, Brole[bnum].x, Brole[bnum].y] := -1;

  Dec(Rrole[rnum].CurrentMP, Rmagic[mnum].NeedMP * level);
  Brole[bnum].Progress := Brole[bnum].Progress - 300;
  Brole[bnum].Acted := 1;
  Brole[bnum].zhuangtai[0] := min(100, Brole[bnum].zhuangtai[0] + 1 + Rrole[Brole[bnum].rnum].CurrentMP *
    (50 + Brole[bnum].zhuangtai[0]) div 100000);
  Brole[bnum].zhuangtai[1] := min(100, Brole[bnum].zhuangtai[1] + 1 + GetRoleDefence(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[1]) div 10000);
  Brole[bnum].zhuangtai[2] := min(100, Brole[bnum].zhuangtai[2] + 1 + GetRoleSpeed(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[2]) div 10000);
  Brole[bnum].zhuangtai[3] := min(100, Brole[bnum].zhuangtai[3] + 1 + Rrole[Brole[bnum].rnum].CurrentHP *
    (50 + Brole[bnum].zhuangtai[3]) div 100000);
  Brole[bnum].zhuangtai[4] := min(100, Brole[bnum].zhuangtai[4] + 1 + GetRoleAttack(Brole[bnum].rnum, True) *
    (50 + Brole[bnum].zhuangtai[4]) div 10000);
  for i := 0 to Brole[bnum].Zhuanzhu - 1 do
  begin
    Brole[bnum].zhuangtai[5] := max(Brole[bnum].lzhuangtai[5], Brole[bnum].zhuangtai[5] - round(i + 2));
    Brole[bnum].zhuangtai[6] := max(Brole[bnum].lzhuangtai[6], Brole[bnum].zhuangtai[6] - round((i + 2) / 3 * 10));
    Brole[bnum].zhuangtai[7] := max(Brole[bnum].lzhuangtai[7], Brole[bnum].zhuangtai[7] - round((i + 2) / 3 * 10));
    Brole[bnum].zhuangtai[8] := max(Brole[bnum].lzhuangtai[8], Brole[bnum].zhuangtai[8] - round((i + 2) / 3 * 10));
    Brole[bnum].zhuangtai[9] := max(Brole[bnum].lzhuangtai[9], Brole[bnum].zhuangtai[9] - round((i + 2) / 3 * 5));
  end;
  Brole[bnum].Zhuanzhu := 0;

end;

procedure zengyuan(mods, id: integer);
var
  i, i1, i2, j, j1, j2, len, Count, n0: integer;
begin
  if (mods = 0) or (mods < 0) then
  begin
    Count := 0;
    len := length(mpbdata[id].BTeam[0].rolearr);
    for i := 0 to length(Brole) - 1 do
    begin
      if len < Count then
        break;
      if (Brole[i].rnum = -1) and (Brole[i].x > -1) and (Brole[i].y > -1) then
      begin
        i1 := Brole[i].X;
        i2 := Brole[i].Y;
        if (bfield[2, i1, i2] = -1) then
        begin

          for j := 0 to len - 1 do
          begin
            if mpbdata[id].BTeam[0].rolearr[j].isin = 0 then
            begin
              Brole[i].rnum := mpbdata[id].BTeam[0].rolearr[j].rnum;
              mpbdata[id].BTeam[0].rolearr[j].isin := 1;
              Brole[i].Team := 0;
              Brole[i].Dead := 0;
              Brole[i].Show := 0;
              Brole[i].auto := 3;
              Brole[i].speed := GetRoleSpeed(Brole[i].rnum, True);
              if CheckEquipSet(Rrole[Brole[i].rnum].Equip[0], Rrole[Brole[i].rnum].Equip[1],
                Rrole[Brole[i].rnum].Equip[2], Rrole[Brole[i].rnum].Equip[3]) = 5 then
                Inc(Brole[i].speed, 30);
              Brole[i].Step := Brole[i].speed div 15;
              Brole[i].Progress := 0;
              Brole[i].X := i1;
              Brole[i].Y := i2;
              bfield[2, i1, i2] := i;
              maxspeed := max(maxspeed, Brole[i].speed);

              Brole[i].Step := 0;
              Brole[i].Acted := 0;
              Brole[i].ExpGot := 0;
              Brole[i].round := 0;
              Brole[i].Wait := 0;
              Brole[i].frozen := 0;
              Brole[i].killed := 0;
              Brole[i].Knowledge := 0;
              Brole[i].zhuanzhu := 0;
              Brole[i].szhaoshi := 0;
              Brole[i].pozhao := 0;
              Brole[i].wanfang := 0;
              for j1 := 0 to 4 do
              begin
                n0 := 0;
                if Brole[i].rnum > -1 then
                  for j2 := 0 to 9 do
                    if Rrole[Brole[i].rnum].Gongti > 0 then
                      if (Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MoveDistance[j2] =
                        60 + j1) then
                        n0 := Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].AttDistance[j2];
                Brole[i].zhuangtai[j1] := 100;
                Brole[i].lzhuangtai[j1] := n0;
              end;
              for j1 := 5 to 9 do
              begin
                n0 := 0;
                if Brole[i].rnum > -1 then
                  for j2 := 0 to 9 do
                    if Rrole[Brole[i].rnum].Gongti > 0 then
                      if (Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MoveDistance[j2] =
                        60 + j1) then
                        n0 := Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].AttDistance[j2];
                Brole[i].zhuangtai[j1] := n0;
                Brole[i].lzhuangtai[j1] := n0;
              end;
              for j1 := 10 to 13 do
                Brole[i].zhuangtai[j1] := 0;



              break;
            end;
            Inc(Count);
          end;
        end;
      end;
    end;
    if len > Count then
    begin
      for i := 0 to length(Brole) - 1 do
      begin
        if len <= Count then
          break;
        if (Brole[i].dead = 1) and (Brole[i].x > -1) and (Brole[i].y > -1) and (Brole[i].Team = 0) then
        begin
          i1 := Brole[i].X;
          i2 := Brole[i].Y;
          if (bfield[2, i1, i2] = -1) then
          begin
            for j := 0 to len - 1 do
            begin
              if mpbdata[id].BTeam[0].rolearr[j].isin = 0 then
              begin
                Brole[i].rnum := mpbdata[id].BTeam[0].rolearr[j].rnum;
                mpbdata[id].BTeam[0].rolearr[j].isin := 1;
                Brole[i].Dead := 0;
                Brole[i].Show := 0;
                Brole[i].auto := 3;
                Brole[i].speed := GetRoleSpeed(Brole[i].rnum, True);
                if CheckEquipSet(Rrole[Brole[i].rnum].Equip[0], Rrole[Brole[i].rnum].Equip[1],
                  Rrole[Brole[i].rnum].Equip[2], Rrole[Brole[i].rnum].Equip[3]) = 5 then
                  Inc(Brole[i].speed, 30);
                Brole[i].Step := Brole[i].speed div 15;
                Brole[i].Progress := 0;
                Brole[i].X := i1;
                Brole[i].Y := i2;
                bfield[2, i1, i2] := i;
                maxspeed := max(maxspeed, Brole[i].speed);
                Brole[i].Step := 0;
                Brole[i].Acted := 0;
                Brole[i].ExpGot := 0;
                Brole[i].round := 0;
                Brole[i].Wait := 0;
                Brole[i].frozen := 0;
                Brole[i].killed := 0;
                Brole[i].Knowledge := 0;
                Brole[i].zhuanzhu := 0;
                Brole[i].szhaoshi := 0;
                Brole[i].pozhao := 0;
                Brole[i].wanfang := 0;
                for j1 := 0 to 4 do
                begin
                  n0 := 0;
                  if Brole[i].rnum > -1 then
                    for j2 := 0 to 9 do
                      if Rrole[Brole[i].rnum].Gongti > 0 then
                        if (Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MoveDistance[j2] =
                          60 + j1) then
                          n0 := Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].AttDistance[j2];
                  Brole[i].zhuangtai[j1] := 100;
                  Brole[i].lzhuangtai[j1] := n0;
                end;
                for j1 := 5 to 9 do
                begin
                  n0 := 0;
                  if Brole[i].rnum > -1 then
                    for j2 := 0 to 9 do
                      if Rrole[Brole[i].rnum].Gongti > 0 then
                        if (Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MoveDistance[j2] =
                          60 + j1) then
                          n0 := Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].AttDistance[j2];
                  Brole[i].zhuangtai[j1] := n0;
                  Brole[i].lzhuangtai[j1] := n0;
                end;
                for j1 := 10 to 13 do
                  Brole[i].zhuangtai[j1] := 0;
                break;
              end;
              Inc(Count);
            end;
          end;
        end;
      end;
    end;
  end;
  if (mods = 1) or (mods < 0) then
  begin
    Count := 0;
    len := length(mpbdata[id].BTeam[1].rolearr);
    for i := 0 to length(Brole) - 1 do
    begin
      if len <= Count then
        break;
      if (Brole[i].rnum = -1) and (Brole[i].x > -1) and (Brole[i].y > -1) then
      begin
        i1 := Brole[i].X;
        i2 := Brole[i].Y;
        if (bfield[2, i1, i2] = -1) then
        begin
          for j := 0 to len - 1 do
          begin
            if mpbdata[id].BTeam[1].rolearr[j].isin = 0 then
            begin
              Brole[i].rnum := mpbdata[id].BTeam[1].rolearr[j].rnum;
              mpbdata[id].BTeam[1].rolearr[j].isin := 1;
              Brole[i].Team := 1;
              Brole[i].Dead := 0;
              Brole[i].Show := 0;
              Brole[i].auto := -1;
              Brole[i].speed := GetRoleSpeed(Brole[i].rnum, True);
              if CheckEquipSet(Rrole[Brole[i].rnum].Equip[0], Rrole[Brole[i].rnum].Equip[1],
                Rrole[Brole[i].rnum].Equip[2], Rrole[Brole[i].rnum].Equip[3]) = 5 then
                Inc(Brole[i].speed, 30);
              Brole[i].Step := Brole[i].speed div 15;
              Brole[i].Progress := 0;
              Brole[i].X := i1;
              Brole[i].Y := i2;
              bfield[2, i1, i2] := i;
              maxspeed := max(maxspeed, Brole[i].speed);

              Brole[i].Step := 0;
              Brole[i].Acted := 0;
              Brole[i].ExpGot := 0;
              Brole[i].round := 0;
              Brole[i].Wait := 0;
              Brole[i].frozen := 0;
              Brole[i].killed := 0;
              Brole[i].Knowledge := 0;
              Brole[i].zhuanzhu := 0;
              Brole[i].szhaoshi := 0;
              Brole[i].pozhao := 0;
              Brole[i].wanfang := 0;
              for j1 := 0 to 4 do
              begin
                n0 := 0;
                if Brole[i].rnum > -1 then
                  for j2 := 0 to 9 do
                    if Rrole[Brole[i].rnum].Gongti > 0 then
                      if (Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MoveDistance[j2] =
                        60 + j1) then
                        n0 := Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].AttDistance[j2];
                Brole[i].zhuangtai[j1] := 100;
                Brole[i].lzhuangtai[j1] := n0;
              end;
              for j1 := 5 to 9 do
              begin
                n0 := 0;
                if Brole[i].rnum > -1 then
                  for j2 := 0 to 9 do
                    if Rrole[Brole[i].rnum].Gongti > 0 then
                      if (Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MoveDistance[j2] =
                        60 + j1) then
                        n0 := Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].AttDistance[j2];
                Brole[i].zhuangtai[j1] := n0;
                Brole[i].lzhuangtai[j1] := n0;
              end;
              for j1 := 10 to 13 do
                Brole[i].zhuangtai[j1] := 0;
              break;
            end;
            Inc(Count);
          end;
        end;
      end;
    end;

    if len > Count then
    begin
      for i := 0 to length(Brole) - 1 do
      begin
        if len <= Count then
          break;
        if (Brole[i].dead = 1) and (Brole[i].x > -1) and (Brole[i].y > -1) and (Brole[i].Team = 1) then
        begin
          i1 := Brole[i].X;
          i2 := Brole[i].Y;
          if (bfield[2, i1, i2] = -1) then
          begin
            for j := 0 to len - 1 do
            begin
              if mpbdata[id].BTeam[1].rolearr[j].isin = 0 then
              begin
                Brole[i].rnum := mpbdata[id].BTeam[1].rolearr[j].rnum;
                mpbdata[id].BTeam[1].rolearr[j].isin := 1;
                Brole[i].Dead := 0;
                Brole[i].Show := 0;
                Brole[i].auto := -1;
                Brole[i].speed := GetRoleSpeed(Brole[i].rnum, True);
                if CheckEquipSet(Rrole[Brole[i].rnum].Equip[0], Rrole[Brole[i].rnum].Equip[1],
                  Rrole[Brole[i].rnum].Equip[2], Rrole[Brole[i].rnum].Equip[3]) = 5 then
                  Inc(Brole[i].speed, 30);
                Brole[i].Step := Brole[i].speed div 15;
                Brole[i].Progress := 0;
                Brole[i].X := i1;
                Brole[i].Y := i2;
                bfield[2, i1, i2] := i;
                maxspeed := max(maxspeed, Brole[i].speed);

                Brole[i].Step := 0;
                Brole[i].Acted := 0;
                Brole[i].ExpGot := 0;
                Brole[i].round := 0;
                Brole[i].Wait := 0;
                Brole[i].frozen := 0;
                Brole[i].killed := 0;
                Brole[i].Knowledge := 0;
                Brole[i].zhuanzhu := 0;
                Brole[i].szhaoshi := 0;
                Brole[i].pozhao := 0;
                Brole[i].wanfang := 0;
                for j1 := 0 to 4 do
                begin
                  n0 := 0;
                  if Brole[i].rnum > -1 then
                    for j2 := 0 to 9 do
                      if Rrole[Brole[i].rnum].Gongti > 0 then
                        if (Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MoveDistance[j2] =
                          60 + j1) then
                          n0 := Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].AttDistance[j2];
                  Brole[i].zhuangtai[j1] := 100;
                  Brole[i].lzhuangtai[j1] := n0;
                end;
                for j1 := 5 to 9 do
                begin
                  n0 := 0;
                  if Brole[i].rnum > -1 then
                    for j2 := 0 to 9 do
                      if Rrole[Brole[i].rnum].Gongti > 0 then
                        if (Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MoveDistance[j2] =
                          60 + j1) then
                          n0 := Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].AttDistance[j2];
                  Brole[i].zhuangtai[j1] := n0;
                  Brole[i].lzhuangtai[j1] := n0;
                end;
                for j1 := 10 to 13 do
                  Brole[i].zhuangtai[j1] := 0;
                break;
              end;
              Inc(Count);
            end;
          end;
        end;
      end;
    end;
  end;
end;

function courthurt(bnum1, bnum2, mnum, level: integer; var tzhaoshi1: integer): integer;
var
  a1, a2, rnum, znum, i: integer;
  thurt, thurt0, mthurt: double;

begin
  Result := 0;
  mthurt := 0;
  znum := 0;
  rnum := Brole[bnum1].rnum;
  for i := 0 to 9 do
    if Rrole[rnum].LMagic[Rrole[rnum].jhMagic[i]] = mnum then
    begin
      znum := Rrole[rnum].jhMagic[i];
      break;
    end;

  thurt0 := CalHurtValue(bnum1, bnum2, mnum, level);

  if (Rrole[Brole[bnum2].rnum].CurrentHP - thurt0) < 0 then
  begin
    thurt0 := min(thurt0 * 4, thurt0 * (100 + (((thurt0 - Rrole[Brole[bnum2].rnum].CurrentHP) * 5) *
      ((thurt0 - Rrole[Brole[bnum2].rnum].CurrentHP) * 5))) / 100);
  end
  else
  begin
    thurt0 := min(thurt0 * 2, round((5 * thurt0 + ((5 * thurt0 * thurt0) /
      (max(1, round(Rrole[Brole[bnum2].rnum].CurrentHP - thurt0))))) / 6));
  end;
  thurt0 := thurt0 * (100 + (Rmagic[mnum].minpeg + (Rmagic[mnum].maxpeg - Rmagic[mnum].minpeg) *
    (level - 1) * (100 - Brole[bnum2].zhuangtai[0])) / 9) *
    (100 + (Rmagic[mnum].minpeg + (Rmagic[mnum].maxpeg - Rmagic[mnum].minpeg) * (level - 1) *
    (100 - Brole[bnum2].zhuangtai[0])) / 9) / 10000;

  for a1 := 0 to 4 do
  begin
    thurt := thurt0;
    if Rmagic[mnum].zhaoshi[a1] <= 0 then break;
    if ((Rrole[rnum].lzhaoshi[znum] and (1 shl a1)) = 0) or (Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].ygongji < 1) then
      continue;
    thurt := (thurt * (900 + Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].gongji * (level - 1))) / 900;
    for a2 := 0 to 23 do
    begin
      if (Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].x < 0) then break;
      if (Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].x <= 9) and
        (Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].y > 0) then
      begin
        thurt := max(1, (power((200 - Brole[bnum2].lzhuangtai[Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].x] -
          (Brole[bnum2].zhuangtai[Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].x] -
          Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].y)) / 100, 1.2)) / 1.2) * thurt;

      end
      else if (Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].x >= 10) and
        (Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].x <= 19) and
        (Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].y > 0) then
        thurt := (100 + 2 * min(100 - Brole[bnum1].zhuangtai[Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].x - 5],
          Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].y)) * thurt / 100
      else if (Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].x >= 30) and
        (Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].x <= 39) and
        (Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].y > 0) then
        thurt := (100 + 10 * min(100 - Brole[bnum1].zhuangtai[Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].x - 30],
          Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].y)) * thurt / 100
      else if (Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].x >= 50) and
        (Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].x <= 59) and
        (Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].y > 0) then
        thurt := (100 - min((Brole[bnum1].zhuangtai[Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].x - 50] -
          Brole[bnum1].lzhuangtai[Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].x - 50]),
          Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].y) * Rrole[Brole[bnum1].rnum].CurrentHP /
          Rrole[Brole[bnum1].rnum].MaxHP) * thurt / 100
      else if (Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].x >= 70) and
        (Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].x <= 89) and
        (Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].y > 0) then
        for i := 0 to 9 do
        begin
          if (Rmagic[Rrole[rnum].LMagic[Rrole[rnum].Gongti]].MoveDistance[i] =
            Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].x) then
          begin
            thurt := thurt * (100 + Rzhaoshi[Rmagic[mnum].zhaoshi[a1]].texiao[a2].y) / 100;
          end;
        end;
    end;
    if thurt > mthurt then
    begin
      mthurt := thurt;
      tzhaoshi1 := Rmagic[mnum].zhaoshi[a1];
    end;
  end;
  if mthurt > 0 then Result := round(mthurt);
end;

procedure magicexp(bnum, mnum, level, rmnum: integer);
var
  rnum, nolw, nnum, lwnum, lwstatus, i1, p, Aptitude, wpn, gtlev,add: integer;
  str: string;
  str1: WideString;
begin
  if (bnum < 0) or (mnum < 1) or (rmnum < 0) then
    exit;
  rnum := Brole[bnum].rnum;
  wpn := 0;
  if Brole[bnum].team = 0 then
  begin
    wujishu[mnum] := min(100, wujishu[mnum] + random(7) div 2);
    if Rrole[rnum].Gongti >= 0 then
      wujishu[Rrole[rnum].LMagic[Rrole[rnum].Gongti]] :=
        min(100, wujishu[Rrole[rnum].LMagic[Rrole[rnum].Gongti]] + random(10) div 7);
  end
  else wujishu[mnum] := min(100, wujishu[mnum] + random(3) div 2);
  add:=2;
  if level <= 2 then
  begin
    add:= max(0,-1 + random(level + 2));
  end;
  Rrole[rnum].MagLevel[rmnum] := Rrole[rnum].MagLevel[rmnum] + add;
  if CheckEquipSet(Rrole[rnum].equip[0], Rrole[rnum].equip[1], Rrole[rnum].equip[2], Rrole[rnum].equip[3]) = 2 then
    Aptitude := 100
  else Aptitude := Rrole[rnum].Aptitude;
  if random(150) < (Aptitude + 50) then
    Rrole[rnum].MagLevel[rmnum] := Rrole[rnum].MagLevel[rmnum] + add;
  if level > 1 then
  begin

    nolw := 0;
    lwstatus := 0;
    nnum := 0;

    for i1 := 0 to 4 do
    begin
      if Rmagic[mnum].zhaoshi[i1] <= 0 then
        break;
      Inc(nolw);

    end;
    nolw := nolw - 1;
    lwstatus := Rrole[rnum].lzhaoshi[rmnum];
    for i1 := 0 to nolw do
      if (lwstatus and (1 shl i1)) = 0 then
        Inc(nnum);
    if nnum > 0 then
    begin
      case Rmagic[mnum].MagicType of
        1: begin wpn := MaxFist; end;
        2: begin wpn := MaxSword; end;
        3: begin wpn := MaxKnife; end;
        4: begin wpn := MaxUnusual; end;
      end;

      if Ritem[Rmagic[mnum].miji].NeedAptitude >= 0 then
        Aptitude := wpn + round(2 * (Aptitude - 1.4 * Ritem[Rmagic[mnum].miji].NeedAptitude))
      else
        Aptitude := wpn - round(4 * (Ritem[Rmagic[mnum].miji].NeedAptitude + 1.4 * Aptitude));
      if random(10000) + 30 <= Aptitude then
      begin
        lwnum := random(nnum);
        p := 0;
        for i1 := 0 to nolw do
          if (lwstatus and (1 shl i1)) = 0 then
          begin
            Inc(p);
            if p > lwnum then
              break;
          end;
        Rrole[rnum].lzhaoshi[rmnum] := Rrole[rnum].lzhaoshi[rmnum] or (1 shl i1);

        EatOneItem(rnum, Rmagic[mnum].miji, True);
        DrawRectangle(220, 70 - 30, 220, 25, 0, ColColor(255), 25);
        str1 := GBKtoUnicode(@Rrole[rnum].Name);
        str1 := str1 + '領悟';
        str1 := str1 + GBKtoUnicode(@Rzhaoshi[Rmagic[mnum].zhaoshi[i1]].Name);
        DrawShadowText(@str1[1], 203, 72 - 30, ColColor($21), ColColor($23));
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        WaitAnyKey;
        Redraw;
        Rrole[rnum].MagLevel[rmnum] := Rrole[rnum].MagLevel[rmnum] + 100;
      end;
    end;
    if Rrole[rnum].MagLevel[rmnum] > 999 then Rrole[rnum].MagLevel[rmnum] := 999;
    if (level < Rrole[rnum].MagLevel[rmnum] div 100 + 1) then
    begin
      if (level < Rrole[rnum].MagLevel[rmnum] div 100) then
      begin
        EatOneItem(rnum, Rmagic[mnum].miji, True);
        WaitAnyKey;
      end;
      EatOneItem(rnum, Rmagic[mnum].miji, True);

      if Rrole[rnum].MagLevel[rmnum] div 100 >= 2 then
        if Rrole[rnum].PracticeBook >= 0 then
          if Ritem[Rrole[rnum].PracticeBook].Magic = Rrole[rnum].lMagic[rmnum] then
          begin
            instruct_32(Rrole[rnum].PracticeBook, 1);
            Rrole[rnum].PracticeBook := -1;
            //Rrole[rnum].ExpForBook := 0;
          end;

      DrawRectangle(220, 70 - 30, 200, 25, 0, ColColor(255), 25);
      str := '升為' + IntToStr(Rrole[rnum].MagLevel[rmnum] div 100 + 1) + '級';
      str1 := GBKtoUnicode(@str[1]);
      DrawShadowText(@str1[1], 303, 72 - 30, ColColor($21), ColColor($23));
      Drawgbkshadowtext(@Rmagic[Rrole[rnum].lMagic[rmnum]].Name, 203, 72 - 30, ColColor($64), ColColor($66));
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      WaitAnyKey;
      Redraw;

    end;
  end;
  gtlev := -1;
  if Rrole[rnum].gongti >= 0 then
  begin
    gtlev := Rrole[rnum].MagLevel[Rrole[rnum].gongti] div 100;

  end;
  if gtlev > -1 then
  begin
    Inc(Rrole[rnum].MagLevel[Rrole[rnum].gongti], random(10) div 8);
    if (Rrole[rnum].MagLevel[Rrole[rnum].gongti] >= (gtlev + 1) * 100) then
    begin
      if (gtlev + 1) <= Rmagic[Rrole[rnum].LMagic[Rrole[rnum].gongti]].MaxLevel then
      begin
        EatOneItem(rnum, Rmagic[Rrole[rnum].LMagic[Rrole[rnum].gongti]].miji, True);
        inc(Rrole[rnum].MaxHP, Rmagic[Rrole[rnum].lmagic[Rrole[rnum].gongti]].Addhp[gtlev + 1]
         - Rmagic[Rrole[rnum].lmagic[Rrole[rnum].gongti]].Addhp[gtlev]);
        inc(Rrole[rnum].MaxMP, Rmagic[Rrole[rnum].lmagic[Rrole[rnum].gongti]].Addmp[gtlev + 1]
         - Rmagic[Rrole[rnum].lmagic[Rrole[rnum].gongti]].Addmp[gtlev]);
        if Rrole[rnum].PracticeBook >= 0 then
        begin
          if Rrole[rnum].PracticeBook = Rmagic[Rrole[rnum].LMagic[Rrole[rnum].gongti]].miji then
          begin
            instruct_32(Rrole[rnum].PracticeBook, 1);
            Rrole[rnum].PracticeBook := -1;
          end;
        end;
        DrawRectangle(220, 70 - 30, 200, 25, 0, ColColor(255), 25);
        str := '升為' + IntToStr(gtlev + 2) + '級';
        str1 := GBKtoUnicode(@str[1]);
        DrawShadowText(@str1[1], 303, 72 - 30, ColColor($21), ColColor($23));
        Drawgbkshadowtext(@Rmagic[Rrole[rnum].LMagic[Rrole[rnum].gongti]].Name, 203, 72 - 30,
          ColColor($64), ColColor($66));
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        WaitAnyKey;
        Redraw;
      end
      else
        Rrole[rnum].MagLevel[Rrole[rnum].gongti] := (gtlev + 1) * 100 - 1;
    end;
  end;
end;
function FindFightPos(team:integer):Tposition;
var
  i,i1,nextX,nextY:integer;
  Xinc, Yinc: array[1..4] of integer;
begin
  Xinc[1] := 0;
  Xinc[2] := 1;
  Xinc[3] := -1;
  Xinc[4] := 0;
  Yinc[1] := -1;
  Yinc[2] := 0;
  Yinc[3] := 0;
  Yinc[4] := 1;
  result.x:=-1;
  result.y:=-1;
  for i := 0 to 41 do
  begin
    if Brole[i].Team = team then
    begin
      for i1 := 1 to 4 do
      begin
        nextX:=Brole[i].X + Xinc[i1];
        nextY:=Brole[i].y + yinc[i1];
        if (nextX < 0) or (nextX > 63) or (nextY < 0) or (nextY > 63) then
          continue
        else if Bfield[1, nextX, nextY] > 0 then
          continue
        else if Bfield[2, nextX, nextY] >= 0 then
        begin
          continue
        end
        else if ((Bfield[0, nextX, nextY] div 2 >= 179) and (Bfield[0, nextX, nextY] div 2 <= 190)) or
          (Bfield[0, nextX, nextY] div 2 = 261) or (Bfield[0, nextX, nextY] div 2 = 511) or
          ((Bfield[0, nextX, nextY] div 2 >= 224) and (Bfield[0, nextX, nextY] div 2 <= 232)) or
          ((Bfield[0, nextX, nextY] div 2 >= 662) and (Bfield[0, nextX, nextY] div 2 <= 674)) then
          continue
        else
        begin
          result.x:=nextX;
          result.y:=nextY;
          exit;
        end;
      end;
    end;
  end;
end;
end.
