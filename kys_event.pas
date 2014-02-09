unit kys_event;

interface

uses
  SysUtils,
  Windows,
  Math,
  Dialogs,
  StrUtils,
  SDL,
  SDL_TTF,
  sdl_gfx,
  //SDL_mixer,
  bass,
  SDL_image,
  kys_type,
  kys_littlegame,
  kys_main;

//�¼�ϵͳ
//��Ӣ����, instructͨ������Ϊ����, swimmingfish������һ�ݷ�����ļ��д���ʹ��
//����ʱ�ʾ"ָ��", ���������Ա��������÷�
procedure instruct_0;
procedure instruct_1(talknum, headnum, dismode: integer);
procedure instruct_2(inum, amount: integer);
procedure ReArrangeItem;
procedure instruct_3(list: array of integer);
function instruct_4(inum, jump1, jump2: integer): integer;
function instruct_5(jump1, jump2: integer): integer;
function instruct_6(battlenum, jump1, jump2, getexp: integer): integer;
procedure instruct_8(musicnum: integer);
function instruct_9(jump1, jump2: integer): integer;
procedure instruct_10(rnum: integer);
function instruct_11(jump1, jump2: integer): integer;
procedure instruct_12;
procedure instruct_13;
procedure instruct_14;
procedure instruct_15;
function instruct_16(rnum, jump1, jump2: integer): integer;
procedure instruct_17(list: array of integer);
function instruct_18(inum, jump1, jump2: integer): integer;
procedure instruct_19(x, y: integer);
function instruct_20(jump1, jump2: integer): integer;
procedure instruct_21(rnum: integer);
procedure instruct_22;
procedure instruct_23(rnum, Poision: integer);
procedure instruct_24;
procedure instruct_25(x1, y1, x2, y2: integer);
procedure instruct_26(snum, enum, add1, add2, add3: integer);
procedure instruct_27(enum, beginpic, endpic: integer);
function instruct_28(rnum, e1, e2, jump1, jump2: integer): integer;
function instruct_29(rnum, r1, r2, jump1, jump2: integer): integer;
procedure instruct_30(y1, x1, y2, x2: integer);
function instruct_31(moneynum, jump1, jump2: integer): integer;
procedure instruct_32(inum, amount: integer);
procedure instruct_33(rnum, magicnum, dismode: integer);
procedure instruct_34(rnum, iq: integer);
procedure instruct_35(rnum, magiclistnum, magicnum, exp: integer);
function instruct_36(sexual, jump1, jump2: integer): integer;
procedure instruct_37(Ethics, rnum: integer);
procedure instruct_38(snum, layernum, oldpic, newpic: integer);
procedure instruct_39(snum: integer);
procedure instruct_40(director: integer);
procedure instruct_41(rnum, inum, amount: integer);
function instruct_42(jump1, jump2: integer): integer;
function instruct_43(inum, jump1, jump2: integer): integer;
procedure instruct_44(enum1, beginpic1, endpic1, enum2, beginpic2, endpic2: integer);
procedure instruct_45(rnum, speed: integer);
procedure instruct_46(rnum, mp: integer);
procedure instruct_47(rnum, Attack: integer);
procedure instruct_48(rnum, hp: integer);
procedure instruct_49(rnum, MPpro: integer);
function instruct_50(list: array of integer): integer;
procedure instruct_51;
procedure instruct_52;
procedure instruct_53;
procedure instruct_54;
function instruct_55(enum, value, jump1, jump2: integer): integer;
procedure instruct_56(Repute, rnum: integer);
procedure instruct_58;
procedure instruct_59;
function instruct_60(snum, enum, pic, jump1, jump2: integer): integer;
procedure instruct_62;
procedure EndAmi;
procedure instruct_63(rnum, sexual: integer);
procedure instruct_64(pnum: integer);
procedure instruct_66(musicnum: integer);
procedure instruct_67(Soundnum: integer);


function e_GetValue(bit, t, x: integer): integer;
function instruct_50e(code, e1, e2, e3, e4, e5, e6: integer): integer;
procedure StudyMagic(rnum, magicnum, newmagicnum, level, dismode: integer);
function HaveMagic(person, mnum, lv: integer): boolean;
function GetMagicLevel(person, mnum: integer): integer;
procedure NewTalk(headnum, talknum, namenum, place, showhead, color, frame: integer); overload;
procedure NewTalk(headnum, talknum, namenum, place, showhead, color, frame, mods: integer); overload;
function ReSetName(t, inum, newnamenum: integer): integer;
procedure ShowTitle(talknum, color: integer);
procedure JmpScene(snum, y, x: integer);
function GetItemCount(inum: integer): integer;
function ReadTalk(talknum: integer): WideString;
procedure Puzzle;
function GetPetSkill(rnum, skill: integer): boolean;
procedure SetScene;
procedure chengesnowhill();
function InputAmount: integer;
function GetGongtiState(person, state: integer): boolean;
function GetGongtiLevel(person, n: integer): integer;
procedure SetGongti(rnum, mnum: integer);
function SelectList(begintalknum, amount: integer): integer;
function GetRoleSpeed(rnum: integer; Equip: boolean): integer;
function GetRoleDefence(rnum: integer; Equip: boolean): integer;
function GetRoleAttack(rnum: integer; Equip: boolean): integer;
function GetRoleHidWeapon(rnum: integer; Equip: boolean): integer;
function GetRoleUnusual(rnum: integer; Equip: boolean): integer;
function GetRoleKnife(rnum: integer; Equip: boolean): integer;
function GetRoleSword(rnum: integer; Equip: boolean): integer;
function GetRoleFist(rnum: integer; Equip: boolean): integer;
function GetRoleDefPoi(rnum: integer; Equip: boolean): integer;
function GetRoleUsePoi(rnum: integer; Equip: boolean): integer;
function GetRoleMedPoi(rnum: integer; Equip: boolean): integer;
function GetRoleMedcine(rnum: integer; Equip: boolean): integer;
function GetRoleAttPoi(rnum: integer; Equip: boolean): integer;
function CheckEquipSet(e0, e1, e2, e3: integer): integer;
//procedure StudyGongti;
//procedure ShowStudyGongti(menu, menu2, max0: integer);
//function StadyGongtiMenu(x, y, w: integer): integer;
procedure GongtiLevelUp(rnum, mnum: integer);
function GetEquipState(person, state: integer): boolean;
procedure AddSkillPoint(num: integer);
function AddBattleStateToEquip: boolean;



var
  exx1, exx2, exx3, exx4, exx5, exx6, exx7, exx8: integer;
  chenghuname: array[0..9] of char;

implementation

uses
  kys_script,
  kys_battle,
  kys_engine,
  sty_engine,
  sty_show,
  sty_newevent;

//�¼�ϵͳ
//�¼�ָ�������������������

procedure instruct_0;
begin
  Redraw;
  SDL_UpdateRect2(screen,0,0,screen.w,screen.h);

end;

procedure instruct_1(talknum, headnum, dismode: integer);
var
  idx, grp, offset, len, i, p, l, headx, heady, diagx, diagy: integer;
  talkarray: array of byte;

begin
  case dismode of
    0:
    begin
      headx := 40;
      heady := 80;
      diagx := 100;
      diagy := 30;
    end;
    1:
    begin
      headx := 546;
      heady := CENTER_Y * 2 - 80;
      diagx := 10;
      diagy := CENTER_Y * 2 - 130;
    end;
    2:
    begin
      headx := -1;
      heady := -1;
      diagx := 100;
      diagy := 30;
    end;
    5:
    begin
      headx := 40;
      heady := CENTER_Y * 2 - 80;
      diagx := 100;
      diagy := CENTER_Y * 2 - 130;
    end;
    4:
    begin
      headx := 546;
      heady := 80;
      diagx := 10;
      diagy := 30;
    end;
    3:
    begin
      headx := -1;
      heady := -1;
      diagx := 100;
      diagy := CENTER_Y * 2 - 130;
    end;
  end;
  idx := FileOpen(TALK_IDX, fmopenread);
  grp := FileOpen(TALK_GRP, fmopenread);
  if talknum = 0 then
  begin
    offset := 0;
    FileRead(idx, len, 4);
  end
  else
  begin
    FileSeek(idx, (talknum - 1) * 4, 0);
    FileRead(idx, offset, 4);
    FileRead(idx, len, 4);
  end;
  len := (len - offset);
  setlength(talkarray, len + 1);
  FileSeek(grp, offset, 0);
  FileRead(grp, talkarray[0], len);
  FileClose(idx);
  FileClose(grp);
  DrawRectangleWithoutFrame(0, diagy - 10, 640, 120, 0, 40);
  if headx > 0 then DrawHeadPic(headnum, headx, heady);
  //if headnum <= MAX_HEAD_NUM then
  //begin
  //name := gbktoUnicode(@rrole[headnum].Name);
  //drawshadowtext(@name[1], headx + 20 - length(name) * 10, heady + 5, colcolor($ff), colcolor($0));
  //end;
  for i := 0 to len - 1 do
  begin
    talkarray[i] := talkarray[i] xor $FF;
    if (talkarray[i] = $2A) then
      talkarray[i] := 0;
  end;
  p := 0;
  l := 0;
  for i := 0 to len do
  begin
    if talkarray[i] = 0 then
    begin
      drawgbkshadowtext(@talkarray[p], diagx, diagy + l * 22, ColColor(0, $FF), ColColor(0, $0));
      p := i + 1;
      l := l + 1;
      if (l >= 4) and (i < len) then
      begin
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        WaitAnyKey;
        Redraw;
        DrawRectangleWithoutFrame(0, diagy - 10, 640, 120, 0, 40);
        if headx > 0 then DrawHeadPic(headnum, headx, heady);
        l := 0;
      end;
    end;
  end;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  WaitAnyKey;
  Redraw;

end;

//�õ���Ʒ����ʾ����, ����Ϊ����ʾʧȥ��Ʒ

procedure instruct_2(inum, amount: integer);
var
  i, x: integer;
  word: WideString;
begin
  i := 0;
  while (RItemList[i].Number >= 0) and (i < MAX_ITEM_AMOUNT) do
  begin
    if (RItemList[i].Number = inum) then
    begin
      RItemList[i].Amount := RItemList[i].Amount + amount;
      if (RItemList[i].Amount < 0) and (amount >= 0) then RItemList[i].Amount := 32767;
      if (RItemList[i].Amount < 0) and (amount < 0) then RItemList[i].Amount := 0;
      break;
    end;
    i := i + 1;
  end;
  if RItemList[i].number < 0 then
  begin
    RItemList[i].Number := inum;
    RItemList[i].Amount := amount;
  end;

  ReArrangeItem;

  x := CENTER_X - 25;
  //  if where = 2 then x := 190;

  DrawRectangle(x - 75, 98, 245, 76, 0, ColColor(0, 255), 30);
  if amount >= 0 then
    word := '�õ���Ʒ'
  else
  begin
    word := 'ʧȥ��Ʒ';
    amount := -amount;
  end;
  DrawShadowText(@word[1], x - 90, 100, ColColor(0, $21), ColColor(0, $23));
  drawgbkshadowtext(@Ritem[inum].Name, x - 90, 125, ColColor(0, $5), ColColor(0, $7));
  word := '����';
  DrawShadowText(@word[1], x - 90, 150, ColColor(0, $64), ColColor(0, $66));
  word := format('%5d', [amount]);
  DrawEngShadowText(@word[1], x - 5, 150, ColColor(0, $64), ColColor(0, $66));
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  WaitAnyKey;
  Redraw;
end;

procedure ReArrangeItem;
var
  i, p: integer;
  item, amount: array of integer;
begin
  p := 0;
  setlength(item, MAX_ITEM_AMOUNT);
  setlength(amount, MAX_ITEM_AMOUNT);
  for i := 0 to MAX_ITEM_AMOUNT - 1 do
  begin
    if (RItemList[i].Number >= 0) and (RItemList[i].Amount > 0) then
    begin
      item[p] := RItemList[i].Number;
      amount[p] := RItemList[i].Amount;
      p := p + 1;
    end;
  end;
  for i := 0 to MAX_ITEM_AMOUNT - 1 do
  begin
    if i < p then
    begin
      RItemList[i].Number := item[i];
      RItemList[i].Amount := amount[i];
    end
    else
    begin
      RItemList[i].Number := -1;
      RItemList[i].Amount := 0;
    end;
  end;

end;

//�ı��¼�, ���ڵ�ǰ���������ó���
//����ı���ͼ�϶�ʱЧ�ʽϵ�

procedure instruct_3(list: array of integer);
var
  i, oldpic, newpic: integer;
begin
  if list[0] = -2 then list[0] := CurScene;
  if list[1] = -2 then list[1] := CurEvent;
  if list[11] = -2 then list[11] := Ddata[list[0], list[1], 9];
  if list[12] = -2 then list[12] := Ddata[list[0], list[1], 10];
  //����Ӧ����ԭ��z�ļ���bug, ��������ڵ�ǰ����, ��������ֵһ���޸�ʱ, ������ͬʱ
  //��S���ݽ����޸�. ��<��������>���м�����������з��������bug�������ȷ�Ľ��
  //if list[0] = CurScene then
  Sdata[list[0], 3, Ddata[list[0], list[1], 10], Ddata[list[0], list[1], 9]] := -1;

  oldpic := DData[list[0], list[1], 5];
  newpic := list[7];

  if (list[0] = CurScene) and ((Ddata[list[0], list[1], 9] <> list[11]) or
    (Ddata[list[0], list[1], 10] <> list[12])) then
    UpdateScene(Ddata[list[0], list[1], 10], Ddata[list[0], list[1], 9], oldpic, 0);
  if list[3] >= 0 then list[1] := list[3];
  for i := 0 to 17 do
  begin
    if list[2 + i] <> -2 then
    begin
      Ddata[list[0], list[1], i] := list[2 + i];
    end;
  end;
  //if list[0] = CurScene then
  Sdata[list[0], 3, Ddata[list[0], list[1], 10], Ddata[list[0], list[1], 9]] := list[1];
  if not (((Sx = RScene[CurScene].ExitX[0]) and (Sy = RScene[CurScene].ExitY[0])) or
    ((Sx = RScene[CurScene].ExitX[1]) and (Sy = RScene[CurScene].ExitY[1])) or
    ((Sx = RScene[CurScene].ExitX[2]) and (Sy = RScene[CurScene].ExitY[2]))) then
  begin
    if (list[0] = CurScene) and ((list[8] <> -2) or (list[9] <> -2) or (list[7] <> -2) or
      (list[11] <> -2) or (list[10] <> -2)) then
      UpdateScene(list[12], list[11], oldpic, newpic);
  end;

end;

//�Ƿ�ʹ����ĳ������Ʒ

function instruct_4(inum, jump1, jump2: integer): integer;
begin
  if inum = CurItem then
    Result := jump1
  else
    Result := jump2;

end;

//ѯ���Ƿ�ս��

function instruct_5(jump1, jump2: integer): integer;
var
  menu: integer;
begin
  setlength(menuString, 0);
  setlength(menuString, 3);
  menuString[1] := '���Y';
  menuString[0] := 'ȡ��';
  menuString[2] := '�Ƿ��c֮���Y��';
  DrawTextWithRect(@menuString[2][1], CENTER_X - 75, CENTER_Y - 85, 150, ColColor(0, 5), ColColor(0, 7));
  menu := CommonMenu2(CENTER_X - 49, CENTER_Y - 50, 98);
  if menu = 1 then Result := jump1 else Result := jump2;
  Redraw;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

end;

//ս��

function instruct_6(battlenum, jump1, jump2, getexp: integer): integer;
begin

  Result := jump2;
  if Battle(battlenum, getexp) then
    Result := jump1;

end;

//ѯ���Ƿ����

procedure instruct_8(musicnum: integer);
begin
  exitScenemusicnum := musicnum;
end;

function instruct_9(jump1, jump2: integer): integer;
var
  menu: integer;
begin
  setlength(menuString, 0);
  setlength(menuString, 3);
  menuString[1] := 'Ҫ��';
  menuString[0] := 'ȡ��';
  menuString[2] := '�Ƿ�Ҫ����룿';
  DrawTextWithRect(@menuString[2][1], CENTER_X - 75, CENTER_Y - 85, 150, ColColor(0, 5), ColColor(0, 7));
  menu := CommonMenu2(CENTER_X - 49, CENTER_Y - 50, 98);
  if menu = 1 then Result := jump1 else Result := jump2;
  Redraw;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

end;

//�������, ͬʱ�õ���������Ʒ

procedure instruct_10(rnum: integer);
var
  i, i1: integer;
  word: WideString;
begin
  if teamcount >= 25 then exit;
  Rrole[rnum].TeamState := 2;
  Rrole[rnum].nweizhi := 13;
  Rrole[rnum].dtime := 1000;
  Inc(teamcount);
  for i1 := 0 to 3 do
  begin
    if (Rrole[rnum].TakingItem[i1] >= 0) and (Rrole[rnum].TakingItemAmount[i1] > 0) then
    begin
      instruct_2(Rrole[rnum].TakingItem[i1], Rrole[rnum].TakingItemAmount[i1]);
      Redraw;
      Rrole[rnum].TakingItem[i1] := -1;
      Rrole[rnum].TakingItemAmount[i1] := 0;
    end;
  end;
  for i := 0 to 5 do
  begin
    if Teamlist[i] = rnum then
    begin
      Rrole[rnum].TeamState := 1;
      break;
    end
    else if Teamlist[i] < 0 then
    begin
      Teamlist[i] := rnum;
      Rrole[rnum].TeamState := 1;
      break;
    end;
  end;
  word := gbktounicode(@Rrole[rnum].Name);
  word := word + '�������';
  Redraw;
  DrawShadowText(@word[1], CENTER_X - 70, 40, ColColor($5), ColColor($7));
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  SDL_Delay(50 * GameSpeed + 500);
end;

//ѯ���Ƿ�ס��

function instruct_11(jump1, jump2: integer): integer;
var
  menu: integer;
begin
  setlength(menuString, 0);
  setlength(menuString, 3);
  menuString[1] := 'Ҫ��';
  menuString[0] := 'ȡ��';
  menuString[2] := '�Ƿ���Ҫס�ޣ�';
  DrawTextWithRect(@menuString[2][1], CENTER_X - 75, CENTER_Y - 85, 150, ColColor(0, 5), ColColor(0, 7));
  menu := CommonMenu2(CENTER_X - 49, CENTER_Y - 50, 98);
  if menu = 1 then Result := jump1 else Result := jump2;
  Redraw;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

end;

//ס��

procedure instruct_12;
var
  i, rnum: integer;
begin
  dayto(1, 0);
  for i := 0 to 5 do
  begin
    rnum := Teamlist[i];
    if (rnum >= 0) then
    begin
      if not ((Rrole[rnum].Hurt > 33) or (Rrole[rnum].Poision > 33)) then
      begin
        Dec(Rrole[rnum].Hurt, 5);
        Rrole[rnum].Hurt := max(Rrole[rnum].Hurt, 0);
        Dec(Rrole[rnum].Poision, 5);
        Rrole[rnum].Poision := max(0, Rrole[rnum].Poision);
        Rrole[rnum].CurrentHP := Rrole[rnum].MaxHP;
        Rrole[rnum].CurrentMP := Rrole[rnum].MaxMP;
        Rrole[rnum].PhyPower := MAX_PHYSICAL_POWER;
      end
      else if not ((Rrole[rnum].Hurt > 60) or (Rrole[rnum].Poision > 60)) then
      begin
        Dec(Rrole[rnum].Hurt, 2);
        Rrole[rnum].Hurt := max(Rrole[rnum].Hurt, 0);
        Dec(Rrole[rnum].Poision, 2);
        Rrole[rnum].Poision := max(0, Rrole[rnum].Poision);
        Rrole[rnum].CurrentHP := (Rrole[rnum].MaxHP - Rrole[rnum].CurrentHP) div 10 + Rrole[rnum].MaxHP div 10;
        Rrole[rnum].CurrentHP := min(Rrole[rnum].CurrentHP, Rrole[rnum].MaxHP);
        Rrole[rnum].CurrentMP := (Rrole[rnum].MaxMP - Rrole[rnum].CurrentMP) div 10 + Rrole[rnum].MaxMP div 10;
        Rrole[rnum].CurrentMP := min(Rrole[rnum].CurrentMP, Rrole[rnum].MaxMP);
        Rrole[rnum].PhyPower := MAX_PHYSICAL_POWER;
      end
      else if not ((Rrole[rnum].Hurt > 80) or (Rrole[rnum].Poision > 80)) then
      begin
        Dec(Rrole[rnum].Hurt, 1);
        Rrole[rnum].Hurt := max(Rrole[rnum].Hurt, 0);
        Dec(Rrole[rnum].Poision, 1);
        Rrole[rnum].Poision := max(0, Rrole[rnum].Poision);
        Rrole[rnum].CurrentHP := (Rrole[rnum].MaxHP - Rrole[rnum].CurrentHP) div 20 + Rrole[rnum].MaxHP div 20;
        Rrole[rnum].CurrentHP := min(Rrole[rnum].CurrentHP, Rrole[rnum].MaxHP);
        Rrole[rnum].CurrentMP := (Rrole[rnum].MaxMP - Rrole[rnum].CurrentMP) div 20 + Rrole[rnum].MaxMP div 20;
        Rrole[rnum].CurrentMP := min(Rrole[rnum].CurrentMP, Rrole[rnum].MaxMP);
        Rrole[rnum].PhyPower := min(MAX_PHYSICAL_POWER, Rrole[rnum].PhyPower + 5);
      end;
    end;
  end;
  for i := 0 to length(Rrole) - 1 do
  begin
    if (Rrole[i].TeamState = 2) then
    begin
      if not ((Rrole[i].Hurt > 33) or (Rrole[i].Poision > 33)) then
      begin
        Rrole[i].Hurt := 0;
        Rrole[i].Poision := 0;
        Rrole[i].CurrentHP := Rrole[i].MaxHP;
        Rrole[i].CurrentMP := Rrole[i].MaxMP;
        Rrole[i].PhyPower := MAX_PHYSICAL_POWER;
      end;
    end;
  end;
end;

//����, ������֮ǰ���³�ʼ������

procedure instruct_13;
var
  i: integer;

begin
  //for i1:=0 to 199 do
  //for i2:=0 to 10 do
  //DData[CurScene, [i1,i2]:=Ddata[CurScene,i1,i2];

  if where = 1 then initialScene;
  //sdl_delay(200);

  for i := 0 to 5 do
  begin

    if (SDL_MUSTLOCK(screen)) then
    begin
      if (SDL_LockSurface(screen) < 0) then
      begin
        MessageBox(0, pchar(Format('Can''t lock screen : %s', [SDL_GetError])), 'Error', MB_OK or MB_ICONHAND);
        exit;
      end;
    end;
    if where = 1 then DrawScene;
    DrawRectangleWithoutFrame(0, 0, screen.w, screen.h, 0, 100 - i * 20);
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    if (SDL_MUSTLOCK(screen)) then
    begin
      SDL_UnlockSurface(screen);
    end;
    SDL_Delay(GameSpeed + 10);
  end;
  drawdate;
  SDL_UpdateRect2(screen, 0, 0, 400, 200);
end;

//����

procedure instruct_14;
var
  i: integer;
begin
  for i := 0 to 10 do
  begin
    //Redraw;
    SDL_Delay(GameSpeed + 10);
    DrawRectangleWithoutFrame(0, 0, screen.w, screen.h, 0, i * 10);
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  end;
  i := length(Jxarr);
  if (random(10) = 0) and (length(tipsarr) <= 0) and (i > 0) then
  begin
    addtips(Jxarr[random(i)]);
  end;

end;

//ʧ�ܻ���

procedure instruct_15;
var

  str: WideString;
begin

  PlayMP3(13, 20);
  where := 4;
  Redraw;
  str := '��ʮ�����m�c������ǧ��·녺���';
  DrawShadowText(@str[1], CENTER_X - length(str) * 10, 50, ColColor(0, 5), ColColor(0, 7));
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  WaitAnyKey;
  Start;
end;

function instruct_16(rnum, jump1, jump2: integer): integer;

begin
  Result := jump2;
  if Rrole[rnum].TeamState in [1, 2] then
  begin
    Result := jump1;
  end;
end;

procedure instruct_17(list: array of integer);

begin
  if list[0] = -2 then list[0] := CurScene;
  sdata[list[0], list[1], list[3], list[2]] := list[4];
  initialScene;
end;

function instruct_18(inum, jump1, jump2: integer): integer;
var
  i: integer;
begin
  Result := jump2;
  for i := 0 to MAX_ITEM_AMOUNT - 1 do
  begin
    if RItemList[i].Number = inum then
    begin
      Result := jump1;
      break;
    end;
  end;
end;

procedure instruct_19(x, y: integer);
begin
  nowstep := -1;
  Sx := y;
  Sy := x;
  Cx := Sx;
  Cy := Sy;
  Redraw;
end;

//Judge the team is full or not.

function instruct_20(jump1, jump2: integer): integer;
var
  i: integer;
begin
  Result := jump1;
{  for i := 0 to 5 do
  begin
    if TeamList[i] < 0 then
    begin
      result := jump2;
      break;
    end;
  end;   }
  if teamcount < 25 then Result := jump2;
end;

//꠆T�x�

procedure instruct_21(rnum: integer);
var
  i, p: integer;
  w: boolean;
  newlist: array[0..5] of integer;
  word: WideString;
begin
  p := 0;
  w := False;

  if Rrole[rnum].TeamState = 1 then
  begin
    w := True;
    for i := 0 to 5 do
    begin
      newlist[i] := -1;
      if Teamlist[i] <> rnum then
      begin
        newlist[p] := Teamlist[i];
        p := p + 1;
      end;
    end;
    for i := 0 to 5 do
      Teamlist[i] := newlist[i];
    //��Ӳ��ѵ�װ��
    {for i := 0 to length(Rrole[rnum].Equip) - 1 do
      if Rrole[rnum].Equip[i] >= 0 then
      begin
        if Ritem[Rrole[rnum].Equip[i]].Magic > 0 then
        begin
          Ritem[Rrole[rnum].Equip[i]].ExpOfMagic := GetMagicLevel(rnum, Ritem[Rrole[rnum].Equip[i]].Magic);
          StudyMagic(rnum, Ritem[Rrole[rnum].Equip[i]].Magic, 0, 0, 1);
        end;
        dec(Rrole[rnum].MaxHP, Ritem[Rrole[rnum].Equip[i]].AddMaxHP);
        dec(Rrole[rnum].CurrentHP, Ritem[Rrole[rnum].Equip[i]].AddMaxHP);
        dec(Rrole[rnum].MaxMP, Ritem[Rrole[rnum].Equip[i]].AddMaxMP);
        dec(Rrole[rnum].CurrentMP, Ritem[Rrole[rnum].Equip[i]].AddMaxMP);
        instruct_32(Rrole[rnum].Equip[i], 1);
        Rrole[rnum].Equip[i] := -1;
      end; }
    Rrole[rnum].TeamState := 3;

  end
  else if Rrole[rnum].TeamState = 2 then
  begin
    w := True;
    Rrole[rnum].TeamState := 3;

  end;

  if Rrole[rnum].PracticeBook >= 0 then
  begin
    instruct_32(Rrole[rnum].PracticeBook, 1);
    Rrole[rnum].PracticeBook := -1;
    //Rrole[rnum].ExpForBook := 0;
  end;

  if w then
  begin
    Dec(teamcount);
    Rrole[rnum].nweizhi := 14;
    Rrole[rnum].dtime := random(5);
    word := gbktounicode(@Rrole[rnum].Name) + '�x�_��飡';
    DrawShadowText(@word[1], CENTER_X - 80, CENTER_Y - 150, ColColor($5), ColColor($7));
  end;
  if Rrole[rnum].leaveevent > 0 then
    CallEvent(Rrole[rnum].leaveevent);
end;

procedure instruct_22;
var
  i: integer;
begin
  for i := 0 to 5 do
    Rrole[Teamlist[i]].CurrentMP := 0;
end;

procedure instruct_23(rnum, Poision: integer);
begin
  Rrole[rnum].UsePoi := Poision;
end;

//Black the screen when fail in battle.
//Note: never be used, leave it as blank.

procedure instruct_24;
begin
end;

//Note: never display the leading role.
//This will be improved when I have a better method.

procedure instruct_25(x1, y1, x2, y2: integer);
var
  i, s: integer;
begin
  if x1 = -2 then x1 := Sy;
  if y1 = -2 then y1 := Sx;
  nowstep := -1;
  s := sign(x2 - x1);
  i := x1 + s;
  //showmessage(inttostr(ssx*100+ssy));
  if s <> 0 then
    while s * (x2 - i) >= 0 do
    begin
      SDL_Delay(50 + 5 * GameSpeed);
      DrawSceneWithoutRole(y1, i);
      //showmessage(inttostr(i));
      DrawRoleOnScene(y1, i);
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      i := i + s;
      //showmessage(inttostr(s*(x2-i)));
    end;
  s := sign(y2 - y1);
  i := y1 + s;
  if s <> 0 then
    while s * (y2 - i) >= 0 do
    begin
      SDL_Delay(50 + 5 * GameSpeed);
      DrawSceneWithoutRole(i, x2);
      //showmessage(inttostr(i));
      DrawRoleOnScene(i, x2);
      //Redraw;
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      i := i + s;
    end;




  Cx := y2;
  Cy := x2;
  //SSx:=0;
  //SSy:=0;
  //showmessage(inttostr(ssx*100+ssy));
end;

procedure instruct_26(snum, enum, add1, add2, add3: integer);
begin
  if snum = -2 then snum := CurScene;
  ddata[snum, enum, 2] := ddata[snum, enum, 2] + add1;
  ddata[snum, enum, 3] := ddata[snum, enum, 3] + add2;
  ddata[snum, enum, 4] := ddata[snum, enum, 4] + add3;

end;

//Note: of course an more effective engine can take place of it.
//����, �����Բ�����

procedure instruct_27(enum, beginpic, endpic: integer);
var
  i, oldpic, picsign: integer;
  AboutMainRole: boolean;
begin
  AboutMainRole := False;
  if enum = -1 then
  begin
    enum := CurEvent;
    if SData[CurScene, 3, Sx, Sy] >= 0 then
      enum := SData[CurScene, 3, Sx, Sy];
    AboutMainRole := True;
  end;

  if enum = SData[CurScene, 3, Sx, Sy] then AboutMainRole := True;
  SData[CurScene, 3, DData[CurScene, enum, 10], DData[CurScene, enum, 9]] := enum;
  oldpic := DData[CurScene, enum, 5];
  picsign := sign(beginpic);
  for i := abs(beginpic) to abs(endpic) do
  begin
    DData[CurScene, enum, 5] := picsign * i;
    UpdateScene(DData[CurScene, enum, 10], DData[CurScene, enum, 9], oldpic, picsign * i);
    oldpic := picsign * i;
    SDL_Delay(GameSpeed + 10);
    DrawSceneWithoutRole(Cx, Cy);
    if not (AboutMainRole) then
      DrawRoleOnScene(Cx, Cy);
    //showmessage(inttostr(enum+100*CurEvent));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  end;
  //showmessage(inttostr(Sx+100*Sy));
  //showmessage(inttostr(DData[CurScene, [enum,10]+100*DData[CurScene, [enum,9]));
  DData[CurScene, enum, 5] := DData[CurScene, enum, 7];
  UpdateScene(DData[CurScene, enum, 10], DData[CurScene, enum, 9], oldpic, DData[CurScene, enum, 5]);
end;

function instruct_28(rnum, e1, e2, jump1, jump2: integer): integer;
begin
  Result := jump2;
  if (Rrole[rnum].Ethics >= e1) and (Rrole[rnum].Ethics <= e2) then Result := jump1;
end;

function instruct_29(rnum, r1, r2, jump1, jump2: integer): integer;
begin
  Result := jump2;
  if (GetRoleAttack(rnum, False) >= r1) and (GetRoleAttack(rnum, False) <= r2) then Result := jump1;
end;

procedure instruct_30(y1, x1, y2, x2: integer);
var
  i, a, i1: integer;
begin
  if x1 = -2 then x1 := Sy;
  if y1 = -2 then y1 := Sx;
  nowstep := -1;
  for i := 0 to 63 do
    for i1 := 0 to 63 do
      Fway[i, i1] := -1;
  FindWay(x1, y1,63);
  Moveman(x1, y1, x2, y2);
  for a := Fway[x2, y2] - 1 downto 0 do
  begin
    if sign(liney[a] - Sy) < 0 then
      SFace := 2
    else if sign(liney[a] - Sy) > 0 then
      sFace := 1
    else if sign(linex[a] - Sx) > 0 then
      SFace := 3
    else sFace := 0;

    SStep := SStep + 1;

    if SStep >= 7 then SStep := 1;
    Sx := linex[a];
    Sy := liney[a];
    Cx := Sx;
    Cy := Sy;
    Redraw;
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay(gamespeed + 10);
  end;

  Sx := x2;
  Sy := y2;
  SStep := 0;
  Cx := Sx;
  Cy := Sy;

end;


function instruct_31(moneynum, jump1, jump2: integer): integer;
var
  moneycount: integer;
begin
  Result := jump2;
  moneycount := getitemcount(MONEY_ID);

  if (moneycount >= moneynum) then
    Result := jump1;
end;

procedure instruct_32(inum, amount: integer);
var
  i: integer;
begin
  i := 0;
  while (RItemList[i].Number >= 0) and (i < MAX_ITEM_AMOUNT) do
  begin
    if (RItemList[i].Number = inum) then
    begin
      RItemList[i].Amount := RItemList[i].Amount + amount;
      if (RItemList[i].Amount < 0) and (amount >= 0) then RItemList[i].Amount := 32767;
      if (RItemList[i].Amount < 0) and (amount < 0) then RItemList[i].Amount := 0;
      break;
    end;
    i := i + 1;
  end;
  if RItemList[i].Number < 0 then
  begin
    RItemList[i].Number := inum;
    RItemList[i].Amount := amount;
  end;
  ReArrangeItem;
end;

//ѧ���书, ��������书������, �������10������ϴ�书

procedure instruct_33(rnum, magicnum, dismode: integer);

begin
  StudyMagic(rnum, 0, magicnum, 0, dismode);
end;

procedure instruct_34(rnum, iq: integer);
var
  word: WideString;
begin
  if Rrole[rnum].Aptitude + iq <= 100 then
  begin
    Rrole[rnum].Aptitude := Rrole[rnum].Aptitude + iq;
  end
  else
  begin
    iq := 100 - Rrole[rnum].Aptitude;
    Rrole[rnum].Aptitude := 100;
  end;
  if iq > 0 then
  begin
    DrawRectangle(CENTER_X - 75, 98, 145, 51, 0, ColColor(0, 255), 30);
    word := '�Y�|����';
    DrawShadowText(@word[1], CENTER_X - 90, 125, ColColor(0, $5), ColColor(0, $7));
    drawgbkshadowtext(@Rrole[rnum].Name, CENTER_X - 80, 100, ColColor(0, $21), ColColor(0, $23));
    word := format('%3d', [iq]);
    DrawEngShadowText(@word[1], CENTER_X + 30, 125, ColColor(0, $64), ColColor(0, $66));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    WaitAnyKey;
    Redraw;
  end;
end;

procedure instruct_35(rnum, magiclistnum, magicnum, exp: integer);
var
  i: integer;
begin
  if (magiclistnum < 0) or (magiclistnum > 29) then
  begin
    for i := 0 to 29 do
    begin
      if Rrole[rnum].lMagic[i] = magicnum then
      begin
        Rrole[rnum].MagLevel[i] := exp;
        break;
      end;
      if Rrole[rnum].lMagic[i] <= 0 then
      begin
        Rrole[rnum].lMagic[i] := magicnum;
        Rrole[rnum].MagLevel[i] := exp;
        break;
      end;
    end;
    if i = 30 then
    begin
      Rrole[rnum].lMagic[0] := magicnum;
      Rrole[rnum].MagLevel[0] := exp;
    end;
  end
  else
  begin
    Rrole[rnum].lMagic[magiclistnum] := magicnum;
    Rrole[rnum].MagLevel[magiclistnum] := exp;
  end;
end;

function instruct_36(sexual, jump1, jump2: integer): integer;
begin
  Result := jump2;
  if Rrole[0].Sexual = sexual then Result := jump1;
  if sexual > 255 then
    if x50[$7000] = 0 then Result := jump1 else Result := jump2;
end;

procedure instruct_37(Ethics, rnum: integer);
var
  a, i: integer;
begin
  if rnum >= 0 then
  begin
    a := 0;
    if Rrole[rnum].MenPai >= 0 then
      if Rmenpai[Rrole[rnum].menpai].zhiwu[8] >= 0 then
        a := Rrole[Rmenpai[Rrole[rnum].menpai].zhiwu[8]].Repute *
          Rrole[Rmenpai[Rrole[rnum].menpai].zhiwu[8]].level div 300;
    Rrole[rnum].Ethics := Rrole[rnum].Ethics + ethics;
    if Random(100) <= a then
      Rrole[rnum].Ethics := Rrole[rnum].Ethics + ethics;
    if Rrole[rnum].Ethics > 100 then Rrole[rnum].Ethics := 100;
    if Rrole[rnum].Ethics < 0 then Rrole[rnum].Ethics := 0;
  end
  else
  begin
    for i := 0 to length(Rrole) - 1 do
    begin
      if Rrole[i].TeamState in [1, 2] then
      begin
        a := 0;
        if Rrole[i].MenPai > 0 then
          if Rmenpai[Rrole[i].menpai].zhiwu[8] >= 0 then
            a := Rrole[Rmenpai[Rrole[i].menpai].zhiwu[8]].Repute *
              Rrole[Rmenpai[Rrole[i].menpai].zhiwu[8]].level div 300;
        Rrole[i].Ethics := Rrole[i].Ethics + ethics * (100 + a) div 100;
        if Rrole[i].Ethics > 100 then Rrole[i].Ethics := 100;
        if Rrole[i].Ethics < 0 then Rrole[i].Ethics := 0;
      end;
    end;
  end;
end;

procedure instruct_38(snum, layernum, oldpic, newpic: integer);
var
  i1, i2: integer;
begin
  if snum = -2 then snum := CurScene;
  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
    begin
      if Sdata[snum, layernum, i1, i2] = oldpic then Sdata[snum, layernum, i1, i2] := newpic;
    end;
  InitialScene;
end;

procedure instruct_39(snum: integer);
begin
  RScene[snum].EnCondition := 0;
end;

procedure instruct_40(director: integer);
begin
  Sface := director;
end;

procedure instruct_41(rnum, inum, amount: integer);
var
  i, p: integer;
begin
  p := 0;
  for i := 0 to 3 do
  begin
    if Rrole[rnum].TakingItem[i] = inum then
    begin
      Rrole[rnum].TakingItemAmount[i] := Rrole[rnum].TakingItemAmount[i] + amount;
      p := 1;
      break;
    end;
  end;
  if p = 0 then
  begin
    for i := 0 to 3 do
    begin
      if Rrole[rnum].TakingItem[i] = -1 then
      begin
        Rrole[rnum].TakingItem[i] := inum;
        Rrole[rnum].TakingItemAmount[i] := amount;
        break;
      end;
    end;
  end;
  for i := 0 to 3 do
  begin
    if Rrole[rnum].TakingItemAmount[i] <= 0 then
    begin
      Rrole[rnum].TakingItem[i] := -1;
      Rrole[rnum].TakingItemAmount[i] := 0;
    end;
  end;

end;

function instruct_42(jump1, jump2: integer): integer;
var
  i: integer;
begin
  Result := jump2;
  for i := 0 to Length(Rrole) - 1 do
  begin
    if Rrole[i].TeamState in [1, 2] then
      if Rrole[i].Sexual = 1 then
      begin
        Result := jump1;
        break;
      end;
  end;
end;

function instruct_43(inum, jump1, jump2: integer): integer;
var
  i: integer;
begin
  Result := jump2;
  for i := 0 to MAX_ITEM_AMOUNT - 1 do
    if RItemList[i].Number = inum then
    begin
      Result := jump1;
      break;
    end;
end;

procedure instruct_44(enum1, beginpic1, endpic1, enum2, beginpic2, endpic2: integer);
var
  i, old1, old2: integer;
begin
  SData[CurScene, 3, DData[CurScene, enum1, 10], DData[CurScene, enum1, 9]] := enum1;
  SData[CurScene, 3, DData[CurScene, enum2, 10], DData[CurScene, enum2, 9]] := enum2;
  old1 := DData[CurScene, enum1, 5];
  old2 := DData[CurScene, enum2, 5];
  for i := 0 to endpic1 - beginpic1 do
  begin
    DData[CurScene, enum1, 5] := beginpic1 + i;
    DData[CurScene, enum2, 5] := beginpic2 + i;
    UpdateScene(DData[CurScene, enum1, 10], DData[CurScene, enum1, 9], old1, beginpic1 + i);
    UpdateScene(DData[CurScene, enum2, 10], DData[CurScene, enum2, 9], old2, beginpic2 + i);
    old1 := DData[CurScene, enum1, 5];
    old2 := DData[CurScene, enum2, 5];
    SDL_Delay(2 * GameSpeed + 20);
    DrawSceneWithoutRole(Sx, Sy);
    DrawScene;
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  end;
  //SData[CurScene, 3, DData[CurScene, [enum,10],DData[CurScene, [enum,9]]:=-1;
end;

procedure instruct_45(rnum, speed: integer);
var
  word: WideString;
begin
  Rrole[rnum].Speed := Rrole[rnum].Speed + speed;
  if Rrole[rnum].TeamState in [1, 2] then
  begin
    DrawRectangle(CENTER_X - 75, 98, 145, 51, 0, ColColor(0, 255), 30);
    if speed > 0 then
      word := '�p������'
    else
      word := '�p���p��';
    DrawShadowText(@word[1], CENTER_X - 90, 125, ColColor(0, $5), ColColor(0, $7));
    drawgbkshadowtext(@Rrole[rnum].Name, CENTER_X - 80, 100, ColColor(0, $21), ColColor(0, $23));
    word := format('%4d', [abs(speed)]);
    DrawEngShadowText(@word[1], CENTER_X + 10, 125, ColColor(0, $64), ColColor(0, $66));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    WaitAnyKey;
    Redraw;
  end;
end;

procedure instruct_46(rnum, mp: integer);
var
  word: WideString;
begin
  Rrole[rnum].MaxMP := Rrole[rnum].MaxMP + mp;
  Rrole[rnum].CurrentMP := Rrole[rnum].MaxMP;
  if Rrole[rnum].TeamState in [1, 2] then
  begin
    DrawRectangle(CENTER_X - 75, 98, 145, 51, 0, ColColor(0, 255), 30);
    if mp > 0 then
      word := '��������'
    else
      word := '�����p��';
    DrawShadowText(@word[1], CENTER_X - 90, 125, ColColor(0, $5), ColColor(0, $7));
    drawgbkshadowtext(@Rrole[rnum].Name, CENTER_X - 80, 100, ColColor(0, $21), ColColor(0, $23));
    word := format('%4d', [abs(mp)]);
    DrawEngShadowText(@word[1], CENTER_X + 10, 125, ColColor(0, $64), ColColor(0, $66));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    WaitAnyKey;
    Redraw;
  end;
end;

procedure instruct_47(rnum, Attack: integer);
var
  word: WideString;
begin
  Rrole[rnum].Attack := Rrole[rnum].Attack + Attack;
  if Rrole[rnum].TeamState in [1, 2] then
  begin
    DrawRectangle(CENTER_X - 75, 98, 145, 51, 0, ColColor(0, 255), 30);
    if Attack > 0 then
      word := '��������'
    else
      word := '�����p��';
    DrawShadowText(@word[1], CENTER_X - 90, 125, ColColor(0, $5), ColColor(0, $7));
    drawgbkshadowtext(@Rrole[rnum].Name, CENTER_X - 80, 100, ColColor(0, $21), ColColor(0, $23));
    word := format('%4d', [abs(Attack)]);
    DrawEngShadowText(@word[1], CENTER_X + 10, 125, ColColor(0, $64), ColColor(0, $66));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    WaitAnyKey;
    Redraw;
  end;
end;

procedure instruct_48(rnum, hp: integer);
var
  word: WideString;
begin
  Rrole[rnum].MaxHP := Rrole[rnum].MaxHP + hp;
  Rrole[rnum].CurrentHP := Rrole[rnum].MaxHP;
  if Rrole[rnum].TeamState in [1, 2] then
  begin
    DrawRectangle(CENTER_X - 75, 98, 145, 51, 0, ColColor(0, 255), 30);
    if hp > 0 then
      word := '��������'
    else
      word := '�����p��';
    DrawShadowText(@word[1], CENTER_X - 90, 125, ColColor(0, $5), ColColor(0, $7));
    drawgbkshadowtext(@Rrole[rnum].Name, CENTER_X - 80, 100, ColColor(0, $21), ColColor(0, $23));
    word := format('%4d', [abs(hp)]);
    DrawEngShadowText(@word[1], CENTER_X + 10, 125, ColColor(0, $64), ColColor(0, $66));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    WaitAnyKey;
    Redraw;
  end;
end;

procedure AddDefense(rnum, def: integer);
var
  word: WideString;
begin
  Rrole[rnum].Defence := Rrole[rnum].Defence + def;
  if Rrole[rnum].Defence > MaxProList[45] then
    Rrole[rnum].Defence := MaxProList[45];
  if Rrole[rnum].TeamState in [1, 2] then
  begin
    DrawRectangle(CENTER_X - 75, 98, 145, 51, 0, ColColor(0, 255), 30);
    if def > 0 then
      word := '��������'
    else
      word := '�����p��';
    DrawShadowText(@word[1], CENTER_X - 90, 125, ColColor(0, $5), ColColor(0, $7));
    drawgbkshadowtext(@Rrole[rnum].Name, CENTER_X - 80, 100, ColColor(0, $21), ColColor(0, $23));
    word := format('%4d', [abs(def)]);
    DrawEngShadowText(@word[1], CENTER_X + 10, 125, ColColor(0, $64), ColColor(0, $66));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    WaitAnyKey;
    Redraw;
  end;
end;

procedure AddSkillPoint(num: integer);
var
  word: WideString;
begin
  Inc(Rrole[0].AddSkillPoint, num);
  DrawRectangle(CENTER_X - 75, 98, 145, 30, 0, ColColor(0, 255), 30);
  word := '�õ������c  ';
  DrawShadowText(@word[1], CENTER_X - 90, 100, ColColor(0, $5), ColColor(0, $7));
  word := format('%d', [num]);

  DrawEngShadowText(@word[1], CENTER_X + 50, 100, ColColor(0, $64), ColColor(0, $66));
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  WaitAnyKey;
  Redraw;
end;

procedure instruct_49(rnum, MPpro: integer);
begin
  Rrole[rnum].MPType := MPpro;
end;

function instruct_50(list: array of integer): integer;
var
  i, p: integer;
  //instruct_50e: function (list1: array of integer): Integer;
begin

  if list[0] <= 128 then
  begin
    //instruct_50e:='';
    Result := instruct_50e(list[0], list[1], list[2], list[3], list[4], list[5], list[6]);
  end
  else
  begin
    Result := list[6];
    p := 0;
    for i := 0 to 4 do
    begin
      p := p + instruct_18(list[i], 1, 0);
    end;
    if p = 5 then Result := list[5];
  end;
end;

procedure instruct_51;
begin
  instruct_1(SOFTSTAR_BEGIN_TALK + random(SOFTSTAR_NUM_TALK), $72, 0);
end;

procedure instruct_52;
var
  word: WideString;
begin
  DrawRectangle(CENTER_X - 110, 98, 220, 26, 0, ColColor(0, 255), 30);
  word := '���Ʒ��ָ���飺';
  DrawShadowText(@word[1], CENTER_X - 125, 100, ColColor(0, $5), ColColor(0, $7));
  word := format('%3d', [Rrole[0].Ethics]);
  DrawEngShadowText(@word[1], CENTER_X + 65, 100, ColColor(0, $64), ColColor(0, $66));
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  WaitAnyKey;
  Redraw;
end;

procedure instruct_53;
var
  word: WideString;
begin
  DrawRectangle(CENTER_X - 110, 98, 220, 26, 0, ColColor(0, 255), 30);
  word := '�����ָ���飺';
  DrawShadowText(@word[1], CENTER_X - 125, 100, ColColor(0, $5), ColColor(0, $7));
  word := format('%3d', [Rrole[0].Repute]);
  DrawEngShadowText(@word[1], CENTER_X + 65, 100, ColColor(0, $64), ColColor(0, $66));
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  WaitAnyKey;
  Redraw;
  
end;

//Open all Scenes.
//Note: in primary game, some Scenes are set to different entrancing condition.

procedure instruct_54;
var
  i: integer;
begin
  for i := 0 to length(rScene) - 1 do
  begin
    case RScene[i].EnCondition of
      1: RScene[i].EnCondition := 0;
      3: RScene[i].EnCondition := 1;
      4: RScene[i].EnCondition := 2;
    end;
  end;
end;

//Judge the event number.

function instruct_55(enum, value, jump1, jump2: integer): integer;
begin
  Result := jump2;
  if DData[CurScene, enum, 2] = value then Result := jump1;
end;

//Add repute.
//�����ոճ���200ʱ�����������

procedure instruct_56(Repute, rnum: integer);
var
  zhiwujc, mpnum, i: integer;
begin
  if rnum >= 0 then
  begin
    mpnum := Rrole[rnum].MenPai;
    zhiwujc := 0;
    if mpnum >= 0 then
      if Rmenpai[mpnum].zhiwu[8] >= 0 then
        zhiwujc := Rrole[Rmenpai[mpnum].zhiwu[8]].Repute * Rrole[Rmenpai[mpnum].zhiwu[8]].level div 300;
    Rrole[rnum].Repute := Rrole[rnum].Repute + repute;
    if random(100) <= zhiwujc then
      Rrole[rnum].Repute := Rrole[rnum].Repute + abs(repute);
    Rrole[rnum].Repute := max(0, Rrole[rnum].Repute);
    Rrole[rnum].Repute := min(1000, Rrole[rnum].Repute);
  end
  else if rnum = -1 then
  begin
    for i := 0 to length(Rrole) - 1 do
    begin
      if Rrole[i].TeamState in [1, 2] then
      begin
        mpnum := Rrole[i].MenPai;
        zhiwujc := 0;
        if mpnum >= 0 then
          if Rmenpai[mpnum].zhiwu[8] >= 0 then
            zhiwujc := Rrole[Rmenpai[mpnum].zhiwu[8]].Repute * Rrole[Rmenpai[mpnum].zhiwu[8]].level div 300;
        Rrole[i].Repute := Rrole[i].Repute + repute;
        if random(100) <= zhiwujc then
          Rrole[i].Repute := Rrole[i].Repute + abs(repute);
        Rrole[i].Repute := max(0, Rrole[i].Repute);
        Rrole[i].Repute := min(1000, Rrole[i].Repute);
      end;
    end;
  end;
end;

{procedure instruct_57;
var
  i: integer;
begin
  for i:=0 to endpic1-beginpic1 do
  begin
    DData[CurScene, [enum1,5]:=beginpic1+i;
    DData[CurScene, [enum2,5]:=beginpic2+i;
    UpdateScene(DData[CurScene, [enum1,10],DData[CurScene, [enum1,9]);
    UpdateScene(DData[CurScene, [enum2,10],DData[CurScene, [enum2,9]);
    sdl_delay((20* GameSpeed) div 10);
    DrawSceneByCenter(Sx,Sy);
    DrawScene;
    SDL_UpdateRect2(screen,0,0,screen.w,screen.h);
  end;
end;}

procedure instruct_58;
var
  i, p: integer;
begin
  for i := 0 to 14 do
  begin
    p := random(2);
    instruct_1(2854 + i * 2 + p, 0, 3);
    if not (Battle(102 + i * 2 + p, 0)) then instruct_15;
    instruct_14;
    instruct_13;
    if i mod 3 = 2 then
    begin
      instruct_1(2891, 0, 3);
      instruct_12;
      instruct_14;
      instruct_13;
    end;
  end;
  instruct_1(2884, 0, 3);
  instruct_1(2885, 0, 3);
  instruct_1(2886, 0, 3);
  instruct_1(2887, 0, 3);
  instruct_1(2888, 0, 3);
  instruct_1(2889, 0, 1);
  instruct_2($8F, 1);

end;

//ȫԱ���, ��δ�������¼�

procedure instruct_59;
var
  i, rnum: integer;
begin
  for i := 1 to 5 do
    TeamList[i] := -1;
  for rnum := 1 to Length(Rrole) - 1 do
  begin
    if Rrole[rnum].TeamState in [1, 2] then
    begin
      //��Ӳ��ѵ�װ��
      {for i := 0 to length(Rrole[rnum].Equip) - 1 do
        if Rrole[rnum].Equip[i] >= 0 then
        begin
          instruct_32(Rrole[rnum].Equip[i], 1);
          Rrole[rnum].Equip[i] := -1;
        end; }
      if Rrole[rnum].PracticeBook >= 0 then
      begin
        instruct_32(Rrole[rnum].PracticeBook, 1);
        Rrole[rnum].PracticeBook := -1;
      end;
      Rrole[rnum].TeamState := 3;
      Dec(teamcount);
    end;
  end;
end;

function instruct_60(snum, enum, pic, jump1, jump2: integer): integer;
begin
  Result := jump2;
  if snum = -2 then snum := CurScene;
  if Ddata[snum, enum, 5] = pic then Result := jump1;
  //showmessage(inttostr(Ddata[snum,enum,5]));
end;

procedure instruct_62;
var
  i: smallint;

begin
  where := 3;
  Redraw;
  EndAmi;

  LoadR(0);

  SaveR(0);
  //display_img('end.png', 0, 0);
  where := 3;
  Start;
end;

procedure EndAmi;
var
  i: integer;

  t: uint32;
begin
  where := 3;
  instruct_14;
  DrawRectangleWithoutFrame(0, 0, screen.w, screen.h, 0, 100);
  ShowTitle(4547, 28515);
  DrawRectangleWithoutFrame(0, 0, screen.w, screen.h, 0, 100);
  ShowTitle(4548, 28515);
  instruct_14;
  i := 400;
  t := SDL_GetTicks;
  while (SDL_PollEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
        if (event.key.keysym.sym = SDLK_ESCAPE) then break;
    end;
    if SDL_GetTicks > t + 30 then
    begin
      drawpngpic(Maker_Pic, 220, i, 0);
      SDL_UpdateRect2(screen, 0, 0, 640, 440);
      Dec(i);
      t := SDL_GetTicks;
      if i <= -3060 then break;
    end;
  end;
end;

//Set sexual.

procedure instruct_63(rnum, sexual: integer);
begin
  Rrole[rnum].Sexual := sexual;
end;

//ΤС�����̵�

procedure instruct_64(pnum: integer);
var
  i, amount, shopnum, menu, price: integer;
  list: array[0..4] of integer;
begin

end;

procedure instruct_66(musicnum: integer);
begin
  StopMP3;
  PlayMP3(musicnum, -1);
end;

procedure instruct_67(Soundnum: integer);
var
  i: integer;
  str: string;
begin
  PlaySoundA(Soundnum, 0);
end;

//50ָ���л�ȡ����ֵ

function e_GetValue(bit, t, x: integer): integer;
var
  i: integer;
begin
  i := t and (1 shl bit);
  if i = 0 then Result := x else Result := x50[x];
end;

//Expanded 50 instructs.

function instruct_50e(code, e1, e2, e3, e4, e5, e6: integer): integer;
var
  i, t1, grp, idx, offset, len, i1, i2: integer;
  p, p1: pchar;
  //ps :pstring;
  str: string;
  word, word1: WideString;
begin

  Result := 0;
  case code of
    0: //Give a value to a papameter.
    begin
      x50[e1] := e2;
    end;
    1: //Give a value to one member in parameter group.
    begin
      t1 := e3 + e_GetValue(0, e1, e4);
      x50[t1] := e_GetValue(1, e1, e5);
      if e2 = 1 then x50[t1] := x50[t1] and $FF;
    end;
    2: //Get the value of one member in parameter group.
    begin
      t1 := e3 + e_GetValue(0, e1, e4);
      x50[e5] := x50[t1];
      if e2 = 1 then x50[t1] := x50[t1] and $FF;
    end;
    3: //Basic calculations.
    begin
      t1 := e_GetValue(0, e1, e5);
      case e2 of
        0: x50[e3] := x50[e4] + t1;
        1: x50[e3] := x50[e4] - t1;
        2: x50[e3] := x50[e4] * t1;
        3: x50[e3] := x50[e4] div t1;
        4: x50[e3] := x50[e4] mod t1;
        5: x50[e3] := uint16(x50[e4]) div t1;
      end;
    end;
    4: //Judge the parameter.
    begin
      x50[$7000] := 0;
      t1 := e_GetValue(0, e1, e4);
      case e2 of
        0: if not (x50[e3] < t1) then x50[$7000] := 1;
        1: if not (x50[e3] <= t1) then x50[$7000] := 1;
        2: if not (x50[e3] = t1) then x50[$7000] := 1;
        3: if not (x50[e3] <> t1) then x50[$7000] := 1;
        4: if not (x50[e3] >= t1) then x50[$7000] := 1;
        5: if not (x50[e3] > t1) then x50[$7000] := 1;
        6: x50[$7000] := 0;
        7: x50[$7000] := 1;
      end;
    end;
    5: //Zero all parameters.
    begin
      for i := -$8000 to $7FFF do
        x50[i] := 0;
    end;

    8: //Read talk to string.
    begin
      t1 := e_GetValue(0, e1, e2);
      idx := FileOpen(TALK_IDX, fmopenread);
      grp := FileOpen(TALK_GRP, fmopenread);
      if t1 = 0 then
      begin
        offset := 0;
        FileRead(idx, len, 4);
      end
      else
      begin
        FileSeek(idx, (t1 - 1) * 4, 0);
        FileRead(idx, offset, 4);
        FileRead(idx, len, 4);
      end;
      len := (len - offset);
      FileSeek(grp, offset, 0);
      FileRead(grp, x50[e3], len);
      FileClose(idx);
      FileClose(grp);
      p := @x50[e3];
      for i := 0 to len - 1 do
      begin
        p^ := char(byte(p^) xor $FF);
        p := p + 1;
      end;
      p^ := char(0);

      //x50[e3+i]:=0;
    end;
    9: //Format the string.
    begin
      e4 := e_GetValue(0, e1, e4);
      p := @x50[e2];
      p1 := @x50[e3];
      str := p1;
      str := format(string(p1), [e4]);
      for i := 0 to length(str) do
      begin
        p^ := str[i + 1];
        p := p + 1;
      end;
    end;
    10: //Get the length of a string.
    begin
      x50[e2] := length(pchar(@x50[e1]));
      //showmessage(inttostr(x50[e2]));
    end;
    11: //Combine 2 strings.
    begin
      p := @x50[e1];
      p1 := @x50[e2];
      for i := 0 to length(p1) - 1 do
      begin
        p^ := (p1 + i)^;
        p := p + 1;
      end;
      p1 := @x50[e3];
      for i := 0 to length(p1) do
      begin
        p^ := (p1 + i)^;
        p := p + 1;
      end;
      //p^:=char(0);
    end;
    12: //Build a string with spaces.
      //Note: here the width of one 'space'is the same as one Chinese charactor.
    begin
      e3 := e_GetValue(0, e1, e3);
      p := @x50[e2];
      for i := 0 to e3 do
      begin
        p^ := char($20);
        p := p + 1;
      end;
      p^ := char(0);
    end;
    16: //Write R data.
    begin
      e3 := e_GetValue(0, e1, e3);
      e4 := e_GetValue(1, e1, e4);
      e5 := e_GetValue(2, e1, e5);
      case e2 of
        0: Rrole[e3].Data[e4 div 2] := e5;
        1: Ritem[e3].Data[e4 div 2] := e5;
        2: RScene[e3].Data[e4 div 2] := e5;
        3: Rmagic[e3].Data[e4 div 2] := e5;
        4: Rshop[e3].Data[e4 div 2] := e5;
        5: Wdate[e4 div 2] := e5;
        6: Rzhaoshi[e3].Data[e4 div 2] := e5;
        7: Rmenpai[e3].Data[e4 div 2] := e5;
      end;
    end;
    17: //Read R data.
    begin
      e3 := e_GetValue(0, e1, e3);
      e4 := e_GetValue(1, e1, e4);
      case e2 of
        0: x50[e5] := Rrole[e3].Data[e4 div 2];
        1: x50[e5] := Ritem[e3].Data[e4 div 2];
        2: x50[e5] := RScene[e3].Data[e4 div 2];
        3: x50[e5] := Rmagic[e3].Data[e4 div 2];
        4: x50[e5] := Rshop[e3].Data[e4 div 2];
        5: x50[e5] := Wdate[e4 div 2];
        6: x50[e5] := Rzhaoshi[e3].Data[e4 div 2];
        7: x50[e5] := Rmenpai[e3].Data[e4 div 2];
      end;
    end;
    18: //Write team data.
    begin
      e2 := e_GetValue(0, e1, e2);
      e3 := e_GetValue(1, e1, e3);
      TeamList[e2] := e3;
      //showmessage(inttostr(e3));
    end;
    19: //Read team data.
    begin
      e2 := e_GetValue(0, e1, e2);
      x50[e3] := TeamList[e2];
    end;
    20: //Get the amount of one item.
    begin
      e2 := e_GetValue(0, e1, e2);
      x50[e3] := GetItemCount(e2);
      //showmessage('rer');
    end;
    21: //Write event in Scene.
    begin
      e2 := e_GetValue(0, e1, e2);
      e3 := e_GetValue(1, e1, e3);
      e4 := e_GetValue(2, e1, e4);
      e5 := e_GetValue(3, e1, e5);
      Ddata[e2, e3, e4] := e5;
      if (e2 = CurScene) and (e4 in [5..7]) then
        InitialScene;
      //Redraw;
      //SDL_UpdateRect2(screen,0,0,screen.w,screen.h);
    end;
    22:
    begin
      e2 := e_GetValue(0, e1, e2);
      e3 := e_GetValue(1, e1, e3);
      e4 := e_GetValue(2, e1, e4);
      x50[e5] := Ddata[e2, e3, e4];
    end;
    23:
    begin
      e2 := e_GetValue(0, e1, e2);
      e3 := e_GetValue(1, e1, e3);
      e4 := e_GetValue(2, e1, e4);
      e5 := e_GetValue(3, e1, e5);
      e6 := e_GetValue(4, e1, e6);
      Sdata[e2, e3, e5, e4] := e6;
      if (e2 = CurScene) and (e3 <> 3) then
        InitialScene;
      //Redraw;
      //SDL_UpdateRect2(screen,0,0,screen.w,screen.h);
    end;
    24:
    begin
      e2 := e_GetValue(0, e1, e2);
      e3 := e_GetValue(1, e1, e3);
      e4 := e_GetValue(2, e1, e4);
      e5 := e_GetValue(3, e1, e5);
      x50[e6] := Sdata[e2, e3, e5, e4];
      //showmessage(inttostr(sface));
    end;
    25:
    begin
      e5 := e_GetValue(0, e1, e5);
      e6 := e_GetValue(1, e1, e6);
      t1 := uint16(e3) + uint16(e4) * $10000 + uint16(e6);
      i := uint16(e3) + uint16(e4) * $10000;
      case t1 of
        $1D295A: Sx := e5;
        $1D295C: Sy := e5;
        $1D2956: Cx := e5;
        $1D2958: Cy := e5;
        $18FE2C:
        begin
          if e6 mod 4 <= 1 then
            Ritemlist[e6 div 4].Number := e5
          else
            Ritemlist[e6 div 4].Amount := e5;
        end;
        $051C83:
        begin
          Acol[e6] := e5 mod 256;
          Acol[e6 + 1] := e5 div 256;
        end;
        $01D295E:
        begin
          CurScene := e5;
        end;
        $4:
        begin
          Bstatus := e5;
        end;
        $6:
        begin
          AutoRefresh := e5;
        end;
      end;
      //redraw;
      //SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    end;
    26:
    begin
      e6 := e_GetValue(0, e1, e6);
      t1 := uint16(e3) + uint16(e4) * $10000 + uint(e6);
      i := uint16(e3) + uint16(e4) * $10000;
      case t1 of
        $1D295E: x50[e5] := CurScene;
        $1D295A: x50[e5] := Sx;
        $1D295C: x50[e5] := Sy;
        $1C0B88: x50[e5] := Mx;
        $1C0B8C: x50[e5] := My;
        //$1D2956: x50[e5] := Cx;
        //$1D2958: x50[e5] := Cy;
        $05B53A: x50[e5] := 1;
        $0544F2: x50[e5] := Sface;
        $1E6ED6: x50[e5] := x50[28100];
        $1D2956: x50[e5] := Cx;
        $1D2958: x50[e5] := Cy;

        $556DA: x50[e5] := Ax;
        $556DC: x50[e5] := Ay;
        $1:
        begin
          x50[e5] := 0;
          for i := 0 to length(Brole) - 1 do
            x50[e5] := max(x50[e5], Brole[i].round);
        end;
        $2: x50[e5] := time;
        $3: x50[e5] := CurEvent;
        $4: x50[e5] := bstatus;
        $5: x50[e5] := BRoleAmount;
        $6: x50[e5] := AutoRefresh;
        $7: x50[e5] := CurItem;
        $8: x50[e5] := where;
        $9: x50[e5] := CurBrole;
        $10: x50[e5] := CurMagic;
        $11: x50[e5] := GetMagicLevel(CurBrole, CurMagic);
      end;
      if (t1 - $18FE2C >= 0) and (t1 - $18FE2C < 800) then
      begin
        i := t1 - $18FE2C;
        //showmessage(inttostr(e3));
        if i mod 4 <= 1 then
          x50[e5] := Ritemlist[i div 4].Number
        else
          x50[e5] := Ritemlist[i div 4].Amount;
      end;

      if (t1 >= $1E4A04) and (t1 < $1E6A04) then
      begin
        i := (t1 - $1E4A04) div 2;
        //showmessage(inttostr(e3));
        x50[e5] := Bfield[2, i mod 64, i div 64];
      end;
    end;

    27: //Read name to string.
    begin
      e3 := e_GetValue(0, e1, e3);
      p := @x50[e4];
      case e2 of
        0: p1 := @Rrole[e3].Name;
        1: p1 := @Ritem[e3].Name;
        2: p1 := @RScene[e3].Name;
        3: p1 := @Rmagic[e3].Name;
      end;
      for i := 0 to 19 do
      begin
        (p + i)^ := (p1 + i)^;
        if (p1 + i)^ = char(0) then break;
      end;
      (p + i)^ := char($20);
      (p + i + 1)^ := char(0);
    end;
    28: //Get the battle number.
    begin
      x50[e1] := x50[28005];
    end;
    29: //Select aim.
    begin
      e2 := e_GetValue(0, e1, e2);
      e3 := e_GetValue(1, e1, e3);
      if e5 = 0 then
      begin
        //showmessage('IN CASE');
        SelectAim(e2, e3,0);
      end;
      x50[e4] := bfield[2, Ax, Ay];
    end;
    30: //Read battle properties.
    begin
      e2 := e_GetValue(0, e1, e2);
      e3 := e_GetValue(1, e1, e3);
      x50[e4] := Brole[e2].Data[e3 div 2];
    end;
    31: //Write battle properties.
    begin
      e2 := e_GetValue(0, e1, e2);
      e3 := e_GetValue(1, e1, e3);
      e4 := e_GetValue(2, e1, e4);
      Brole[e2].Data[e3 div 2] := e4;
    end;
    32: //Modify next instruct.
    begin
      e3 := e_GetValue(0, e1, e3);
      Result := 655360 * (e3 + 1) + x50[e2];
      //showmessage(inttostr(result));
    end;
    33: //Draw a string.
    begin
      e3 := e_GetValue(0, e1, e3);
      e4 := e_GetValue(1, e1, e4);
      e5 := e_GetValue(2, e1, e5);
      //showmessage(inttostr(e5));
      i := 0;
      t1 := 0;
      p := @x50[e2];
      p1 := p;
      while byte(p^) > 0 do
      begin
        if byte(p^) = $2A then
        begin
          p^ := char(0);
          drawgbkshadowtext(p1, e3 - 22, e4 + 22 * i - 25, ColColor(0, e5 and $FF),
            ColColor(0, (e5 and $FF00) shr 8));
          i := i + 1;
          p1 := p + 1;
        end;
        p := p + 1;
      end;
      drawgbkshadowtext(p1, e3 - 22, e4 + 22 - 25, ColColor(0, e5 and $FF), ColColor(0, (e5 and $FF00) shr 8));
      if autorefresh = 0 then SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      //waitanykey;
    end;
    34: //Draw a rectangle as background.
    begin
      e2 := e_GetValue(0, e1, e2);
      e3 := e_GetValue(1, e1, e3);
      e4 := e_GetValue(2, e1, e4);
      e5 := e_GetValue(3, e1, e5);
      e6 := e_GetValue(4, e1, e6);
      DrawRectangle(e2, e3, e4, e5, 0, ColColor(0, $FF), e6);
      //SDL_UpdateRect2(screen,e1,e2,e3+1,e4+1);
    end;
    35: //Pause and wait a key.
    begin
      WaitAnyKey(@x50[e1], @x50[e2], @x50[e3]);
      x50[e3] := x50[e3] - 30;
      case x50[e1] of
        SDLK_LEFT: x50[e1] := 154;
        SDLK_RIGHT: x50[e1] := 156;
        SDLK_UP: x50[e1] := 158;
        SDLK_DOWN: x50[e1] := 152;
        SDLK_KP4: x50[e1] := 154;
        SDLK_KP6: x50[e1] := 156;
        SDLK_KP8: x50[e1] := 158;
        SDLK_KP2: x50[e1] := 152;
      end;
    end;
    36: //Draw a string with background then pause, if the key pressed is 'Y'then jump=0.
    begin
      e3 := e_GetValue(0, e1, e3);
      e4 := e_GetValue(1, e1, e4);
      e5 := e_GetValue(2, e1, e5);
      //word := gbktounicode(@x50[e2]);
      //t1 := length(word);
      //drawtextwithrect(@word[1], e3, e4, t1 * 20 - 15, colcolor(0,e5 and $FF), colcolor(0,(e5 and $FF00) shl 8));
      p := @x50[e2];
      i1 := 1;
      i2 := 0;
      t1 := 0;
      while byte(p^) > 0 do
      begin
        //showmessage('');
        if byte(p^) = $2A then
        begin
          if t1 > i2 then i2 := t1;
          t1 := 0;
          i1 := i1 + 1;
        end;
        if byte(p^) = $20 then t1 := t1 + 1;
        p := p + 1;
        t1 := t1 + 1;
      end;
      if t1 > i2 then i2 := t1;
      p := p - 1;
      if i1 = 0 then i1 := 1;
      if byte(p^) = $2A then i1 := i1 - 1;
      DrawRectangle(e3, e4, i2 * 10 + 25, i1 * 22 + 5, 0, ColColor(0, 255), 30);
      p := @x50[e2];
      p1 := p;
      i := 0;
      while byte(p^) > 0 do
      begin
        if byte(p^) = $2A then
        begin
          p^ := char(0);
          drawgbkshadowtext(p1, e3 - 17, e4 + 22 * i + 2, ColColor(0, e5 and $FF),
            ColColor(0, (e5 and $FF00) shr 8));
          i := i + 1;
          p1 := p + 1;
        end;
        p := p + 1;
      end;
      drawgbkshadowtext(p1, e3 - 17, e4 + 22 * i + 2, ColColor(0, e5 and $FF), ColColor(0, (e5 and $FF00) shr 8));
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      i := WaitAnyKey;
      if i = SDLK_y then x50[$7000] := 0 else x50[$7000] := 1;
      //redraw;
    end;
    37: //Delay.
    begin
      e2 := e_GetValue(0, e1, e2);
      SDL_Delay((e2 * GameSpeed) div 10);
    end;
    38: //Get a number randomly.
    begin
      e2 := e_GetValue(0, e1, e2);
      if e2 = 100 then
        x50[e3] := randomf3 div 100
      else
        x50[e3] := random(e2);
    end;
    39: //Show a menu to select. The 40th instruct is too complicable, just use the 30th.
    begin
      e2 := e_GetValue(0, e1, e2);
      e5 := e_GetValue(1, e1, e5);
      e6 := e_GetValue(2, e1, e6);
      setlength(menuString, 0);
      setlength(menuString, e2);
      setlength(menuEngString, 0);
      t1 := 0;
      for i := 0 to e2 - 1 do
      begin
        menuString[i] := gbktounicode(@x50[x50[e3 + i]]);
        i1 := length(pchar(@x50[x50[e3 + i]]));
        if i1 > t1 then t1 := i1;
      end;
      x50[e4] := CommonMenu(e5, e6, t1 * 10 + 3, e2 - 1) + 1;
    end;
    40: //Show a menu to select. The 40th instruct is too complicable, just use the 30th.
    begin
      e2 := e_GetValue(0, e1, e2);
      e5 := e_GetValue(1, e1, e5);
      e6 := e_GetValue(2, e1, e6);
      setlength(menuString, 0);
      setlength(menuString, e2);
      setlength(menuEngString, 0);
      i2 := 0;
      for i := 0 to e2 - 1 do
      begin
        menuString[i] := gbktounicode(@x50[x50[e3 + i]]);
        i1 := length(pchar(@x50[x50[e3 + i]]));
        if i1 > i2 then i2 := i1;
      end;
      t1 := (e1 shr 8) and $FF;
      if t1 = 0 then t1 := 5;
      //showmessage(inttostr(t1));
      x50[e4] := CommonScrollMenu(e5, e6, i2 * 10 + 3, e2 - 1, t1) + 1;
    end;
    41: //Draw a picture.
    begin
      e3 := e_GetValue(0, e1, e3);
      e4 := e_GetValue(1, e1, e4);
      e5 := e_GetValue(2, e1, e5);
      RShowpic.repeated:=e_GetValue(3, e1, e6);
      RShowpic.tp:=e2;
      RShowpic.pnum:=e5;
      RShowpic.x:=e3;
      RShowpic.y:=e4;
      case e2 of
        0:
        begin
          if where <> 0 then
          begin
            if e5 > 0 then
              DrawSPic(e5 div 2, e3, e4, 0, 0, screen.w, screen.h)
            else
              DrawSNewPic(-e5 div 2, e3, e4, 0, 0, screen.w, screen.h, 0);
          end
          else DrawMPic(e5 div 2, e3, e4, 0);
        end;
        1: DrawHeadPic(e5, e3, e4); {ZoomPic(head_pic[e5].pic, 0, e3, e4 - 60, 58, 60);}
        2: DrawItemPic(e5, e3, e4);
      end;
      if autorefresh = 0 then SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    end;
    42: //Change the poistion on world map.
    begin
      e2 := e_GetValue(0, e1, e2);
      e3 := e_GetValue(0, e1, e3);
      Mx := e3;
      My := e2;
    end;
    43: //Call another event.
    begin
      e2 := e_GetValue(0, e1, e2);
      e3 := e_GetValue(1, e1, e3);
      e4 := e_GetValue(2, e1, e4);
      e5 := e_GetValue(3, e1, e5);
      e6 := e_GetValue(4, e1, e6);
      x50[$7100] := e3;
      x50[$7101] := e4;
      x50[$7102] := e5;
      x50[$7103] := e6;
      if e2 = -1 then
      begin
        jmpScene(e3, e4, e5);
      end

      else if e2 = -2 then
      begin
        x50[$7000] := 1;
        if Poetry(e3, e4, e5, e6) then
          x50[$7000] := 0;
        Redraw;
      end
      else if e2 = -3 then
      begin
        x50[$7000] := 1;
        if GetPetSkill(e3, e4) then
          x50[$7000] := 0;
      end
      else if e2 = -4 then
      begin
        x50[$7000] := 1;
        if Acupuncture(e3) then
          x50[$7000] := 0;
        Redraw;
      end
      else if e2 = -5 then
      begin
        ShowMR := True;
        if e3 = 1 then ShowMR := False;
      end
      else if e2 = -6 then
      begin
        time := e3;
        timeevent := e4;
        if e3 <= 0 then
        begin
          time := -1;
          timeevent := -1;
        end;
        DrawScene;
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end
      else if e2 = -7 then
      begin
        RandomEvent := e3;
      end
      else if e2 = -8 then
      begin
        //redraw;
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end
      else if e2 = -9 then
      begin
        x50[$7000] := 1;
        if shoteagle(e3, e4) then
          x50[$7000] := 0;
      end
      else if e2 = -10 then
      begin
        x50[$7000] := 1;
        if rotospellpicture(e3, e4) then
          x50[$7000] := 0;
        Redraw;
      end
      else if e2 = -11 then
      begin
        AddDefense(e3, e4);
      end
      else if e2 = -12 then
      begin
        for i := 0 to length(Brole) - 1 do
        begin
          if Brole[i].rnum = e3 then
          begin
            Brole[i].Data[e4 div 2] := e5;
          end;
        end;
      end
      else if e2 = -13 then
      begin
        for i := 0 to length(Brole) - 1 do
        begin
          if Brole[i].rnum = e3 then
          begin
            x50[e5] := Brole[i].Data[e4 div 2];
          end;
        end;
      end
      else if e2 = -14 then
      begin
        Bx := e4;
        By := e3;
        Redraw;
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end
      else if e2 = -15 then //�ݴ��书
      begin
        for i := 0 to 29 do
        begin
          magictemp[i] := Rrole[e3].lmagic[i];
          magiclvtemp[i] := Rrole[e3].MagLevel[i];
        end;
      end
      else if e2 = -16 then //����书
      begin
        for i := 0 to 29 do
          if Rrole[e3].lmagic[i] > 0 then
            if Rmagic[Rrole[e3].lmagic[i]].MagicType <> 5 then
            begin
              Rrole[e3].lmagic[i] := -1;
              Rrole[e3].MagLevel[i] := 0;
            end;
        for i := 28 downto 0 do
          if Rrole[e3].lmagic[i] = 0 then
          begin
            for i1 := i to 8 do
            begin
              Rrole[e3].lmagic[i1] := Rrole[e3].lmagic[i1 + 1];
              Rrole[e3].MagLevel[i1] := Rrole[e3].MagLevel[i1 + 1];
            end;
          end;
        Rrole[e3].lmagic[29] := -1;
        Rrole[e3].MagLevel[29] := 0;
      end
      else if e2 = -17 then //�ָ��书
      begin
        for i := 0 to 29 do
        begin
          Rrole[e3].lmagic[i] := magictemp[i];
          Rrole[e3].MagLevel[i] := magiclvtemp[i];
        end;
      end
      else if e2 = -18 then //ս���õ��书 0Ϊ���ã�1Ϊ��ȡ
      begin
        if e3 = 0 then
        begin
          if e4 <> -2 then
            Warsta.GetKongfu[0] := e4;
          if e5 <> -2 then
            Warsta.GetKongfu[1] := e5;
          if e6 <> -2 then
            Warsta.GetKongfu[2] := e6;
        end
        else
        begin
          x50[e4] := Warsta.GetKongfu[0];
          x50[e5] := Warsta.GetKongfu[1];
          x50[e6] := Warsta.GetKongfu[2];
        end;
      end
      else if e2 = -19 then // ս���õ���Ʒ  0Ϊ���ã�1Ϊ��ȡ
      begin
        if e3 = 0 then
        begin
          if e4 <> -2 then
            Warsta.GetItems[0] := e4;
          if e5 <> -2 then
            Warsta.GetItems[1] := e5;
          if e6 <> -2 then
            Warsta.GetItems[2] := e6;
        end
        else
        begin
          x50[e4] := Warsta.GetItems[0];
          x50[e5] := Warsta.GetItems[1];
          x50[e6] := Warsta.GetItems[2];
        end;
      end
      else if e2 = -20 then // ս���õ���Ǯ  0Ϊ���ã�1Ϊ��ȡ
      begin
        if e3 = 0 then
        begin
          if e4 <> -2 then
            Warsta.GetMoney := e4;
        end
        else
          x50[e4] := Warsta.GetMoney;
      end
      else if e2 = -21 then // ����ս������
      begin
        for i := 0 to length(Brole) - 1 do
          Brole[i].Show := e3;
      end
      else if e2 = -22 then // �ж���Ϸ����
      begin
        x50[$7000] := 1;
          {if gametime >= e3 then
            x50[$7000] := 0;}
      end
      else if e2 = -23 then // �޸�ս����ͼ
      begin
        i := Bfield[e3, e5, e4];
        Bfield[e3, e5, e4] := e6;
        UpdateBattleScene(e5, e4, i, e6);
      end
      else if e2 = -24 then // ��ȡս����ͼ
      begin
        x50[e6] := Bfield[e3, e5, e4];
      end
      else if e2 = -25 then // ̰����
      begin
        x50[e3] := femalesnake;
        Redraw;
      end
      else if e2 = -26 then // ѡ��
      begin
        x50[e5] := SelectList(e3, e4);
      end
      else if e2 = -27 then // ����ս������
      begin
        for i := 0 to length(Brole) - 1 do
        begin
          if (Brole[i].rnum = -1) and (Brole[i].Team = e4) then
          begin
            if e5 = -2 then i1 := Brole[i].X else i1 := e5;
            if e6 = -2 then i2 := Brole[i].Y else i2 := e6;
            if (bfield[2, i1, i2] = -1) then
            begin
              Brole[i].rnum := e3;
              Brole[i].Dead := 0;
              Brole[i].Show := 0;
              Brole[i].speed := GetRoleSpeed(e3, True);
              if CheckEquipSet(Rrole[e3].Equip[0], Rrole[e3].Equip[1], Rrole[e3].Equip[2],
                Rrole[e3].Equip[3]) = 5 then
                Inc(Brole[i].speed, 30);
              Brole[i].Step := Brole[i].speed div 15;
              Brole[i].Progress := 0;
              Brole[i].X := i1;
              Brole[i].Y := i2;
              bfield[2, i1, i2] := i;
              maxspeed := max(maxspeed, Brole[i].speed);
              break;
            end;
          end;
        end;
      end
      else if e2 = -28 then //ѧϰ����
      begin
        //StudyGongti;
      end
      else if e2 = -29 then //���徭������ luke�Ğ��ޟ��c������
      begin
        if e3 >= 0 then
          Rrole[e3].ExpForBook := min(Rrole[e3].ExpForBook + e4, 50000)
        else
          for i := 0 to length(Rrole) - 1 do
            if Rrole[i].TeamState in [1, 2] then
              Rrole[i].ExpForBook := min(Rrole[i].ExpForBook + e4, 50000);
      end
      else if e2 = -30 then
      begin
        AddSkillPoint(e3);
      end
      else if e2 = -31 then //�ڰ���
      begin
        x50[$7000] := 1;
        if Lamp(e3, e4, e5, e6) then x50[$7000] := 0;
      end
      else if e2 = -32 then //��֪����ʲ��
      begin
        Puzzle;
      end
      else if e2 = -33 then //��֪����ʲ��
      begin
        chengesnowhill();
      end
      else if e2 = -113 then
      begin
        x50[$7000] := 1;
        if Rrole[e3].LMagic[Rrole[e3].Gongti] = e4 then
          x50[$7000] := 0;
      end
      else if e2 = -114 then
      begin
        SetGongti(e3, e4);
      end
      else if e2 = -115 then
      begin
        StudyMagic(e3, e4, e5, e6, 1);
      end
      else if e2 = -116 then
      begin
        x50[$7000] := 1;
        if HaveMagic(e3, e4, e5) then
          x50[$7000] := 0;
      end
      else if e2 = -117 then
      begin
        i := InputAmount;
        x50[e3] := i;
      end
      else if e2 = -118 then
      begin
        x50[$7000] := 0;
        x50[e5] := -1;
        if Ritem[e3].Count <= 0 then
        begin
          x50[e5] := e3;
          x50[$7000] := 1;
        end
        else
          for i := 0 to 4 do
          begin
            if Ritem[e3].NeedItem[i] >= 0 then
            begin
              if GetItemCount(Ritem[e3].NeedItem[i]) < Ritem[e3].NeedMatAmount[i] * e4 then
              begin
                x50[e5] := Ritem[e3].NeedItem[i];
                x50[$7000] := 1;
                break;
              end;
            end;
          end;
      end
      else if e2 = -119 then
      begin
        instruct_32(e3, e4);
      end
      else if e2 = -120 then
      begin
        if e3 = -2 then e3 := curScene;
        rScene[e3].Pallet := e4;
        resetpallet;
      end
      else if e2 = -121 then
      begin
        if e3 = -2 then e3 := curScene;
        rScene[e3].Mapmode := e4;
        setScene;
      end
      else if e2 = -122 then
      begin
        x50[$7000] := 1;
        if AddBattleStateToEquip then
          x50[$7000] := 0;
      end

        {else if e2 = 200 then
        begin
          xuewu(e3,e4);
        end
        else if e2 = 201 then
        begin
          hebing1(e3,e4,e5,e6);
        end
        else if e2 = 202 then
        begin
          hebing2(e3,e4,e5,e6);
        end
        else if e2 = 203 then
        begin
          callnewtalk2;
        end
        else if e2 = 204 then
        begin
          showmenpai(e3);
        end
        else if e2 = 205 then
        begin
          tiaose;
        end
        else if e2 = 206 then
        begin
          givezhangmen(e3,e4);
        end
        else if e2 = 207 then
        begin
          x50[$7000]:=checkzmr(e3,e4);

        end
        else if e2 = 208 then
        begin
          menpaimenu(e3);
        end}
      else if e2 > 0 then
        CallEvent(e2);
      //showmessage(inttostr(e2));
    end;
    44: //Play amination.
    begin
      e2 := e_GetValue(0, e1, e2);
      if e2 > 100 then e2 := e_GetValue(0, 1, e2);
      e3 := e_GetValue(1, e1, e3);
      e4 := e_GetValue(2, e1, e4);
      e5 := e_GetValue(3, e1, e5);
      e6 := e_GetValue(3, e1, e6);
      PlayActionAmination(e2, e3);
      PlayMagicAmination(e2, e5, e4, e6);
    end;
    45: //Show values.
    begin
      e2 := e_GetValue(0, e1, e2);
      case e2 of
        1: e2 := 0;
        2: e2 := 2;
        3: e2 := 4;
        4: e2 := 3;
        5: e2 := 1;
      end;
      ShowHurtValue(e2);
    end;
    46: //Set effect layer.
    begin
      e2 := e_GetValue(0, e1, e2);
      e3 := e_GetValue(1, e1, e3);
      e4 := e_GetValue(2, e1, e4);
      e5 := e_GetValue(3, e1, e5);
      e6 := e_GetValue(4, e1, e6);
      for i1 := e2 to e2 + e4 - 1 do
        for i2 := e3 to e3 + e5 - 1 do
          bfield[4, i2, i1] := e6;
    end;
    47: //Here no need to re-set the pic.
    begin
    end;
    48: //Show some parameters.
    begin
      str := '';
      for i := e1 to e1 + e2 - 1 do
        str := str + 'x' + IntToStr(i) + '=' + IntToStr(x50[i]) + char(13) + char(10);
      messagebox(0, @str[1], 'KYS Windows', MB_OK);
    end;
    49: //In PE files, you can't call any procedure as your wish.
    begin
    end;
    50: //Enter name for items, magics and roles.
    begin
      e2 := e_GetValue(0, e1, e2);
      e3 := e_GetValue(1, e1, e3);
      e4 := e_GetValue(2, e1, e4);
      e5 := e_GetValue(3, e1, e5);

      case e2 of
        0: p := @Rrole[e3].Data[e4 div 2];
        1: p := @Ritem[e3].Data[e4 div 2];
        2: p := @Rmagic[e3].Data[e4 div 2];
        3: p := @RScene[e3].Data[e4 div 2];
      end;

      if FULLSCREEN = 1 then
      begin
        if HW = 0 then screen := SDL_SetVideoMode(CENTER_X * 2, CENTER_Y * 2, 32, SDL_HWSURFACE or
            SDL_DOUBLEBUF or SDL_ANYFORMAT)
        else screen := SDL_SetVideoMode(CENTER_X * 2, CENTER_Y * 2, 32, SDL_SWSURFACE or
            SDL_DOUBLEBUF or SDL_ANYFORMAT);
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end;
      //redraw;

      //showmessage(inttostr(e4));
      word1 := gbktounicode(p);
      word1 := MidStr(word1, 2, length(word1) - 1);
      word := 'Ոݔ�����Q              ';
      word := InputBox('Enter name', word, word1);
      word := Simplified2Traditional(word);
      str := UnicodeToGBK(@word[1]);
      p1 := @str[1];
      if FULLSCREEN = 1 then
      begin
        screen := SDL_SetVideoMode(CENTER_X * 2, CENTER_Y * 2, 32, SDL_FULLSCREEN);
        //redraw;
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end;

      for i := 0 to e5 - 1 do
        (p + i)^ := (p1 + i)^;
    end;
    51: //Enter a number.
    begin
      i := InputAmount;
      x50[e1] := i;
    end;
    52: //Judge someone grasp some mggic.
    begin
      e2 := e_GetValue(0, e1, e2);
      e3 := e_GetValue(1, e1, e3);
      e4 := e_GetValue(2, e1, e4);
      x50[$7000] := 1;
      if (HaveMagic(e2, e3, e4) = True) then
        x50[$7000] := 0;
    end;
    60: //Call scripts.
    begin
      e2 := e_GetValue(0, e1, e2);
      e3 := e_GetValue(1, e1, e3);
      ExecScript(pchar('script\' + IntToStr(e2) + '.lua'), pchar('f' + IntToStr(e3)));
    end;
  end;

end;

//�ж�ĳ���з�ĳ�书ĳ��

function HaveMagic(person, mnum, lv: integer): boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to 29 do
    if (Rrole[person].lMagic[i] = mnum) then
      if (Rrole[person].MagLevel[i] >= lv) then Result := True;
end;

//��ȡĳ��ĳ�书����

function GetMagicLevel(person, mnum: integer): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to 29 do
    if (Rrole[person].lMagic[i] = mnum) then
      Result := Rrole[person].MagLevel[i];
end;

//��ȡ���弶��


function GetGongtiLevel(person, n: integer): integer;
var
  i: integer;
begin
  if (person >= 0) and (n >= -1) then
    Result := min(Rmagic[Rrole[person].lmagic[n]].MaxLevel, Rrole[person].maglevel[n] div 100)
  else Result := 0;
end;

procedure SetGongti(rnum, mnum: integer);
var
  l, oldkongti, i, j, n, k: integer;
  hp, mp: double;
begin
  oldkongti := Rrole[rnum].Gongti;
  if Rrole[rnum].MaxHP <> 0 then
    hp := Rrole[rnum].CurrentHP / Rrole[rnum].MaxHP
  else
    hp := 0;

  if Rrole[rnum].MaxMP <> 0 then
    mp := Rrole[rnum].CurrentMP / Rrole[rnum].MaxMP
  else
    mp := 0;

  if oldkongti >= 0 then
  begin
    l := getgongtiLevel(rnum, oldkongti);
    Dec(Rrole[rnum].MaxHP, Rmagic[Rrole[rnum].lmagic[oldkongti]].Addhp[l]);
    Dec(Rrole[rnum].MaxMP, Rmagic[Rrole[rnum].lmagic[oldkongti]].Addmp[l]);
  end;
  Rrole[rnum].Gongti := -1;
  for i := 0 to 29 do
  begin
    if (mnum > 0) and (mnum = Rrole[rnum].LMagic[i]) then
    begin
      Rrole[rnum].Gongti := i;
      break;
    end;
  end;
  if Rrole[rnum].Gongti >= 0 then
  begin
    l := getgongtiLevel(rnum, Rrole[rnum].Gongti);
    Inc(Rrole[rnum].MaxHP, Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].Addhp[l]);
    Inc(Rrole[rnum].MaxMP, Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].Addmp[l]);
  end;

  Rrole[rnum].CurrentHP := max(trunc(Rrole[rnum].MaxHP * hp), 1);
  Rrole[rnum].CurrentMP := max(trunc(Rrole[rnum].MaxMP * mp), 0);

  for i := 0 to 9 do
  begin
    Rrole[rnum].jhMagic[i] := -1;
  end;
  if rnum > 0 then
  begin
    n := 0;
    if Rrole[rnum].gongti = -1 then
    begin
      for i := 0 to 29 do
        if ((Rrole[rnum].lmagic[i] <= 0) or (n > 9)) then break
        else if (Rmagic[Rrole[rnum].lmagic[i]].magictype <> 5) then
        begin
          Rrole[rnum].jhMagic[n] := i;
          Inc(n);
        end;

    end
    else
    begin
      for i := 0 to 29 do
        if ((Rrole[rnum].lmagic[i] <= 0) or (n > 9)) then break
        else if (Rmagic[Rrole[rnum].lmagic[i]].magictype <> 5) then
        begin
          k := 0;
          for j := 0 to 9 do
          begin
            if (Rmagic[Rrole[rnum].lmagic[i]].teshumod[0] = -1) or
              ((Rmagic[Rrole[rnum].lmagic[i]].teshu[j] = Rrole[rnum].lmagic[Rrole[rnum].gongti]) and
              ((Rmagic[Rrole[rnum].lmagic[i]].teshumod[j] = 0) or
              (Rmagic[Rrole[rnum].lmagic[i]].teshumod[j] = Rrole[rnum].menpai))) then
            begin
              k := 1;
              break;
            end;
          end;
          if k = 1 then
          begin
            Rrole[rnum].jhMagic[n] := i;
            Inc(n);

          end;
        end;
    end;
  end;

end;


function GetGongtiState(person, state: integer): boolean;
var
  i, bnum: integer;
begin
  Result := False;
  if Rrole[person].Gongti < 0 then
  begin
    Result := False;
    exit;
  end
  else if Rmagic[Rrole[person].LMagic[Rrole[person].Gongti]].MaxLevel > GetGongtiLevel(person,
    Rrole[person].Gongti) then
    Result := False
  else if state = Rmagic[Rrole[person].LMagic[Rrole[person].Gongti]].BattleState then Result := True;
  if (not Result) and getpetskill(5, 4) then
  begin
    if (where = 2) then
    begin
      for i := 0 to length(Brole) - 1 do
        if Brole[i].rnum = person then
          bnum := i;

      for i := 0 to length(Brole) - 1 do
        if (Brole[i].Dead = 0) and (Brole[i].rnum >= 0) and (Brole[i].Team = 0) and
          (i <> bnum) and (Brole[i].Team = Brole[bnum].Team) and (Brole[i].X in
          [Brole[bnum].X - 3..Brole[bnum].X + 3]) and (Brole[i].Y in [Brole[bnum].Y - 3..Brole[bnum].Y + 3]) then
          if (Rrole[Brole[i].rnum].Gongti >= 0) and
            (Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].MaxLevel <=
            GetGongtiLevel(Brole[i].rnum, Rrole[Brole[i].rnum].Gongti)) and
            (state = Rmagic[Rrole[Brole[i].rnum].LMagic[Rrole[Brole[i].rnum].Gongti]].BattleState) then
            Result := True;
    end
    else
    begin
      for i := 0 to length(teamlist) - 1 do
        if (teamlist[i] >= 0) then
          if (Rrole[teamlist[i]].Gongti >= 0) and
            (Rmagic[Rrole[teamlist[i]].LMagic[Rrole[teamlist[i]].Gongti]].MaxLevel <=
            GetGongtiLevel(teamlist[i], Rrole[teamlist[i]].Gongti)) and (state =
            Rmagic[Rrole[teamlist[i]].LMagic[Rrole[teamlist[i]].Gongti]].BattleState) then
            Result := True;
    end;
  end;
end;


function GetEquipState(person, state: integer): boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to 4 do
    if (Rrole[person].Equip[i] >= 0) and (Ritem[Rrole[person].Equip[i]].BattleEffect = state) then
      Result := True;
end;
//��д��ѧ���书

procedure StudyMagic(rnum, magicnum, newmagicnum, level, dismode: integer);
var
  i, n: integer;
  word: WideString;
label
  Next;
begin
  if newmagicnum = 0 then //ɾ���书
  begin
    for i := 0 to 29 do
    begin
      if Rrole[rnum].lMagic[i] = magicnum then
      begin
        for n := i to 28 do
        begin
          Rrole[rnum].lMagic[n] := Rrole[rnum].lMagic[n + 1];
          Rrole[rnum].MagLevel[n] := Rrole[rnum].MagLevel[n + 1];
        end;
        Rrole[rnum].lMagic[29] := -1;
        Rrole[rnum].MagLevel[29] := 0;
        break;
      end;
    end;
  end
  else
  begin
    n := 0;
    for i := 0 to 29 do
    begin
      if Rrole[rnum].lMagic[i] = newmagicnum then //�Ѿ�����书
      begin
        if level = -2 then level := 0;
        Rrole[rnum].MagLevel[i] := min(Rrole[rnum].MagLevel[i] + level + 100, 999);
        StudyMagic(rnum, magicnum, 0, 0, 1);
        n := 1; //���ѽ�ԭ���书������ִ���滻�书
        break;
      end;
    end;
    if n = 0 then
      for i := 0 to 29 do
      begin
        if (Rrole[rnum].lMagic[i] = magicnum) then //���书�滻Ϊ���书
        begin
          if level <> -2 then Rrole[rnum].MagLevel[i] := level;
          Rrole[rnum].lMagic[i] := newmagicnum;
          break;
        end;
      end;
    for i := 0 to 29 do
    begin
      if (magicnum > 0) and (Rrole[rnum].lMagic[i] <= 0) then //���书�滻Ϊ���书������
      begin
        Rrole[rnum].lMagic[i] := magicnum;
        if level = -2 then level := 0;
        Rrole[rnum].MagLevel[i] := min(Rrole[rnum].MagLevel[i] + level + 100, 999);
        break;
      end;
    end;

  end;

  //if i = 10 then rrole[rnum].data[i+63] := magicnum;
  if dismode = 0 then
  begin
    DrawRectangle(CENTER_X - 75, 98, 145, 76, 0, ColColor(0, 255), 30);
    word := '�W��';
    DrawShadowText(@word[1], CENTER_X - 90, 125, ColColor(0, $5), ColColor(0, $7));
    drawgbkshadowtext(@Rrole[rnum].Name, CENTER_X - 90, 100, ColColor(0, $21), ColColor(0, $23));
    drawgbkshadowtext(@Rmagic[newmagicnum].Name, CENTER_X - 90, 150, ColColor(0, $64), ColColor(0, $66));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    WaitAnyKey;
    Redraw;
  end;

  n := 0;
  for i := 0 to 29 do
  begin
    if Rrole[rnum].lMagic[i] > 0 then
      Inc(n);
  end;
  if n = 30 then
  begin
    if Rrole[rnum].PracticeBook >= 0 then
    begin
      if Ritem[Rrole[rnum].PracticeBook].Magic > 0 then
      begin
        if GetMagicLevel(rnum, Ritem[Rrole[rnum].PracticeBook].Magic) = -1 then
        begin
          instruct_32(Rrole[rnum].PracticeBook, 1);
          Rrole[rnum].PracticeBook := -1;
          //Rrole[rnum].ExpForBook := 0;
        end;
      end;
    end;
  end;
end;

procedure NewTalk(headnum, talknum, namenum, place, showhead, color, frame: integer); overload;
begin
  NewTalk(headnum, talknum, namenum, place, showhead, color, frame, -1);
end;

procedure NewTalk(headnum, talknum, namenum, place, showhead, color, frame, mods: integer); overload;
var
  alen, newcolor, color1, color2, nh, nw, ch, c1, r1, n, namelen, i, t1, grp, idx, offset,
  len, i1, i2, face, c, nx, ny, hx, hy, hw, hh, x, y, w, h, cell, row: integer;
  np3, np, np1, np2, np4, tp, p1, pp1, ap, app: pchar;
  actorarray, actorarray1, talkarray, namearray, name1, name2: array of byte;
  pword: array[0..1] of uint16;
  wd, str: string;
  temp2: WideString;
begin
  pword[1] := 0;
  face := 4900;
  (* case color of
   0:color:=28515;
   1:color:=28421;
   2:color:=28435;
   3:color:=28563;
   4:color:=28466;
   5:color:=28450;
   end; *)
  if color = 0 then color := 28515;
  color1 := color and $FF;
  color2 := (color shr 8) and $FF;
  x := 155;
  y := 320;
  w := 450;
  h := 109;
  nx := 155;
  ny := 291;
  nw := 145;
  nh := 28;

  hx := 10;
  hy := 409;
  hw := 145;
  hh := 150;

  row := 5;
  cell := 22;
  if place = 1 then
  begin
    x := 40;
    y := 70;
    nx := 340;
    ny := 41;
    hx := 490;
    hy := 159;

  end;
  //read talk
  if mods = -1 then
  begin
    idx := FileOpen(TALK_IDX, fmopenread);
    grp := FileOpen(TALK_GRP, fmopenread);
  end
  else
  begin
    idx := FileOpen(t1_IDX, fmopenread);
    grp := FileOpen(t1_GRP, fmopenread);
  end;
  if talknum = 0 then
  begin
    offset := 0;
    FileRead(idx, len, 4);
  end
  else
  begin
    FileSeek(idx, (talknum - 1) * 4, 0);
    FileRead(idx, offset, 4);
    FileRead(idx, len, 4);
  end;
  len := (len - offset);
  setlength(talkarray, len + 2);
  FileSeek(grp, offset, 0);
  FileRead(grp, talkarray[0], len);
  FileClose(idx);
  FileClose(grp);
  for i := 0 to len - 1 do
  begin
    talkarray[i] := talkarray[i] xor $FF;
    if (talkarray[i] = $FF) then
      talkarray[i] := 0;
  end;
  talkarray[len] := byte(0);
  talkarray[len + 1] := byte(0);
  tp := @talkarray[0];

  //read name
  //read name
  if namenum > 0 then
  begin
    idx := FileOpen(NAME_IDX, fmopenread);
    grp := FileOpen(NAME_GRP, fmopenread);
    FileSeek(idx, (namenum - 1) * 4, 0);
    FileRead(idx, offset, 4);
    FileRead(idx, namelen, 4);

    namelen := (namelen - offset);

    setlength(namearray, namelen + 1);
    FileSeek(grp, offset, 0);
    FileRead(grp, namearray[0], namelen);
    FileClose(idx);
    FileClose(grp);
    for i := 0 to namelen - 2 do
    begin
      namearray[i] := namearray[i] xor $FF;
    end;
    np := @namearray[0];
  end
  else if namenum = -2 then
  begin
    for i := 0 to length(Rrole) - 1 do
    begin
      if Rrole[i].HeadNum = headnum then
      begin
        p1 := @Rrole[i].Name;
        namelen := length(p1) + 2;
        setlength(namearray, namelen);
        np := @namearray[0];
        for n := 0 to namelen - 3 do
        begin
          (np + n)^ := (p1 + n)^;
          if (p1 + n)^ = char(0) then break;
        end;
        (np + n)^ := char(0);
        (np + n + 1)^ := char(0);
        break;
      end;
    end;
  end;

  p1 := @Rrole[0].Name;
  alen := length(p1) + 2;
  setlength(actorarray, alen);
  ap := @actorarray[0];
  for n := 0 to alen - 1 do
  begin
    (ap + n)^ := (p1 + n)^;
    if (p1 + n)^ = char(0) then break;
  end;
  (ap + n)^ := char($0);
  (ap + n + 1)^ := char(0);

  if alen = 6 then
  begin
    setlength(name1, 4);
    np1 := @name1[0];
    np1^ := ap^;
    (np1 + 1)^ := (ap + 1)^;
    (np1 + 2)^ := char(0);
    (np1 + 3)^ := char(0);
    setlength(name2, 4);
    np2 := @name2[0];
    np2^ := ap^;
    for i := 0 to length(name2) - 1 do
      (np2 + i)^ := (ap + i + 2)^;
  end
  else if alen > 8 then
  begin
    setlength(name1, 6);
    np1 := @name1[0];
    np1^ := ap^;
    (np1 + 1)^ := (ap + 1)^;
    (np1 + 2)^ := (ap + 2)^;
    (np1 + 3)^ := (ap + 3)^;
    (np1 + 4)^ := char(0);
    (np1 + 5)^ := char(0);
    setlength(name2, 6);
    np2 := @name2[0];
    for i := 0 to length(name2) - 1 do
      (np2 + i)^ := (ap + i + 4)^;
  end
  else if alen = 8 then
  begin
    if ((puint16(ap)^ = $6EAB) and ((puint16(ap + 2)^ = $63AE))) or
      ((puint16(ap)^ = $E8A6) and ((puint16(ap + 2)^ = $F9AA))) or ((puint16(ap)^ = $46AA) and
      ((puint16(ap + 2)^ = $E8A4))) or ((puint16(ap)^ = $4FA5) and ((puint16(ap + 2)^ = $B0AA))) or
      ((puint16(ap)^ = $7DBC) and ((puint16(ap + 2)^ = $65AE))) or ((puint16(ap)^ = $71A5) and
      ((puint16(ap + 2)^ = $A8B0))) or ((puint16(ap)^ = $D1BD) and ((puint16(ap + 2)^ = $AFB8))) or
      ((puint16(ap)^ = $71A5) and ((puint16(ap + 2)^ = $C5AA))) or ((puint16(ap)^ = $D3A4) and
      ((puint16(ap + 2)^ = $76A5))) or ((puint16(ap)^ = $BDA4) and ((puint16(ap + 2)^ = $5DAE))) or
      ((puint16(ap)^ = $DABC) and ((puint16(ap + 2)^ = $A7B6))) or ((puint16(ap)^ = $43AD) and
      ((puint16(ap + 2)^ = $DFAB))) or ((puint16(ap)^ = $71A5) and ((puint16(ap + 2)^ = $7BAE))) or
      ((puint16(ap)^ = $B9A7) and ((puint16(ap + 2)^ = $43C3))) or ((puint16(ap)^ = $61B0) and
      ((puint16(ap + 2)^ = $D5C1))) or ((puint16(ap)^ = $74A6) and ((puint16(ap + 2)^ = $E5A4))) or
      ((puint16(ap)^ = $DDA9) and ((puint16(ap + 2)^ = $5BB6))) then
    begin
      setlength(name1, 6);
      np1 := @name1[0];
      np1^ := ap^;
      (np1 + 1)^ := (ap + 1)^;
      (np1 + 2)^ := (ap + 2)^;
      (np1 + 3)^ := (ap + 3)^;
      (np1 + 4)^ := char(0);
      (np1 + 5)^ := char(0);
      setlength(name2, 4);
      np2 := @name2[0];
      for i := 0 to length(name2) - 1 do
        (np2 + i)^ := (ap + i + 4)^;
    end
    else
    begin
      setlength(name1, 4);
      np1 := @name1[0];
      np1^ := ap^;
      (np1 + 1)^ := (ap + 1)^;
      (np1 + 2)^ := char(0);
      (np1 + 3)^ := char(0);
      setlength(name2, 6);
      np2 := @name2[0];
      for i := 0 to length(name2) - 1 do
        (np2 + i)^ := (ap + i + 2)^;
    end;
  end;

  ch := 0;

  while ((puint16(tp + ch))^ shl 8 <> 0) and ((puint16(tp + ch))^ shr 8 <> 0) do
  begin
    Redraw;
    c1 := 0;
    r1 := 0;
    DrawRectangle(x, y, w, h, frame, ColColor(0, $FF), 60);
    if (showhead = 0) and (headnum >= 0) then
    begin
      //DrawRectangle(hx, hy, hw, hh, frame, colcolor(0, $FF), 60);
      DrawHeadPic(headnum, hx, hy);
      //DrawRectangle(hx, hy, hw, hh, frame, colcolor(0, $FF), 0);
    end;
    if namenum <> 0 then
    begin
      DrawRectangle(nx, ny, nw, nh, frame, ColColor(0, $FF), 60);
      namelen := length(np);
      DrawgbkShadowText(np, nx + 50 - namelen * 9 div 2, ny + 4, ColColor(0, $63), ColColor(0, $70));
    end;

    while r1 < row do
    begin
      pword[0] := (puint16(tp + ch))^;
      if (pword[0] shr 8 <> 0) and (pword[0] shl 8 <> 0) then
      begin
        ch := ch + 2;
        if (pword[0] and $FF) = $5E then //^^�ı�������ɫ
        begin
          case SmallInt((pword[0] and $FF00) shr 8) - $30 of
            0: newcolor := 28515;
            1: newcolor := 28421;
            2: newcolor := 28435;
            3: newcolor := 28563;
            4: newcolor := 28466;
            5: newcolor := 28450;
            64: newcolor := color;
            else
              newcolor := color;
          end;
          color1 := newcolor and $FF;
          color2 := (newcolor shr 8) and $FF;
        end
        else if pword[0] = $2323 then //## ��ʱ
        begin
          SDL_Delay(50 * GameSpeed + 500);
        end
        else if pword[0] = $2A2A then //**����
        begin
          if c1 > 0 then
            Inc(r1);
          c1 := 0;
        end
        else if pword[0] = $4040 then //@@�ȴ�����
        begin
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          n := WaitAnyKey;
          while (n = SDLK_UP) or (n = SDLK_DOWN) or (n = SDLK_RIGHT) or (n = SDLK_LEFT) or
            (n = SDLK_KP2) or (n = SDLK_KP4) or (n = SDLK_KP8) or (n = SDLK_KP6) do
            n := WaitAnyKey;
        end
        else if (pword[0] = $2626) or (pword[0] = $2525) or (pword[0] = $2424) or (pword[0] = $5B5B) then
        begin
          {if (pword[0] = $2626) or (pword[0] = $2525) or (pword[0] = $2424) then
          begin
            ������Uչ�������˶����{�����������Ǻ��韩���Ğ���[[����
            p1 := @Rrole[X50[-1]].Name;
            alen := length(p1) + 2;
            setlength(actorarray, alen);
            ap := @actorarray[0];
            for n := 0 to alen - 1 do
            begin
              (ap + n)^ := (p1 + n)^;
              if (p1 + n)^ = char(0) then break;
            end;
            (ap + n)^ := char($0);
            (ap + n + 1)^ := char(0);

            if alen = 6 then
            begin
              setlength(name1, 4);
              np1 := @name1[0];
              np1^ := ap^;
              (np1 + 1)^ := (ap + 1)^;
              (np1 + 2)^ := char(0);
              (np1 + 3)^ := char(0);
              setlength(name2, 4);
              np2 := @name2[0];
              np2^ := ap^;
              for i := 0 to length(name2) - 1 do
                (np2 + i)^ := (ap + i + 2)^;
            end
            else if alen > 8 then
            begin
              setlength(name1, 6);
              np1 := @name1[0];
              np1^ := ap^;
              (np1 + 1)^ := (ap + 1)^;
              (np1 + 2)^ := (ap + 2)^;
              (np1 + 3)^ := (ap + 3)^;
              (np1 + 4)^ := char(0);
              (np1 + 5)^ := char(0);
              setlength(name2, 6);
              np2 := @name2[0];
              for i := 0 to length(name2) - 1 do
                (np2 + i)^ := (ap + i + 4)^;
            end
            else if alen = 8 then
            begin
              if ((puint16(ap)^ = $6EAB) and ((puint16(ap + 2)^ = $63AE))) or
                ((puint16(ap)^ = $E8A6) and ((puint16(ap + 2)^ = $F9AA))) or
                ((puint16(ap)^ = $46AA) and ((puint16(ap + 2)^ = $E8A4))) or
                ((puint16(ap)^ = $4FA5) and ((puint16(ap + 2)^ = $B0AA))) or
                ((puint16(ap)^ = $7DBC) and ((puint16(ap + 2)^ = $65AE))) or
                ((puint16(ap)^ = $71A5) and ((puint16(ap + 2)^ = $A8B0))) or
                ((puint16(ap)^ = $D1BD) and ((puint16(ap + 2)^ = $AFB8))) or
                ((puint16(ap)^ = $71A5) and ((puint16(ap + 2)^ = $C5AA))) or
                ((puint16(ap)^ = $D3A4) and ((puint16(ap + 2)^ = $76A5))) or
                ((puint16(ap)^ = $BDA4) and ((puint16(ap + 2)^ = $5DAE))) or
                ((puint16(ap)^ = $DABC) and ((puint16(ap + 2)^ = $A7B6))) or
                ((puint16(ap)^ = $43AD) and ((puint16(ap + 2)^ = $DFAB))) or
                ((puint16(ap)^ = $71A5) and ((puint16(ap + 2)^ = $7BAE))) or
                ((puint16(ap)^ = $B9A7) and ((puint16(ap + 2)^ = $43C3))) or
                ((puint16(ap)^ = $61B0) and ((puint16(ap + 2)^ = $D5C1))) or
                ((puint16(ap)^ = $74A6) and ((puint16(ap + 2)^ = $E5A4))) or
                ((puint16(ap)^ = $DDA9) and ((puint16(ap + 2)^ = $5BB6))) then
              begin
                setlength(name1, 6);
                np1 := @name1[0];
                np1^ := ap^;
                (np1 + 1)^ := (ap + 1)^;
                (np1 + 2)^ := (ap + 2)^;
                (np1 + 3)^ := (ap + 3)^;
                (np1 + 4)^ := char(0);
                (np1 + 5)^ := char(0);
                setlength(name2, 4);
                np2 := @name2[0];
                for i := 0 to length(name2) - 1 do
                  (np2 + i)^ := (ap + i + 4)^;
              end
              else
              begin
                setlength(name1, 4);
                np1 := @name1[0];
                np1^ := ap^;
                (np1 + 1)^ := (ap + 1)^;
                (np1 + 2)^ := char(0);
                (np1 + 3)^ := char(0);
                setlength(name2, 6);
                np2 := @name2[0];
                for i := 0 to length(name2) - 1 do
                  (np2 + i)^ := (ap + i + 2)^;
              end;
            end;
          end}
          if (pword[0] = $5B5B) then
          begin
            case x50[-1] of
              0: pp1 := @Rrole[x50[-2]].Data[x50[-3] div 2];
              1: pp1 := @Ritem[x50[-2]].Data[x50[-3] div 2];
              2: pp1 := @RScene[x50[-2]].Data[x50[-3] div 2];
              3: pp1 := @Rmagic[x50[-2]].Data[x50[-3] div 2];
              4: pp1 := @Rshop[x50[-2]].Data[x50[-3] div 2];
              5: pp1 := @Wdate[x50[-3] div 2];
              6: pp1 := @Rzhaoshi[x50[-2]].Data[x50[-3] div 2];
              7: pp1 := @Rmenpai[x50[-2]].Data[x50[-3] div 2];
            end;
            alen := length(pp1) + 2;
            setlength(actorarray1, alen);
            app := @actorarray1[0];
            for n := 0 to alen - 1 do
            begin
              (app + n)^ := (pp1 + n)^;
              if (pp1 + n)^ = char(0) then break;
            end;
            (app + n)^ := char($0);
            (app + n + 1)^ := char(0);
          end;

          case pword[0] of
            $2626: np3 := ap; //&&��ʾ����
            $2525: np3 := np2; //%%��ʾ��
            $2424: np3 := np1; //$$��ʾ��
            $5B5B: np3 := app; //[[��ʾ��������

          end;
          i := 0;
          while (puint16(np3 + i)^ shr 8 <> 0) and (puint16(np3 + i)^ shl 8 <> 0) do
          begin
            pword[0] := puint16(np3 + i)^;
            i := i + 2;
            DrawgbkShadowText(@pword[0], x - 14 + CHINESE_FONT_SIZE * c1, y + 4 + CHINESE_FONT_SIZE *
              r1, ColColor(0, color1), ColColor(0, color2));
            Inc(c1);
            if c1 = cell then
            begin
              c1 := 0;
              Inc(r1);
              if r1 = row then
              begin
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                WaitAnyKey;
                c1 := 0;
                r1 := 0;
                Redraw;
                DrawRectangle(x, y, w, h, frame, ColColor(0, $FF), 60);
                if (showhead = 0) and (headnum >= 0) then
                begin
                  //DrawRectangle(hx, hy, hw, hh, frame, colcolor(0, $FF), 60);
                  DrawHeadPic(headnum, hx, hy);
                end;
                if namenum <> 0 then
                begin
                  DrawRectangle(nx, ny, nw, nh, frame, ColColor(0, $FF), 60);
                  namelen := length(np);
                  DrawgbkShadowText(np, nx + 50 - namelen * 9 div 2, ny + 4, ColColor(0, $63), ColColor(0, $70));
                end;
              end;
            end;
          end;
        end
        else //��ʾ����
        begin
          DrawgbkShadowText(@pword, x - 14 + CHINESE_FONT_SIZE * c1, y + 4 + CHINESE_FONT_SIZE *
            r1, ColColor(0, color1), ColColor(0, color2));
          Inc(c1);
          if c1 = cell then
          begin
            c1 := 0;
            Inc(r1);
          end;
        end;
      end
      else break;
    end;
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    n := WaitAnyKey;
    while (n = SDLK_UP) or (n = SDLK_DOWN) or (n = SDLK_RIGHT) or (n = SDLK_LEFT) or
      (n = SDLK_KP2) or (n = SDLK_KP4) or (n = SDLK_KP6) or (n = SDLK_KP8) do
      n := WaitAnyKey;
    if (pword[0] and $FF = 0) or (pword[0] and $FF00 = 0) then break;
  end;
  Redraw;

  setlength(wd, 0);
  setlength(str, 0);
  setlength(temp2, 0);
end;




function ReSetName(t, inum, newnamenum: integer): integer;
var
  NewName: string;
  offset, len, i, idx, grp: integer;
  p, np: pchar;
  talkarray: array of byte;
begin

  idx := FileOpen(NAME_IDX, fmopenread);
  grp := FileOpen(NAME_GRP, fmopenread);
  if newnamenum = 0 then
  begin
    offset := 0;
    FileRead(idx, len, 4);
  end
  else
  begin
    FileSeek(idx, (newnamenum - 1) * 4, 0);
    FileRead(idx, offset, 4);
    FileRead(idx, len, 4);
  end;
  len := (len - offset);
  setlength(talkarray, len + 1);
  FileSeek(grp, offset, 0);
  FileRead(grp, talkarray[0], len);
  FileClose(idx);
  FileClose(grp);
  for i := 0 to len - 1 do
  begin
{    if (key > 0) then
    begin
      talkarray[i] := RORForByte(talkarray[i], key);
      talkarray[i] := talkarray[i] xor byte(ckey[0]);
    end;       }
    talkarray[i] := talkarray[i] xor $FF;
    if (talkarray[i] = $2A) then
      talkarray[i] := 0;
    if (talkarray[i] = $FF) then
      talkarray[i] := 0;
  end;
  talkarray[len] := 0;
  np := @talkarray[0];

  case t of
    0: p := @Rrole[inum].Name; //����
    1: p := @Ritem[inum].Name; //��Ʒ
    2: p := @RScene[inum].Name; //����
    3: p := @Rmagic[inum].Name; //�书
    4: p := @Ritem[inum].Introduction; //��Ʒ˵��
  end;

  for i := 0 to len - 1 do
  begin
    (p + i)^ := (np + i)^;
  end;
  (p + i)^ := char(0);

  Result := 0;

end;

procedure ShowTitle(talknum, color: integer);
var
  newcolor, alen, x1, y1, ch, color1, color2, c1, r1, n, namelen, i, t1, grp, idx, offset,
  len, i1, i2, face, c, x, y, w, h, cell, row: integer;
  np3, np1, np2, tp, p1,pp1, ap,app: pchar;
  actorarray,actorarray1, name1, name2, talkarray: array of byte;
  pword: array[0..1] of uint16;
  wd, str: string;
  temp2: WideString;
begin
  pword[1] := 0;
  face := 4900;
  (* case color of
   0:color:=28515;
   1:color:=28421;
   2:color:=28435;
   3:color:=28563;
   4:color:=28466;
   5:color:=28450;
   end; *)
  color1 := color and $FF;
  color2 := (color shr 8) and $FF;
  x := 0;
  if where <> 3 then y := 30 else y := 60;
  w := 640;
  h := 109;
  if where <> 3 then row := 5 else row := 15;
  cell := 25;
  //read talk
  idx := FileOpen(TALK_IDX, fmopenread);
  grp := FileOpen(TALK_GRP, fmopenread);
  if talknum = 0 then
  begin
    offset := 0;
    FileRead(idx, len, 4);
  end
  else
  begin
    FileSeek(idx, (talknum - 1) * 4, 0);
    FileRead(idx, offset, 4);
    FileRead(idx, len, 4);
  end;
  len := (len - offset);
  setlength(talkarray, len + 2);
  FileSeek(grp, offset, 0);
  FileRead(grp, talkarray[0], len);
  FileClose(idx);
  FileClose(grp);
  for i := 0 to len - 1 do
  begin
    talkarray[i] := talkarray[i] xor $FF;
    if (talkarray[i] = $FF) then
      talkarray[i] := 0;
  end;
  talkarray[len] := byte(0);
  talkarray[len + 1] := byte(0);
  tp := @talkarray[0];

  if length(tp) > cell * 2 then
  begin
    x1 := 300 - cell * 10;
  end
  else x1 := 300 - length(tp) * 5;

  if ((length(tp) div 2) > cell * row) then
  begin
    y1 := y + (h div 2) - 50;
  end
  else y1 := y + (h div 2) - 10 - ((length(tp) div 2) div cell) * 10;

  p1 := @Rrole[0].Name;
  alen := length(p1) + 2;
  setlength(actorarray, alen);
  ap := @actorarray[0];
  for n := 0 to alen - 1 do
  begin
    (ap + n)^ := (p1 + n)^;
    if (p1 + n)^ = char(0) then break;
  end;
  (ap + n)^ := char($0);
  (ap + n + 1)^ := char(0);

  if alen = 6 then
  begin
    setlength(name1, 4);
    np1 := @name1[0];
    np1^ := ap^;
    (np1 + 1)^ := (ap + 1)^;
    (np1 + 2)^ := char(0);
    (np1 + 3)^ := char(0);
    setlength(name2, 4);
    np2 := @name2[0];
    np2^ := ap^;
    for i := 0 to length(name2) - 1 do
      (np2 + i)^ := (ap + i + 2)^;
  end
  else if alen > 8 then
  begin
    setlength(name1, 6);
    np1 := @name1[0];
    np1^ := ap^;
    (np1 + 1)^ := (ap + 1)^;
    (np1 + 2)^ := (ap + 2)^;
    (np1 + 3)^ := (ap + 3)^;
    (np1 + 4)^ := char(0);
    (np1 + 5)^ := char(0);
    setlength(name2, 6);
    np2 := @name2[0];
    for i := 0 to length(name2) - 1 do
      (np2 + i)^ := (ap + i + 4)^;
  end
  else if alen = 8 then
  begin
    if ((puint16(ap)^ = $6EAB) and ((puint16(ap + 2)^ = $63AE))) or
      ((puint16(ap)^ = $E8A6) and ((puint16(ap + 2)^ = $F9AA))) or ((puint16(ap)^ = $46AA) and
      ((puint16(ap + 2)^ = $E8A4))) or ((puint16(ap)^ = $4FA5) and ((puint16(ap + 2)^ = $B0AA))) or
      ((puint16(ap)^ = $7DBC) and ((puint16(ap + 2)^ = $65AE))) or ((puint16(ap)^ = $71A5) and
      ((puint16(ap + 2)^ = $A8B0))) or ((puint16(ap)^ = $D1BD) and ((puint16(ap + 2)^ = $AFB8))) or
      ((puint16(ap)^ = $71A5) and ((puint16(ap + 2)^ = $C5AA))) or ((puint16(ap)^ = $D3A4) and
      ((puint16(ap + 2)^ = $76A5))) or ((puint16(ap)^ = $BDA4) and ((puint16(ap + 2)^ = $5DAE))) or
      ((puint16(ap)^ = $DABC) and ((puint16(ap + 2)^ = $A7B6))) or ((puint16(ap)^ = $43AD) and
      ((puint16(ap + 2)^ = $DFAB))) or ((puint16(ap)^ = $71A5) and ((puint16(ap + 2)^ = $7BAE))) or
      ((puint16(ap)^ = $B9A7) and ((puint16(ap + 2)^ = $43C3))) or ((puint16(ap)^ = $61B0) and
      ((puint16(ap + 2)^ = $D5C1))) or ((puint16(ap)^ = $74A6) and ((puint16(ap + 2)^ = $E5A4))) or
      ((puint16(ap)^ = $DDA9) and ((puint16(ap + 2)^ = $5BB6))) then
    begin
      setlength(name1, 6);
      np1 := @name1[0];
      np1^ := ap^;
      (np1 + 1)^ := (ap + 1)^;
      (np1 + 2)^ := (ap + 2)^;
      (np1 + 3)^ := (ap + 3)^;
      (np1 + 4)^ := char(0);
      (np1 + 5)^ := char(0);
      setlength(name2, 4);
      np2 := @name2[0];
      for i := 0 to length(name2) - 1 do
        (np2 + i)^ := (ap + i + 4)^;
    end
    else
    begin
      setlength(name1, 4);
      np1 := @name1[0];
      np1^ := ap^;
      (np1 + 1)^ := (ap + 1)^;
      (np1 + 2)^ := char(0);
      (np1 + 3)^ := char(0);
      setlength(name2, 6);
      np2 := @name2[0];
      for i := 0 to length(name2) - 1 do
        (np2 + i)^ := (ap + i + 2)^;
    end;
  end;
 { temp2 := gbktounicode(tp);

  str := unicodetogbk(@temp2[1]);
 // str := Traditional2Simplified(str);
  setlength(wd, 0);
  i := 0;
  while i < length(str) do
  begin
    setlength(wd, length(wd) + 1);
    wd[length(wd) - 1] := str[i];
    if (integer(str[i]) in [$81..$FE]) and (integer(str[i + 1]) <> $7E) then
    begin
      setlength(wd, length(wd) + 1);
      wd[length(wd) - 1] := str[i + 1];
      wd[length(wd) - 2] := str[i];
      inc(i, 2);
      continue
    end;
    if (str[i] = #$0D) and (str[i + 1] = #$0A) then
    begin
      setlength(wd, length(wd) + 1);
      wd[length(wd) - 1] := '*';
      wd[length(wd) - 2] := '*';
      inc(i, 2);
      continue;
    end;
    if (integer(str[i]) in [$20..$7F]) then
    begin
      if str[i] = '^'then
      begin
        if (integer(str[i + 1]) in [$30..$39]) or (str[i + 1] = '^') then
        begin
          setlength(wd, length(wd) + 1);
          wd[length(wd) - 1] := str[i + 1];
          inc(i, 2);
          continue;
        end;
      end
      else if (str[i] = '*') and (str[i + 1] = '*') then
      begin
        setlength(wd, length(wd) + 1);
        wd[length(wd) - 1] := str[i + 1];
        inc(i, 2);
        continue;
      end
      else if (str[i] = '&') and (str[i + 1] = '&') then
      begin
        setlength(wd, length(wd) + 1);
        wd[length(wd) - 1] := str[i + 1];
        inc(i, 2);
        continue;
      end
      else if (str[i] = '#') and (str[i + 1] = '#') then
      begin
        setlength(wd, length(wd) + 1);
        wd[length(wd) - 1] := str[i + 1];
        inc(i, 2);
        continue;
      end
      else if (str[i] = '@') and (str[i + 1] = '@') then
      begin
        setlength(wd, length(wd) + 1);
        wd[length(wd) - 1] := str[i + 1];
        inc(i, 2);
        continue;
      end
      else if (str[i] = '$') and (str[i + 1] = '$') then
      begin
        setlength(wd, length(wd) + 1);
        wd[length(wd) - 1] := str[i + 1];
        inc(i, 2);
        continue;
      end
      else if (str[i] = '%') and (str[i + 1] = '%') then
      begin
        setlength(wd, length(wd) + 1);
        wd[length(wd) - 1] := str[i + 1];
        inc(i, 2);
        continue;
      end;
      setlength(wd, length(wd) + 1);
      wd[length(wd) - 1] := char($A0 + (smallint(str[i]) - 32));
      wd[length(wd) - 2] := char($A3);
    end;
    inc(i);
  end;

  temp2 := gbktounicode(@wd[3]);
  tp := @wd[3];
                  }
  ch := 0;

  while ((puint16(tp + ch))^ shl 8 <> 0) and ((puint16(tp + ch))^ shr 8 <> 0) do
  begin
    if where <> 3 then Redraw
    else DrawRectangleWithoutFrame(0, 0, screen.w, screen.h, 0, 0);
    c1 := 0;
    r1 := 0;
    DrawRectangleWithoutFrame(x, y, w, h, 0, 40);
    while r1 < row do
    begin
      pword[0] := (puint16(tp + ch))^;
      if (pword[0] shr 8 <> 0) and (pword[0] shl 8 <> 0) then
      begin
        ch := ch + 2;
        if (pword[0] and $FF) = $5E then //^^�ı�������ɫ
        begin
          case SmallInt((pword[0] and $FF00) shr 8) - $30 of
            0: newcolor := 28515;
            1: newcolor := 28421;
            2: newcolor := 28435;
            3: newcolor := 28563;
            4: newcolor := 28466;
            5: newcolor := 28450;
            64: newcolor := color;
            else
              newcolor := color;
          end;
          color1 := newcolor and $FF;
          color2 := (newcolor shr 8) and $FF;
        end
        else if pword[0] = $2323 then //## ��ʱ
        begin
          SDL_Delay(50 * GameSpeed + 500);
        end
        else if pword[0] = $2A2A then //**����
        begin
          if c1 > 0 then
          begin
            Inc(r1);
            DrawRectangleWithoutFrame(x, y + h + 11 * (r1 - 1) + 1, w, 10, 0, 40);
          end;
          c1 := 0;
        end
        else if pword[0] = $4040 then //@@�ȴ�����
        begin
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          n := WaitAnyKey;
          while (n = SDLK_UP) or (n = SDLK_DOWN) or (n = SDLK_RIGHT) or (n = SDLK_LEFT) or
            (n = SDLK_KP2) or (n = SDLK_KP4) or (n = SDLK_KP6) or (n = SDLK_KP8) do
            n := WaitAnyKey;

        end
        else if (pword[0] = $2626) or (pword[0] = $2525) or (pword[0] = $2424)
         or (pword[0] = $5B5B) then
        begin
          if (pword[0] = $5B5B) then
          begin
            case x50[-1] of
              0: pp1 := @Rrole[x50[-2]].Data[x50[-3] div 2];
              1: pp1 := @Ritem[x50[-2]].Data[x50[-3] div 2];
              2: pp1 := @RScene[x50[-2]].Data[x50[-3] div 2];
              3: pp1 := @Rmagic[x50[-2]].Data[x50[-3] div 2];
              4: pp1 := @Rshop[x50[-2]].Data[x50[-3] div 2];
              5: pp1 := @Wdate[x50[-3] div 2];
              6: pp1 := @Rzhaoshi[x50[-2]].Data[x50[-3] div 2];
              7: pp1 := @Rmenpai[x50[-2]].Data[x50[-3] div 2];
            end;
            alen := length(pp1) + 2;
            setlength(actorarray1, alen);
            app := @actorarray1[0];
            for n := 0 to alen - 3 do
            begin
              (app + n)^ := (pp1 + n)^;
              if (pp1 + n)^ = char(0) then break;
            end;
            (app + n)^ := char($0);
            (app + n + 1)^ := char(0);
          end;
          case pword[0] of
            $2626: np3 := ap; //&&��ʾ����
            $2525: np3 := np2; //%%��ʾ��
            $2424: np3 := np1; //$$��ʾ��
            $5B5B: np3 := app; //[[��ʾ��������
          end;
          i := 0;
          while (puint16(np3 + i)^ shr 8 <> 0) and (puint16(np3 + i)^ shl 8 <> 0) do
          begin
            pword[0] := puint16(np3 + i)^;
            i := i + 2;
            DrawgbkShadowText(@pword[0], x1 + CHINESE_FONT_SIZE * c1, y1 + CHINESE_FONT_SIZE *
              r1, ColColor(0, color1), ColColor(0, color2));
            Inc(c1);
            if c1 = cell then
            begin
              c1 := 0;
              Inc(r1);
              DrawRectangleWithoutFrame(x, y + h + 11 * (r1 - 1) + 1, w, 10, 0, 40);
              if r1 = row then
              begin
                if where <> 3 then Redraw
                else DrawRectangleWithoutFrame(0, 0, screen.w, screen.h, 0, 0);
                c1 := 0;
                r1 := 0;
                DrawRectangleWithoutFrame(x, y, w, h, 0, 40);
              end;
            end;
          end;
        end
        else //��ʾ����
        begin
          DrawgbkShadowText(@pword, x1 + CHINESE_FONT_SIZE * c1, y1 + CHINESE_FONT_SIZE * r1,
            ColColor(0, color1), ColColor(0, color2));
          Inc(c1);
          if c1 = cell then
          begin
            c1 := 0;
            Inc(r1);
            DrawRectangleWithoutFrame(x, y + h + 11 * (r1 - 1) + 1, w, 10, 0, 40);
          end;
        end;
      end
      else break;
    end;
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    n := WaitAnyKey;
    while (n = SDLK_UP) or (n = SDLK_DOWN) or (n = SDLK_RIGHT) or (n = SDLK_LEFT) or
      (n = SDLK_KP2) or (n = SDLK_KP4) or (n = SDLK_KP6) or (n = SDLK_KP8) do
      n := WaitAnyKey;
    if (pword[0] and $FF = 0) or (pword[0] and $FF00 = 0) then break;
  end;
  if where <> 3 then Redraw
  else DrawRectangleWithoutFrame(0, 0, screen.w, screen.h, 0, 0);
  //DrawgbkShadowText(@pword, x1 + CHINESE_FONT_SIZE * c1, y1 + CHINESE_FONT_SIZE * r1, colcolor(0, color1), colcolor(0, color2));

  setlength(wd, 0);
  setlength(str, 0);
  setlength(temp2, 0);
end;

procedure JmpScene(snum, y, x: integer);
var
  i: integer;
begin
  CurScene := snum;
  if x = -2 then
  begin
    x := RScene[CurScene].EntranceX;
  end;
  if y = -2 then
  begin
    y := RScene[CurScene].EntranceY;
  end;
  //Cx := x + Cx - Sx;
  //Cy := y + Cy - Sy;
  Cx := x;
  Cy := y;
  Sx := x;
  Sy := y;
  where := 1;
  Rrole[0].weizhi := CurScene;
  resetpallet;
  instruct_14;
  InitialScene;
  DrawScene;
  instruct_13;
  ShowSceneName(CurScene);
  if (Rscene[CurScene].inbattle = 1) and (Rrole[0].menpai = Rscene[CurScene].menpai) then
  begin
    for i := 0 to 19 do
    begin
      if (mpbdata[i].key >= 0) and (mpbdata[i].snum = curscene) and (timetonum > mpbdata[i].daytime) then
      begin
        NewTalk(0, 205, -2, 0, 0, 0, 0, 1);
        timetompbattle(i, 1);
        InitialScene;
        DrawScene;
        ShowSceneName(CurScene);
        break;
      end;
    end;
  end;
  CheckEvent3;
end;

function GetItemCount(inum: integer): integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to MAX_ITEM_AMOUNT - 1 do
  begin
    if (RItemList[i].Number = inum) then
    begin
      Result := RItemList[i].Amount;
      break;
    end;
  end;
end;

function ReadTalk(talknum: integer): WideString;
var
  i, idx, grp, len, offset: integer;
  p: pchar;
  talkarray: array of byte;
begin
  idx := FileOpen(TALK_IDX, fmopenread);
  grp := FileOpen(TALK_GRP, fmopenread);
  if talknum = 0 then
  begin
    offset := 0;
    FileRead(idx, len, 4);
  end
  else
  begin
    FileSeek(idx, (talknum - 1) * 4, 0);
    FileRead(idx, offset, 4);
    FileRead(idx, len, 4);
  end;
  len := (len - offset);
  setlength(talkarray, len + 1);
  FileSeek(grp, offset, 0);
  FileRead(grp, talkarray[0], len);
  FileClose(idx);
  FileClose(grp);
  for i := 0 to len - 1 do
  begin
    talkarray[i] := talkarray[i] xor $FF;
    if (talkarray[i] = $FF) then
      talkarray[i] := 0;
  end;
  talkarray[len] := byte(0);
  p := @talkarray[0];
  Result := gbktounicode(p);
end;

procedure Puzzle;
var
  i, a, b: integer;
  Y1, x1, CurDNum, CenterXy, CenterX, Centery: integer;
  X211, X212, X248, X249, X250, X221: integer;
  X222, X223, X224, X243, X244, X245, x246: integer;
  X251, X267, X207, X208, X258: integer;
  X247, X262, X263, X209, X210, X260: integer;
  X256, X255, X259, X253, X266, X254, x261: integer;
  Array1000: array[0..8] of integer;
  Array1050: array[0..3] of integer;
begin
  if Sface = 0 then
  begin
    Y1 := Sy;
    X1 := Sx - 1;
  end;
  if Sface = 1 then
  begin
    Y1 := Sy + 1;
    X1 := Sx;
  end;
  if Sface = 2 then
  begin
    Y1 := Sy - 1;
    X1 := Sx;
  end;
  if Sface = 3 then
  begin
    Y1 := Sy;
    X1 := Sx + 1;
  end;
  CurDNum := Sdata[CurScene, 3, x1, y1];
  CenterXY := Ddata[CurScene, CurEvent, 8];
  CenterY := CenterXY div 100;
  CenterX := CenterXY mod 100;
  if (CenterY = Sy) or (CenterX = Sx) then exit;
  X221 := Y1 - CenterY;
  X222 := X1 - CenterX;
  X223 := Y1 - Sy;
  X224 := X1 - Sx;
  X243 := X221 * X224;
  X244 := X222 * X223;
  X245 := X243 - X244;
  for x246 := 0 to 8 do
    Array1000[X246] := -1;
  for x246 := 0 to 3 do
    Array1050[X246] := -1;
  for x246 := 0 to 3 do
  begin
    if X246 = 0 then
    begin
      X221 := 0;
      X222 := -1;
    end;
    if X246 = 1 then
    begin
      X221 := 1;
      X222 := 0;
    end;
    if X246 = 2 then
    begin
      X221 := 0;
      X222 := 1;
    end;
    if X246 = 3 then
    begin
      X221 := -1;
      X222 := 0;
    end;
    X207 := CenterY + X221;
    X208 := CenterX + X222;
    X258 := Sdata[CurScene, 3, X208, X207];
    if X258 <> -1 then
    begin
      X267 := DData[CurScene, X258, 8];
      if X267 = CenterXY then
      begin
        Array1050[X246] := X258;
        X247 := X221 - 1;
        X247 := X247 * X222;
        X262 := X247 * X245;
        X247 := X222 + 1;
        X247 := X247 * X221;
        X263 := X247 * X245;
        X209 := X207 + X262;
        X210 := X208 + X263;
        if (SData[CurScene, 3, X210, X209] <> -1) then
          break;
        X211 := CenterY + X262;
        X212 := CenterX + X263;

        if SData[CurScene, 3, X212, X211] <> -1 then break;

        if Sdata[CurScene, 3, X212, X211] <> -1 then
          if DData[CurScene, Sdata[CurScene, 3, X212, X211], 8] <> CenterXY then break;
        X248 := X262 + 1;
        X249 := X263 + 1;
        X250 := X249 * 3;
        X250 := X250 + X248;
        Array1000[X250] := X258;
      end;
    end;
  end;
  for X246 := 0 to 3 do
  begin
    X262 := Array1050[X246];
    if X262 <> -1 then
    begin
      Sdata[CurScene, 3, X1, y1] := -1;
      a := Ddata[CurScene, CurDNum, 5];
      Ddata[CurScene, CurDNum, 1] := x262;
      Ddata[CurScene, CurDNum, 2] := 0;
      Ddata[CurScene, CurDNum, 3] := 0;
      Ddata[CurScene, CurDNum, 4] := 0;
      Ddata[CurScene, CurDNum, 5] := 0;
      Ddata[CurScene, CurDNum, 6] := 0;
      Ddata[CurScene, CurDNum, 7] := 0;
      Ddata[CurScene, CurDNum, 8] := -1;
      Ddata[CurScene, CurDNum, 9] := -1;
      Ddata[CurScene, CurDNum, 10] := -1;
      UpdateScene(x1, y1, a, 0);
    end;
  end;
  for X246 := 0 to 8 do
  begin
    X251 := array1000[X246];
    if X251 <> -1 then
    begin
      X266 := X246 + 3635;
      X248 := X246 mod 3;
      X249 := X246 div 3;
      X253 := X248 - 1;
      X254 := X249 - 1;
      X255 := CenterY + X253;
      X256 := CenterX + X254;
      Sdata[CurScene, 3, X256, X255] := X251;
      Ddata[CurScene, X251, 0] := 1;
      Ddata[CurScene, X251, 2] := 540;
      Ddata[CurScene, X251, 5] := X266;
      Ddata[CurScene, X251, 6] := X266;
      Ddata[CurScene, X251, 7] := X266;
      Ddata[CurScene, X251, 8] := CenterXY;
      Ddata[CurScene, X251, 9] := X255;
      Ddata[CurScene, X251, 10] := X256;
      UpdateScene(x1, y1, 0, X266);
    end;
  end;
  X259 := Sdata[CurScene, 3, X1, Y1];
  if X259 <> -1 then
  begin
    X260 := Y1 + X223;
    X261 := X1 + X224;
    Sy := X260;
    Sx := X261;
  end
  else
  begin
    Sy := Y1;
    Sx := X1;
  end;

end;

function GetPetSkill(rnum, skill: integer): boolean;
begin
  Result := False;
  if Rrole[rnum].lMagic[skill] > 0 then Result := True;
end;


procedure SetScene;
var
  i, i1, i2, a, b, r: integer;
begin
  Effect := Kys_ini.ReadInteger('Set', 'Effect', 0);
  fog := False;
  rain := -1;
  water := -1;
  snow := -1;
  showBlackScreen := False;
  if RScene[curScene].Mapmode = 1 then
  begin
    for i1 := 0 to 439 do
    begin
      for i := 0 to 639 do
      begin
        b := ((i - (screen.w shr 1)) * (i - (screen.w shr 1)) + (i1 - (screen.h shr 1)) *
          (i1 - (screen.h shr 1))) div 150;
        if b > 100 then b := 100;
        snowalpha[i1][i] := b;
      end;
    end;
    showBlackScreen := True;
  end
  else if Effect = 0 then
  begin
    if RScene[curScene].Mapmode = 2 then
    begin
      for i1 := 0 to 60 do
      begin
        a := Trunc(power(-1, i1 div 15));
        b := Trunc(abs((i1 mod 15) div 5 - 2));
        b := Trunc(a * (b - 1));
        snowalpha[0][i1] := b;
      end;
      water := 0;
    end
    else if RScene[curScene].Mapmode = 3 then
    begin
      for i1 := 0 to 439 do
      begin
        for i := 0 to 639 do
        begin
          r := random(170);
          if r = 0 then
          begin
            snowalpha[i1][i] := 1;
            r := random(10);
            if r = 0 then
            begin
              snowalpha[abs(i1 - 1)][i] := 1;
              snowalpha[i1][abs(i - 1)] := 1;
            end;
          end
          else
            snowalpha[i1][i] := 0;
        end;
      end;
      snow := 0;
    end
    else if RScene[curScene].Mapmode = 4 then
    begin
      for i1 := 0 to 439 do
      begin
        for i := 0 to 639 do
          snowalpha[i1][i] := 0;
      end;
      for i1 := 0 to 439 do
      begin
        for i := 0 to 639 do
        begin
          r := random(200);
          if r = 0 then
          begin
            snowalpha[i1][i] := 1;
            r := random(10);
            for I2 := 0 to r do
            begin
              a := (i1 + i2);
              if a > 439 then a := a - 440;
              snowalpha[a][i] := 1;
            end;
          end;
        end;
      end;
      rain := 0;
    end
    else if RScene[curScene].Mapmode = 5 then
    begin
      for i1 := 0 to 439 do
      begin
        for i := 0 to 639 do
          snowalpha[i1][i] := 60 + random(10);
      end;
      fog := True;
    end;
  end;

end;

procedure chengesnowhill();
var
  i: integer;
begin

  sdata[curScene, 0, 52, 33] := 1220;
  sdata[curScene, 4, 52, 33] := 32;
  sdata[curScene, 0, 52, 32] := 1222;
  sdata[curScene, 4, 52, 32] := 24;
  sdata[curScene, 0, 52, 31] := 1224;
  sdata[curScene, 4, 52, 31] := 16;
  sdata[curScene, 0, 52, 30] := 1226;
  sdata[curScene, 4, 52, 30] := 8;
  sdata[curScene, 0, 17, 45] := 1220;
  sdata[curScene, 4, 17, 45] := 32;
  sdata[curScene, 0, 16, 45] := 1222;
  sdata[curScene, 4, 16, 45] := 24;
  sdata[curScene, 0, 15, 45] := 1224;
  sdata[curScene, 4, 15, 45] := 16;
  sdata[curScene, 0, 14, 45] := 1226;
  sdata[curScene, 4, 14, 45] := 8;

  for i := 18 to 52 do
  begin
    sdata[curScene, 0, i, 45] := 1216;
    sdata[curScene, 4, i, 45] := 36;
  end;
  for i := 34 to 44 do
  begin
    sdata[curScene, 0, 52, i] := 1216;
    sdata[curScene, 4, 52, i] := 36;
  end;
  InitialScene();
  instruct_19(29, 52);

end;

function InputAmount: integer;
var
  str, countstr: WideString;
  amount: integer;
begin
  Result := 0;
  amount := 0;
  countstr := format('%5d', [amount]);
  str := 'ݔ�딵��';
  DrawRectangle(CENTER_X - 100, CENTER_Y - 15, 200, 30, 0, ColColor(255), 100);
  DrawShadowText(@str[1], CENTER_X - 100, CENTER_Y - 10, ColColor(5), ColColor(7));
  DrawShadowText(@str[1], CENTER_X - 100, CENTER_Y - 10, ColColor(5), ColColor(7));
  DrawEngText(screen, @countstr[1], CENTER_X + 41, CENTER_Y - 10, ColColor(7));
  DrawEngText(screen, @countstr[1], CENTER_X + 40, CENTER_Y - 10, ColColor(5));
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym >= SDLK_0) and (event.key.keysym.sym <= SDLK_9) then
        begin
          if amount < 3276 then
          begin
            amount := amount * 10 + (event.key.keysym.sym - 48);
            countstr := format('%5d', [amount]);
          end;
        end;
        if (event.key.keysym.sym >= 256) and (event.key.keysym.sym <= 267) then
        begin
          if amount < 3276 then
          begin
            amount := amount * 10 + (event.key.keysym.sym - 256);
            countstr := format('%5d', [amount]);
          end;
        end;
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = 271) then
        begin
          break;
        end;
        if (event.key.keysym.sym = SDLK_BACKSPACE) then
        begin
          amount := amount div 10;
          countstr := format('%5d', [amount]);
        end;
      end;
    end;
    DrawRectangle(CENTER_X - 100, CENTER_Y - 15, 200, 30, 0, ColColor(255), 100);
    DrawShadowText(@str[1], CENTER_X - 100, CENTER_Y - 10, ColColor(5), ColColor(7));
    DrawShadowText(@str[1], CENTER_X - 100, CENTER_Y - 10, ColColor(5), ColColor(7));
    DrawEngText(screen, @countstr[1], CENTER_X + 41, CENTER_Y - 10, ColColor(7));
    DrawEngText(screen, @countstr[1], CENTER_X + 40, CENTER_Y - 10, ColColor(5));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

  end;
  Result := amount;
end;


function GetRoleMedcine(rnum: integer; Equip: boolean): integer;
var
  l: integer;
begin
  Result := Rrole[rnum].Medcine;
  if (Rrole[rnum].Gongti > -1) then
  begin
    l := getgongtiLevel(rnum, Rrole[rnum].Gongti);
    if l = Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].MaxLevel then
    begin
      Inc(Result, Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].AddMedcine);
    end;
  end;
  if equip then
    for l := 0 to length(Rrole[rnum].Equip) - 1 do
      if Rrole[rnum].Equip[l] >= 0 then
        Inc(Result, Ritem[Rrole[rnum].Equip[l]].AddMedcine);
end;

function GetRoleMedPoi(rnum: integer; Equip: boolean): integer;
var
  l: integer;
begin
  Result := Rrole[rnum].MedPoi;
  if (Rrole[rnum].Gongti > -1) then
  begin
    l := getgongtiLevel(rnum, Rrole[rnum].Gongti);
    if l = Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].MaxLevel then
    begin
      Inc(Result, Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].AddMedPoi);
    end;
  end;
  if equip then
    for l := 0 to length(Rrole[rnum].Equip) - 1 do
      if Rrole[rnum].Equip[l] >= 0 then
        Inc(Result, Ritem[Rrole[rnum].Equip[l]].AddMedPoi);
end;

function GetRoleUsePoi(rnum: integer; Equip: boolean): integer;
var
  l: integer;
begin
  Result := Rrole[rnum].UsePoi;
  if (Rrole[rnum].Gongti > -1) then
  begin
    l := getgongtiLevel(rnum, Rrole[rnum].Gongti);
    if l = Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].MaxLevel then
    begin
      Inc(Result, Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].AddUsePoi);
    end;
  end;
  if equip then
    for l := 0 to length(Rrole[rnum].Equip) - 1 do
      if Rrole[rnum].Equip[l] >= 0 then
        Inc(Result, Ritem[Rrole[rnum].Equip[l]].AddUsePoi);
end;

function GetRoleAttPoi(rnum: integer; Equip: boolean): integer;
var
  l: integer;
begin
  Result := Rrole[rnum].AttPoi;
  if equip then
    for l := 0 to length(Rrole[rnum].Equip) - 1 do
      if Rrole[rnum].Equip[l] >= 0 then
        Inc(Result, Ritem[Rrole[rnum].Equip[l]].AddAttPoi);
end;

function GetRoleDefPoi(rnum: integer; Equip: boolean): integer;
var
  l: integer;
begin
  Result := Rrole[rnum].DefPoi;
  if (Rrole[rnum].Gongti > -1) then
  begin
    l := getgongtiLevel(rnum, Rrole[rnum].Gongti);
    if l = Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].MaxLevel then
    begin
      Inc(Result, Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].AddDefPoi);
    end;
  end;
  if equip then
    for l := 0 to length(Rrole[rnum].Equip) - 1 do
      if Rrole[rnum].Equip[l] >= 0 then
        Inc(Result, Ritem[Rrole[rnum].Equip[l]].AddDefPoi);
end;

function GetRoleFist(rnum: integer; Equip: boolean): integer;
var
  l: integer;
begin
  Result := Rrole[rnum].Fist;
  if (Rrole[rnum].Gongti > -1) then
  begin
    l := getgongtiLevel(rnum, Rrole[rnum].Gongti);
    if l = Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].MaxLevel then
    begin
      Inc(Result, Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].AddFist);
    end;
  end;
  if equip then
    for l := 0 to length(Rrole[rnum].Equip) - 1 do
      if Rrole[rnum].Equip[l] >= 0 then
        Inc(Result, Ritem[Rrole[rnum].Equip[l]].AddFist);
end;

function GetRoleSword(rnum: integer; Equip: boolean): integer;
var
  l: integer;
begin
  Result := Rrole[rnum].Sword;
  if (Rrole[rnum].Gongti > -1) then
  begin
    l := getgongtiLevel(rnum, Rrole[rnum].Gongti);
    if l = Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].MaxLevel then
    begin
      Inc(Result, Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].AddSword);
    end;
  end;
  if equip then
    for l := 0 to length(Rrole[rnum].Equip) - 1 do
      if Rrole[rnum].Equip[l] >= 0 then
        Inc(Result, Ritem[Rrole[rnum].Equip[l]].AddSword);
end;

function GetRoleKnife(rnum: integer; Equip: boolean): integer;
var
  l: integer;
begin
  Result := Rrole[rnum].Knife;
  if (Rrole[rnum].Gongti > -1) then
  begin
    l := getgongtiLevel(rnum, Rrole[rnum].Gongti);
    if l = Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].MaxLevel then
    begin
      Inc(Result, Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].AddKnife);
    end;
  end;
  if equip then
    for l := 0 to length(Rrole[rnum].Equip) - 1 do
      if Rrole[rnum].Equip[l] >= 0 then
        Inc(Result, Ritem[Rrole[rnum].Equip[l]].AddKnife);
end;

function GetRoleUnusual(rnum: integer; Equip: boolean): integer;
var
  l: integer;
begin
  Result := Rrole[rnum].Unusual;
  if (Rrole[rnum].Gongti > -1) then
  begin
    l := getgongtiLevel(rnum, Rrole[rnum].Gongti);
    if l = Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].MaxLevel then
    begin
      Inc(Result, Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].AddUnusual);
    end;
  end;
  if equip then
    for l := 0 to length(Rrole[rnum].Equip) - 1 do
      if Rrole[rnum].Equip[l] >= 0 then
        Inc(Result, Ritem[Rrole[rnum].Equip[l]].AddUnusual);
end;

function GetRoleHidWeapon(rnum: integer; Equip: boolean): integer;
var
  l: integer;
begin
  Result := Rrole[rnum].HidWeapon;
  if (Rrole[rnum].Gongti > -1) then
  begin
    l := getgongtiLevel(rnum, Rrole[rnum].Gongti);
    if l = Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].MaxLevel then
    begin
      Inc(Result, Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].AddHidWeapon);
    end;
  end;
  if equip then
    for l := 0 to length(Rrole[rnum].Equip) - 1 do
      if Rrole[rnum].Equip[l] >= 0 then
        Inc(Result, Ritem[Rrole[rnum].Equip[l]].AddHidWeapon);
end;

function GetRoleAttack(rnum: integer; Equip: boolean): integer;
var
  l: integer;
begin
  Result := Rrole[rnum].Attack;
  if (Rrole[rnum].Gongti > -1) then
  begin
    l := getgongtiLevel(rnum, Rrole[rnum].Gongti);
    Inc(Result, Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].AddAtt[l]);
  end;
  if equip then
  begin
    for l := 0 to length(Rrole[rnum].Equip) - 1 do
      if Rrole[rnum].Equip[l] >= 0 then
        Inc(Result, Ritem[Rrole[rnum].Equip[l]].AddAttack);
  end;
  Result := Result * 100 div (100 + Rrole[rnum].Hurt + Rrole[rnum].Poision);
end;

function GetRoleDefence(rnum: integer; Equip: boolean): integer;
var
  l: integer;
begin
  Result := Rrole[rnum].Defence;
  if (Rrole[rnum].Gongti > -1) then
  begin
    l := getgongtiLevel(rnum, Rrole[rnum].Gongti);
    Inc(Result, Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].AddDef[l]);
  end;
  if equip then
    for l := 0 to length(Rrole[rnum].Equip) - 1 do
      if Rrole[rnum].Equip[l] >= 0 then
        Inc(Result, Ritem[Rrole[rnum].Equip[l]].AddDefence);
  Result := Result * 100 div (100 + Rrole[rnum].Hurt + Rrole[rnum].Poision);
end;

function GetRoleSpeed(rnum: integer; Equip: boolean): integer;
var
  l: integer;
begin
  Result := Rrole[rnum].Speed;
  if (Rrole[rnum].Gongti > -1) then
  begin
    l := getgongtiLevel(rnum, Rrole[rnum].Gongti);
    Inc(Result, Rmagic[Rrole[rnum].lmagic[Rrole[rnum].Gongti]].Addspd[l]);
  end;
  if equip then
    for l := 0 to length(Rrole[rnum].Equip) - 1 do
      if Rrole[rnum].Equip[l] >= 0 then
        Inc(Result, Ritem[Rrole[rnum].Equip[l]].AddSpeed);
  Result := Result * 100 div (100 + Rrole[rnum].Hurt + Rrole[rnum].Poision);
end;

function SelectList(begintalknum, amount: integer): integer;
var
  i, x, y, w, h, idx, talknum, grp, len, offset: integer;
  p: pchar;
  talkarray: array of byte;
begin
  w := 0;
  setlength(menuString, 0);
  setlength(menuEngString, 0);
  setlength(menuString, amount);
  setlength(menuEngString, amount);
  idx := FileOpen(TALK_IDX, fmopenread);
  grp := FileOpen(TALK_GRP, fmopenread);
  for talknum := begintalknum to begintalknum + amount - 1 do
  begin
    if talknum = 0 then
    begin
      offset := 0;
      FileRead(idx, len, 4);
    end
    else
    begin
      FileSeek(idx, (talknum - 1) * 4, 0);
      FileRead(idx, offset, 4);
      FileRead(idx, len, 4);
    end;
    len := (len - offset);
    setlength(talkarray, len + 1);
    FileSeek(grp, offset, 0);
    FileRead(grp, talkarray[0], len);

    for i := 0 to len - 1 do
    begin
      talkarray[i] := talkarray[i] xor $FF;
      if (talkarray[i] = $FF) then
        talkarray[i] := 0;
    end;
    talkarray[len] := byte(0);
    p := @talkarray[0];
    menuString[talknum - begintalknum] := gbktounicode(p);
    menuEngString[talknum - begintalknum] := '';
    w := max(w, len - 1);
  end;
  x := screen.w div 2 - w * 5 - 5;
  y := 270 - amount * 22;
  Result := CommonMenu(x, y, w * 10 + 10, amount - 1);
  FileClose(idx);
  FileClose(grp);
end;

{procedure StudyGongti;
var
  rnum, mnum, i, position, moveable, lv, max1, max2, x, y, w, h, x1, y1, w1, h1, x2, y2, w2, h2: integer;
  teammenu, magicmenu, menu1, menu2: integer;
  personname: array of widestring;
  magic: array of integer;
  str: widestring;
begin
  x := 10;
  y := 10;
  x1 := x + 110;
  y1 := y;
  x2 := x1;
  y2 := y + 210;
  w := 100;
  w1 := 510;
  w2 := 100;
  h1 := 200;
  h2 := 210;
  max1 := 0;
  teammenu := 0;
  for i := 0 to length(teamlist) - 1 do
  begin
    if teamlist[i] < 0 then break;
    inc(max1);
    rrole[teamlist[i]].moveable := 0;
  end;
  h := max1 * 22 + 10;
  max2 := 0;
  for i := 0 to 29 do
  begin
    if (rrole[teamlist[teammenu]].lMagic[i] > 0) and
      (rmagic[rrole[teamlist[teammenu]].lMagic[i]].MagicType = 5) then
    begin
      inc(max2);
      setlength(magic, max2);
      magic[max2 - 1] := i;
    end;
  end;
  h := max1 * 22 + 10;
  position := 0;
  redraw;
  magicmenu := -1;
  ShowStudyGongti(teammenu, magicmenu, max1);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

  event.key.keysym.sym := 0;
  event.button.button := 0;
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    if (event.type_ = SDL_KEYUP) then
    begin
      if (event.key.keysym.sym = sdlk_up) or (event.key.keysym.sym = sdlk_kp8) then
      begin
        if position = 0 then
        begin
          dec(teammenu);
          if teammenu < 0 then teammenu := max1 - 1;
        end
        else
        begin
          dec(magicmenu);
          if magicmenu < 0 then magicmenu := max2 - 1;
        end;
      end;
      if (event.key.keysym.sym = sdlk_down) or (event.key.keysym.sym = sdlk_kp2) then
      begin
        if position = 0 then
        begin
          inc(teammenu);
          if teammenu >= max1 then teammenu := 0;
        end
        else
        begin
          inc(magicmenu);
          if magicmenu >= max2 then magicmenu := 0;
        end;
      end;
      if event.key.keysym.sym = sdlk_escape then
        if position = 0 then
          break
        else
        begin
          magicmenu := -1;
          position := 0;
        end;
      if (event.key.keysym.sym = sdlk_space) or (event.key.keysym.sym = sdlk_return) then
      begin
        if position = 0 then
        begin
          max2 := 0;
          for i := 0 to 29 do
          begin
            if (rrole[teamlist[teammenu]].lMagic[i] > 0) and
              (rmagic[rrole[teamlist[teammenu]].lMagic[i]].MagicType = 5) then
            begin
              inc(max2);
              setlength(magic, max2);
              magic[max2 - 1] := i;
            end;
          end;
          if max2 > 0 then
          begin
            position := 1;
            magicmenu := 0;
          end
          else magicmenu := -1;
        end
        else
        begin
          rnum := teamlist[teammenu];
          mnum := rrole[rnum].lmagic[magic[magicmenu]];
          lv := getmagiclevel(rnum, mnum);
          if (rmagic[mnum].MaxLevel > lv) and (rrole[rnum].GongtiExam >= rmagic[mnum].NeedExp[lv + 1]) then
          begin
            setlength(Menustring, 0);
            setlength(Menustring, 2);
            menustring[0] := '�W��';
            menustring[1] := 'ȡ��';
            if StadyGongtiMenu(x2 + 300, y2 + 6, 98) = 0 then
            begin
              gongtilevelup(rnum, mnum);
              dec(rrole[rnum].GongtiExam, rmagic[mnum].NeedExp[lv + 1]);
              inc(rrole[rnum].MagLevel[magic[magicmenu]], 100);
              rrole[rnum].moveable := 0;
            end;
            setlength(Menustring, 0);
          end;
        end;
      end;
      redraw;
      ShowStudyGongti(teammenu, magicmenu, max1);
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    end;
    if (event.type_ = SDL_mousebuttonUP) then
    begin
      if event.button.button = SDL_BUTTON_Right then
        if position = 0 then
          break
        else
        begin
          magicmenu := -1;
          position := 0;
        end;
      if event.button.button = SDL_BUTTON_LEFT then
      begin
        if position = 0 then
        begin
          max2 := 0;
          for i := 0 to 29 do
          begin
            if (rrole[teamlist[teammenu]].lMagic[i] > 0) and
              (rmagic[rrole[teamlist[teammenu]].lMagic[i]].MagicType = 5) then
            begin
              inc(max2);
              setlength(magic, max2);
              magic[max2 - 1] := i;
            end;
          end;
          if max2 > 0 then
          begin
            position := 1;
            magicmenu := 0;
          end
          else magicmenu := -1;
        end
        else
        begin
          rnum := teamlist[teammenu];
          mnum := rrole[rnum].lmagic[magic[magicmenu]];
          lv := getmagiclevel(rnum, mnum);
          if (rmagic[mnum].MaxLevel > lv) and (rrole[rnum].GongtiExam >= rmagic[mnum].NeedExp[lv + 1]) then
          begin
            setlength(Menustring, 0);
            setlength(Menustring, 2);
            menustring[0] := '�W��';
            menustring[1] := 'ȡ��';
            if StadyGongtiMenu(x2 + 300, y2 + 6, 98) = 0 then
            begin
              gongtilevelup(rnum, mnum);
              dec(rrole[rnum].GongtiExam, rmagic[mnum].NeedExp[lv + 1]);
              inc(rrole[rnum].MagLevel[magic[magicmenu]], 100);
              rrole[rnum].moveable := 0;
            end;
            setlength(Menustring, 0);
          end;
        end;
      end;
      redraw;
      ShowStudyGongti(teammenu, magicmenu, max1);
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    end;
    if (event.type_ = SDL_MOUSEMOTION) then
    begin
      menu1 := teammenu;
      menu2 := magicmenu;
      if (event.button.x >= x2) and (event.button.x <= x2 + w2)
        and (event.button.y >= y2) and (event.button.y <= y2 + h2) then
      begin

        max2 := 0;
        for i := 0 to 29 do
        begin
          if (rrole[teamlist[teammenu]].lMagic[i] > 0) and
            (rmagic[rrole[teamlist[teammenu]].lMagic[i]].MagicType = 5) then
          begin
            inc(max2);
            setlength(magic, max2);
            magic[max2 - 1] := i;
          end;
        end;
        if max2 > 0 then
        begin
          position := 1;
          position := 1;
          magicmenu := (event.button.y - y2) div 22;
          magicmenu := min(max2 - 1, magicmenu);
          magicmenu := max(0, magicmenu);
        end
        else magicmenu := -1;
      end
      else if (event.button.x >= x) and (event.button.x <= x + w)
        and (event.button.y >= y) and (event.button.y <= y + h) then
      begin
        if (position <> 0) then position := 0
        else
        begin
          magicmenu := -1;
          teammenu := (event.button.y - y) div 22;
          teammenu := min(max1 - 1, teammenu);
          teammenu := max(0, teammenu);
        end;
      end;
      if (teammenu <> menu1) or (magicmenu <> menu2) then
      begin
        max2 := 0;
        for i := 0 to 29 do
        begin
          if (rrole[teamlist[teammenu]].lMagic[i] > 0) and
            (rmagic[rrole[teamlist[teammenu]].lMagic[i]].MagicType = 5) then
          begin
            inc(max2);
            setlength(magic, max2);
            magic[max2 - 1] := i;
          end;
        end;
        redraw;
        ShowStudyGongti(teammenu, magicmenu, max1);
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end;

    end;
  end;
  event.key.keysym.sym := 0;
  event.button.button := 0;
end;

procedure ShowStudyGongti(menu, menu2, max0: integer);
var
  mnum, i1, i, lv, l, max2, rnum, x, y, w, h, x1, y1, w1, h1, x2, y2, w2, h2, x3, y3, w3, h3: integer;
  teammenu, magicmenu: integer;
  personname, magicname: array of widestring;
  str: widestring;
begin
  x := 10;
  y := 10;
  x1 := x + 110;
  y1 := y;
  x2 := x1;
  y2 := y + 210;
  w := 100;
  w1 := 510;
  w2 := 110;
  h1 := 200;
  h2 := 210;
  h := max0 * 22 + 10;
  x3 := x2 + 120;
  y3 := y2;
  w3 := w1 - 120;
  h3 := h2;

  drawrectangle(x, y, w, h, 0, $FFFFFF, 60);
  drawrectangle(x1, y1, w1, h1, 0, $FFFFFF, 60);

  setlength(personname, max0);
  for i := 0 to max0 - 1 do
  begin
    personname[i] := gbktounicode(@rrole[teamlist[i]].Name[0]);
    if menu <> i then
      drawshadowtext(@personname[i][1], x - 10, y + 5 + 22 * i, colcolor(0, 5), colcolor(0, 7))
    else
      drawshadowtext(@personname[i][1], x - 10, y + 5 + 22 * i, colcolor(0, $64), colcolor(0, $66));
  end;
  rnum := teamlist[menu];
  if rnum >= 0 then
  begin
    drawheadpic(rrole[rnum].HeadNum, x1 + 23, y1 + 70);
    l := length(personname[menu]) - 1;
    drawshadowtext(@personname[menu][1], x1 + 30 - (l * 10), y1 + 78, colcolor(0, $5), colcolor(0, $7));

    str := format('%d', [rrole[rnum].level]);
    drawshadowtext(@str[1], x1 + 70, y1 + 103, colcolor(0, $5), colcolor(0, $7));
    str := '�ȼ�';
    drawshadowtext(@str[1], x1, y1 + 103, colcolor(0, $5), colcolor(0, $7));

    updateHPMP(rnum, x1, y1 + 107);

    str := format('%d', [GetRoleAttack(rnum, false)]);
    drawshadowtext(@str[1], x1 + 90 + 70, y1 + 10, colcolor(0, $5), colcolor(0, $7));
    str := '����';
    drawshadowtext(@str[1], x1 + 90, y1 + 10, colcolor(0, $5), colcolor(0, $7));

    str := format('%d', [GetRoleDefence(rnum, false)]);
    drawshadowtext(@str[1], x1 + 90 + 70, y1 + 32, colcolor(0, $5), colcolor(0, $7));
    str := '���R';
    drawshadowtext(@str[1], x1 + 90, y1 + 32, colcolor(0, $5), colcolor(0, $7));

    str := format('%d', [GetRoleSpeed(rnum, false)]);
    drawshadowtext(@str[1], x1 + 90 + 70, y1 + 54, colcolor(0, $5), colcolor(0, $7));
    str := '�p��';
    drawshadowtext(@str[1], x1 + 90, y1 + 54, colcolor(0, $5), colcolor(0, $7));


    str := format('%d', [GetRoleMedcine(rnum, false)]);
    drawshadowtext(@str[1], x1 + 200 + 70, y1 + 10, colcolor(0, $5), colcolor(0, $7));
    str := '�t��';
    drawshadowtext(@str[1], x1 + 200, y1 + 10, colcolor(0, $5), colcolor(0, $7));

    str := format('%d', [GetRoleUsepoi(rnum, false)]);
    drawshadowtext(@str[1], x1 + 200 + 70, y1 + 32, colcolor(0, $5), colcolor(0, $7));
    str := '�ö�';
    drawshadowtext(@str[1], x1 + 200, y1 + 32, colcolor(0, $5), colcolor(0, $7));

    str := format('%d', [GetRoleMedPoi(rnum, false)]);
    drawshadowtext(@str[1], x1 + 200 + 70, y1 + 54, colcolor(0, $5), colcolor(0, $7));
    str := '�ⶾ';
    drawshadowtext(@str[1], x1 + 200, y1 + 54, colcolor(0, $5), colcolor(0, $7));

    str := format('%d', [GetRoleDefPoi(rnum, false)]);
    drawshadowtext(@str[1], x1 + 200 + 70, y1 + 76, colcolor(0, $5), colcolor(0, $7));
    str := '����';
    drawshadowtext(@str[1], x1 + 200, y1 + 76, colcolor(0, $5), colcolor(0, $7));

    str := format('%d', [GetRoleFist(rnum, false)]);
    drawshadowtext(@str[1], x1 + 310 + 70, y1 + 10, colcolor(0, $5), colcolor(0, $7));
    str := 'ȭ��';
    drawshadowtext(@str[1], x1 + 310, y1 + 10, colcolor(0, $5), colcolor(0, $7));

    str := format('%d', [GetRoleSword(rnum, false)]);
    drawshadowtext(@str[1], x1 + 310 + 70, y1 + 32, colcolor(0, $5), colcolor(0, $7));
    str := '�R��';
    drawshadowtext(@str[1], x1 + 310, y1 + 32, colcolor(0, $5), colcolor(0, $7));

    str := format('%d', [GetRoleKnife(rnum, false)]);
    drawshadowtext(@str[1], x1 + 310 + 70, y1 + 54, colcolor(0, $5), colcolor(0, $7));
    str := 'ˣ��';
    drawshadowtext(@str[1], x1 + 310, y1 + 54, colcolor(0, $5), colcolor(0, $7));

    str := format('%d', [GetRoleUnusual(rnum, false)]);
    drawshadowtext(@str[1], x1 + 310 + 70, y1 + 76, colcolor(0, $5), colcolor(0, $7));
    str := '���T';
    drawshadowtext(@str[1], x1 + 310, y1 + 76, colcolor(0, $5), colcolor(0, $7));

    str := format('%d', [GetRoleHidWeapon(rnum, false)]);
    drawshadowtext(@str[1], x1 + 310 + 70, y1 + 98, colcolor(0, $5), colcolor(0, $7));
    str := '����';
    drawshadowtext(@str[1], x1 + 310, y1 + 98, colcolor(0, $5), colcolor(0, $7));
    max2 := 0;

    drawrectangle(x2, y2, w2, h2, 0, $FFFFFF, 60);
    drawrectangle(x3, y3, w3, h3, 0, $FFFFFF, 60);
    for i := 0 to 29 do
    begin
      if (rrole[rnum].lMagic[i] > 0) and (rmagic[rrole[rnum].lMagic[i]].MagicType = 5) then
      begin
        inc(max2);
        setlength(magicname, max2);
        magicname[max2 - 1] := gbktounicode(@rmagic[rrole[rnum].lMagic[i]].Name[0]);
        if menu2 <> max2 - 1 then
          drawshadowtext(@magicname[max2 - 1][1], x2 - 15, y2 + 5 + 22 * (max2 - 1), colcolor(0, 5), colcolor(0, 7))
        else
        begin
          mnum := rrole[rnum].lMagic[i];
          i1 := 0;
          lv := getmagicLevel(rnum, mnum);
          drawshadowtext(@magicname[max2 - 1][1], x2 - 15, y2 + 5 + 22 * (max2 - 1), colcolor(0, $64), colcolor(0, $66));
          drawshadowtext(@magicname[max2 - 1][1], x3 - 10, y3 + 5, colcolor(0, $5), colcolor(0, $7));
          case lv of
            0: str := 'Ŀǰ�ȼ�   �쾚';
            1: str := 'Ŀǰ�ȼ�   ����';
            2: str := 'Ŀǰ�ȼ�   ����';
          end;
          drawshadowtext(@str[1], x3 - 10, y3 + 32 - 5, colcolor(0, $64), colcolor(0, $66));

          if lv >= rmagic[mnum].MaxLevel then
          begin
            str := '�ѵ��_피�';
            drawshadowtext(@str[1], x3 - 10, y3 + 54 - 5, colcolor(0, $21), colcolor(0, $23));
          end
          else
          begin
            str := '���轛�ֵ ';
            drawshadowtext(@str[1], x3 - 10, y3 + 54 - 5, colcolor(0, $21), colcolor(0, $23));
            str := format('%d', [rmagic[mnum].NeedExp[lv + 1]]);
            drawshadowtext(@str[1], x3 + 103, y3 + 54 - 5, colcolor(0, $64), colcolor(0, $66));
          end;

          str := '�F�н��ֵ ';
          drawshadowtext(@str[1], x3 - 10, y3 + 76 - 5, colcolor(0, $21), colcolor(0, $23));
          str := format('%d', [rrole[rnum].GongtiExam]);
          drawshadowtext(@str[1], x3 + 103, y3 + 76 - 5, colcolor(0, $64), colcolor(0, $66));

          if rmagic[mnum].AddHP[lv] <> 0 then
          begin
            str := format('%d', [rmagic[mnum].AddHP[lv]]);
            drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90 + 50, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
            str := '����';
            drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
            inc(i1);
          end;
          if rmagic[mnum].AddMP[lv] <> 0 then
          begin
            str := format('%d', [rmagic[mnum].AddMP[lv]]);
            drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90 + 50, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
            str := '����';
            drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
            inc(i1);
          end;
          if rmagic[mnum].AddAtt[lv] <> 0 then
          begin
            str := format('%d', [rmagic[mnum].AddAtt[lv]]);
            drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90 + 50, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
            str := '����';
            drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
            inc(i1);
          end;
          if rmagic[mnum].AddDef[lv] <> 0 then
          begin
            str := format('%d', [rmagic[mnum].AddDef[lv]]);
            drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90 + 50, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
            str := '���R';
            drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
            inc(i1);
          end;
          if rmagic[mnum].AddSpd[lv] <> 0 then
          begin
            str := format('%d', [rmagic[mnum].AddSpd[lv]]);
            drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90 + 50, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
            str := '�p��';
            drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
            inc(i1);
          end;
          if lv = rmagic[mnum].MaxLevel then
          begin
            if rmagic[mnum].AddMedcine <> 0 then
            begin
              str := format('%d', [rmagic[mnum].AddMedcine]);
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90 + 50, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
              str := '�t��';
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
              inc(i1);
            end;
            if rmagic[mnum].AddUsepoi <> 0 then
            begin
              str := format('%d', [rmagic[mnum].AddUsePoi]);
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90 + 50, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
              str := '�ö�';
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
              inc(i1);
            end;
            if rmagic[mnum].AddMedPoi <> 0 then
            begin
              str := format('%d', [rmagic[mnum].AddMedPoi]);
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90 + 50, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
              str := '�ⶾ';
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
              inc(i1);
            end;
            if rmagic[mnum].AddDefPoi <> 0 then
            begin
              str := format('%d', [rmagic[mnum].AddDefPoi]);
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90 + 50, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
              str := '����';
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
              inc(i1);
            end;
            if rmagic[mnum].AddFist <> 0 then
            begin
              str := format('%d', [rmagic[mnum].AddFist]);
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90 + 50, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
              str := 'ȭ��';
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
              inc(i1);
            end;
            if rmagic[mnum].AddSword <> 0 then
            begin
              str := format('%d', [rmagic[mnum].AddSword]);
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90 + 50, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
              str := '�R�� ';
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
              inc(i1);
            end;
            if rmagic[mnum].AddKnife <> 0 then
            begin
              str := format('%d', [rmagic[mnum].AddKnife]);
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90 + 50, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
              str := 'ˣ��';
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
              inc(i1);
            end;
            if rmagic[mnum].AddUnusual <> 0 then
            begin
              str := format('%d', [rmagic[mnum].AddUnusual]);
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90 + 50, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
              str := '���T';
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
              inc(i1);
            end;
            if rmagic[mnum].AddHidWeapon <> 0 then
            begin
              str := format('%d', [rmagic[mnum].AddHidWeapon]);
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90 + 50, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));
              str := '����';
              drawshadowtext(@str[1], x3 - 10 + (i1 mod 4) * 90, y3 - 5 + 98 + (i1 div 4) * 22, colcolor(0, $5), colcolor(0, $7));

            end;
          end;
          if (rmagic[mnum].BattleState > 0) and (lv >= rmagic[mnum].MaxLevel) then
          begin
            str := '���w��Ч ';
            drawshadowtext(@str[1], x3 - 10, y3 + 115 + (i1 div 4) * 22, colcolor(0, $21), colcolor(0, $23));
            case rmagic[mnum].BattleState of
              1: str := '�w�����p';
              2: str := 'Ů���书�����ӳ�';
              3: str := 'ƹ�Ч�ӱ�';
              4: str := '�S�C�����D��';
              5: str := '�S�C��������';
              6: str := '�Ȃ�����';
              7: str := '�����w��';
              8: str := '�����W�����';
              9: str := '�������S�ȼ�ѭ������';
              10: str := '�������Ĝp��';
              11: str := 'ÿ�غϻ֏�����';
              12: str := 'ؓ���B����';
              13: str := 'ȫ���书�����ӳ�';
              14: str := '�S�C���ι���';
              15: str := 'ȭ���书�����ӳ�';
              16: str := '���g�书�����ӳ�';
              17: str := '�����书�����ӳ�';
              18: str := '���T�书�����ӳ�';
              19: str := '���ӃȂ�����';
              20: str := '���ӷ�Ѩ����';
              21: str := '����΢����Ѫ';
              22: str := '�������x����';
              23: str := 'ÿ�غϻ֏̓���';
              24: str := 'ʹ�ð������x����';
              25: str := '���Ӛ������Ճ���';
            end;

            drawshadowtext(@str[1], x3 - 10, y3 + 137 + (i1 div 4) * 22, colcolor(0, $64), colcolor(0, $66));
          end;
        end;
      end;
    end;
  end;
end;

function StadyGongtiMenu(x, y, w: integer): integer;
var
  menu, menup: integer;
begin
  menu := 0;
  SDL_EnableKeyRepeat(10, 100);
  //DrawMMap;
  showcommonMenu2(x, y, w, menu);
  SDL_UpdateRect2(screen, x, y, w + 1, 29);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    case event.type_ of
      SDL_KEYDown:
        begin
          if (event.key.keysym.sym = sdlk_left) or (event.key.keysym.sym = sdlk_right) or (event.key.keysym.sym = sdlk_KP4) or (event.key.keysym.sym = sdlk_KP6) then
          begin
            if menu = 1 then
              menu := 0
            else
              menu := 1;
            showcommonMenu2(x, y, w, menu);
            SDL_UpdateRect2(screen, x, y, w + 1, 29);
          end;
        end;

      SDL_KEYUP:
        begin

          if ((event.key.keysym.sym = sdlk_escape)) and (where <= 2) then
          begin
            result := -1;
            SDL_UpdateRect2(screen, x, y, w + 1, 29);
            break;
          end;
          if (event.key.keysym.sym = sdlk_return) or (event.key.keysym.sym = sdlk_space) then
          begin
            result := menu;
            SDL_UpdateRect2(screen, x, y, w + 1, 29);
            break;
          end;
        end;
      SDL_MOUSEBUTTONUP:
        begin
          if (event.button.button = sdl_button_right) and (where <= 2) then
          begin
            result := -1;
            SDL_UpdateRect2(screen, x, y, w + 1, 29);
            break;
          end;
          if (event.button.button = sdl_button_left) then
          begin
            result := menu;
            SDL_UpdateRect2(screen, x, y, w + 1, 29);
            break;
          end;
        end;
      SDL_MOUSEMOTION:
        begin
          if (event.button.x >= x) and (event.button.x < x + w) and (event.button.y > y) and (event.button.y < y + 29) then
          begin
            menup := menu;
            menu := (event.button.x - x - 2) div 50;
            if menu > 1 then
              menu := 1;
            if menu < 0 then
              menu := 0;
            if menup <> menu then
            begin
              showcommonMenu2(x, y, w, menu);
              SDL_UpdateRect2(screen, x, y, w + 1, 29);
            end;
          end;
        end;
    end;
  end;
  //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(30, 30);
end;}

procedure GongtiLevelUp(rnum, mnum: integer);
var
  lv: integer;
begin
  if mnum <> Rrole[rnum].lmagic[Rrole[rnum].gongti] then exit;

  lv := getGongtilevel(rnum, Rrole[rnum].gongti);
  Dec(Rrole[rnum].CurrentHP, Rmagic[mnum].Addhp[lv]);
  Dec(Rrole[rnum].CurrentMP, Rmagic[mnum].Addmp[lv]);
  Dec(Rrole[rnum].MaxHP, Rmagic[mnum].Addhp[lv]);
  Dec(Rrole[rnum].MaxMP, Rmagic[mnum].Addmp[lv]);
  Inc(Rrole[rnum].CurrentHP, Rmagic[mnum].Addhp[lv + 1]);
  Inc(Rrole[rnum].CurrentMP, Rmagic[mnum].Addmp[lv + 1]);
  Inc(Rrole[rnum].MaxHP, Rmagic[mnum].Addhp[lv + 1]);
  Inc(Rrole[rnum].MaxMP, Rmagic[mnum].Addmp[lv + 1]);

  Rrole[rnum].CurrentHP := max(Rrole[rnum].CurrentHP, 0);
  Rrole[rnum].CurrentMP := max(Rrole[rnum].CurrentMP, 0);
end;

function CheckEquipSet(e0, e1, e2, e3: integer): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 1 to 5 do
  begin
    if (SetNum[i, 0] <> e0) and (SetNum[i, 0] >= 0) then continue;
    if (SetNum[i, 1] <> e1) and (SetNum[i, 1] >= 0) then continue;
    if (SetNum[i, 2] <> e2) and (SetNum[i, 2] >= 0) then continue;
    if (SetNum[i, 3] <> e3) and (SetNum[i, 3] >= 0) then continue;
    Result := i;
  end;

end;

function AddBattleStateToEquip: boolean;
var
  i, i1, i2, menu, n: integer;
  str: array[1..25] of string;
  state: array[1..25] of integer;
  str1: WideString;
  battlestate, EquipList: array of smallint;
  SelectedState, SelectEquip: smallint;
begin
  Redraw;
  Result := False;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  str[1] := '�w�����p';
  str[2] := 'Ů���书�����ӳ�';
  str[3] := 'ƹ�Ч�ӱ�';
  str[4] := '�S�C�����D��';
  str[5] := '�S�C��������';
  str[6] := '�Ȃ�����';
  str[7] := '�����w��';
  str[8] := '�����W�����';
  str[9] := '�������S�ȼ�ѭ������';
  str[10] := '�������Ĝp��';
  str[11] := 'ÿ�غϻ֏�����';
  str[12] := 'ؓ���B����';
  str[13] := 'ȫ���书�����ӳ�';
  str[14] := '�S�C���ι���';
  str[15] := 'ȭ���书�����ӳ�';
  str[16] := '���g�书�����ӳ�';
  str[17] := '�����书�����ӳ�';
  str[18] := '���T�书�����ӳ�';
  str[19] := '���ӃȂ�����';
  str[20] := '���ӷ�Ѩ����';
  str[21] := '����΢����Ѫ';
  str[22] := '�������x����';
  str[23] := 'ÿ�غϻ֏̓���';
  str[24] := 'ʹ�ð������x����';
  str[25] := '���Ӛ������Ճ���';
  n := 0;
  setlength(menuString, 0);
  setlength(menuEngString, 0);
  for i := 1 to 25 do
    state[i] := 0;
  for i := 0 to 35 do
  begin
    if (Rrole[i].TeamState = 1) or (Rrole[i].TeamState = 2) then
    begin
      for i1 := 0 to 29 do
      begin
        if (Rrole[i].lMagic[i1] > 0) and (Rmagic[Rrole[i].lMagic[i1]].MagicType = 5) and
          (Rmagic[Rrole[i].lMagic[i1]].BattleState > 0) and (GetMagicLevel(i, Rrole[i].lMagic[i1]) >=
          Rmagic[Rrole[i].lMagic[i1]].MaxLevel) then
        begin
          state[Rmagic[Rrole[i].lMagic[i1]].BattleState] := 1;
        end;
      end;
    end;
  end;
  for i := 1 to 25 do
  begin
    if state[i] = 1 then
    begin
      Inc(n);
      setlength(menuString, n);
      setlength(battlestate, n);
      menuString[n - 1] := GBKtoUnicode(@str[i][1]);
      battlestate[n - 1] := i;
    end;
  end;
  if n = 0 then
  begin
    Redraw;
    str1 := GBKtoUnicode('�]�п��ù��w��Ч');
    DrawTextWithRect(@str1[1], 320 - 85, 45, 170, ColColor($21), ColColor($23));
    WaitAnyKey;
    exit;
  end;

  str1 := GBKtoUnicode('�x���w��Ч');

  menu := TitleCommonScrollMenu(@str1[1], ColColor(0, 5), ColColor(0, 7), 5, 5, 300, n - 1, 17);
  if menu >= 0 then
  begin
    SelectedState := battlestate[menu];
    n := 0;
    setlength(menuString, 0);
    setlength(menuEngString, 0);
    for i := 0 to length(Ritem) - 1 do
    begin
      if (getitemcount(i) > 0) and (Ritem[i].ItemType = 1) and (Ritem[i].SetNum > 0) and
        (Ritem[i].BattleEffect <= 0) then
      begin
        Inc(n);
        setlength(menuString, n);
        setlength(EquipList, n);
        menuString[n - 1] := GBKtoUnicode(@Ritem[i].Name);
        EquipList[n - 1] := i;
      end;
    end;
    if n = 0 then
    begin
      Redraw;
      str1 := GBKtoUnicode('�]�п�ע����b��');
      DrawTextWithRect(@str1[1], 320 - 85, 45, 170, ColColor($21), ColColor($23));
      WaitAnyKey;
      exit;
    end;
    str1 := GBKtoUnicode('�x���b��');
    menu := TitleCommonScrollMenu(@str1[1], ColColor(0, 5), ColColor(0, 7), 315, 5, 300, n - 1, 17);
    if menu >= 0 then
    begin
      Ritem[equiplist[menu]].BattleEffect := selectedState;
      Result := True;
    end;
  end;
end;

end.