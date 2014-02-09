unit sty_NewEvent;

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

type
  TNewShop = record
    case TCallType of
      Element: (Item, Amount, own_num, Seclectamount, Price, index: Smallint);
      Address: (Data: array[0..5] of Smallint);
  end;

//ly
//�Ƿ�����
function IsZhangmen(rnum, snum, jump1, jump2: integer): integer;
//n1�Ƿ����� n2����
function IsInMenpai(rnum, mpnum, jump1, jump2: integer): integer;
//�ж��Ѻö� n1�Ѻ��Ƿ�<=n2 >=n3
function chkyouhao(rnum, top, bottom, jump1, jump2: integer): integer;

//��������ƶ�  n1���� n2���� n3����
function instruct_89(n1, n2, n3, jump1, jump2: integer): integer;

procedure xuewu(shifu, tudi: integer);
procedure showxuewu(shifu, tudi, menu, menutop: integer; sfmag: array of smallint);
procedure showyn(mnum, mlev, menuyn: integer);
procedure chenghu(rnum1, rnum2: integer);
procedure NewTalk2(rnum, talknum, showhead, place, ex, color, ey: integer);
{procedure hebing1(x1,x2,x3,x4: integer);
procedure hebing2(x5,x6,x7,x8: integer);
procedure callnewtalk2; }
procedure showmenpai(snum: integer);
procedure tiaose;
function eventcaller(ex, ey: integer): integer;
procedure Givezhangmen(rnum, rnum2: integer);

function checkzmr(rnum, snum: integer): integer;
procedure anpai(rnum: integer);

function menpaimenu(snum: integer): integer;
procedure setrole(snum, rnum, mods: integer);

//�T��ָ��
procedure showdizi(mpnum: integer);
function zhuangtaistr(rnum: integer): WideString;
function xingdongstr(rnum: integer): WideString;
function zhiwustr(znum: integer): WideString;
procedure selectjianshe(snum: integer);
procedure showjianshe(snum, x, y, menu: integer);
procedure selectchaichu(snum: integer);
procedure showchaichu(snum, x, y, menu: integer);
procedure showrenming(mpnum: integer);
procedure showneigong(mpnum: integer);
procedure showsongli(mpnum: integer);
procedure showyidong(mpnum: integer);
procedure drawyidong(max0, line, row, menu, menutop, mods: integer);
function confirmyidong(mpnum, snum: integer): integer;
function SelectyidongRole(snum, snum2: integer): boolean;
procedure showjingong(snum, mpnum: integer);
procedure zhuchu(rnum: integer);
procedure xiujian(snum, xnum: integer; ziyuan: array of integer);
procedure chaichu(snum, xnum: integer; ziyuan: array of integer);
procedure drawrenming(mpnum, menu: integer);
function selectdizi(trole: psmallint; mpnum, max0, menu, x, y: integer): integer;
procedure drawdizi(Trole: psmallint; mpnum, bg, ed, max0, pnum, x, y, menu: integer);
procedure showrolemagic(rnum, x, y: integer);
//�ı��T��
procedure joinmenpai(rnum, shifu: integer);

//��׃����
procedure changejiaoqing(rnum, Count: integer);
//�S�C�д�
function sjqiecuo(rnum, jump1, jump2: integer): integer;
//�T�ɑ��Y
function menpaibattle(snum, mpnum1, mpnum2, jump1, jump2: integer): integer;

function xuanze2(jump1, jump2: integer): integer;
procedure addmpshengwang(mpnum, value: integer);
procedure drawneigong(mpnum, menu: integer);
function selectneigong(mpnum, x, y: integer): integer;

procedure drawsongli(mpnum, menu: integer);
function selectsldizi(trole: psmallint; mpnum, max0, menu, x, y: integer): integer;

//�����ڲؽ��w���]�P�ҡ������t������_
procedure zjcjg;
procedure zjbgs(day: integer);
procedure zjbgsmenu;
procedure zjldl;
procedure zjdzt;

procedure xiugaievent(snum, enum, anum, value, atime: integer);
procedure addziyuan(mpnum, zynum, value: integer);
function checkmpgx(mpnum, top, low, jump1, jump2: integer): integer;
procedure changempgx(mpnum1, mpnum2, value: integer);
function checkmpsw(mpnum, top, low, jump1, jump2: integer): integer;
function checkmpse(mpnum, top, low, jump1, jump2: integer): integer;
procedure changempse(mpnum, value: integer);
function checkeventpar(snum, enum, pnum, top, low, jump1, jump2: integer): integer;
function checkfy(xishu, jump1, jump2: integer): integer;
procedure roledie(rnum: integer);
procedure jiwei(mpnum, rnum: integer);
procedure changezhongcheng(rnum, value: integer);

procedure suijijiangli(mpnum, mods, value: integer);
procedure addteamjiaoqing(value: integer);
//�Ƅӵ���؈D
procedure gotommap(x, y: integer);
//�������
procedure randomrole(mpnum, EthicsUp, EthicsDown, ReputeUp, ReputeDown, jqUp, jqDown, sex, v1, v2, yn, Rtype: integer);

//��������DƬ
procedure clearrole(snum, rnum: integer);

function checkjiaoqing(rnum, up, low, jump1, jump2: integer): integer;
procedure changewardata(e1, wnum, dnum, value: integer);

function getyouhao(rnum: integer): integer;

procedure rolejicheng(rnum1, rnum2: integer);
procedure levsort(var arr: array of smallint); //����
//�Ԅ���������
function aotobuildrole(mpnum, level, x1, x2: integer): integer;
//С���΄���ʾ
procedure addtishi(talknum, btime, dtime: integer);
procedure gettishi(ntime, x1: integer);
function ischoushi(rnum, mpnum: integer): boolean;
//�T�ɹ�������
procedure drawgongji(max0, line, row, menu, menutop: integer);
procedure DrawWideScrollMenu(x, y, line, row, menutop, max0, menu: integer);
function confirmgongji(mpnum1, mpnum2: integer): integer;
procedure zhanlin(mpnum, snum: integer);
function selectgongjirole(snum, snum2: integer; var battle_id: integer): boolean;
procedure drawMultiRole(Trole, mrole: array of smallint; mpnum, bg, ed, max0, pnum, x, y, menu: integer);

//���
procedure showqingbao;
procedure CommonScrollQingbao(x, y, w, max0, maxshow: integer; tsnum: array of smallint);
procedure showcommonscrollQingbao(x, y, w, max0, maxshow, menu, menutop: integer; tsnum: array of smallint);

procedure ShutSceSheshi(snum: integer);
procedure BuildBattle(ID, dtime, gongjimp, fangyump, snum, rnum: integer);
procedure AddBattleRole(sign, ID, a, rnum1, rnum2, rnum3, rnum4, rnum5: integer);
procedure SecChangeMp(snum, mpnum: integer);

//�̵�
procedure NewShop(cnum: integer);
procedure drawnewshop(buylist: array of tnewshop; bg, ed, max0, pnum, money, x, y, menu: integer);
procedure addexpn(rnum, exp: integer);

procedure showdizi2(mpnum: integer);

procedure Feventcaller(code, e, x, y: integer);
//ֱ�ӌ�����ŵ�����
function RoleEvent(key, key2, rnum, snum, x, y, face, Ytime, enum1, enum2, enum3, pic0, picE,
  picB, picD, Btime, dtime, Rtime, Jtime, act, Gtime, Genum, reX, jump1, jump2: smallint): smallint;
//�΄���ʾӛ�
function talktostr(talknum: integer): WideString;
procedure talktotips(talknum: integer);
procedure addrenwu(key, num, talknum, status, day: smallint);
//�³�ս��������Ա
procedure AddEnemyNextFight(key,rnum,team:integer);
implementation

uses
  kys_engine,
  kys_event,
  sty_engine,
  sty_show;

procedure xuewu(shifu, tudi: integer);
var
  i, j, magicnum, mlevel, needexp, x, y, menu, menutop, menup, menuyn, wugong1: integer;
  addatk, adddef, addspeed, maxshow, yes, Aptitude: integer;
  str: WideString;
  color1, color2: uint32;
  sfmag, sfmaglv: array of smallint;
begin
  if shifu = -1 then shifu := Ddata[CurScene, CurEvent, 0] div 10;
  if tudi = -1 then tudi := Ddata[CurScene, CurEvent, 0] div 10;
  menu := 0;
  menuyn := 0;
  wugong1 := 0;
  menutop := 0;
  maxshow := 10;
  yes := 0;
  SDL_EnableKeyRepeat(30, 30);
  if CheckEquipSet(Rrole[tudi].equip[0], Rrole[tudi].equip[1], Rrole[tudi].equip[2], Rrole[tudi].equip[3]) = 2 then
    Aptitude := 100
  else Aptitude := Rrole[tudi].Aptitude;


  for i := 0 to 29 do
  begin
    magicnum := Rrole[shifu].lmagic[i];
    if (magicnum > 0) and (Rrole[shifu].MagLevel[i] > 100) then
      if Rmagic[magicnum].ismichuan = 0 then
      begin
        wugong1 := wugong1 + 1;
        setlength(sfmag, wugong1);
        setlength(sfmaglv, wugong1);
        sfmag[wugong1 - 1] := magicnum;
        sfmaglv[wugong1 - 1] := Rrole[shifu].maglevel[i] div 100;
      end;
  end;
  if wugong1 < 1 then exit;
  showxuewu(shifu, tudi, menu, menutop, sfmag);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYdown:
      begin
        if (event.key.keysym.sym = SDLK_DOWN) then
        begin
          menu := menu + 1;
          if menu - menutop >= maxshow then
          begin
            menutop := menutop + 1;
          end;
          if menu > wugong1 - 1 then
          begin
            menu := 0;
            menutop := 0;
          end;
          showxuewu(shifu, tudi, menu, menutop, sfmag);
        end;
        if (event.key.keysym.sym = SDLK_UP) then
        begin
          menu := menu - 1;
          if menu <= menutop then
          begin
            menutop := menu;
          end;
          if menu < 0 then
          begin
            menu := wugong1 - 1;
            menutop := menu - maxshow + 1;
            if menutop < 0 then menutop := 0;
          end;
          showxuewu(shifu, tudi, menu, menutop, sfmag);
        end;
        if (event.key.keysym.sym = SDLK_PAGEDOWN) then
        begin
          menu := menu + maxshow;
          menutop := menutop + maxshow;
          if menu > wugong1 - 1 then
          begin
            menu := wugong1 - 1;
          end;
          if menutop > wugong1 - maxshow then
          begin
            menutop := wugong1 - maxshow;
          end;
          showxuewu(shifu, tudi, menu, menutop, sfmag);
        end;
        if (event.key.keysym.sym = SDLK_PAGEUP) then
        begin
          menu := menu - maxshow;
          menutop := menutop - maxshow;
          if menu < 0 then
          begin
            menu := 0;
          end;
          if menutop < 0 then
          begin
            menutop := 0;
          end;
          showxuewu(shifu, tudi, menu, menutop, sfmag);
        end;
      end;
      SDL_KEYup:
      begin
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          if Ritem[Rmagic[sfmag[menu]].miji].NeedExp > 0 then
            needexp := (Ritem[Rmagic[sfmag[menu]].miji].NeedExp * (800 - Aptitude * 6)) div 200
          else needexp := ((-Ritem[Rmagic[sfmag[menu]].miji].NeedExp) * (200 + Aptitude * 6)) div 200;
          if GetMagicLevel(tudi, sfmag[menu]) > -1 then
          begin
            str := 'ԓ�书����Ҫָ�c��';
            DrawRectangle(CENTER_X - 100, CENTER_Y - 140, 190, 22, 0, ColColor(255), 70);
            DrawShadowText(@str[1], CENTER_X - 100, CENTER_Y - 140, ColColor($13), ColColor($15));
            SDL_UpdateRect2(screen, CENTER_X - 100, CENTER_Y - 140, 191, 23);
            SDL_Delay(50 * (GameSpeed + 10));
          end
          else if (needexp div 2) > Rrole[shifu].ExpForBook then
          begin
            str := '��ѧ����������';
            DrawRectangle(CENTER_X - 100, CENTER_Y - 140, 190, 22, 0, ColColor(255), 70);
            DrawShadowText(@str[1], CENTER_X - 100, CENTER_Y - 140, ColColor($13), ColColor($15));
            SDL_UpdateRect2(screen, CENTER_X - 100, CENTER_Y - 140, 191, 23);
            SDL_Delay(50 * (GameSpeed + 10));
          end
          else if NeedExp div 2 > Rrole[tudi].ExpForBook then
          begin
            str := '��ѧ����������';
            DrawRectangle(CENTER_X - 100, CENTER_Y - 140, 190, 22, 0, ColColor(255), 70);
            DrawShadowText(@str[1], CENTER_X - 100, CENTER_Y - 140, ColColor($13), ColColor($15));
            SDL_UpdateRect2(screen, CENTER_X - 100, CENTER_Y - 140, 191, 23);
            SDL_Delay(50 * (GameSpeed + 10));
          end
          else if not (CanEquip(tudi, Rmagic[sfmag[menu]].miji)) then
          begin
            str := '���m�όW��ԓ�书��';
            DrawRectangle(CENTER_X - 100, CENTER_Y - 140, 190, 22, 0, ColColor(255), 70);
            DrawShadowText(@str[1], CENTER_X - 100, CENTER_Y - 140, ColColor($13), ColColor($15));
            SDL_UpdateRect2(screen, CENTER_X - 100, CENTER_Y - 140, 191, 23);
            SDL_Delay(50 * (GameSpeed + 10));
          end
          else
          begin
            showyn(sfmag[menu], GetMagicLevel(tudi, sfmag[menu]) div 100, menuyn);
            while (SDL_WaitEvent(@event) >= 0) do
            begin
              CheckBasicEvent;
              case event.type_ of
                SDL_KEYUP:
                begin
                  if (event.key.keysym.sym = SDLK_RIGHT) then
                  begin
                    if menuyn = 0 then menuyn := 1;

                    showyn(sfmag[menu], GetMagicLevel(tudi, sfmag[menu]) div 100, menuyn);
                    //SDL_UpdateRect2(screen, x, y, 50, 50);
                  end;
                  if (event.key.keysym.sym = SDLK_LEFT) then
                  begin

                    if menuyn = 1 then
                      menuyn := 0;

                    showyn(sfmag[menu], GetMagicLevel(tudi, sfmag[menu]) div 100, menuyn);
                    //SDL_UpdateRect2(screen, x, y, 50, 50);
                  end;
                  if ((event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE)) then
                  begin
                    if menuyn = 0 then
                    begin
                      Dec(Rrole[tudi].ExpForBook, NeedExp div 2);
                      Dec(Rrole[shifu].ExpForBook, NeedExp div 2);
                      instruct_33(tudi, sfmag[menu], 1);

                      //ȡ�����Ğ�ԕ�
                        {Rrole[tudi].Fist := min(Rrole[tudi].Fist + Rmagic[Rrole[shifu].lmagic[menu]].AddFist, 200);
                        Rrole[tudi].Sword := min(Rrole[tudi].Sword + Rmagic[Rrole[shifu].lmagic[menu]].AddSword, 200);
                        Rrole[tudi].Knife := min(Rrole[tudi].Knife + Rmagic[Rrole[shifu].lmagic[menu]].AddKnife, 200);
                        Rrole[tudi].Unusual := min(Rrole[tudi].Unusual + Rmagic[Rrole[shifu].lmagic[menu]].AddUnusual, 200);}
                      EatOneItem(tudi, Rmagic[sfmag[menu]].miji, True);
                      yes := 1;
                      Redraw;
                      SDL_UpdateRect2(screen, x, y, 50, 50);
                      break;
                    end;
                    if menuyn = 1 then
                    begin
                      menuyn := 0;
                      Redraw;
                      showxuewu(shifu, tudi, menu, menutop, sfmag);

                      break;
                    end;
                  end;
                  if (event.key.keysym.sym = SDLK_ESCAPE) then
                  begin
                    menuyn := 0;
                    Redraw;
                    showxuewu(shifu, tudi, menu, menutop, sfmag);
                    break;
                  end;

                end;
                SDL_MOUSEBUTTONUP:
                begin
                  if (event.button.button = SDL_BUTTON_RIGHT) then
                  begin
                    menuyn := 0;
                    Redraw;
                    showxuewu(shifu, tudi, menu, menutop, sfmag);
                    break;
                  end;
                  if (event.button.button = SDL_BUTTON_LEFT) then
                  begin
                    if menuyn = 0 then
                    begin
                      Dec(Rrole[tudi].ExpForBook, NeedExp div 2);
                      Dec(Rrole[shifu].ExpForBook, NeedExp div 2);
                      instruct_33(tudi, sfmag[menu], 1);
                      //ȡ�����Ğ�ԕ�
                        {Rrole[tudi].Fist := min(Rrole[tudi].Fist + Rmagic[Rrole[shifu].lmagic[menu]].AddFist, 200);
                        Rrole[tudi].Sword := min(Rrole[tudi].Sword + Rmagic[Rrole[shifu].lmagic[menu]].AddSword, 200);
                        Rrole[tudi].Knife := min(Rrole[tudi].Knife + Rmagic[Rrole[shifu].lmagic[menu]].AddKnife, 200);
                        Rrole[tudi].Unusual := min(Rrole[tudi].Unusual + Rmagic[Rrole[shifu].lmagic[menu]].AddUnusual, 200);}
                      EatOneItem(tudi, Rmagic[sfmag[menu]].miji, True);
                      yes := 1;
                      Redraw;

                      break;
                    end;
                    if menuyn = 1 then
                    begin
                      menuyn := 0;
                      Redraw;
                      showxuewu(shifu, tudi, menu, menutop, sfmag);
                      break;
                    end;
                  end;
                end;
                SDL_MOUSEMOTION:
                begin
                  if (event.button.x >= CENTER_X - 60) and (event.button.x < CENTER_X - 32) and
                    (event.button.y > CENTER_Y + 38) and (event.button.y < CENTER_Y + 60) then
                  begin
                    menuyn := 0;
                    showyn(sfmag[menu], GetMagicLevel(tudi, sfmag[menu]) div 100, menuyn);

                  end;
                  if (event.button.x >= CENTER_X) and (event.button.x < CENTER_X + 28) and
                    (event.button.y > CENTER_Y + 38) and (event.button.y < CENTER_Y + 60) then
                  begin
                    menuyn := 1;
                    showyn(sfmag[menu], GetMagicLevel(tudi, sfmag[menu]) div 100, menuyn);

                  end;
                end;
              end;
            end;

            event.key.keysym.sym := 0;
            event.button.button := 0;
            SDL_EnableKeyRepeat(50, 30);
            if yes = 1 then
            begin
              instruct_14;
              dayto(1, 0);
              instruct_13;
              break;
            end;
          end;
        end;

      end;

      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          if Ritem[Rmagic[sfmag[menu]].miji].NeedExp > 0 then
            needexp := (Ritem[Rmagic[sfmag[menu]].miji].NeedExp * (800 - Aptitude * 6)) div 200
          else needexp := ((-Ritem[Rmagic[sfmag[menu]].miji].NeedExp) * (200 + Aptitude * 6)) div 200;

          if GetMagicLevel(tudi, sfmag[menu]) > -1 then
          begin
            str := 'ԓ�书����Ҫָ�c��';
            DrawRectangle(CENTER_X - 100, CENTER_Y - 140, 190, 22, 0, ColColor(255), 70);
            DrawShadowText(@str[1], CENTER_X - 100, CENTER_Y - 140, ColColor($13), ColColor($15));
            SDL_UpdateRect2(screen, CENTER_X - 100, CENTER_Y - 140, 191, 23);
            SDL_Delay(50 * (GameSpeed + 10));
          end

          else if (needexp div 2) > Rrole[shifu].ExpForBook then
          begin
            str := '��ѧ����������';
            DrawRectangle(CENTER_X - 100, CENTER_Y - 140, 190, 22, 0, ColColor(255), 70);
            DrawShadowText(@str[1], CENTER_X - 100, CENTER_Y - 140, ColColor($13), ColColor($15));
            SDL_UpdateRect2(screen, CENTER_X - 100, CENTER_Y - 140, 191, 23);
            SDL_Delay(50 * (GameSpeed + 10));
          end
          else if NeedExp div 2 > Rrole[tudi].ExpForBook then
          begin
            str := '��ѧ����������';
            DrawRectangle(CENTER_X - 100, CENTER_Y - 140, 190, 22, 0, ColColor(255), 70);
            DrawShadowText(@str[1], CENTER_X - 100, CENTER_Y - 140, ColColor($13), ColColor($15));
            SDL_UpdateRect2(screen, CENTER_X - 100, CENTER_Y - 140, 191, 23);
            SDL_Delay(50 * (GameSpeed + 10));
          end
          else if not (CanEquip(tudi, Rmagic[sfmag[menu]].miji)) then
          begin
            str := '���m�όW��ԓ�书��';
            DrawRectangle(CENTER_X - 100, CENTER_Y - 140, 190, 22, 0, ColColor(255), 70);
            DrawShadowText(@str[1], CENTER_X - 100, CENTER_Y - 140, ColColor($13), ColColor($15));
            SDL_UpdateRect2(screen, CENTER_X - 100, CENTER_Y - 140, 191, 23);
            SDL_Delay(50 * (GameSpeed + 10));
          end
          else
          begin
            showyn(sfmag[menu], GetMagicLevel(tudi, sfmag[menu]) div 100, menuyn);
            while (SDL_WaitEvent(@event) >= 0) do
            begin
              CheckBasicEvent;
              case event.type_ of
                SDL_KEYUP:
                begin
                  if (event.key.keysym.sym = SDLK_RIGHT) then
                  begin
                    if menuyn = 0 then menuyn := 1;

                    showyn(sfmag[menu], GetMagicLevel(tudi, sfmag[menu]) div 100, menuyn);
                    //SDL_UpdateRect2(screen, x, y, 50, 50);
                  end;
                  if (event.key.keysym.sym = SDLK_LEFT) then
                  begin

                    if menuyn = 1 then
                      menuyn := 0;

                    showyn(sfmag[menu], GetMagicLevel(tudi, sfmag[menu]) div 100, menuyn);
                    //SDL_UpdateRect2(screen, x, y, 50, 50);
                  end;
                  if ((event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE)) then
                  begin
                    if menuyn = 0 then
                    begin
                      Dec(Rrole[tudi].ExpForBook, NeedExp div 2);
                      Dec(Rrole[shifu].ExpForBook, NeedExp div 2);
                      instruct_33(tudi, sfmag[menu], 1);

                      //ȡ�����Ğ�ԕ�
                        {Rrole[tudi].Fist := min(Rrole[tudi].Fist + Rmagic[Rrole[shifu].lmagic[menu]].AddFist, 200);
                        Rrole[tudi].Sword := min(Rrole[tudi].Sword + Rmagic[Rrole[shifu].lmagic[menu]].AddSword, 200);
                        Rrole[tudi].Knife := min(Rrole[tudi].Knife + Rmagic[Rrole[shifu].lmagic[menu]].AddKnife, 200);
                        Rrole[tudi].Unusual := min(Rrole[tudi].Unusual + Rmagic[Rrole[shifu].lmagic[menu]].AddUnusual, 200);}
                      EatOneItem(tudi, Rmagic[sfmag[menu]].miji, True);
                      yes := 1;
                      Redraw;
                      SDL_UpdateRect2(screen, x, y, 50, 50);
                      break;
                    end;
                    if menuyn = 1 then
                    begin
                      menuyn := 0;
                      Redraw;
                      showxuewu(shifu, tudi, menu, menutop, sfmag);

                      break;
                    end;
                  end;
                  if (event.key.keysym.sym = SDLK_ESCAPE) then
                  begin
                    menuyn := 0;
                    Redraw;
                    showxuewu(shifu, tudi, menu, menutop, sfmag);
                    break;
                  end;

                end;
                SDL_MOUSEBUTTONUP:
                begin
                  if (event.button.button = SDL_BUTTON_RIGHT) then
                  begin
                    menuyn := 0;
                    Redraw;
                    showxuewu(shifu, tudi, menu, menutop, sfmag);
                    break;
                  end;
                  if (event.button.button = SDL_BUTTON_LEFT) then
                  begin
                    if menuyn = 0 then
                    begin
                      Dec(Rrole[tudi].ExpForBook, NeedExp div 2);
                      Dec(Rrole[shifu].ExpForBook, NeedExp div 2);
                      instruct_33(tudi, sfmag[menu], 1);
                      //ȡ�����Ğ�ԕ�
                        {Rrole[tudi].Fist := min(Rrole[tudi].Fist + Rmagic[Rrole[shifu].lmagic[menu]].AddFist, 200);
                        Rrole[tudi].Sword := min(Rrole[tudi].Sword + Rmagic[Rrole[shifu].lmagic[menu]].AddSword, 200);
                        Rrole[tudi].Knife := min(Rrole[tudi].Knife + Rmagic[Rrole[shifu].lmagic[menu]].AddKnife, 200);
                        Rrole[tudi].Unusual := min(Rrole[tudi].Unusual + Rmagic[Rrole[shifu].lmagic[menu]].AddUnusual, 200);}
                      EatOneItem(tudi, Rmagic[sfmag[menu]].miji, True);
                      yes := 1;
                      Redraw;

                      break;
                    end;
                    if menuyn = 1 then
                    begin
                      menuyn := 0;
                      Redraw;
                      showxuewu(shifu, tudi, menu, menutop, sfmag);
                      break;
                    end;
                  end;
                end;
                SDL_MOUSEMOTION:
                begin
                  if (event.button.x >= CENTER_X - 60) and (event.button.x < CENTER_X - 32) and
                    (event.button.y > CENTER_Y + 38) and (event.button.y < CENTER_Y + 60) then
                  begin
                    menuyn := 0;
                    showyn(sfmag[menu], GetMagicLevel(tudi, sfmag[menu]) div 100, menuyn);

                  end;
                  if (event.button.x >= CENTER_X) and (event.button.x < CENTER_X + 28) and
                    (event.button.y > CENTER_Y + 38) and (event.button.y < CENTER_Y + 60) then
                  begin
                    menuyn := 1;
                    showyn(sfmag[menu], GetMagicLevel(tudi, sfmag[menu]) div 100, menuyn);

                  end;
                end;
              end;
            end;

            event.key.keysym.sym := 0;
            event.button.button := 0;
            SDL_EnableKeyRepeat(50, 30);
            if yes = 1 then
            begin
              instruct_14;
              dayto(1, 0);
              instruct_13;
              break;
            end;
          end;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x > 20) and (event.button.x < 200) and (event.button.y > CENTER_Y - 90 + 46) and
          (event.button.y < CENTER_Y - 90 + 46 + 22 * wugong1) then
        begin
          menup := menu;
          menu := (event.button.y - CENTER_Y + 90 - 42) div 22 + menutop;
          if menu > wugong1 - 1 then
            menu := wugong1 - 1;
          if menu < 0 then
            menu := 0;
          if menup <> menu then
          begin
            showxuewu(shifu, tudi, menu, menutop, sfmag);
          end;
        end;
      end;
    end;
  end;
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(50, 30);
end;

procedure showyn(mnum, mlev, menuyn: integer);
var
  x, y: integer;
  str, yes, no: WideString;
  color1, color2: uint32;
begin
  x := CENTER_X - 140;
  y := CENTER_Y - 40;
  Redraw;
  if mlev = 0 then
  begin

    DrawRectangle(x, y, 240, 120, 0, ColColor(255), 50);
    str := 'Ҫѧϰ' + gbktounicode(@Rmagic[mnum].Name) + '��';
    DrawShadowText(@str[1], x + 5, y + 10, ColColor($66), ColColor($63));
  end
  else
  begin
    DrawRectangle(x, y, 240, 120, 0, ColColor(255), 50);
    str := 'Ҫ��' + gbktounicode(@Rmagic[mnum].Name) + '';
    DrawShadowText(@str[1], x + 30, y + 10, ColColor($66), ColColor($63));
    str := '��' + (IntToStr((mlev div 100) + 1)) + '��������' + (IntToStr((mlev div 100) + 2)) + '����';
    DrawShadowText(@str[1], x + 27, y + 37, ColColor($66), ColColor($63));
  end;
  yes := '��';
  no := '��';
  if menuyn = 0 then
  begin
    DrawRectangle(x + 70, y + 75, 100, 28, 0, ColColor(0, 255), 30);
    DrawShadowText(@yes[1], x + 70, y + 75, ColColor($7), ColColor($5));
    DrawShadowText(@no[1], x + 120, y + 75, ColColor($23), ColColor($21));
    //drawtextwithrect(@yes[1], x+70, y+75, 28, colcolor($7), colcolor($5));
    //drawtextwithrect(@no[1], x+130, y+70, 28, colcolor($23), colcolor($21));
  end
  else if menuyn = 1 then
  begin
    DrawRectangle(x + 70, y + 75, 100, 28, 0, ColColor(0, 255), 30);
    DrawShadowText(@yes[1], x + 70, y + 75, ColColor($23), ColColor($21));
    DrawShadowText(@no[1], x + 120, y + 75, ColColor($7), ColColor($5));
    //drawtextwithrect(@yes[1], x+70, y+70, 28, colcolor($23), colcolor($21));
    //drawtextwithrect(@no[1], x+130, y+75, 28, colcolor($7), colcolor($5));
  end;
  SDL_UpdateRect2(screen, x, y, 241, 121);

end;

procedure showxuewu(shifu, tudi, menu, menutop: integer; sfmag: array of smallint);
var
  i, magicnum, mlevel, needexp, x, y, w, max0, maxshow, Aptitude: integer;
  str, Name: WideString;
  color1, color2: uint32;
begin
  Redraw;
  x := 20;
  y := CENTER_Y - 180;
  w := 200;
  max0 := 0;
  maxshow := 10;
  if CheckEquipSet(Rrole[tudi].equip[0], Rrole[tudi].equip[1], Rrole[tudi].equip[2], Rrole[tudi].equip[3]) = 2 then
    Aptitude := 100
  else Aptitude := Rrole[tudi].Aptitude;

  DrawHeadPic(Rrole[shifu].HeadNum, x, y + 60);
  Name := gbktounicode(@Rrole[shifu].Name) + ':Ҫѧʲô';
  DrawShadowText(@Name[1], x - length(pchar(@Rrole[shifu].Name)) * 5, y + 65, ColColor($66), ColColor($63));

  DrawRectangle(x + 70, y + 12, 100, 48, 0, ColColor(0, 255), 30);
  Name := '�ޟ��c��';
  DrawShadowText(@Name[1], x + 70, y + 14, ColColor($66), ColColor($63));
  Name := IntToStr(Rrole[shifu].ExpForBook);
  DrawShadowText(@Name[1], x + 80, y + 36, ColColor($13), ColColor($15));

  DrawHeadPic(Rrole[tudi].HeadNum, x + 200, y + 60);
  Name := gbktounicode(@Rrole[tudi].Name) + '��ѧ����书��';
  DrawShadowText(@Name[1], x + 200 - length(pchar(@Rrole[shifu].Name)) * 5, y + 65, ColColor($66), ColColor($63));

  DrawRectangle(x + 270, y + 12, 100, 48, 0, ColColor(0, 255), 30);
  Name := '�ޟ��c��';
  DrawShadowText(@Name[1], x + 270, y + 14, ColColor($66), ColColor($63));
  Name := IntToStr(Rrole[tudi].ExpForBook);
  DrawShadowText(@Name[1], x + 280, y + 36, ColColor($13), ColColor($15));

  showrolemagic(tudi, x + 200, y + 90);
  for i := 0 to length(sfmag) - 1 do
  begin
    if sfmag[i] <= 0 then break
    else
    begin
      setlength(menustring2, i + 1);
      setlength(menuengstring2, i + 1);
      menustring2[i] := '';
      menuengstring2[i] := '';
      menustring2[i] := gbktounicode(@Rmagic[sfmag[i]].Name);
      if Ritem[Rmagic[sfmag[i]].miji].NeedExp > 0 then
        needexp := (Ritem[Rmagic[sfmag[i]].miji].NeedExp * (800 - Aptitude * 6)) div 200
      else needexp := ((-Ritem[Rmagic[sfmag[i]].miji].NeedExp) * (200 + Aptitude * 6)) div 200;
      menuengstring2[i] := IntToStr(NeedExp div 2);
      Inc(max0);
    end;
  end;
  Dec(max0);

  //  SDL_EnableKeyRepeat(10, 100);
  maxshow := min(max0 + 1, maxshow);
  if max0 >= 0 then
  begin
    showselectmagic(x, y + 90, w, max0, maxshow, menu, menutop);
  end;
      {if i=menu then
      begin
        drawgbkshadowtext(@Rmagic[magicnum].Name, x + 60, y + 97 + 21 * i, colcolor($66), colcolor($64));
        str := format('%3d', [Rrole[shifu].MagLevel[i] div 100 + 1]);
        drawengshadowtext(@str[1], x + 160, y + 97 + 21 * i, colcolor($66), colcolor($64));
      end
      else
      begin
        drawgbkshadowtext(@Rmagic[magicnum].Name, x + 60, y + 95 + 21 * i, colcolor($5), colcolor($7));
        str := format('%3d', [Rrole[shifu].MagLevel[i] div 100 + 1]);
        drawengshadowtext(@str[1], x + 160, y + 95 + 21 * i, colcolor($5), colcolor($7));
      end; }


  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
end;

//�@ʾ���W�书

procedure showrolemagic(rnum, x, y: integer);
var
  w, h, i, j: integer;
  tmp: array[0..11] of char;
  magic: array[0..29] of WideString;
begin
  w := 400;
  h := 220;
  DrawRectangle(x, y, w, h, 0, ColColor(255), 50);
  for i := 0 to 29 do
  begin
    if Rrole[rnum].lmagic[i] <= 0 then break;
    for j := 0 to 9 do tmp[j] := Rmagic[Rrole[rnum].lmagic[i]].Name[j];
    tmp[10] := char(0);
    tmp[11] := char(0);
    magic[i] := gbktounicode(@tmp);
    DrawShadowText(@magic[i][1], x + 130 * (i mod 3), y + 22 * (i div 3), ColColor($5), ColColor($7));
  end;

end;

procedure chenghu(rnum1, rnum2: integer);
var
  scd, bsd: integer;
begin
  if Rrole[rnum1].menpai = Rrole[rnum2].menpai then
  begin
    scd := Rrole[rnum1].scsx - Rrole[rnum2].scsx;
    bsd := Rrole[rnum1].bssx - Rrole[rnum2].bssx;
    if rmenpai[Rrole[rnum1].MenPai].zmr = rnum2 then chenghuname := '���T'
    else if (scd > 0) then
    begin
      case scd of
        1:
        begin
          if Rrole[rnum1].shifu = rnum2 then
            chenghuname := '����'
          else
            chenghuname := '����'

        end;

        2: chenghuname := '̫����';
        3: chenghuname := '����';
        else
          chenghuname := '̫����';
      end;
    end
    else if scd = 0 then
    begin
      if bsd > 0 then chenghuname := 'ʦ��'
      else chenghuname := 'ʦ��';
    end
    else
    begin
      case scd of
      -1:
      begin
        if Rrole[rnum2].shifu = rnum1 then
          chenghuname := 'ͽ��'
        else
          chenghuname := '��ֶ';
      end;

        else
          chenghuname := 'ͽ�O��';
      end;
    end;
  end
  else chenghuname := '�@λ�قb';

end;

{procedure hebing1(x1,x2,x3,x4:integer);
begin
  exx1:=x1;
  exx2:=x2;
  exx3:=x3;
  exx4:=x4;
end;
procedure hebing2(x5,x6,x7,x8:integer);
begin
  exx5:=x5;
  exx6:=x6;
  exx7:=x7;
  exx8:=x8;
end;

procedure callnewtalk2;
begin
  newtalk2(exx1,exx2,exx3,exx4,exx5,exx6);
  exx1:=0;
  exx2:=0;
  exx3:=0;
  exx4:=0;
  exx5:=0;
  exx6:=0;
  exx7:=0;
  exx8:=0;

end;}

procedure Showmenpai(snum: integer);
var
  x, y, i, j, k, tmp, mpnum: integer;
  wordtmp: array[0..9] of WideString;
  zyname, zy, zyadd: array[0..9] of WideString;
  neigong: array[0..19] of WideString;
  guanxi, menpainame: array[0..39] of WideString;
  zhiwu: array[0..9] of WideString;
  str, str1, tmps: WideString;
  strs: array[0..9] of WideString;
  color1, color2: uint32;
  Name: WideString;

begin
  strs[0] := '���T��';
  strs[1] := '����';
  strs[2] := '���c��';
  strs[3] := '���Ӕ�';
  strs[4] := '�T����';
  strs[5] := '�Ɛ���';
  strs[6] := '�YԴ��';
  strs[7] := '�T�Ƀȹ�';
  strs[8] := '�T���P�S';
  strs[9] := '�T����';
  zyname[0] := '�F�V';
  zyname[1] := 'ʯ��';
  zyname[2] := 'ľ��';
  zyname[3] := 'ʳ��';
  zyname[4] := '��̿';
  zyname[5] := '��ˎ';
  zyname[6] := '��ľ';
  zyname[7] := '����';
  zyname[8] := 'ϡ��';
  zyname[9] := '���F';
  if snum = -2 then
    mpnum := Rscene[CurScene].menpai
  else if snum = -1 then
    mpnum := Rrole[0].menpai
  else mpnum := Rscene[snum].menpai;
  for i := 0 to 9 do
  begin
    zy[i] := '' + IntToStr(Rmenpai[mpnum].ziyuan[i]);
    zyadd[i] := IntToStr(Rmenpai[mpnum].aziyuan[i]);
    if Rmenpai[mpnum].aziyuan[i] >= 0 then zyadd[i] := '+' + zyadd[i];
    zyadd[i] := '(' + zyadd[i] + ')';
  end;
  Redraw;
  x := 40;
  y := CENTER_Y - 160;
  display_imgFromSurface(MPZHUANGTAI_PIC.pic, 0, 0);
  DrawRectangle(x, y, 560, 315, 0, ColColor(255), 50);
  //��ʾ�T��
  Name := gbktounicode(@Rmenpai[mpnum].Name);
  Name := '��������������������' + Name + '��������������������';
  DrawShadowText(@Name[1], CENTER_X - length(Name) * 10 - 9, y + 15, ColColor($5), ColColor($7));
  //��ʾ�����ַ�
  wordtmp[0] := gbktounicode(@Rrole[Rmenpai[mpnum].zmr].Name);
  wordtmp[1] := gbktounicode(@Rscene[Rmenpai[mpnum].zongduo].Name);
  wordtmp[2] := ' ' + IntToStr(Rmenpai[mpnum].jvdian);
  tmps := format('%3d', [Rmenpai[mpnum].dizi]);
  wordtmp[3] := '  ��';
  wordtmp[4] := '  ' + IntToStr(Rmenpai[mpnum].shengwang);
  tmp := Rmenpai[mpnum].shane;
  case tmp of -3: wordtmp[5] := '�O��'; -2: wordtmp[5] := '�ܐ�'; -1: wordtmp[5] := '��';
    0: wordtmp[5] := '����';
    1: wordtmp[5] := '��';
    2: wordtmp[5] := '����';
    3: wordtmp[5] := '�O��';
  end;
  for i := 0 to 2 do
  begin
    DrawShadowText(@strs[i, 1], x - 10 + 180 * i, y + 50, ColColor($21), ColColor($23));
    DrawShadowText(@wordtmp[i, 1], x + 66 + 180 * i, y + 50, ColColor($13), ColColor($15));
  end;
  for i := 3 to 5 do
  begin
    DrawShadowText(@strs[i, 1], x - 10 + 180 * (i - 3), y + 75, ColColor($21), ColColor($23));
    DrawShadowText(@wordtmp[i, 1], x + 76 + 180 * (i - 3), y + 75, ColColor($13), ColColor($15));
  end;
  DrawShadowText(@tmps[1], x + 66, y + 73, ColColor($13), ColColor($15));
  DrawShadowText(@strs[6, 1], x - 10, y + 115, ColColor($21), ColColor($23));
  for i := 0 to 4 do
  begin
    DrawShadowText(@zyname[i, 1], x - 10 + 115 * i, y + 150, ColColor($5), ColColor($6));
    DrawShadowText(@zy[i, 1], x - 10 + 115 * i, y + 175, ColColor($64), ColColor($66));
    DrawShadowText(@zyadd[i, 1], x - 10 + (length(zy[i]) * 10) + 115 * i, y + 175, ColColor($30), ColColor($32));
  end;
  for i := 5 to 9 do
  begin
    DrawShadowText(@zyname[i, 1], x - 585 + 115 * i, y + 200, ColColor($6), ColColor($7));
    DrawShadowText(@zy[i, 1], x - 585 + 115 * i, y + 225, ColColor($64), ColColor($66));
    DrawShadowText(@zyadd[i, 1], x - 585 + (length(zy[i]) * 10) + 115 * i, y + 225, ColColor($30), ColColor($32));
  end;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  WaitAnyKey;
  Redraw;
  display_imgFromSurface(MPZHUANGTAI_PIC.pic, 0, 0);
  DrawRectangle(x, y, 560, 315, 0, ColColor(255), 50);
  Name := '�����������������T���P�S����������������';
  DrawShadowText(@Name[1], CENTER_X - length(Name) * 10 - 9, y + 15, ColColor($5), ColColor($7));
  j := 0;
  for k := 0 to 39 do
    if (k <> mpnum) and (Rmenpai[k].zongduo >= 0) then
    begin
      menpainame[j] := gbkToUnicode(@Rmenpai[k].Name);
      guanxi[j] := IntToStr(Rmenpai[mpnum].guanxi[k]);
      Inc(j);
    end;

  if j > 0 then
  begin
    i := 0;
    repeat
      begin
        DrawShadowText(@menpainame[i, 1], x + 120 * (i mod 4), y + 60 + 40 * (i div 4), ColColor($21), ColColor($23));
        DrawShadowText(@guanxi[i, 1], x + 120 * (i mod 4) + length(menpainame[i]) * 20, y +
          60 + 40 * (i div 4), ColColor($64), ColColor($66));
        Inc(i);
      end;
    until i > j - 1;
  end;
  SDL_UpdateRect2(screen, x, y, 561, 316);
  WaitAnyKey;
end;

procedure tiaose;
var
  j, k: integer;
  z: WideString;
begin
  Redraw;
  for j := 1 to 16 do
    for k := 0 to 15 do
    begin
      z := IntToStr(j + k * 16) + '';
      DrawShadowText(@z[1], 10 + 30 * j, 50 + 20 * k, ColColor(j + k * 16), ColColor(j + k * 16 + 2));
    end;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  WaitAnyKey;
end;

function eventcaller(ex, ey: integer): integer;

begin
  Result := -1;
  if Sdata[CurScene, 3, ey, ex] >= 0 then
  begin
    if Ddata[CurScene, Sdata[CurScene, 3, ey, ex], 0] > 9 then
      Result := Ddata[CurScene, Sdata[CurScene, 3, ey, ex], 0] div 10;
  end;
end;

procedure givezhangmen(rnum, rnum2: integer);
var
  i, mpnum: integer;
  tword: WideString;
begin
  mpnum := Rrole[rnum2].MenPai;
  //����
  for i := 0 to 9 do
  begin
    if Rmenpai[Rrole[rnum].MenPai].zhiwu[i] = rnum then
    begin
      Rmenpai[Rrole[rnum].MenPai].zhiwu[i] := -1;
      Inc(Rmenpai[mpnum].aziyuan[0], (20 + 10 * (i div 4)) div 30);
      Inc(Rmenpai[mpnum].aziyuan[1], (20 + 10 * (i div 4)) div 30);
      Inc(Rmenpai[mpnum].aziyuan[2], (20 + 10 * (i div 4)) div 30);
      Inc(Rmenpai[mpnum].aziyuan[3], (100 + 20 * (i div 4)) div 30);
      break;
    end;
  end;
  //�����ɲ�һ�������ޣ�������
  if Rrole[rnum].menpai <> mpnum then
  begin
    for i := 0 to 2 do
    begin
      if Rrole[rnum].choushi[i] = mpnum then
      begin
        Rrole[rnum].choushi[i] := -1;
        break;
      end;
    end;
    Rmenpai[Rrole[rnum].MenPai].dizi := Rmenpai[Rrole[rnum].MenPai].dizi - 1;
    Inc(Rmenpai[Rrole[rnum].MenPai].aziyuan[3]);
    Rmenpai[mpnum].dizi := Rmenpai[mpnum].dizi + 1;
    Dec(Rmenpai[mpnum].aziyuan[3]);
    Rrole[rnum].menpai := mpnum;
  end;
  Rmenpai[mpnum].zmr := rnum;
  tword := gbktounicode(@Rrole[rnum].Name) + '�ɞ�' + gbktounicode(@rmenpai[mpnum].Name) + '���T��';
  if (mpnum = Rrole[0].menpai) or (rnum = 0) or (rnum2 = 0) then
  begin
    DrawTextWithRect(@tword[1], CENTER_X - length(tword) * 8, 30, length(tword) * 20 + 10, ColColor(5), ColColor(7));

    SDL_Delay(50 * (GameSpeed + 10));
  end
  else addtips(tword);
end;

function checkzmr(rnum, snum: integer): integer;
var
  i: integer;
begin
  Result := 0;
  if Rmenpai[Rscene[snum].menpai].zmr = rnum then Result := 1;
end;

function menpaimenu(snum: integer): integer;
var

  menu, menup, mpnum, x, y, w, max0, rst: integer;
begin
  menu := 0;
  x := CENTER_X + 40;
  y := CENTER_Y - 100;
  w := 50;
  if snum = -1 then
  begin
    mpnum := Rrole[0].menpai;
    snum := curscene;
  end
  else
    mpnum := Rscene[snum].menpai;
  if mpnum < 0 then
    exit;
  max0 := 11;
  setlength(menuString, 0);
  setlength(menuString, max0);
  //setlength(menustring,5);
  setlength(menuEngString, 0);
  menuString[0] := '��B';
  menuString[1] := '����';
  menuString[2] := '���O';
  menuString[3] := '���';
  menuString[4] := '����';
  menuString[5] := '�ȹ�';
  menuString[6] := '�ͶY';
  menuString[7] := '�Ƅ�';
  menuString[8] := '����';
  menuString[9] := '���';
  menuString[10] := '��Ʒ';
  SDL_EnableKeyRepeat(10, 100);
  ShowCommonMenu(x, y, w, max0 - 1, menu);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYDown:
      begin
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          menu := menu + 1;
          if menu > max0 - 1 then
            menu := 0;
          ShowCommonMenu(x, y, w, max0 - 1, menu);
          SDL_UpdateRect2(screen, x, y, w + 1, (max0 - 1) * 22 + 29);
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          menu := menu - 1;
          if menu < 0 then
            menu := max0 - 1;
          ShowCommonMenu(x, y, w, max0 - 1, menu);
          SDL_UpdateRect2(screen, x, y, w + 1, (max0 - 1) * 22 + 29);
        end;
      end;

      SDL_KEYUP:
      begin
        if ((event.key.keysym.sym = SDLK_ESCAPE)) then
        begin
          Result := -1;
          menu := -1;
          rst := -1;
          Redraw;
          SDL_UpdateRect2(screen, x, y, w + 1, (max0 - 1) * 22 + 29);
          break;
        end;
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          rst := menu;
          //Redraw;
          SDL_UpdateRect2(screen, x, y, w + 1, (max0 - 1) * 22 + 29);
          break;
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          Result := -1;
          menu := -1;
          rst := -1;
          Redraw;
          SDL_UpdateRect2(screen, x, y, w + 1, (max0 - 1) * 22 + 29);
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          rst := menu;
          //Redraw;
          SDL_UpdateRect2(screen, x, y, w + 1, (max0 - 1) * 22 + 29);
          break;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x >= x) and (event.button.x < x + w) and (event.button.y > y) and
          (event.button.y < y + (max0 - 1) * 22 + 29) then
        begin
          menup := menu;
          menu := (event.button.y - y - 2) div 22;
          if menu > max0 - 1 then
            menu := max0 - 1;
          if menu < 0 then
            menu := 0;
          if menup <> menu then
          begin
            ShowCommonMenu(x, y, w, max0 - 1, menu);
            SDL_UpdateRect2(screen, x, y, w + 1, (max0 - 1) * 22 + 29);
          end;
        end;
      end;
    end;
  end;
  //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(30, 30);
  case rst of
    0: showmenpai(snum);
    1: showdizi(Rrole[0].menpai);
    2: selectjianshe(snum);
    3: selectchaichu(snum);
    4: showrenming(Rrole[0].menpai);
    5: showneigong(Rrole[0].menpai);
    6: showsongli(Rrole[0].menpai);
    7: showyidong(Rrole[0].menpai);
    8: showjingong(snum, Rrole[0].menpai);
    9: showqingbao;
    10: NewMPMenuItem;
  end;
end;

procedure showdizi(mpnum: integer);
var
  i, i1, i2, i3, j, k, k1, n, page, npage, pnum, x, y, w, menu, menup, menuz, menuzp, menud,
  menudp, menuyn, menudz, menudzp: integer;
  trole: array[0..49] of smallint;
  strs: array[0..11] of WideString;
  word, str: WideString;
  wordtmp: array of array[0..5] of WideString;
begin
  SDL_EnableKeyRepeat(10, 100);
  Redraw;
  k := 0;
  j := 0;
  if mpnum = -1 then mpnum := Rrole[0].MenPai;
  if mpnum < 0 then exit;
  x := 40;
  y := CENTER_Y - 160;
  w := 120;
  pnum := 7;
  for i := 0 to length(Rrole) - 1 do
  begin
    if Rrole[i].menpai = mpnum then
    begin
      trole[k] := i;
      k := k + 1;
    end;
  end;
  page := max(0, (k - 1)) div pnum;
  strs[0] := '���';
  strs[1] := '���T�˲�������Լ���';
  strs[2] := ' ǰ�';
  strs[3] := ' ���';
  strs[4] := '������������������������' + gbktounicode(@Rmenpai[mpnum].Name) + '������������������������';
  strs[5] := '�';
  strs[6] := '���T�˲��ܼ�����飡';
  strs[7] := '���Լ��ѽ�������У�';
  strs[8] := 'ԓ�����ѽ�������У�';
  strs[9] := 'ԓ����o�����룡';
  strs[10] := '�㲻��������ң�';
  strs[11] := 'ԓ���ﲻ�������';
  setlength(menuString, 2);
  menuString[0] := ' �_�J';
  menuString[1] := ' ȡ��';
  menu := -1;
  menup := -1;
  menuz := -1;
  menuzp := -1;
  menud := -1;
  menudp := -1;
  menuyn := -1;
  menudz := -1;
  npage := 0;
  if k > 0 then
  begin

    k1 := min(pnum - 1, k - npage * pnum - 1);
    drawdizi(@Trole[0], mpnum, 0, k1, k - 1, pnum, x, y, menudz);
    DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));
    for i := 0 to k1 do
    begin
      if menuz = i then DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($5), ColColor($7))
      else DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($15), ColColor($17));
      if menud = i then DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor($5), ColColor($7))
      else DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor(47), ColColor(49));
    end;
    str := format('%3d', [npage + 1]);
    word := '��     �';
    DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
    DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
    DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
    for i := 0 to 1 do
      if i = menu then
      begin
        DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
      end
      else
      begin
        DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
      end;
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    while (SDL_WaitEvent(@event) >= 0) do
    begin
      CheckBasicEvent;
      case event.type_ of
        SDL_KEYUP:
        begin
          if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
          begin
            menudz := menudz + 1;
            if menudz >= pnum then
            begin
              npage := npage + 1;
              if npage > page then npage := 0;
              menudz := 0;
            end;
            Redraw;
            k1 := min(pnum - 1, k - npage * pnum - 1);
            drawdizi(@Trole[0], mpnum, npage * pnum, npage * pnum + k1, k - 1, pnum, x, y, menudz);
            DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));
            for i := 0 to k1 do
            begin
              if menuz = i then DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($5), ColColor($7))
              else DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($15), ColColor($17));
              if menud = i then DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor($5), ColColor($7))
              else DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor(47), ColColor(49));
            end;
            str := format('%3d', [npage + 1]);
            word := '��     �';
            DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
            DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
            DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
            for i := 0 to 1 do
              if i = menu then
              begin
                DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
              end
              else
              begin
                DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
              end;
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

          end;
          if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
          begin
            menudz := menudz - 1;
            if menudz < 0 then
            begin
              npage := npage - 1;
              if npage < 0 then npage := page;
              menudz := min(pnum - 1, k - npage * pnum - 1);
            end;
            Redraw;

            k1 := min(pnum - 1, k - npage * pnum - 1);
            drawdizi(@Trole[0], mpnum, npage * pnum, npage * pnum + k1, k - 1, pnum, x, y, menudz);
            DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));
            for i := 0 to k1 do
            begin
              if menuz = i then DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($5), ColColor($7))
              else DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($15), ColColor($17));
              if menud = i then DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor($5), ColColor($7))
              else DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor(47), ColColor(49));
            end;
            str := format('%3d', [npage + 1]);
            word := '��     �';
            DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
            DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
            DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
            for i := 0 to 1 do
              if i = menu then
              begin
                DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
              end
              else
              begin
                DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
              end;
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;
          if ((event.key.keysym.sym = SDLK_ESCAPE)) and (where <= 2) then
          begin
            Redraw;
            break;
          end;
          if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
          begin
            if (menudz >= 0) and (menudz <= k1) then
            begin
              newshowstatus(trole[npage * pnum + menudz]);
              WaitAnyKey;
              Redraw;
              k1 := min(pnum - 1, k - npage * pnum - 1);
              drawdizi(@Trole[0], mpnum, npage * pnum, npage * pnum + k1, k - 1, pnum, x, y, menudz);
              DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));
              for i := 0 to k1 do
              begin
                if menuz = i then DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($5), ColColor($7))
                else DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($15), ColColor($17));
                if menud = i then DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor($5), ColColor($7))
                else DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor(47), ColColor(49));
              end;
              str := format('%3d', [npage + 1]);
              word := '��     �';
              DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
              DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
              DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
              for i := 0 to 1 do
                if i = menu then
                begin
                  DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
                end
                else
                begin
                  DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
                end;
              SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            end;
          end;
        end;
        SDL_MOUSEBUTTONUP:
        begin
          if (event.button.button = SDL_BUTTON_RIGHT) and (where <= 2) then
          begin
            Redraw;
            break;
          end;
          if (event.button.button = SDL_BUTTON_LEFT) then
          begin

            case menu of
              0:
              begin
                npage := npage - 1;
                if npage < 0 then npage := page;
              end;
              1:
              begin
                npage := npage + 1;
                if npage > page then npage := 0;
              end;
            end;
            Redraw;

            k1 := min(pnum - 1, k - npage * pnum - 1);
            drawdizi(@Trole[0], mpnum, npage * pnum, npage * pnum + k1, k - 1, pnum, x, y, menudz);
            DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));
            for i := 0 to k1 do
            begin
              if menuz = i then DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($5), ColColor($7))
              else DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($15), ColColor($17));
              if menud = i then DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor($5), ColColor($7))
              else DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor(47), ColColor(49));
            end;
            str := format('%3d', [npage + 1]);
            word := '��     �';
            DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
            DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
            DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
            for i := 0 to 1 do
              if i = menu then
              begin
                DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
              end
              else
              begin
                DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
              end;
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            if (menudz >= 0) and (menudz <= k1) then
            begin
              newshowstatus(trole[npage * pnum + menudz]);
              WaitAnyKey;
              Redraw;
              k1 := min(pnum - 1, k - npage * pnum - 1);
              drawdizi(@Trole[0], mpnum, npage * pnum, npage * pnum + k1, k - 1, pnum, x, y, menudz);
              DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));
              for i := 0 to k1 do
              begin
                if menuz = i then DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($5), ColColor($7))
                else DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($15), ColColor($17));
                if menud = i then DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor($5), ColColor($7))
                else DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor(47), ColColor(49));
              end;
              str := format('%3d', [npage + 1]);
              word := '��     �';
              DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
              DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
              DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
              for i := 0 to 1 do
                if i = menu then
                begin
                  DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
                end
                else
                begin
                  DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
                end;
              SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            end;
            if (menuz >= 0) and (menuz <= k1) then
            begin
              if trole[npage * pnum + menuz] = Rmenpai[mpnum].zmr then
              begin
                Redraw;
                DrawShadowText(@strs[1][1], CENTER_X - 100, y + 20, ColColor($13), ColColor($15));
                SDL_UpdateRect2(screen, 0, 0, 561, 316);
                SDL_Delay(50 * (GameSpeed + 10));
              end
              else if Rrole[trole[npage * pnum + menuz]].nweizhi = 20 then
              begin
                Redraw;
                DrawShadowText(@strs[10][1], CENTER_X - 100, y + 20, ColColor($13), ColColor($15));
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                SDL_Delay(50 * (GameSpeed + 10));
              end
              else if Rrole[trole[npage * pnum + menuz]].zhongcheng = -2 then
              begin
                Redraw;
                DrawShadowText(@strs[11][1], CENTER_X - 100, y + 20, ColColor($13), ColColor($15));
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                SDL_Delay(50 * (GameSpeed + 10));
              end
              else
              begin
                menuyn := CommonMenu2(CENTER_X - 70, y + 120, 120);
                if menuyn = 0 then
                begin
                  setrole(Rrole[trole[npage * pnum + menuz]].weizhi, trole[npage * pnum + menuz], 0);
                  zhuchu(trole[npage * pnum + menuz]);
                  instruct_14;
                  InitialScene;
                  DrawScene;
                  instruct_13;
                end;

              end;
              break;
            end;
            if (menud >= 0) and (menud <= k1) then
            begin
              if trole[npage * pnum + menud] = Rmenpai[mpnum].zmr then
              begin
                Redraw;
                DrawShadowText(@strs[6][1], CENTER_X - 100, y + 20, ColColor($13), ColColor($15));
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                SDL_Delay(50 * (GameSpeed + 10));
                Redraw;

                k1 := min(pnum - 1, k - npage * pnum - 1);
                drawdizi(@Trole[0], mpnum, npage * pnum, npage * pnum + k1, k - 1, pnum, x, y, menudz);
                DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));
                for i := 0 to k1 do
                begin
                  if menuz = i then DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($5), ColColor($7))
                  else DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($15), ColColor($17));
                  if menud = i then DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor($5), ColColor($7))
                  else DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor(47), ColColor(49));
                end;
                str := format('%3d', [npage + 1]);
                word := '��     �';
                DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
                DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
                DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
                for i := 0 to 1 do
                  if i = menu then
                  begin
                    DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2,
                      ColColor($64), ColColor($66));
                  end
                  else
                  begin
                    DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
                  end;
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                continue;
              end
              else if trole[npage * pnum + menud] = 0 then
              begin
                Redraw;
                DrawShadowText(@strs[7][1], CENTER_X - 100, y + 20, ColColor($13), ColColor($15));
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                SDL_Delay(50 * (GameSpeed + 10));
                Redraw;

                k1 := min(pnum - 1, k - npage * pnum - 1);
                drawdizi(@Trole[0], mpnum, npage * pnum, npage * pnum + k1, k - 1, pnum, x, y, menudz);
                DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));
                for i := 0 to k1 do
                begin
                  if menuz = i then DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($5), ColColor($7))
                  else DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($15), ColColor($17));
                  if menud = i then DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor($5), ColColor($7))
                  else DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor(47), ColColor(49));
                end;
                str := format('%3d', [npage + 1]);
                word := '��     �';
                DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
                DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
                DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
                for i := 0 to 1 do
                  if i = menu then
                  begin
                    DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2,
                      ColColor($64), ColColor($66));
                  end
                  else
                  begin
                    DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
                  end;
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                continue;
              end
              else if Rrole[trole[npage * pnum + menud]].TeamState in [1, 2] then
              begin
                Redraw;
                DrawShadowText(@strs[8][1], CENTER_X - 100, y + 20, ColColor($13), ColColor($15));
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                SDL_Delay(50 * (GameSpeed + 10));
                Redraw;

                k1 := min(pnum - 1, k - npage * pnum - 1);
                drawdizi(@Trole[0], mpnum, npage * pnum, npage * pnum + k1, k - 1, pnum, x, y, menudz);
                DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));
                for i := 0 to k1 do
                begin
                  if menuz = i then DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($5), ColColor($7))
                  else DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($15), ColColor($17));
                  if menud = i then DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor($5), ColColor($7))
                  else DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor(47), ColColor(49));
                end;
                str := format('%3d', [npage + 1]);
                word := '��     �';
                DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
                DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
                DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
                for i := 0 to 1 do
                  if i = menu then
                  begin
                    DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2,
                      ColColor($64), ColColor($66));
                  end
                  else
                  begin
                    DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
                  end;
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                continue;
              end
              else if Rrole[trole[npage * pnum + menud]].dtime > 1 then
              begin
                Redraw;
                DrawShadowText(@strs[9][1], CENTER_X - 100, y + 20, ColColor($13), ColColor($15));
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                SDL_Delay(50 * (GameSpeed + 10));
                Redraw;

                k1 := min(pnum - 1, k - npage * pnum - 1);
                drawdizi(@Trole[0], mpnum, npage * pnum, npage * pnum + k1, k - 1, pnum, x, y, menudz);
                DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));
                for i := 0 to k1 do
                begin
                  if menuz = i then DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($5), ColColor($7))
                  else DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($15), ColColor($17));
                  if menud = i then DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor($5), ColColor($7))
                  else DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor(47), ColColor(49));
                end;
                str := format('%3d', [npage + 1]);
                word := '��     �';
                DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
                DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
                DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
                for i := 0 to 1 do
                  if i = menu then
                  begin
                    DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2,
                      ColColor($64), ColColor($66));
                  end
                  else
                  begin
                    DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
                  end;
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                continue;
              end
              else
              begin
                setrole(Rrole[trole[npage * pnum + menud]].weizhi, trole[npage * pnum + menud], 0);
                instruct_10(trole[npage * pnum + menud]);
                instruct_14;
                InitialScene;
                DrawScene;
                instruct_13;
                Redraw;

                k1 := min(pnum - 1, k - npage * pnum - 1);
                drawdizi(@Trole[0], mpnum, npage * pnum, npage * pnum + k1, k - 1, pnum, x, y, menudz);
                DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));
                for i := 0 to k1 do
                begin
                  if menuz = i then DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($5), ColColor($7))
                  else DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($15), ColColor($17));
                  if menud = i then DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor($5), ColColor($7))
                  else DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor(47), ColColor(49));
                end;
                str := format('%3d', [npage + 1]);
                word := '��     �';
                DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
                DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
                DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
                for i := 0 to 1 do
                  if i = menu then
                  begin
                    DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2,
                      ColColor($64), ColColor($66));
                  end
                  else
                  begin
                    DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
                  end;
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                continue;
              end;

            end;
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;

        end;
        SDL_MOUSEMOTION:
        begin
          if (event.button.x >= CENTER_X - 80) and (event.button.x < CENTER_X + w) and
            (event.button.y > y + 230) and (event.button.y < y + 259) then
          begin
            menuzp := menuz;
            menuz := -1;
            menudp := menud;
            menud := -1;
            menudzp := menudz;
            menudz := -1;
            menup := menu;
            menu := (event.button.x - CENTER_X + 47) div 50;
            if menu > 1 then
              menu := -1;
            if menu < 0 then
              menu := -1;
          end
          else if (event.button.x >= x + 500) and (event.button.x < x + 550) and
            (event.button.y > y + 25) and (event.button.y < y + 147 + 22 * k1) then
          begin
            menup := menu;
            menu := -1;
            menudp := menud;
            menud := -1;
            menudzp := menudz;
            menudz := -1;
            menuzp := menuz;
            menuz := (event.button.y - CENTER_Y + 80) div 22;
            if menuz > k1 then
              menuz := -1;
            if menuz < 0 then
              menuz := -1;
          end
          else if (event.button.x >= x - 20) and (event.button.x < x + 15) and
            (event.button.y > y + 25) and (event.button.y < y + 147 + 22 * k1) then
          begin
            menup := menu;
            menu := -1;
            menuzp := menuz;
            menuz := -1;
            menudzp := menudz;
            menudz := -1;
            menudp := menud;
            menud := (event.button.y - CENTER_Y + 80) div 22;
            if menud > k1 then
              menud := -1;
            if menud < 0 then
              menud := -1;
          end
          else if (event.button.x >= x + 20) and (event.button.x < x + 480) and
            (event.button.y > y + 75) and (event.button.y < y + 100 + 22 * k1) then
          begin
            menup := menu;
            menu := -1;
            menuzp := menuz;
            menuz := -1;
            menudp := menud;
            menud := -1;
            menudzp := menudz;
            menudz := (event.button.y - y - 75) div 22;
            if menudz > k1 then
              menudz := -1;
            if menudz < 0 then
              menudz := -1;
          end
          else
          begin
            menup := menu;
            menu := -1;
            menuzp := menuz;
            menuz := -1;
            menudp := menud;
            menud := -1;
            menudzp := menudz;
            menudz := -1;
          end;
          if (menup <> menu) or (menuzp <> menuz) or (menudp <> menud) or (menudzp <> menudz) then
          begin
            Redraw;

            k1 := min(pnum - 1, k - npage * pnum - 1);
            drawdizi(@Trole[0], mpnum, npage * pnum, npage * pnum + k1, k - 1, pnum, x, y, menudz);
            DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));
            for i := 0 to k1 do
            begin
              if menuz = i then DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($5), ColColor($7))
              else DrawShadowText(@strs[0][1], x + 480, y + 75 + 22 * i, ColColor($15), ColColor($17));
              if menud = i then DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor($5), ColColor($7))
              else DrawShadowText(@strs[5][1], x - 20, y + 75 + 22 * i, ColColor(47), ColColor(49));
            end;
            str := format('%3d', [npage + 1]);
            word := '��     �';
            DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
            DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
            DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
            for i := 0 to 1 do
              if i = menu then
              begin
                DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
              end
              else
              begin
                DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
              end;
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;

        end;

      end;
    end;
    //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
    event.key.keysym.sym := 0;
    event.button.button := 0;
    SDL_EnableKeyRepeat(30, 30);

  end;
end;

procedure drawdizi(Trole: psmallint; mpnum, bg, ed, max0, pnum, x, y, menu: integer);
var
  i, i1, i2, i3, n, k1: integer;
  strs: array[0..10] of WideString;
  word: WideString;
  wordtmp: array of array[0..5] of WideString;
begin
  n := 0;
  strs[0] := '����';
  strs[1] := '݅��';
  strs[2] := '��';
  strs[3] := '��B';
  strs[4] := '�Є�';
  strs[5] := 'λ��';
  strs[6] := ' ǰ�';
  strs[7] := ' ���';
  display_imgFromSurface(DIZI_PIC.pic, 0, 0);
  DrawRectangle(x - 30, y, 590, 315, 0, ColColor(255), 50);
  for i := 0 to 5 do
  begin
    DrawShadowText(@strs[i][1], x + 80 * i, y + 45, ColColor($5), ColColor($7));
  end;
  if (ed >= 0) and (max0 >= ed) and ((ed - bg) >= 0) then
  begin
    k1 := ed - bg;
    setlength(wordtmp, k1 + 1);
    if (menu >= 0) and (menu < pnum) then
      DrawRectangle(x + 10, y + 75 + 22 * (menu mod pnum), 540, 22, 0, ColColor(64), 20);
    i1 := bg;
    i := 0;
    if i1 > 0 then
      repeat
        begin
          Inc(Trole);
          Inc(i);
        end;
      until i > i1 - 1;
    repeat
      begin
        wordtmp[n][0] := gbktounicode(@Rrole[trole^].Name);
        wordtmp[n][1] := format('%3d', [Rrole[trole^].scsx + 1]);
        wordtmp[n][2] := '��ͨ';
        for i2 := 0 to 9 do
        begin
          if Rmenpai[mpnum].zhiwu[i2] = trole^ then
          begin
            wordtmp[n][2] := zhiwustr(i2);
            break;
          end;
        end;
        if iszhangmen(Rrole[trole^].ListNum, -2, 1, 2) = 1 then
          wordtmp[n][2] := '���T';
        wordtmp[n][3] := zhuangtaistr(trole^);
        wordtmp[n][4] := xingdongstr(trole^);
        wordtmp[n][5] := gbktounicode(@Rscene[Rrole[trole^].weizhi].Name);
        for i2 := 0 to 5 do
        begin
          DrawShadowText(@wordtmp[n][i2][1], x + 80 * i2, y + 75 + 22 * n, ColColor($41), ColColor($48));
        end;
        n := n + 1;
        if n > k1 then n := 0
        else Inc(trole);
        Inc(i1);
      end;
    until i1 > ed;
  end;
end;

procedure zhuchu(rnum: integer);
var
  strs: WideString;
  i, mpnum: integer;
begin
  mpnum := Rrole[rnum].MenPai;
  strs := gbktounicode(@Rrole[rnum].Name) + '�ѽ��x�_�ˎ��T��';
  for i := 0 to 9 do
    if Rmenpai[Rrole[rnum].menpai].zhiwu[i] = rnum then
    begin
      Rmenpai[Rrole[rnum].menpai].zhiwu[i] := -1;
      Inc(Rmenpai[mpnum].aziyuan[0], (20 + 10 * (i div 4)) div 30);
      Inc(Rmenpai[mpnum].aziyuan[1], (20 + 10 * (i div 4)) div 30);
      Inc(Rmenpai[mpnum].aziyuan[2], (20 + 10 * (i div 4)) div 30);
      Inc(Rmenpai[mpnum].aziyuan[3], (100 + 20 * (i div 4)) div 30);
    end;
  Rmenpai[Rrole[rnum].MenPai].dizi := Rmenpai[Rrole[rnum].MenPai].dizi - 1;
  Inc(Rmenpai[Rrole[rnum].MenPai].aziyuan[3]);
  Rrole[rnum].MenPai := -1;
  Rrole[rnum].weizhi := -1;
  Rrole[rnum].nweizhi := -1;
  Rrole[rnum].shifu := -1;
  Rrole[rnum].bssx := -1;
  Rrole[rnum].scsx := -1;
  Rrole[rnum].dtime := 0;
  if (rnum >= 300) and (rnum < 600) then Rrole[rnum].HeadNum := -1;
  if (Rrole[0].menpai > 0) and (Rrole[rnum].MenPai = Rrole[0].menpai) then
  begin
    addtips(strs);
  end;
end;

function xingdongstr(rnum: integer): WideString;
begin
  Result := 'δ�Є�';
  case Rrole[rnum].nweizhi of

    0..4: Result := '����';
    5..9: Result := '�ؽ�';
    10: Result := '�]�P';
    11: Result := '����';
    12: Result := '���';
    13: Result := '�S�';
    14: Result := '�Ƅ�';
    15: Result := '��';
    16: Result := '���Y';
    20: Result := '����';
  end;
end;

function zhiwustr(znum: integer): WideString;
begin
  case znum of
    0: Result := '��ʥʹ';
    1: Result := '��ʥʹ';
    2: Result := '�����o��';
    3: Result := '�׻��o��';
    4: Result := '��ȸ�o��';
    5: Result := '�����o��';
    6: Result := '����';
    7: Result := '�̷�';
    8: Result := '����';
    9: Result := '����';
    else
      Result := '��ͨ';

  end;
end;

function zhuangtaistr(rnum: integer): WideString;
var
  i, tmp1, tmp2: integer;
begin
  case Rrole[rnum].Hurt of
    34..66: tmp1 := 1;
    67..1000: tmp1 := 2;
    else
      tmp1 := 0;
  end;
  case Rrole[rnum].Poision of
    34..66: tmp2 := 1;
    67..1000: tmp2 := 2;
    else
      tmp2 := 0;
  end;
  Result := ('����');
  case tmp1 of
    1: Result := ('�p��');
    2: Result := ('�؂�');
  end;
  if tmp1 = 0 then
  begin
    case tmp2 of
      1: Result := ('�p��');
      2: Result := ('�ض�');
    end;
  end
  else
  begin
    case tmp2 of
      1: Result := Result + ('�p��');
      2: Result := Result + ('�ض�');
    end;
  end;

end;

procedure selectjianshe(snum: integer);
var
  x, y, i, i1, menu, menup, mpnum: integer;
  str: WideString;
  key: integer;
  ziyuan: array[0..4] of array[0..3] of integer;
  strs: array[0..1] of WideString;
begin
  if snum = -1 then
    mpnum := Rrole[0].menpai
  else
    mpnum := Rscene[snum].menpai;
  if mpnum < 0 then
    exit;
  Redraw;
  x := 40;
  y := CENTER_Y - 190;
  menu := 0;
  setlength(menuString, 6);
  menuString[0] := '�����������������';
  menuString[1] := '�������ؽ��񡷡���';
  menuString[2] := '�������]�P�w������';
  menuString[3] := '�����������t������';
  menuString[4] := '����������_������';
  menuString[5] := '���������޽�������';
  setlength(menustring2, 3);
  menustring2[1] := '�_��';
  menustring2[2] := 'ȡ��';

  strs[0] := 'ԓ�Ŀ�ѽ��_���ֵ���������޽���';
  strs[1] := '�YԴ���㣬�o�����죡';


  ziyuan[0][0] := 150;
  ziyuan[0][1] := 110;
  ziyuan[0][2] := 45;
  ziyuan[0][3] := 50;

  ziyuan[1][0] := 25;
  ziyuan[1][1] := 90;
  ziyuan[1][2] := 195;
  ziyuan[1][3] := 50;

  ziyuan[2][0] := 15;
  ziyuan[2][1] := 120;
  ziyuan[2][2] := 130;
  ziyuan[2][3] := 250;

  ziyuan[3][0] := 75;
  ziyuan[3][1] := 90;
  ziyuan[3][2] := 200;
  ziyuan[3][3] := 30;

  ziyuan[4][0] := 275;
  ziyuan[4][1] := 60;
  ziyuan[4][2] := 110;
  ziyuan[4][3] := 40;

  SDL_EnableKeyRepeat(10, 100);
  showjianshe(snum, x, y, menu);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYDown:
      begin
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          menu := menu + 1;
          if menu > 5 then
            menu := 0;
          Redraw;
          showjianshe(snum, x, y, menu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          menu := menu - 1;
          if menu < 0 then
            menu := 5;
          Redraw;
          showjianshe(snum, x, y, menu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;

      SDL_KEYUP:
      begin
        if ((event.key.keysym.sym = SDLK_ESCAPE)) then
        begin
          menu := 5;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          if menu = 5 then
          begin
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            break;
          end;
          key := 1;
          for i := 0 to 3 do
          begin
            if Rmenpai[mpnum].ziyuan[i] < ziyuan[menu][i] then
            begin
              key := 0;
              break;
            end;
          end;
          if key = 1 then
          begin
            case menu of
              0: menustring2[0] := '��_��Ҫ�޽�������᣿';
              1: menustring2[0] := '��_��Ҫ�޽��ؽ���᣿';
              2: menustring2[0] := '��_��Ҫ�޽��]�P�w�᣿';
              3: menustring2[0] := '��_��Ҫ�޽������t�᣿';
              4: menustring2[0] := '��_��Ҫ�޽�����_�᣿';

            end;
            key := commonmenu22(x + 100, y + 150, 240);
            if key = 0 then
            begin
              for i := 0 to 3 do
              begin
                Dec(Rmenpai[mpnum].ziyuan[i], ziyuan[menu][i]);
              end;
              SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
              break;
            end;
          end
          else
          begin
            DrawShadowText(@strs[1][1], CENTER_X - 120, 40, ColColor($5), ColColor($7));
            SDL_UpdateRect2(screen, 0, 0, 561, 316);
            SDL_Delay(50 * (GameSpeed + 10));
          end;

          Redraw;
          showjianshe(snum, x, y, menu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          menu := 5;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          if menu = 5 then
          begin
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            break;
          end;
          key := 1;
          for i := 0 to 3 do
          begin
            if Rmenpai[mpnum].ziyuan[i] < ziyuan[menu][i] then
            begin
              key := 0;
              break;
            end;
          end;
          if key = 1 then
          begin
            case menu of
              0: menustring2[0] := '��_��Ҫ�޽�������᣿';
              1: menustring2[0] := '��_��Ҫ�޽��ؽ���᣿';
              2: menustring2[0] := '��_��Ҫ�޽��]�P�w�᣿';
              3: menustring2[0] := '��_��Ҫ�޽������t�᣿';
              4: menustring2[0] := '��_��Ҫ�޽�����_�᣿';

            end;
            key := commonmenu22(x + 100, y + 150, 240);
            if key = 0 then
            begin
              for i := 0 to 3 do
              begin
                Dec(Rmenpai[mpnum].ziyuan[i], ziyuan[menu][i]);
              end;
              SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
              break;
            end;
          end
          else
          begin
            DrawShadowText(@strs[1][1], CENTER_X - 120, 40, ColColor($5), ColColor($7));
            SDL_UpdateRect2(screen, 0, 0, 561, 316);
            SDL_Delay(50 * (GameSpeed + 10));
          end;

          Redraw;
          showjianshe(snum, x, y, menu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x >= x + 15) and (event.button.x < x + 215) and (event.button.y > y + 70) and
          (event.button.y < y + 300) then
        begin
          menup := menu;
          menu := (event.button.y - y - 72) div 22;
          if menu > 5 then
            menu := 5;
          if menu < 0 then
            menu := 0;
          if menup <> menu then
          begin
            Redraw;
            showjianshe(snum, x, y, menu);
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;
        end;
      end;
    end;
  end;
  //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(30, 30);

  case menu of
    0:
    begin
      if Rscene[snum].lwc < Rscene[snum].zlwc then xiujian(snum, Rscene[snum].lwc + 1, ziyuan[0])
      else
      begin
        Redraw;
        DrawShadowText(@strs[0][1], CENTER_X - 140, y + 40, ColColor($13), ColColor($15));
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        SDL_Delay(80 * (GameSpeed + 10));
      end;
    end;
    1:
    begin
      if Rscene[snum].cjg < Rscene[snum].zcjg then xiujian(snum, Rscene[snum].cjg + 6, ziyuan[1])
      else
      begin
        Redraw;
        DrawShadowText(@strs[0][1], CENTER_X - 140, y + 40, ColColor($15), ColColor($17));
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        SDL_Delay(80 * (GameSpeed + 10));
      end;
    end;
    2:
    begin
      if Rscene[snum].bgskg < 1 then xiujian(snum, 10, ziyuan[2])
      else
      begin
        Redraw;
        DrawShadowText(@strs[0][1], CENTER_X - 140, y + 40, ColColor($15), ColColor($17));
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        SDL_Delay(80 * (GameSpeed + 10));
      end;
    end;
    3:
    begin
      if Rscene[snum].ldlkg < 1 then xiujian(snum, 11, ziyuan[3])
      else
      begin
        Redraw;
        DrawShadowText(@strs[0][1], CENTER_X - 140, y + 40, ColColor($15), ColColor($17));
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        SDL_Delay(80 * (GameSpeed + 10));
      end;
    end;
    4:
    begin
      if Rscene[snum].bqckg < 1 then xiujian(snum, 12, ziyuan[4])
      else
      begin
        Redraw;
        DrawShadowText(@strs[0][1], CENTER_X - 140, y + 40, ColColor($15), ColColor($17));
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        SDL_Delay(80 * (GameSpeed + 10));
      end;
    end;
    5: Redraw;
  end;
end;

procedure selectchaichu(snum: integer);
var
  x, y, i, i1, menu, menup, mpnum: integer;
  str: WideString;
  key: integer;
  ziyuan: array[0..4] of array[0..3] of integer;
  strs: array[0..1] of WideString;
begin
  mpnum := Rscene[snum].menpai;
  Redraw;
  x := 40;
  y := CENTER_Y - 190;
  menu := 0;
  setlength(menuString, 6);
  menuString[0] := '�����������������';
  menuString[1] := '�������ؽ��񡷡���';
  menuString[2] := '�������]�P�w������';
  menuString[3] := '�����������t������';
  menuString[4] := '����������_������';
  menuString[5] := '�����������������';
  setlength(menustring2, 3);
  menustring2[1] := '�_��';
  menustring2[2] := 'ȡ��';

  strs[0] := '���؛]��ԓ���B���o�������';
  strs[1] := '����һ��������o�������';

  ziyuan[0][0] := 150;
  ziyuan[0][1] := 110;
  ziyuan[0][2] := 45;
  ziyuan[0][3] := 50;

  ziyuan[1][0] := 25;
  ziyuan[1][1] := 90;
  ziyuan[1][2] := 195;
  ziyuan[1][3] := 50;

  ziyuan[2][0] := 15;
  ziyuan[2][1] := 120;
  ziyuan[2][2] := 130;
  ziyuan[2][3] := 250;

  ziyuan[3][0] := 75;
  ziyuan[3][1] := 90;
  ziyuan[3][2] := 200;
  ziyuan[3][3] := 30;

  ziyuan[4][0] := 275;
  ziyuan[4][1] := 60;
  ziyuan[4][2] := 110;
  ziyuan[4][3] := 40;

  SDL_EnableKeyRepeat(10, 100);
  showchaichu(snum, x, y, menu);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYDown:
      begin
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          menu := menu + 1;
          if menu > 5 then
            menu := 0;
          Redraw;
          showchaichu(snum, x, y, menu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          menu := menu - 1;
          if menu < 0 then
            menu := 5;
          Redraw;
          showchaichu(snum, x, y, menu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;

      SDL_KEYUP:
      begin
        if ((event.key.keysym.sym = SDLK_ESCAPE)) then
        begin
          menu := 5;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          if menu = 5 then
          begin
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            break;
          end;
          key := 1;
          if (menu = 0) and (Rscene[snum].lwc = 0) then
            key := 0;
          if key = 1 then
          begin
            case menu of
              0: menustring2[0] := '��_��Ҫ���������᣿';
              1: menustring2[0] := '��_��Ҫ����ؽ���᣿';
              2: menustring2[0] := '��_��Ҫ����]�P�w�᣿';
              3: menustring2[0] := '��_��Ҫ��������t�᣿';
              4: menustring2[0] := '��_��Ҫ�������_�᣿';

            end;
            key := commonmenu22(x + 100, y + 150, 240);
            if key = 0 then
            begin
              for i := 0 to 3 do
              begin
                Inc(Rmenpai[mpnum].ziyuan[i], ziyuan[menu][i] div 3);
              end;
              SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
              break;
            end;
          end
          else
          begin
            DrawShadowText(@strs[1][1], CENTER_X - 120, 40, ColColor($5), ColColor($7));
            SDL_UpdateRect2(screen, 0, 0, 561, 316);
            SDL_Delay(50 * (GameSpeed + 10));
          end;

          Redraw;
          showchaichu(snum, x, y, menu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          menu := 5;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          if menu = 5 then
          begin
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            break;
          end;
          key := 1;
          if (menu = 0) and (Rscene[snum].lwc = 0) then
            key := 0;
          if key = 1 then
          begin
            case menu of
              0: menustring2[0] := '��_��Ҫ���������᣿';
              1: menustring2[0] := '��_��Ҫ����ؽ���᣿';
              2: menustring2[0] := '��_��Ҫ����]�P�w�᣿';
              3: menustring2[0] := '��_��Ҫ��������t�᣿';
              4: menustring2[0] := '��_��Ҫ�������_�᣿';

            end;
            key := commonmenu22(x + 100, y + 150, 240);
            if key = 0 then
            begin
              for i := 0 to 3 do
              begin
                Inc(Rmenpai[mpnum].ziyuan[i], ziyuan[menu][i] div 3);
              end;
              SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
              break;
            end;
          end
          else
          begin
            DrawShadowText(@strs[1][1], CENTER_X - 120, 40, ColColor($5), ColColor($7));
            SDL_UpdateRect2(screen, 0, 0, 561, 316);
            SDL_Delay(50 * (GameSpeed + 10));
          end;

          Redraw;
          showchaichu(snum, x, y, menu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x >= x + 15) and (event.button.x < x + 215) and (event.button.y > y + 70) and
          (event.button.y < y + 300) then
        begin
          menup := menu;
          menu := (event.button.y - y - 72) div 22;
          if menu > 5 then
            menu := 5;
          if menu < 0 then
            menu := 0;
          if menup <> menu then
          begin
            Redraw;
            showchaichu(snum, x, y, menu);
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;
        end;
      end;
    end;
  end;
  //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(30, 30);

  case menu of
    0:
    begin
      if Rscene[snum].lwc >= 0 then chaichu(snum, Rscene[snum].lwc, ziyuan[0])
      else
      begin
        Redraw;
        DrawShadowText(@strs[0][1], CENTER_X - 140, y + 40, ColColor($13), ColColor($15));
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        SDL_Delay(80 * (GameSpeed + 10));
      end;
    end;
    1:
    begin
      if Rscene[snum].cjg >= 0 then chaichu(snum, Rscene[snum].cjg + 5, ziyuan[1])
      else
      begin
        Redraw;
        DrawShadowText(@strs[0][1], CENTER_X - 140, y + 40, ColColor($15), ColColor($17));
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        SDL_Delay(80 * (GameSpeed + 10));
      end;
    end;
    2:
    begin
      if Rscene[snum].bgskg = 1 then chaichu(snum, 10, ziyuan[2])
      else
      begin
        Redraw;
        DrawShadowText(@strs[0][1], CENTER_X - 140, y + 40, ColColor($15), ColColor($17));
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        SDL_Delay(80 * (GameSpeed + 10));
      end;
    end;
    3:
    begin
      if Rscene[snum].ldlkg = 1 then chaichu(snum, 11, ziyuan[3])
      else
      begin
        Redraw;
        DrawShadowText(@strs[0][1], CENTER_X - 140, y + 40, ColColor($15), ColColor($17));
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        SDL_Delay(80 * (GameSpeed + 10));
      end;
    end;
    4:
    begin
      if Rscene[snum].bqckg = 1 then chaichu(snum, 12, ziyuan[4])
      else
      begin
        Redraw;
        DrawShadowText(@strs[0][1], CENTER_X - 140, y + 40, ColColor($15), ColColor($17));
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        SDL_Delay(80 * (GameSpeed + 10));
      end;
    end;
    5: Redraw;
  end;
end;

procedure showjianshe(snum, x, y, menu: integer);
var
  i, mpnum: integer;
  strs: array[0..9] of WideString;
  tmp1, tmp2: array[0..4] of WideString;
  zyname: array[0..3] of WideString;
  str: WideString;
  ziyuan: array[0..4] of array[0..3] of integer;
begin
  if snum = -1 then
    mpnum := Rrole[0].menpai
  else
    mpnum := Rscene[snum].menpai;
  if mpnum < 0 then
    exit;
  zyname[0] := '�F�V';
  zyname[1] := 'ʯ��';
  zyname[2] := 'ľ��';
  zyname[3] := 'ʳ��';
  ziyuan[0][0] := 150;
  ziyuan[0][1] := 110;
  ziyuan[0][2] := 45;
  ziyuan[0][3] := 50;

  ziyuan[1][0] := 25;
  ziyuan[1][1] := 90;
  ziyuan[1][2] := 195;
  ziyuan[1][3] := 50;

  ziyuan[2][0] := 15;
  ziyuan[2][1] := 120;
  ziyuan[2][2] := 130;
  ziyuan[2][3] := 250;

  ziyuan[3][0] := 75;
  ziyuan[3][1] := 90;
  ziyuan[3][2] := 200;
  ziyuan[3][3] := 30;

  ziyuan[4][0] := 275;
  ziyuan[4][1] := 60;
  ziyuan[4][2] := 110;
  ziyuan[4][3] := 40;

  for i := 0 to 4 do
  begin
    tmp1[i] := '';
    tmp2[i] := '';
  end;


  tmp1[0] := format('%3d', [Rscene[snum].lwc + 1]);
  tmp2[0] := format('%3d', [Rscene[snum].zlwc + 1]);
  strs[0] := '������� ������� ����';
  tmp1[1] := format('%3d', [Rscene[snum].cjg + 1]);
  tmp2[1] := format('%3d', [Rscene[snum].zcjg + 1]);
  strs[1] := '�ؽ��� ������� ����';
  tmp1[2] := format('%3d', [Rscene[snum].bgskg]);
  strs[2] := '�]�P�w�� ��';
  tmp1[3] := format('%3d', [Rscene[snum].ldlkg]);
  strs[3] := '�����t�� ��';
  tmp1[4] := format('%3d', [Rscene[snum].bqckg]);
  strs[4] := '����_�� ��';

  strs[5] := '�ѽ��޽����Oʩ��';
  strs[6] := '�����޽����Oʩ��';
  strs[7] := '����ɱ���';
  strs[8] := '�S�ֳɱ���';
  strs[9] := '����YԴ��';

  display_imgFromSurface(JIANSHE_PIC.pic, 0, 0);
  DrawRectangle(x, y, 560, 385, 0, ColColor(255), 30);
  DrawRectangle(x + 260, y + 220, 280, 155, 0, ColColor(255), 50);
  DrawRectangle(x + 260, y + 25, 280, 90, 0, ColColor(255), 50);
  DrawRectangle(x + 260, y + 120, 280, 90, 0, ColColor(255), 50);
  DrawRectangle(x + 15, y + 250, 220, 100, 0, ColColor(255), 50);
  DrawShadowText(@strs[5][1], x + 270, y + 225, ColColor($5), ColColor($7));
  DrawShadowText(@strs[6][1], x + 15, y + 30, ColColor($5), ColColor($7));
  DrawShadowText(@strs[7][1], x + 270, y + 30, ColColor($5), ColColor($7));
  DrawShadowText(@strs[8][1], x + 270, y + 125, ColColor($5), ColColor($7));
  DrawShadowText(@strs[9][1], x + 15, y + 265, ColColor($5), ColColor($7));
  for i := 0 to 4 do
  begin
    DrawShadowText(@strs[i][1], x + 270, y + 258 + i * 22, ColColor($5), ColColor($7));
    if tmp1[i] <> '' then DrawShadowText(@tmp1[i][1], x + 340, y + 256 + i * 22, ColColor($5), ColColor($7));

    if tmp2[i] <> '' then DrawShadowText(@tmp2[i][1], x + 430, y + 256 + i * 22, ColColor($5), ColColor($7));
  end;

  if menu < 5 then
  begin
    for i := 0 to 3 do
    begin
      if ziyuan[menu][i] > 0 then
      begin
        DrawShadowText(@zyname[i][1], x + 270 + 120 * (i mod 2), y + 60 + 22 * (i div 2),
          ColColor($66), ColColor($68));
        str := IntToStr(ziyuan[menu][i]);
        DrawShadowText(@str[1], x + 325 + 120 * (i mod 2), y + 60 + 22 * (i div 2), ColColor($66), ColColor($68));
      end;
    end;

    for i := 0 to 3 do
    begin
      if ziyuan[menu][i] > 0 then
      begin
        DrawShadowText(@zyname[i][1], x + 270 + 120 * (i mod 2), y + 155 + 22 * (i div 2),
          ColColor($13), ColColor($15));
        str := IntToStr(ziyuan[menu][i] div 30);
        DrawShadowText(@str[1], x + 325 + 120 * (i mod 2), y + 155 + 22 * (i div 2), ColColor($13), ColColor($15));
      end;
    end;
  end;
  for i := 0 to 3 do
  begin
    DrawShadowText(@zyname[i][1], x + 15 + 100 * (i mod 2), y + 290 + 22 * (i div 2), ColColor($5), ColColor($7));
    str := IntToStr(Rmenpai[mpnum].ziyuan[i]);
    DrawShadowText(@str[1], x + 70 + 100 * (i mod 2), y + 290 + 22 * (i div 2), ColColor($30), ColColor($32));
  end;
  showcommonMenun(x + 15, y + 70, 200, 5, menu);
end;

procedure showchaichu(snum, x, y, menu: integer);
var
  i, mpnum: integer;
  strs: array[0..9] of WideString;
  tmp1, tmp2: array[0..4] of WideString;
  zyname: array[0..3] of WideString;
  str: WideString;
  ziyuan: array[0..4] of array[0..3] of integer;
begin

  mpnum := Rscene[snum].menpai;
  zyname[0] := '�F�V';
  zyname[1] := 'ʯ��';
  zyname[2] := 'ľ��';
  zyname[3] := 'ʳ��';
  ziyuan[0][0] := 150;
  ziyuan[0][1] := 110;
  ziyuan[0][2] := 45;
  ziyuan[0][3] := 50;

  ziyuan[1][0] := 25;
  ziyuan[1][1] := 90;
  ziyuan[1][2] := 195;
  ziyuan[1][3] := 50;

  ziyuan[2][0] := 15;
  ziyuan[2][1] := 120;
  ziyuan[2][2] := 130;
  ziyuan[2][3] := 250;

  ziyuan[3][0] := 75;
  ziyuan[3][1] := 90;
  ziyuan[3][2] := 200;
  ziyuan[3][3] := 30;

  ziyuan[4][0] := 275;
  ziyuan[4][1] := 60;
  ziyuan[4][2] := 110;
  ziyuan[4][3] := 40;

  for i := 0 to 4 do
  begin
    tmp1[i] := '';
    tmp2[i] := '';
  end;


  tmp1[0] := format('%3d', [Rscene[snum].lwc + 1]);
  tmp2[0] := format('%3d', [Rscene[snum].zlwc + 1]);
  strs[0] := '������� ������� ����';
  tmp1[1] := format('%3d', [Rscene[snum].cjg + 1]);
  tmp2[1] := format('%3d', [Rscene[snum].zcjg + 1]);
  strs[1] := '�ؽ��� ������� ����';
  tmp1[2] := format('%3d', [Rscene[snum].bgskg]);
  strs[2] := '�]�P�w�� ��';
  tmp1[3] := format('%3d', [Rscene[snum].ldlkg]);
  strs[3] := '�����t�� ��';
  tmp1[4] := format('%3d', [Rscene[snum].bqckg]);
  strs[4] := '����_�� ��';

  strs[5] := '�ѽ��޽����Oʩ��';
  strs[6] := '��Ҫ������Oʩ��';
  strs[7] := '�����YԴ��';
  strs[8] := '�S�ֳɱ���';
  strs[9] := '����YԴ��';

  display_imgFromSurface(JIANSHE_PIC.pic, 0, 0);
  DrawRectangle(x, y, 560, 385, 0, ColColor(255), 30);
  DrawRectangle(x + 260, y + 220, 280, 155, 0, ColColor(255), 50);
  DrawRectangle(x + 260, y + 25, 280, 90, 0, ColColor(255), 50);
  DrawRectangle(x + 260, y + 120, 280, 90, 0, ColColor(255), 50);
  DrawRectangle(x + 15, y + 250, 220, 100, 0, ColColor(255), 50);
  DrawShadowText(@strs[5][1], x + 270, y + 225, ColColor($5), ColColor($7));
  DrawShadowText(@strs[6][1], x + 15, y + 30, ColColor($5), ColColor($7));
  DrawShadowText(@strs[7][1], x + 270, y + 30, ColColor($5), ColColor($7));
  DrawShadowText(@strs[8][1], x + 270, y + 125, ColColor($5), ColColor($7));
  DrawShadowText(@strs[9][1], x + 15, y + 265, ColColor($5), ColColor($7));
  for i := 0 to 4 do
  begin
    DrawShadowText(@strs[i][1], x + 270, y + 258 + i * 22, ColColor($5), ColColor($7));
    if tmp1[i] <> '' then DrawShadowText(@tmp1[i][1], x + 340, y + 256 + i * 22, ColColor($5), ColColor($7));

    if tmp2[i] <> '' then DrawShadowText(@tmp2[i][1], x + 430, y + 256 + i * 22, ColColor($5), ColColor($7));
  end;

  if menu < 5 then
  begin
    for i := 0 to 3 do
    begin
      if ziyuan[menu][i] > 0 then
      begin
        DrawShadowText(@zyname[i][1], x + 270 + 120 * (i mod 2), y + 60 + 22 * (i div 2),
          ColColor($66), ColColor($68));
        str := IntToStr(ziyuan[menu][i] div 3);
        DrawShadowText(@str[1], x + 325 + 120 * (i mod 2), y + 60 + 22 * (i div 2), ColColor($66), ColColor($68));
      end;
    end;

    for i := 0 to 3 do
    begin
      if ziyuan[menu][i] > 0 then
      begin
        DrawShadowText(@zyname[i][1], x + 270 + 120 * (i mod 2), y + 155 + 22 * (i div 2),
          ColColor($13), ColColor($15));
        str := IntToStr(ziyuan[menu][i] div 30);
        DrawShadowText(@str[1], x + 325 + 120 * (i mod 2), y + 155 + 22 * (i div 2), ColColor($13), ColColor($15));
      end;
    end;
  end;
  for i := 0 to 3 do
  begin
    DrawShadowText(@zyname[i][1], x + 15 + 100 * (i mod 2), y + 290 + 22 * (i div 2), ColColor($5), ColColor($7));
    str := IntToStr(Rmenpai[mpnum].ziyuan[i]);
    DrawShadowText(@str[1], x + 70 + 100 * (i mod 2), y + 290 + 22 * (i div 2), ColColor($30), ColColor($32));
  end;
  showcommonMenun(x + 15, y + 70, 200, 5, menu);
end;

procedure xiujian(snum, xnum: integer; ziyuan: array of integer);
var
  tmpx, tmpy: integer;
  word, tmp: WideString;
begin
  Dec(Rmenpai[Rscene[snum].menpai].aziyuan[0], ziyuan[0] div 30);
  Dec(Rmenpai[Rscene[snum].menpai].aziyuan[1], ziyuan[1] div 30);
  Dec(Rmenpai[Rscene[snum].menpai].aziyuan[2], ziyuan[2] div 30);
  Dec(Rmenpai[Rscene[snum].menpai].aziyuan[3], ziyuan[3] div 30);
  if ((xnum > -1) and (xnum < 5)) then
  begin
    tmpy := Rscene[snum].lwcx[xnum];
    tmpx := Rscene[snum].lwcy[xnum];
    DData[snum, SData[snum, 3, tmpx, tmpy], 0] := 1;
    //DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 2568 ;
    DData[snum, SData[snum, 3, tmpx, tmpy], 15] := 0;
    Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 19;
    Rscene[snum].lwc := Rscene[snum].lwc + 1;
    instruct_14;
    InitialScene;
    DrawScene;
    instruct_13;
    tmp := format('%3d', [Rscene[snum].lwc + 1]);
    word := '����� �ѽ��޽�';
    DrawShadowText(@word[1], CENTER_X - 80, CENTER_Y - 150, ColColor($5), ColColor($7));
    DrawShadowText(@tmp[1], CENTER_X - 40, CENTER_Y - 150, ColColor($5), ColColor($7));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay(50 * (GameSpeed + 10));
  end;
  if ((xnum > 4) and (xnum < 10)) then
  begin
    tmpy := Rscene[snum].cjgx[xnum - 5];
    tmpx := Rscene[snum].cjgy[xnum - 5];
    DData[snum, SData[snum, 3, tmpx, tmpy], 0] := 1;
    //DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 2404 ;
    DData[snum, SData[snum, 3, tmpx, tmpy], 15] := 0;
    Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 20;
    Rscene[snum].cjg := Rscene[snum].cjg + 1;
    instruct_14;
    InitialScene;
    DrawScene;
    instruct_13;
    tmp := format('%3d', [Rscene[snum].cjg + 1]);
    word := '�ؽ��� �ѽ��޽�';

    DrawShadowText(@word[1], CENTER_X - 80, CENTER_Y - 150, ColColor($5), ColColor($7));
    DrawShadowText(@tmp[1], CENTER_X - 40, CENTER_Y - 150, ColColor($5), ColColor($7));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay(50 * (GameSpeed + 10));
  end;
  if xnum = 10 then
  begin
    tmpy := Rscene[snum].bgsx;
    tmpx := Rscene[snum].bgsy;
    DData[snum, SData[snum, 3, tmpx, tmpy], 0] := 1;
    //DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 2898 ;
    DData[snum, SData[snum, 3, tmpx, tmpy], 15] := 0;
    Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 21;
    Rscene[snum].bgskg := 1;
    instruct_14;
    InitialScene;
    DrawScene;
    instruct_13;
    word := '�]�P�w�ѽ��޽�';
    DrawShadowText(@word[1], CENTER_X - 85, CENTER_Y - 150, ColColor($5), ColColor($7));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay(50 * (GameSpeed + 10));
  end;
  if xnum = 11 then
  begin
    tmpy := Rscene[snum].ldlx;
    tmpx := Rscene[snum].ldly;
    DData[snum, SData[snum, 3, tmpx, tmpy], 0] := 1;
    //DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 2702 ;
    DData[snum, SData[snum, 3, tmpx, tmpy], 15] := 0;
    Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 22;
    Rscene[snum].ldlkg := 1;
    instruct_14;
    InitialScene;
    DrawScene;
    instruct_13;
    word := '�����t�ѽ��޽�';
    DrawShadowText(@word[1], CENTER_X - 85, CENTER_Y - 150, ColColor($5), ColColor($7));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay(50 * (GameSpeed + 10));
  end;
  if xnum = 12 then
  begin
    tmpy := Rscene[snum].bqcx;
    tmpx := Rscene[snum].bqcy;
    DData[snum, SData[snum, 3, tmpx, tmpy], 0] := 1;
    //DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 2620;
    DData[snum, SData[snum, 3, tmpx, tmpy], 15] := 0;
    Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 23;
    Rscene[snum].bqckg := 1;
    instruct_14;
    InitialScene;
    DrawScene;
    instruct_13;
    word := '����_�ѽ��޽�';
    DrawShadowText(@word[1], CENTER_X - 85, CENTER_Y - 150, ColColor($5), ColColor($7));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay(50 * (GameSpeed + 10));
  end;
end;

procedure chaichu(snum, xnum: integer; ziyuan: array of integer);
var
  tmpx, tmpy: integer;
  word, tmp: WideString;
begin
  Inc(Rmenpai[Rscene[snum].menpai].aziyuan[0], ziyuan[0] div 30);
  Inc(Rmenpai[Rscene[snum].menpai].aziyuan[1], ziyuan[1] div 30);
  Inc(Rmenpai[Rscene[snum].menpai].aziyuan[2], ziyuan[2] div 30);
  Inc(Rmenpai[Rscene[snum].menpai].aziyuan[3], ziyuan[3] div 30);

  if ((xnum > -1) and (xnum < 5)) then
  begin
    tmpy := Rscene[snum].lwcx[xnum] + 1;
    tmpx := Rscene[snum].lwcy[xnum];
    DData[snum, SData[snum, 3, tmpx, tmpy], 0] := 0;
    DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 0;
    Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 0;
    SceAnpai[snum][xnum] := -1;

    tmpy := tmpy - 1;
    DData[snum, SData[snum, 3, tmpx, tmpy], 15] := 1;

    Rscene[snum].lwc := Rscene[snum].lwc - 1;
    instruct_14;
    InitialScene;
    DrawScene;
    instruct_13;
    tmp := format('%3d', [Rscene[snum].lwc + 2]);
    word := '����� �ѽ����';
    DrawShadowText(@word[1], CENTER_X - 80, CENTER_Y - 150, ColColor($5), ColColor($7));
    DrawShadowText(@tmp[1], CENTER_X - 40, CENTER_Y - 150, ColColor($5), ColColor($7));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay(50 * (GameSpeed + 10));
  end;
  if ((xnum > 4) and (xnum < 10)) then
  begin
    tmpy := Rscene[snum].cjgx[xnum - 5];
    tmpx := Rscene[snum].cjgy[xnum - 5] + 1;
    Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 0] := 0;
    DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 0;
    Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 0;
    SceAnpai[snum][xnum] := -1;

    tmpx := tmpx - 1;
    DData[snum, SData[snum, 3, tmpx, tmpy], 15] := 1;
    Rscene[snum].cjg := Rscene[snum].cjg - 1;
    instruct_14;
    InitialScene;
    DrawScene;
    instruct_13;
    tmp := format('%3d', [Rscene[snum].cjg + 2]);
    word := '�ؽ��� �ѽ����';

    DrawShadowText(@word[1], CENTER_X - 80, CENTER_Y - 150, ColColor($5), ColColor($7));
    DrawShadowText(@tmp[1], CENTER_X - 40, CENTER_Y - 150, ColColor($5), ColColor($7));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay(50 * (GameSpeed + 10));
  end;
  if xnum = 10 then
  begin
    tmpy := Rscene[snum].bgsx;
    tmpx := Rscene[snum].bgsy + 1;
    Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 0] := 0;
    DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 0;
    Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 0;
    SceAnpai[snum][10] := -1;

    tmpx := tmpx - 1;
    DData[snum, SData[snum, 3, tmpx, tmpy], 15] := 1;
    Rscene[snum].bgskg := 0;
    instruct_14;
    InitialScene;
    DrawScene;
    instruct_13;
    word := '�]�P�w�ѽ����';
    DrawShadowText(@word[1], CENTER_X - 85, CENTER_Y - 150, ColColor($5), ColColor($7));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay(50 * (GameSpeed + 10));
  end;
  if xnum = 11 then
  begin
    tmpy := Rscene[snum].ldlx + 1;
    tmpx := Rscene[snum].ldly;
    Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 0] := 0;
    DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 0;
    Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 0;
    SceAnpai[snum][11] := -1;

    tmpy := tmpy - 1;
    DData[snum, SData[snum, 3, tmpx, tmpy], 15] := 1;
    Rscene[snum].ldlkg := 0;
    instruct_14;
    InitialScene;
    DrawScene;
    instruct_13;
    word := '�����t�ѽ����';
    DrawShadowText(@word[1], CENTER_X - 85, CENTER_Y - 150, ColColor($5), ColColor($7));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay(50 * (GameSpeed + 10));
  end;
  if xnum = 12 then
  begin
    tmpy := Rscene[snum].bqcx;
    tmpx := Rscene[snum].bqcy - 1;
    Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 0] := 0;
    DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 0;
    Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 0;
    SceAnpai[snum][12] := -1;

    tmpx := tmpx + 1;

    DData[snum, SData[snum, 3, tmpx, tmpy], 15] := 1;

    Rscene[snum].bqckg := 0;
    instruct_14;
    InitialScene;
    DrawScene;
    instruct_13;
    word := '����_�ѽ����';
    DrawShadowText(@word[1], CENTER_X - 85, CENTER_Y - 150, ColColor($5), ColColor($7));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay(50 * (GameSpeed + 10));
  end;
end;

procedure showrenming(mpnum: integer);
var
  x, y, i, j, k, menu, menudz, menup: integer;
  Trole: array of smallint;
  str: WideString;
begin
  Redraw;
  x := 40;
  y := CENTER_Y - 160;
  menu := -1;

  k := 0;
  for i := 0 to length(Rrole) - 1 do
  begin
    if (i <> Rmenpai[mpnum].zmr) and (Rrole[i].menpai = mpnum) and (Rrole[i].nweizhi <> 20) then
    begin
      setlength(trole, k + 1);
      trole[k] := i;
      k := k + 1;
    end;
  end;
  drawrenming(mpnum, menu);
  SDL_EnableKeyRepeat(10, 100);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if ((event.key.keysym.sym = SDLK_ESCAPE)) then
        begin
          menu := -1;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          menu := -1;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) and (menu > -1) then
        begin

          if (Rmenpai[mpnum].ziyuan[0] > 20 + 10 * ((menu - 9) div 4)) and
            (Rmenpai[mpnum].ziyuan[1] > 20 + 10 * ((menu - 9) div 4)) and
            (Rmenpai[mpnum].ziyuan[2] > 20 + 10 * ((menu - 9) div 4)) and
            (Rmenpai[mpnum].ziyuan[3] > 100 + 20 * ((menu - 9) div 4)) then
          begin
            menudz := selectdizi(@trole[0], mpnum, k - 1, menu, x, y);
            if menudz >= 0 then
            begin
              for i := 0 to 9 do
                if Rmenpai[mpnum].zhiwu[i] = Trole[menudz] then
                begin
                  Rmenpai[mpnum].zhiwu[i] := -1;
                  Inc(Rmenpai[mpnum].aziyuan[0], (20 + 10 * ((9 - i) div 4)) div 30);
                  Inc(Rmenpai[mpnum].aziyuan[1], (20 + 10 * ((9 - i) div 4)) div 30);
                  Inc(Rmenpai[mpnum].aziyuan[2], (20 + 10 * ((9 - i) div 4)) div 30);
                  Inc(Rmenpai[mpnum].aziyuan[3], (100 + 20 * ((9 - i) div 4)) div 30);
                end;
              Rmenpai[mpnum].zhiwu[menu] := Trole[menudz];
              Dec(Rmenpai[mpnum].ziyuan[0], 20 + 10 * ((9 - menu) div 4));
              Dec(Rmenpai[mpnum].ziyuan[1], 20 + 10 * ((9 - menu) div 4));
              Dec(Rmenpai[mpnum].ziyuan[2], 20 + 10 * ((9 - menu) div 4));
              Dec(Rmenpai[mpnum].ziyuan[3], 100 + 20 * ((9 - menu) div 4));
              Dec(Rmenpai[mpnum].aziyuan[0], (20 + 10 * ((9 - menu) div 4)) div 30);
              Dec(Rmenpai[mpnum].aziyuan[1], (20 + 10 * ((9 - menu) div 4)) div 30);
              Dec(Rmenpai[mpnum].aziyuan[2], (20 + 10 * ((9 - menu) div 4)) div 30);
              Dec(Rmenpai[mpnum].aziyuan[3], (100 + 20 * ((9 - menu) div 4)) div 30);
            end;
            menu := -1;
            Redraw;
            drawrenming(mpnum, menu);
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end
          else
          begin
            str := '�YԴ���㣬�o��������';
            DrawShadowText(@str[1], CENTER_X - 85, CENTER_Y - 150, ColColor($5), ColColor($7));
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            SDL_Delay(50 * (GameSpeed + 10));
          end;

        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x > x + 160) and (event.button.x < x + 395) and (event.button.y > y + 90) and
          (event.button.y < y + 114) then
        begin
          menup := menu;
          menu := (event.button.x - x - 160) div 140;
          if menu > 1 then
            menu := -1;
          if menu < 0 then
            menu := -1;
        end
        else if (event.button.x > x + 40) and (event.button.x < x + 515) and
          (event.button.y > y + 175) and (event.button.y < y + 199) then
        begin
          menup := menu;
          menu := (event.button.x - x - 40) div 120 + 2;
          if menu > 5 then
            menu := -1;
          if menu < 2 then
            menu := -1;
        end
        else if (event.button.x > x + 40) and (event.button.x < x + 515) and
          (event.button.y > y + 260) and (event.button.y < y + 284) then
        begin
          menup := menu;
          menu := (event.button.x - x - 40) div 120 + 6;
          if menu > 9 then
            menu := -1;
          if menu < 6 then
            menu := -1;
        end
        else
        begin
          menup := menu;
          menu := -1;
        end;
        if menup <> menu then
        begin
          Redraw;
          drawrenming(mpnum, menu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;

      end;
    end;
  end;
  //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(30, 30);

end;

procedure drawrenming(mpnum, menu: integer);
var
  x, y, i, j: integer;
  strs: array[0..11] of WideString;
  names: array[0..9] of WideString;
  Trole: array[0..9] of integer;
begin
  Redraw;
  x := 40;
  y := CENTER_Y - 160;

  strs[0] := '��ʥʹ';
  strs[1] := '��ʥʹ';
  strs[2] := '�����o��';
  strs[3] := '�׻��o��';
  strs[4] := '��ȸ�o��';
  strs[5] := '�����o��';
  strs[6] := ' ����ʹ';
  strs[7] := ' �̷�ʹ';
  strs[8] := ' ����ʹ';
  strs[9] := ' ����ʹ';
  strs[10] := '�����������������������T���ա���������������������';
  strs[11] := '��������Ҫ������Դ�e�������xʽ��';

  for j := 0 to 9 do
    names[j] := '';

  for i := 0 to length(Rrole) - 1 do
    for j := 0 to 9 do
      if (Rmenpai[mpnum].zhiwu[j] = i) then
      begin
        Trole[j] := i;
        names[j] := gbktounicode(@Rrole[i].Name);
      end;
  display_imgFromSurface(RENMING_PIC.pic, 0, 0);
  DrawRectangle(x, y, 560, 340, 0, ColColor(255), 30);
  DrawShadowText(@strs[10][1], x + 15, y + 20, ColColor(249), ColColor(252));
  DrawShadowText(@strs[11][1], x + 15, y + 310, ColColor($5), ColColor($7));
  for i := 0 to 1 do
  begin
    DrawRectangle(x + 160 + 140 * i, y + 60, 95, 24, ColColor(5), ColColor(255), 50);
    DrawShadowText(@strs[i][1], x + 160 + 140 * i, y + 60, ColColor($13), ColColor($15));
    if menu = i then DrawRectangle(x + 160 + 140 * i, y + 90, 95, 24, ColColor(64), ColColor(68), 50)
    else DrawRectangle(x + 160 + 140 * i, y + 90, 95, 24, ColColor(192), ColColor(255), 50);
    DrawShadowText(@names[i][1], x + 151 + 140 * i + (95 - length(names[i]) * 20) div 2, y +
      90, ColColor($5), ColColor($7));
  end;
  for i := 2 to 5 do
  begin
    DrawRectangle(x - 200 + 120 * i, y + 145, 115, 24, ColColor(5), ColColor(255), 50);
    DrawShadowText(@strs[i][1], x - 200 + 120 * i, y + 145, ColColor($13), ColColor($15));

    if menu = i then DrawRectangle(x - 200 + 120 * i, y + 175, 115, 24, ColColor(64), ColColor(68), 50)
    else DrawRectangle(x - 200 + 120 * i, y + 175, 115, 24, ColColor(192), ColColor(255), 50);
    DrawShadowText(@names[i][1], x - 209 + 120 * i + (115 - length(names[i]) * 20) div 2, y +
      175, ColColor($5), ColColor($7));
  end;
  for i := 6 to 9 do
  begin
    DrawRectangle(x - 680 + 120 * i, y + 230, 115, 24, ColColor(5), ColColor(255), 50);
    DrawShadowText(@strs[i][1], x - 680 + 120 * i, y + 230, ColColor($13), ColColor($15));

    if menu = i then DrawRectangle(x - 680 + 120 * i, y + 260, 115, 24, ColColor(64), ColColor(68), 50)
    else DrawRectangle(x - 680 + 120 * i, y + 260, 115, 24, ColColor(192), ColColor(255), 50);
    DrawShadowText(@names[i][1], x - 689 + 120 * i + (115 - length(names[i]) * 20) div 2, y +
      260, ColColor($5), ColColor($7));
  end;
end;

function selectdizi(trole: psmallint; mpnum, max0, menu, x, y: integer): integer;
var
  i, j, k1, pnum, page, npage, menupage, menupp, menudzp, menudz: integer;
  str, word: WideString;
  strs: array[0..11] of WideString;
begin
  Redraw;
  Result := -1;
  menupage := -1;
  menudz := -1;
  strs[0] := '��ʥʹ '; //�M�����Y�r�S�C��Ԯ��ƽ�r���܎��I�o�µ������΄�
  strs[1] := '��ʥʹ '; //�M�����Y�r�S�C��Ԯ��ƽ�r���܎��I�o�µ������΄�
  strs[2] := '�����o�� '; //�T�ɷ��R���Y�r��ÿ�غϻ֏��`����� ������ľ�ġ���̿����ˎ�a��
  strs[3] := '�׻��o�� '; //�T�ɷ��R���Y�r��ÿ�غϻ֏͚�����ж����Ȃ� �������F�V����̿�����ݮa��
  strs[4] := '��ȸ�o�� '; //�T�ɷ��R���Y�r��ÿ�غϻ֏��������w��������ʳ���̿����ľ�a��
  strs[5] := '�����o�� '; //�T�ɷ��R���Y�r��ÿ�غϻ֏�Ӳ�������� ������ʯ�ġ���̿��ϡ��a��
  strs[6] := ' ����ʹ '; //������Ͳؽ��w���������Y���
  strs[7] := ' �̷�ʹ '; //�u����Ʒ�����\��醚v
  strs[8] := ' ����ʹ '; //�@ȡ�����T������Ʒ�¡��T���Ɛ�
  strs[9] := ' ����ʹ '; //�������ںϣ��ޟ��ȹ�
  strs[10] := ' ǰ� ';
  strs[11] := ' ��� ';
  str := '��ѡ�����' + strs[menu] + '���ˆT';
  pnum := 7;
  page := max0 div pnum;
  npage := 0;
  setlength(menustring2, 3);
  menustring2[0] := '�_����Ҫ�����᣿';
  menustring2[1] := 'ȡ��';
  menustring2[2] := '�_��';
  k1 := min(pnum - 1, max0 - npage * pnum);
  drawdizi(Trole, mpnum, 0, k1, max0, pnum, x, y, -1);
  DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
  word := '��' + IntToStr(npage + 1) + '�';
  DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
  DrawRectangle(CENTER_X - 90, y + 230, 120, 28, 0, ColColor(255), 30);
  for i := 0 to 1 do
    if i = menupage then
    begin
      DrawShadowText(@strs[10 + i][1], CENTER_X - 107 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
    end
    else
    begin
      DrawShadowText(@strs[10 + i][1], CENTER_X - 107 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
    end;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin

        if ((event.key.keysym.sym = SDLK_ESCAPE)) and (where <= 2) then
        begin
          Redraw;
          break;
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) and (where <= 2) then
        begin
          Result := -1;
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          case menupage of
            0:
            begin
              npage := npage - 1;
              if npage < 0 then npage := page;
            end;
            1:
            begin
              npage := npage + 1;
              if npage > page then npage := 0;
            end;
          end;
          if menudz >= 0 then
          begin
            if commonmenu22(CENTER_X - 130, CENTER_Y - 40, 200) = 1 then
            begin
              Result := menudz;
              Redraw;
              break;
            end;
          end;
          Redraw;
          k1 := min(pnum - 1, max0 - npage * pnum);
          drawdizi(Trole, mpnum, npage * pnum, npage * pnum + k1, max0, pnum, x, y, menudz);
          DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
          word := '��' + IntToStr(npage + 1) + '�';
          DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
          DrawRectangle(CENTER_X - 90, y + 230, 120, 28, 0, ColColor(255), 30);
          for i := 0 to 1 do
            if i = menupage then
            begin
              DrawShadowText(@strs[10 + i][1], CENTER_X - 107 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
            end
            else
            begin
              DrawShadowText(@strs[10 + i][1], CENTER_X - 107 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
            end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        menupp := menupage;
        menupage := -1;
        menudzp := menudz;
        menudz := -1;
        if (event.button.x >= CENTER_X - 82) and (event.button.x < CENTER_X + 80) and
          (event.button.y > y + 230) and (event.button.y < y + 259) then
        begin
          menupp := menupage;
          menupage := (event.button.x - CENTER_X + 82) div 50;
          if menupage > 1 then
            menupage := -1;
          if menupage < 0 then
            menupage := -1;
        end;
        if (event.button.x >= x) and (event.button.x < x + 480) and (event.button.y > y + 75) and
          (event.button.y < y + 97 + 22 * k1) then
        begin
          menudzp := menudz;
          menudz := ((event.button.y - y - 75) div 22) + npage * pnum;
          if menudz > max0 then
            menudz := -1
          else if menudz < 0 then
            menudz := -1;
        end;
        if (menupp <> menupage) or (menudzp <> menudz) then
        begin
          Redraw;
          k1 := min(pnum - 1, max0 - npage * pnum);
          drawdizi(Trole, mpnum, npage * pnum, npage * pnum + k1, max0, pnum, x, y, menudz);
          DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
          word := '��' + IntToStr(npage + 1) + '�';
          DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
          DrawRectangle(CENTER_X - 90, y + 230, 120, 28, 0, ColColor(255), 30);
          for i := 0 to 1 do
            if i = menupage then
            begin
              DrawShadowText(@strs[10 + i][1], CENTER_X - 107 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
            end
            else
            begin
              DrawShadowText(@strs[10 + i][1], CENTER_X - 107 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
            end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;

      end;

    end;
  end;
  //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(30, 30);

end;

procedure showneigong(mpnum: integer);
var
  x, y, i, j, k, menu, menung, menup: integer;

begin
  Redraw;
  x := 40;
  y := CENTER_Y - 160;
  menu := -1;
  k := 0;
  drawneigong(mpnum, menu);
  SDL_EnableKeyRepeat(10, 100);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if ((event.key.keysym.sym = SDLK_ESCAPE)) then
        begin
          menu := -1;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          menu := -1;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) and (menu > -1) then
        begin

          menung := selectneigong(mpnum, x, y);
          if menung >= 0 then
          begin
            for i := 0 to 19 do
              if Rmenpai[mpnum].neigong[i] = menung then Rmenpai[mpnum].neigong[i] := -1;
            Rmenpai[mpnum].neigong[menu] := menung;
          end
          else if menung = -1 then
          begin
            Rmenpai[mpnum].neigong[menu] := -1;
            for i := menu to 18 do
            begin
              Rmenpai[mpnum].neigong[menu] := Rmenpai[mpnum].neigong[menu+1];
            end;
            Rmenpai[mpnum].neigong[19] := -1;
          end;

          menu := -1;
          Redraw;
          drawneigong(mpnum, menu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x > 25) and (event.button.x < 625) and (event.button.y > y + 40) and
          (event.button.y < y + 320) then
        begin
          menup := menu;
          menu := (event.button.x - 25) div 120 + (event.button.y - y - 40) div 70 * 5;
          if menu > 19 then
            menu := -1;
          if menu < 0 then
            menu := -1;
        end

        else
        begin
          menup := menu;
          menu := -1;
        end;
        if menup <> menu then
        begin
          Redraw;
          drawneigong(mpnum, menu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;

      end;
    end;
  end;
  //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(30, 30);

end;

procedure drawneigong(mpnum, menu: integer);
var
  x, y, i, j, k: integer;
  strs: array[0..3] of WideString;
  names: array[0..19] of WideString;
  Tneigong: array[0..9] of integer;
begin
  Redraw;
  x := 15;
  y := CENTER_Y - 190;

  strs[0] := '�ȹ�';
  strs[1] := '�������������������������T�Ƀȹ�������������������������';
  k := 0;
  for i := 0 to 19 do
  begin
    if Rmenpai[mpnum].neigong[i] < 0 then break;
    names[k] := GBKtounicode(@Rmagic[Rmenpai[mpnum].neigong[i]].Name);
    Inc(k);
  end;
  display_imgFromSurface(MPNeigong_PIC.pic, 0, 0);
  DrawRectangle(x, y, 610, 380, 0, ColColor(255), 30);
  DrawShadowText(@strs[1][1], x + 15, y + 20, ColColor(249), ColColor(252));
  for i := 0 to k do
  begin
    DrawRectangle(x + 10 + 120 * (i mod 5), y + 60 + 70 * (i div 5), 95, 24, ColColor(5), ColColor(255), 50);
    strs[2] := strs[0] + IntToStr(i + 1);
    DrawShadowText(@strs[2][1], x + 10 + 120 * (i mod 5), y + 60 + 70 * (i div 5), ColColor($13), ColColor($15));
    if menu = i then DrawRectangle(x + 10 + 120 * (i mod 5), y + 90 + 70 * (i div 5), 95, 24,
        ColColor(64), ColColor(68), 50)
    else DrawRectangle(x + 10 + 120 * (i mod 5), y + 90 + 70 * (i div 5), 95, 24, ColColor(192), ColColor(255), 50);
    if i < k then DrawShadowText(@names[i][1], x + 1 + 120 * (i mod 5) + (95 - length(names[i]) * 20) div
        2, y + 90 + 70 * (1 div 5), ColColor($5), ColColor($7));
  end;

end;

function selectneigong(mpnum, x, y: integer): integer;

var
  i, j, k, w, menu, menup, menutop, maxshow, max0: integer;
  magicn, magic: array of integer;
  none: WideString;
  key: boolean;
begin
  max0 := 0;
  menu := 0;
  maxshow := 10;
  w := 200;
  Result := -1;
  none := '��]�п����x��ăȹ���';

  for i := 0 to 399 do
  begin
    if Rmpmagic[mpnum][i] < 0 then break;
    if (Rmagic[Rmpmagic[mpnum][i]].MagicType = 5) then
    begin
      key := False;
      for j := 0 to 19 do
      begin
        if Rmenpai[mpnum].neigong[j] < 0 then
        begin
          key := False;
          break;
        end;
        if Rmpmagic[mpnum][i] = Rmenpai[mpnum].neigong[j] then
        begin
          key := True;
          break;
        end;
      end;
      if not (key) then
      begin

        setlength(menustring2, max0 + 1);
        setlength(menuengstring2, max0 + 1);
        setlength(magic, max0 + 1);
        menustring2[max0] := gbkToUnicode(@Rmagic[Rmpmagic[mpnum][i]].Name);
        menuengstring2[max0] := '';
        magic[max0] := Rmpmagic[mpnum][i];
        Inc(max0);
      end;
    end;
  end;

  max0 := max0 - 1;
  menutop := 0;
  SDL_EnableKeyRepeat(10, 100);
  maxshow := min(max0 + 1, maxshow);
  if max0 >= 0 then
  begin
    Redraw;
    showselectmagic(x, y, w, max0, maxshow, menu, menutop);

    while (SDL_WaitEvent(@event) >= 0) do
    begin
      CheckBasicEvent;
      case event.type_ of
        SDL_KEYdown:
        begin
          if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
          begin
            menu := menu + 1;
            if menu - menutop >= maxshow then
            begin
              menutop := menutop + 1;
            end;
            if menu > max0 then
            begin
              menu := 0;
              menutop := 0;
            end;
            Redraw;
            showselectmagic(x, y, w, max0, maxshow, menu, menutop);

          end;
          if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
          begin
            menu := menu - 1;
            if menu <= menutop then
            begin
              menutop := menu;
            end;
            if menu < 0 then
            begin
              menu := max0;
              menutop := menu - maxshow + 1;
              if menutop < 0 then menutop := 0;
            end;
            Redraw;
            showselectmagic(x, y, w, max0, maxshow, menu, menutop);

          end;
          if (event.key.keysym.sym = SDLK_PAGEDOWN) then
          begin
            menu := menu + maxshow;
            menutop := menutop + maxshow;
            if menu > max0 then
            begin
              menu := max0;
            end;
            if menutop > max0 - maxshow + 1 then
            begin
              menutop := max0 - maxshow + 1;
            end;
            Redraw;
            showselectmagic(x, y, w, max0, maxshow, menu, menutop);

          end;
          if (event.key.keysym.sym = SDLK_PAGEUP) then
          begin
            menu := menu - maxshow;
            menutop := menutop - maxshow;
            if menu < 0 then
            begin
              menu := 0;
            end;
            if menutop < 0 then
            begin
              menutop := 0;
            end;
            Redraw;
            showselectmagic(x, y, w, max0, maxshow, menu, menutop);
          end;
        end;

        SDL_KEYup:
        begin
          if ((event.key.keysym.sym = SDLK_ESCAPE)) and (where <= 2) then
          begin
            Result := -1;
            break;
          end;
          if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
          begin
            Result := magic[menu];
            break;
          end;
        end;
        SDL_MOUSEBUTTONUP:
        begin
          if (event.button.button = SDL_BUTTON_RIGHT) and (where <= 2) then
          begin
            Result := -1;

            break;
          end;
          if (event.button.button = SDL_BUTTON_LEFT) then
          begin
            Result := magic[menu];

            break;
          end;
          if (event.button.button = sdl_button_wheeldown) then
          begin
            menu := menu + 1;
            if menu - menutop >= maxshow then
            begin
              menutop := menutop + 1;
            end;
            if menu > max0 then
            begin
              menu := 0;
              menutop := 0;
            end;
            Redraw;
            showselectmagic(x, y, w, max0, maxshow, menu, menutop);
            SDL_UpdateRect2(screen, x, y, w + 1, maxshow * 22 + 47);
          end;
          if (event.button.button = sdl_button_wheelup) then
          begin
            menu := menu - 1;
            if menu <= menutop then
            begin
              menutop := menu;
            end;
            if menu < 0 then
            begin
              menu := max0;
              menutop := menu - maxshow + 1;
              if menutop < 0 then
              begin
                menutop := 0;
              end;
            end;
            Redraw;
            showselectmagic(x, y, w, max0, maxshow, menu, menutop);

          end;
        end;
        SDL_MOUSEMOTION:
        begin
          if (event.button.x >= x) and (event.button.x < x + w) and (event.button.y > y + 42) and
            (event.button.y < y + max0 * 22 + 64) then
          begin
            menup := menu;
            menu := (event.button.y - y - 42) div 22 + menutop;
            if menu > max0 then
              menu := max0;
            if menu < 0 then
              menu := 0;
            if menup <> menu then
            begin
              Redraw;
              showselectmagic(x, y, w, max0, maxshow, menu, menutop);

            end;
          end;
        end;
      end;
    end;
    //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
    event.key.keysym.sym := 0;
    event.button.button := 0;
    SDL_EnableKeyRepeat(30, 30);

  end

  else
  begin
    DrawShadowText(@none[1], CENTER_X - length(none) * 10, y + 55, ColColor($13), ColColor($15));
    SDL_UpdateRect2(screen, CENTER_X - length(none) * 10, y + 55, 240, 22);
    SDL_Delay(50 * (GameSpeed + 10));
  end;
end;

procedure showsongli(mpnum: integer);
var
  i, j, k, menu, menup, menudz, max1, x, y, len: integer;
  trole: array of smallint;
  str: WideString;
  menpainum: array[0..39] of integer;
begin
  x := 40;
  y := CENTER_Y - 160;
  k := 0;
  for i := 1 to length(Rrole) - 1 do
  begin
    if (i <> Rmenpai[mpnum].zmr) and (Rrole[i].menpai = mpnum) and (Rrole[i].nweizhi <> 20) and
      (Rrole[i].dtime < 2) then
    begin
      setlength(trole, k + 1);
      trole[k] := i;
      k := k + 1;
    end;
  end;
  max1 := 0;
  for i := 0 to 39 do
    if (i <> mpnum) and (Rmenpai[i].zongduo >= 0) then
    begin
      menpainum[max1] := i;

      Inc(max1);
    end;
  menu := -1;
  menudz := -1;
  Redraw;
  drawsongli(mpnum, menu);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  SDL_EnableKeyRepeat(10, 100);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if ((event.key.keysym.sym = SDLK_ESCAPE)) then
        begin
          menu := -1;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          menu := -1;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) and (menu > -1) then
        begin

          menudz := selectsldizi(@trole[0], mpnum, k - 1, menu, x, y);
          if menudz >= 0 then
          begin
            Rrole[Trole[menudz]].nweizhi := 15;
            Rrole[Trole[menudz]].dtime := 30;
            len := length(songli);
            setlength(songli, len + 1);
            songli[len][0] := mpnum;
            songli[len][1] := menpainum[menu];
            songli[len][2] := timetonum + 30;
            str := '�ͶY����ѽ���ǲ��';
            DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 55, ColColor($13), ColColor($15));
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            SDL_Delay(50 * (GameSpeed + 10));
          end;
          menu := -1;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x > x) and (event.button.x < x + 670) and (event.button.y > y + 60) and
          (event.button.y < y + 370) then
        begin
          menup := menu;
          menu := (event.button.x - x) div 125 + ((event.button.y - y - 60) div 40) * 4;
          if menu > max1 - 1 then
            menu := -1;
          if menu < 0 then
            menu := -1;
        end
        else
        begin
          menup := menu;
          menu := -1;
        end;
        if menup <> menu then
        begin
          Redraw;
          drawsongli(mpnum, menu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;

      end;
    end;
  end;
  //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(30, 30);

end;

procedure drawsongli(mpnum, menu: integer);
var
  i, j, k, x, y: integer;
  menpainame, guanxi: array[0..39] of WideString;
  Name: WideString;
begin
  x := 40;
  y := CENTER_Y - 160;
  display_imgFromSurface(SONGLI_PIC.pic, 0, 0);
  DrawRectangle(x, y, 560, 315, 0, ColColor(255), 50);
  Name := '�����������������x���T�ɣ���������������';
  DrawShadowText(@Name[1], CENTER_X - length(Name) * 10 - 9, y + 15, ColColor($5), ColColor($7));
  j := 0;
  for k := 0 to 39 do
    if (k <> mpnum) and (Rmenpai[k].zongduo >= 0) then
    begin
      menpainame[j] := gbkToUnicode(@Rmenpai[k].Name);
      guanxi[j] := IntToStr(Rmenpai[mpnum].guanxi[k]);
      Inc(j);
    end;

  if j > 0 then
  begin
    i := 0;
    repeat
      begin
        if menu = i then
        begin
          DrawShadowText(@menpainame[i, 1], x + 125 * (i mod 4), y + 60 + 40 * (i div 4),
            ColColor($64), ColColor($66));
        end
        else
        begin
          DrawShadowText(@menpainame[i, 1], x + 125 * (i mod 4), y + 60 + 40 * (i div 4),
            ColColor($21), ColColor($23));
        end;
        DrawShadowText(@guanxi[i, 1], x + 125 * (i mod 4) + length(menpainame[i]) * 20, y +
          60 + 40 * (i div 4), ColColor($64), ColColor($66));
        Inc(i);
      end;
    until i > j - 1;
  end;

end;

function selectsldizi(trole: psmallint; mpnum, max0, menu, x, y: integer): integer;
var
  i, j, k1, pnum, page, npage, menupage, menupp, menudzp, menudz: integer;
  str, word: WideString;
  strs: array[0..1] of WideString;
begin
  Redraw;
  Result := -1;
  menupage := -1;
  menudz := -1;
  strs[0] := ' ǰ� ';
  strs[1] := ' ��� ';
  str := '��ѡ��ǰ���ͶY���ˆT';
  pnum := 7;
  page := max0 div pnum;
  npage := 0;


  k1 := min(pnum - 1, max0 - npage * pnum);
  drawdizi(Trole, mpnum, 0, k1, max0, pnum, x, y, -1);
  DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
  word := '��' + IntToStr(npage + 1) + '�';
  DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
  DrawRectangle(CENTER_X - 90, y + 230, 120, 28, 0, ColColor(255), 30);
  for i := 0 to 1 do
    if i = menupage then
    begin
      DrawShadowText(@strs[i][1], CENTER_X - 107 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
    end
    else
    begin
      DrawShadowText(@strs[i][1], CENTER_X - 107 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
    end;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if ((event.key.keysym.sym = SDLK_ESCAPE)) and (where <= 2) then
        begin
          Redraw;
          break;
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) and (where <= 2) then
        begin
          Result := -1;
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          case menupage of
            0:
            begin
              npage := npage - 1;
              if npage < 0 then npage := page;
            end;
            1:
            begin
              npage := npage + 1;
              if npage > page then npage := 0;
            end;
          end;
          if menudz >= 0 then
          begin
            Result := menudz;
            Redraw;
            break;
          end;
          Redraw;
          k1 := min(pnum - 1, max0 - npage * pnum);
          drawdizi(Trole, mpnum, npage * pnum, npage * pnum + k1, max0, pnum, x, y, menudz);
          DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
          word := '��' + IntToStr(npage + 1) + '�';
          DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
          DrawRectangle(CENTER_X - 90, y + 230, 120, 28, 0, ColColor(255), 30);
          for i := 0 to 1 do
            if i = menupage then
            begin
              DrawShadowText(@strs[i][1], CENTER_X - 107 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
            end
            else
            begin
              DrawShadowText(@strs[i][1], CENTER_X - 107 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
            end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        menupp := menupage;
        menupage := -1;
        menudzp := menudz;
        menudz := -1;
        if (event.button.x >= CENTER_X - 82) and (event.button.x < CENTER_X + 80) and
          (event.button.y > y + 230) and (event.button.y < y + 259) then
        begin
          menupp := menupage;
          menupage := (event.button.x - CENTER_X + 82) div 50;
          if menupage > 1 then
            menupage := -1;
          if menupage < 0 then
            menupage := -1;
        end;
        if (event.button.x >= x) and (event.button.x < x + 480) and (event.button.y > y + 75) and
          (event.button.y < y + 97 + 22 * k1) then
        begin
          menudzp := menudz;
          menudz := ((event.button.y - y - 75) div 22) + npage * pnum;
          if menudz > max0 then
            menudz := -1
          else if menudz < 0 then
            menudz := -1;
        end;
        if (menupp <> menupage) or (menudzp <> menudz) then
        begin
          Redraw;
          k1 := min(pnum - 1, max0 - npage * pnum);
          drawdizi(Trole, mpnum, npage * pnum, npage * pnum + k1, max0, pnum, x, y, menudz);
          DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
          word := '��' + IntToStr(npage + 1) + '�';
          DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
          DrawRectangle(CENTER_X - 90, y + 230, 120, 28, 0, ColColor(255), 30);
          for i := 0 to 1 do
            if i = menupage then
            begin
              DrawShadowText(@strs[i][1], CENTER_X - 107 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
            end
            else
            begin
              DrawShadowText(@strs[i][1], CENTER_X - 107 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
            end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;

      end;

    end;
  end;
  //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(30, 30);

end;

procedure showyidong(mpnum: integer);
var
  i, i1, i2, j, j1, max0, x, y, len, line, row, menu, menutop, menup, maxshow, nowstep, snum1, snum2, mods: integer;
  tscen: array of integer;
  str: WideString;
begin
  x := 40;
  y := CENTER_Y - 160;
  line := 5;
  row := 12;
  mods := 0;
  maxshow := line * row;
  setlength(menuString, 0);
  setlength(menuEngString, 0);
  max0 := 0;
  for i := 0 to length(Rscene) - 1 do
  begin
    if Rscene[i].menpai = mpnum then
    begin
      setlength(tscen, max0 + 1);
      tscen[max0] := i;
      setlength(menuString, max0 + 1);
      menuString[max0] := gbktounicode(@Rscene[i].Name);
      max0 := max0 + 1;
    end;
  end;
  Dec(max0);
  maxshow := min(maxshow, max0 + 1);
  if max0 < 1 then
  begin
    str := '�]�п����Ƅӵĵ��c';
    DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor($13), ColColor($15));
    SDL_UpdateRect2(screen, CENTER_X - length(str) * 12, y + 15, 240, 22);
    SDL_Delay(50 * (GameSpeed + 10));
    exit;
  end;
  Redraw;
  menu := -1;
  menutop := 0;
  drawyidong(max0, line, row, menu, menutop, mods);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYDOWN:
      begin
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          menu := menu + line;
          if menu - menutop >= maxshow then
          begin
            menutop := menutop + line;
          end;
          if (menu > max0) and (menu < max0 + line) then
          begin
            menu := max0;
            menutop := ((max0 + 1) div line - row + 1) * line;

          end
          else if menu >= max0 + line then
          begin
            menu := menu mod line;
            if menu > max0 then
              menu := 0;
            menutop := 0;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawyidong(max0, line, row, menu, menutop, mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          menu := menu - line;
          if menu < menutop then
          begin
            menutop := menutop - line;
          end;
          if (menu < 0) and (menu > -line) then
          begin
            menu := 0;
            menutop := 0;
          end
          else if menu <= -line then
          begin
            menu := (max0 + 1) div line * line + (line + menu) mod line;
            menutop := ((max0 + 1) div line - row + 1) * line;
            if menutop < 0 then menutop := 0;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawyidong(max0, line, row, menu, menutop, mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
        if (event.key.keysym.sym = SDLK_LEFT) or (event.key.keysym.sym = SDLK_KP4) then
        begin
          menu := menu - 1;
          if menu < menutop then
          begin
            menutop := menutop - line;
          end;
          if menu < 0 then
          begin
            menu := max0;
            menutop := ((max0 + 1) div line - row + 1) * line;
            if menutop < 0 then menutop := 0;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawyidong(max0, line, row, menu, menutop, mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
        if (event.key.keysym.sym = SDLK_RIGHT) or (event.key.keysym.sym = SDLK_KP6) then
        begin
          menu := menu + 1;
          if menu - menutop >= maxshow then
          begin
            menutop := menutop + line;
          end;
          if menu > max0 then
          begin
            menu := 0;
            if menu > max0 then
              menu := 0;
            menutop := 0;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawyidong(max0, line, row, menu, menutop, mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
        if (event.key.keysym.sym = SDLK_PAGEDOWN) then
        begin
          menu := menu + maxshow;
          menutop := menutop + maxshow;
          if menu > max0 - maxshow then
          begin
            menutop := ((max0 + 1) div line - row + 1) * line;
            if (menu > max0) then
            begin
              menu := max0;
            end;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawyidong(max0, line, row, menu, menutop, mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
        if (event.key.keysym.sym = SDLK_PAGEUP) then
        begin
          menu := menu - maxshow;
          menutop := menutop - maxshow;
          if menu < 0 then
          begin
            menu := menu + maxshow;
          end;
          if menutop < 0 then
          begin
            menutop := 0;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawyidong(max0, line, row, menu, menutop, mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
      end;
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          if menu >= 0 then
          begin
            snum1 := tscen[menu];
            snum2 := confirmyidong(mpnum, snum1);
            if snum2 > 0 then
            begin
              if selectyidongrole(snum1, snum2) then
              begin
                Redraw;
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                exit;
              end
              else
              begin
                Redraw;
                drawyidong(max0, line, row, menu, menutop, mods);
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                SDL_Delay(5 * (GameSpeed + 10));
              end;
            end
            else
            begin
              Redraw;
              drawyidong(max0, line, row, menu, menutop, mods);
              SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
              SDL_Delay(5 * (GameSpeed + 10));
            end;
          end;
        end;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          menu := -1;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          menu := -1;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) and (menu > -1) then
        begin
          if menu >= 0 then
          begin
            snum1 := tscen[menu];
            snum2 := confirmyidong(mpnum, snum1);
            if snum2 > 0 then
            begin
              if selectyidongrole(snum1, snum2) then
              begin
                Redraw;
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                exit;
              end
              else
              begin
                Redraw;
                drawyidong(max0, line, row, menu, menutop, mods);
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                SDL_Delay(5 * (GameSpeed + 10));
              end;
            end
            else
            begin
              Redraw;
              drawyidong(max0, line, row, menu, menutop, mods);
              SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
              SDL_Delay(5 * (GameSpeed + 10));
            end;
          end;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x > x) and (event.button.x < x + 550) and (event.button.y > y + 52) and
          (event.button.y < y + 266) then
        begin
          menup := menu;
          menu := menutop + (event.button.x - x) div 110 + ((event.button.y - y - 52) div 22) * line;
          if menu > max0 then
            menu := -1;
          if menu < 0 then
            menu := -1;
        end
        else
        begin
          menup := menu;
          menu := -1;
        end;
        if menup <> menu then
        begin
          Redraw;
          drawyidong(max0, line, row, menu, menutop, mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;

      end;
    end;
  end;

  //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(30, 30);
end;

function confirmyidong(mpnum, snum: integer): integer;
var
  i, i1, i2, j, j1, max0, x, y, len, line, row, menu, menutop, menup, maxshow, nowstep, snum1, snum2, mods: integer;
  tscen: array of integer;
  str: WideString;
begin
  mods := 1;
  Result := -1;
  x := 40;
  y := CENTER_Y - 160;
  line := 5;
  row := 12;
  maxshow := line * row;
  setlength(menuString, 0);
  setlength(menuEngString, 0);
  max0 := 0;
  for i := 0 to length(Rscene) - 1 do
  begin
    if (Rscene[i].menpai = mpnum) and (i <> snum) then
    begin
      setlength(tscen, max0 + 1);
      tscen[max0] := i;
      setlength(menuString, max0 + 1);
      menuString[max0] := gbktounicode(@Rscene[i].Name);
      max0 := max0 + 1;
    end;
  end;
  Dec(max0);
  maxshow := min(maxshow, max0 + 1);
  if max0 < 0 then
  begin
    str := '�]�п����Ƅӵĵ��c';
    DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor($13), ColColor($15));
    SDL_UpdateRect2(screen, CENTER_X - length(str) * 12, y + 15, 240, 22);
    SDL_Delay(50 * (GameSpeed + 10));
    setlength(menuString, 0);
    setlength(menuEngString, 0);
    max0 := 0;
    for i := 0 to length(Rscene) - 1 do
    begin
      if (Rscene[i].menpai = mpnum) then
      begin
        setlength(tscen, max0 + 1);
        tscen[max0] := i;
        setlength(menuString, max0 + 1);
        menuString[max0] := gbktounicode(@Rscene[i].Name);
        max0 := max0 + 1;
      end;
    end;
    exit;
  end;
  Redraw;
  menu := -1;
  menutop := 0;
  drawyidong(max0, line, row, menu, menutop, mods);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYDOWN:
      begin
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          menu := menu + line;
          if menu - menutop >= maxshow then
          begin
            menutop := menutop + line;
          end;
          if (menu > max0) and (menu < max0 + line) then
          begin
            menu := max0;
            menutop := ((max0 + 1) div line - row + 1) * line;

          end
          else if menu >= max0 + line then
          begin
            menu := menu mod line;
            if menu > max0 then
              menu := 0;
            menutop := 0;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawyidong(max0, line, row, menu, menutop, mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          menu := menu - line;
          if menu < menutop then
          begin
            menutop := menutop - line;
          end;
          if (menu < 0) and (menu > -line) then
          begin
            menu := 0;
            menutop := 0;
          end
          else if menu <= -line then
          begin
            menu := (max0 + 1) div line * line + (line + menu) mod line;
            menutop := ((max0 + 1) div line - row + 1) * line;
            if menutop < 0 then menutop := 0;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawyidong(max0, line, row, menu, menutop, mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
        if (event.key.keysym.sym = SDLK_LEFT) or (event.key.keysym.sym = SDLK_KP4) then
        begin
          menu := menu - 1;
          if menu < menutop then
          begin
            menutop := menutop - line;
          end;
          if menu < 0 then
          begin
            menu := max0;
            menutop := ((max0 + 1) div line - row + 1) * line;
            if menutop < 0 then menutop := 0;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawyidong(max0, line, row, menu, menutop, mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
        if (event.key.keysym.sym = SDLK_RIGHT) or (event.key.keysym.sym = SDLK_KP6) then
        begin
          menu := menu + 1;
          if menu - menutop >= maxshow then
          begin
            menutop := menutop + line;
          end;
          if menu > max0 then
          begin
            menu := 0;
            if menu > max0 then
              menu := 0;
            menutop := 0;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawyidong(max0, line, row, menu, menutop, mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
        if (event.key.keysym.sym = SDLK_PAGEDOWN) then
        begin
          menu := menu + maxshow;
          menutop := menutop + maxshow;
          if menu > max0 - maxshow then
          begin
            menutop := ((max0 + 1) div line - row + 1) * line;
            if (menu > max0) then
            begin
              menu := max0;
            end;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawyidong(max0, line, row, menu, menutop, mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
        if (event.key.keysym.sym = SDLK_PAGEUP) then
        begin
          menu := menu - maxshow;
          menutop := menutop - maxshow;
          if menu < 0 then
          begin
            menu := menu + maxshow;
          end;
          if menutop < 0 then
          begin
            menutop := 0;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawyidong(max0, line, row, menu, menutop, mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
      end;
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          if menu >= 0 then
          begin
            Result := tscen[menu];
            Redraw;
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            break;
          end;
        end;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          menu := -1;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          menu := -1;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) and (menu > -1) then
        begin
          if menu >= 0 then
          begin
            Result := tscen[menu];
            Redraw;
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            break;
          end;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x > x) and (event.button.x < x + 550) and (event.button.y > y + 52) and
          (event.button.y < y + 266) then
        begin
          menup := menu;
          menu := menutop + (event.button.x - x) div 110 + ((event.button.y - y - 52) div 22) * line;
          if menu > max0 then
            menu := -1;
          if menu < 0 then
            menu := -1;
        end
        else
        begin
          menup := menu;
          menu := -1;
        end;
        if menup <> menu then
        begin
          Redraw;
          drawyidong(max0, line, row, menu, menutop, mods);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;

      end;
    end;
  end;
  setlength(menuString, 0);
  setlength(menuEngString, 0);
  max0 := 0;
  for i := 0 to length(Rscene) - 1 do
  begin
    if (Rscene[i].menpai = mpnum) then
    begin
      setlength(tscen, max0 + 1);
      tscen[max0] := i;
      setlength(menuString, max0 + 1);
      menuString[max0] := gbktounicode(@Rscene[i].Name);
      max0 := max0 + 1;
    end;
  end;
  //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(30, 30);
end;

procedure drawyidong(max0, line, row, menu, menutop, mods: integer);
var
  x, y: integer;
  str: WideString;
begin
  x := 40;
  y := CENTER_Y - 160;
  display_imgFromSurface(GONGJI_PIC.pic, 0, 0);
  DrawRectangle(x, y, 560, 52, 0, ColColor(255), 50);
  if mods = 0 then
    str := '�������������x��Ҫ�Ƅӵĵ��c������������'
  else if mods = 1 then
    str := '�������������x��Ҫ�����ĵ��c������������';
  DrawShadowText(@str[1], CENTER_X - length(str) * 10 - 9, y + 15, ColColor($21), ColColor($23));
  DrawWideScrollMenu(x, y + 52, line, row, menutop, max0, menu);
end;

function SelectyidongRole(snum, snum2: integer): boolean;
var
  i, i1, i2, x, y, mpnum, max0, j, k1, pnum, page, npage, menupage, menupp, menudzp, menudz, Count, len: integer;
  trole, mrole: array of smallint;
  str, word: WideString;
  strs: array[0..1] of WideString;
begin
  x := 40;
  y := CENTER_Y - 160;
  Count := 0;
  Result := False;
  mpnum := Rscene[snum].menpai;
  max0 := 0;
  strs[0] := 'ǰ�';
  strs[1] := '���';
  for i := 1 to length(Rrole) - 1 do
  begin
    if (Rrole[i].weizhi = snum) and (Rrole[i].menpai = mpnum) and (Rrole[i].dtime < 2) then
    begin
      setlength(trole, max0 + 1);
      trole[max0] := i;
      setlength(mrole, max0 + 1);
      mrole[max0] := 0;
      Inc(max0);
    end;
  end;
  Dec(max0);
  setlength(menustring2, 3);
  setlength(menuengstring2, 0);
  menustring2[0] := '�_��Ҫ�Ƅӆ᣿';
  menustring2[1] := '�_��';
  menustring2[2] := 'ȡ��';
  Redraw;
  menupage := -1;
  menudz := -1;
  str := '��ѡ��Ҫ�Ƅӵ��ˆT������x��Ո��ESC�_�J';
  pnum := 7;
  page := max0 div pnum;
  npage := 0;
  k1 := min(pnum - 1, max0 - npage * pnum);
  drawmultiRole(Trole, mrole, mpnum, 0, k1, max0, pnum, x, y, menudz);
  DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
  word := '��' + IntToStr(npage + 1) + '�';
  DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
  DrawRectangle(x + 185, y + 230, 120, 28, 0, ColColor(255), 30);
  for i := 0 to 1 do
    if i = menupage then
    begin
      DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($64), ColColor($66));
    end
    else
    begin
      DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($5), ColColor($7));
    end;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYDOWN:
      begin
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          menudz := menudz + 1;
          if menudz - npage * pnum >= pnum then
          begin
            npage := npage + 1;
            if npage > page then npage := 0;
          end;
          Redraw;
          k1 := min(pnum - 1, max0 - npage * pnum);
          drawmultirole(Trole, mrole, mpnum, npage * pnum, npage * pnum + k1, max0, pnum, x, y, menudz);
          DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
          word := '��' + IntToStr(npage + 1) + '�';
          DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
          DrawRectangle(x + 185, y + 230, 120, 28, 0, ColColor(255), 30);
          for i := 0 to 1 do
            if i = menupage then
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($64), ColColor($66));
            end
            else
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($5), ColColor($7));
            end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          menudz := menudz - 1;
          if menudz < npage * pnum then
          begin
            npage := npage - 1;
            if npage < 0 then npage := page;
          end;
          Redraw;
          k1 := min(pnum - 1, max0 - npage * pnum);
          drawmultirole(Trole, mrole, mpnum, npage * pnum, npage * pnum + k1, max0, pnum, x, y, menudz);
          DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
          word := '��' + IntToStr(npage + 1) + '�';
          DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
          DrawRectangle(x + 185, y + 230, 120, 28, 0, ColColor(255), 30);
          for i := 0 to 1 do
            if i = menupage then
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($64), ColColor($66));
            end
            else
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($5), ColColor($7));
            end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
      SDL_KEYUP:
      begin
        if ((event.key.keysym.sym = SDLK_ESCAPE)) and (where <= 2) then
        begin
          if Count > 0 then
          begin
            if CommonMenu22(CENTER_X - 110, y + 40, 220) = 0 then
            begin
              Result := True;
              for i := 0 to max0 do
              begin
                if mrole[i] = 1 then
                begin
                  Rrole[trole[i]].weizhi := snum2;
                  Rrole[trole[i]].nweizhi := 14;
                  Rrole[trole[i]].dtime := 5;
                end;
              end;
            end;
          end;
          Redraw;
          break;
        end;
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          if menudz >= 0 then
          begin
            if mrole[menudz] = 0 then
            begin
              mrole[menudz] := 1;
              Inc(Count);
            end
            else
            begin
              mrole[menudz] := 0;
              Dec(Count);
            end;
          end;
          Redraw;
          k1 := min(pnum - 1, max0 - npage * pnum);
          drawmultiRole(Trole, mrole, mpnum, npage * pnum, npage * pnum + k1, max0, pnum, x, y, menudz);
          DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
          word := '��' + IntToStr(npage + 1) + '�';
          DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
          DrawRectangle(x + 185, y + 230, 120, 28, 0, ColColor(255), 30);
          for i := 0 to 1 do
            if i = menupage then
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($64), ColColor($66));
            end
            else
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($5), ColColor($7));
            end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) and (where <= 2) then
        begin
          if Count > 0 then
          begin
            if CommonMenu22(CENTER_X - 110, y + 40, 220) = 0 then
            begin
              Result := True;
              for i := 0 to max0 do
              begin
                if mrole[i] = 1 then
                begin
                  Rrole[trole[i]].weizhi := snum2;
                  Rrole[trole[i]].nweizhi := 14;
                  Rrole[trole[i]].dtime := 5;
                end;
              end;
            end;
          end;
          Redraw;
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          case menupage of
            0:
            begin
              npage := npage - 1;
              if npage < 0 then npage := page;
            end;
            1:
            begin
              npage := npage + 1;
              if npage > page then npage := 0;
            end;
          end;
          if menudz >= 0 then
          begin
            if mrole[menudz] = 0 then
            begin
              mrole[menudz] := 1;
              Inc(Count);
            end
            else
            begin
              mrole[menudz] := 0;
              Dec(Count);
            end;
          end;
          Redraw;
          k1 := min(pnum - 1, max0 - npage * pnum);
          drawmultiRole(Trole, mrole, mpnum, npage * pnum, npage * pnum + k1, max0, pnum, x, y, menudz);
          DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
          word := '��' + IntToStr(npage + 1) + '�';
          DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
          DrawRectangle(x + 185, y + 230, 120, 28, 0, ColColor(255), 30);
          for i := 0 to 1 do
            if i = menupage then
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($64), ColColor($66));
            end
            else
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($5), ColColor($7));
            end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        menupp := menupage;
        menupage := -1;
        menudzp := menudz;
        menudz := -1;
        if (event.button.x >= x + 190) and (event.button.x < x + 310) and (event.button.y > y + 230) and
          (event.button.y < y + 259) then
        begin
          menupp := menupage;
          menupage := (event.button.x - x - 185) div 60;
          if menupage > 1 then
            menupage := -1;
          if menupage < 0 then
            menupage := -1;
        end;
        if (event.button.x >= x + 40) and (event.button.x < x + 360) and (event.button.y > y + 75) and
          (event.button.y < y + 97 + 22 * k1) then
        begin
          menudzp := menudz;
          menudz := ((event.button.y - y - 75) div 22) + npage * pnum;
          if menudz > max0 then
            menudz := -1
          else if menudz < 0 then
            menudz := -1;
        end;
        if (menupp <> menupage) or (menudzp <> menudz) then
        begin
          Redraw;
          k1 := min(pnum - 1, max0 - npage * pnum);
          drawmultirole(Trole, mrole, mpnum, npage * pnum, npage * pnum + k1, max0, pnum, x, y, menudz);
          DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
          word := '��' + IntToStr(npage + 1) + '�';
          DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
          DrawRectangle(x + 185, y + 230, 120, 28, 0, ColColor(255), 30);
          for i := 0 to 1 do
            if i = menupage then
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($64), ColColor($66));
            end
            else
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($5), ColColor($7));
            end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
    end;
  end;
  //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(30, 30);

end;

procedure showjingong(snum, mpnum: integer);
var
  i, i1, i2, j, j1, max0, x, y, len, line, row, menu, menutop, menup, maxshow, nowstep, battle_id: integer;
  tscen: array of integer;
  str: WideString;
begin
  x := 40;
  y := CENTER_Y - 160;
  line := 5;
  row := 12;
  maxshow := line * row;
  setlength(menuString, 0);
  setlength(menuEngString, 0);
  max0 := 0;
  for i := 0 to length(Rscene) - 1 do
  begin
    if Rscene[i].menpai = mpnum then
    begin
      for i1 := 0 to 9 do
      begin
        if (Rscene[i].lianjie[i1] > -1) then
        begin
          if (Rscene[Rscene[i].lianjie[i1]].menpai > 0) and (Rscene[Rscene[i].lianjie[i1]].menpai <> mpnum) then
          begin
            if max0 > 0 then
            begin
              for i2 := 0 to max0 - 1 do
              begin
                if Rscene[i].lianjie[i1] = tscen[i2] then
                  break;
              end;
              if i2 >= max0 then
              begin
                setlength(tscen, max0 + 1);
                tscen[max0] := Rscene[i].lianjie[i1];
                setlength(menuString, max0 + 1);
                menuString[max0] := gbktounicode(@Rscene[tscen[max0]].Name);
                max0 := max0 + 1;
              end;
            end
            else
            begin
              setlength(tscen, max0 + 1);
              tscen[max0] := Rscene[i].lianjie[i1];
              setlength(menuString, max0 + 1);
              menuString[max0] := gbktounicode(@Rscene[tscen[max0]].Name);
              max0 := max0 + 1;
            end;
          end;
        end
        else
          break;
      end;
    end;
  end;
  Dec(max0);
  maxshow := min(maxshow, max0 + 1);
  if max0 < 0 then
  begin
    str := '�]�п����M���ĵ��c';
    DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor($13), ColColor($15));
    SDL_UpdateRect2(screen, CENTER_X - length(str) * 12, y + 15, 240, 22);
    SDL_Delay(50 * (GameSpeed + 10));
    exit;
  end;
  Redraw;
  menu := -1;
  menutop := 0;
  drawgongji(max0, line, row, menu, menutop);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYDOWN:
      begin
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          menu := menu + line;
          if menu - menutop >= maxshow then
          begin
            menutop := menutop + line;
          end;
          if (menu > max0) and (menu < max0 + line) then
          begin
            menu := max0;
            menutop := ((max0 + 1) div line - row + 1) * line;

          end
          else if menu >= max0 + line then
          begin
            menu := menu mod line;
            if menu > max0 then
              menu := 0;
            menutop := 0;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawgongji(max0, line, row, menu, menutop);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          menu := menu - line;
          if menu < menutop then
          begin
            menutop := menutop - line;
          end;
          if (menu < 0) and (menu > -line) then
          begin
            menu := 0;
            menutop := 0;
          end
          else if menu <= -line then
          begin
            menu := (max0 + 1) div line * line + (line + menu) mod line;
            menutop := ((max0 + 1) div line - row + 1) * line;
            if menutop < 0 then menutop := 0;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawgongji(max0, line, row, menu, menutop);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
        if (event.key.keysym.sym = SDLK_LEFT) or (event.key.keysym.sym = SDLK_KP4) then
        begin
          menu := menu - 1;
          if menu < menutop then
          begin
            menutop := menutop - line;
          end;
          if menu < 0 then
          begin
            menu := max0;
            menutop := ((max0 + 1) div line - row + 1) * line;
            if menutop < 0 then menutop := 0;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawgongji(max0, line, row, menu, menutop);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
        if (event.key.keysym.sym = SDLK_RIGHT) or (event.key.keysym.sym = SDLK_KP6) then
        begin
          menu := menu + 1;
          if menu - menutop >= maxshow then
          begin
            menutop := menutop + line;
          end;
          if menu > max0 then
          begin
            menu := 0;
            if menu > max0 then
              menu := 0;
            menutop := 0;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawgongji(max0, line, row, menu, menutop);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
        if (event.key.keysym.sym = SDLK_PAGEDOWN) then
        begin
          menu := menu + maxshow;
          menutop := menutop + maxshow;
          if menu > max0 - maxshow then
          begin
            menutop := ((max0 + 1) div line - row + 1) * line;
            if (menu > max0) then
            begin
              menu := max0;
            end;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawgongji(max0, line, row, menu, menutop);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
        if (event.key.keysym.sym = SDLK_PAGEUP) then
        begin
          menu := menu - maxshow;
          menutop := menutop - maxshow;
          if menu < 0 then
          begin
            menu := menu + maxshow;
          end;
          if menutop < 0 then
          begin
            menutop := 0;
          end;
          if menutop < 0 then menutop := 0;
          Redraw;
          drawgongji(max0, line, row, menu, menutop);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          SDL_Delay(5 * (GameSpeed + 10));
        end;
      end;
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          if menu >= 0 then
          begin
            if Rscene[tscen[menu]].inbattle = 1 then
            begin
              str := 'ԓ���ѱ��e�˹���';
              DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor($13), ColColor($15));
              SDL_UpdateRect2(screen, CENTER_X - length(str) * 12, y + 15, 240, 22);
              SDL_Delay(50 * (GameSpeed + 10));
              break;
            end;
            if confirmgongji(mpnum, Rscene[tscen[menu]].menpai) > 0 then
            begin
              if selectGongjiRole(snum, tscen[menu], battle_id) then
              begin
                NewTalk(0, 200, -2, 0, 0, 0, 0, 1);
                Rrole[0].weizhi := -1;
                where := 0;
                resetpallet;
                instruct_14;
                instruct_13;
                for i := 0 to 479 do
                  for i1 := 0 to 479 do
                    Fway[i, i1] := -1;
                FindWay(Mx, My, -2);
                Moveman(Mx, My, Rscene[tscen[menu]].MainEntranceX1, Rscene[tscen[menu]].MainEntranceY1);
                nowstep := Fway[Rscene[tscen[menu]].MainEntranceX1, Rscene[tscen[menu]].MainEntranceY1] - 1;
                while nowstep >= 0 do
                begin
                  if sign(linex[nowstep] - Mx) < 0 then
                    MFace := 0
                  else if sign(linex[nowstep] - Mx) > 0 then
                    MFace := 3
                  else if sign(liney[nowstep] - My) > 0 then
                    MFace := 1
                  else MFace := 2;
                  MStep := 6 - nowstep mod 6;
                  Mx := linex[nowstep];
                  My := liney[nowstep];
                  Dec(nowstep);
                  adddate(2);
                  DrawMMap;
                  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                  SDL_Delay(GameSpeed + 10);
                  if inship = 1 then
                  begin
                    shipx := My;
                    shipy := Mx;
                  end;
                  if (shipy = Mx) and (shipx = My) then
                  begin
                    inship := 1;
                  end;
                end;

                Mx := Rscene[tscen[menu]].MainEntranceX1;
                My := Rscene[tscen[menu]].MainEntranceY1;
                Sx := Rscene[tscen[menu]].EntranceX;
                Sy := Rscene[tscen[menu]].EntranceY;
                Cx := Sx;
                Cy := Sy;
                CurScene := tscen[menu];
                where := 1;
                Rrole[0].weizhi := CurScene;
                resetpallet;
                instruct_14;
                InitialScene;
                DrawScene;
                instruct_13;
                ShowSceneName(CurScene);
                Redraw;
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                NewTalk(0, 201, -2, 0, 0, 0, 0, 1);

                clearrole(snum, -1);
                if Battle(0, 0, -3, battle_id) then
                  NewTalk(0, 202, -2, 0, 0, 0, 0, 1)
                else NewTalk(0, 203, -2, 0, 0, 0, 0, 1);
                instruct_14;
                gotommap(-1, -1);
                instruct_13;
                exit;
              end
              else
              begin
                Redraw;
                drawgongji(max0, line, row, menu, menutop);
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                SDL_Delay(5 * (GameSpeed + 10));
              end;
            end
            else
            begin
              Redraw;
              drawgongji(max0, line, row, menu, menutop);
              SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
              SDL_Delay(5 * (GameSpeed + 10));
            end;
          end;
        end;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          menu := -1;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          menu := -1;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) and (menu > -1) then
        begin
          if menu >= 0 then
          begin
            if Rscene[tscen[menu]].inbattle = 1 then
            begin
              str := 'ԓ���ѱ��e�˹���';
              DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor($13), ColColor($15));
              SDL_UpdateRect2(screen, CENTER_X - length(str) * 12, y + 15, 240, 22);
              SDL_Delay(50 * (GameSpeed + 10));
              break;
            end;
            if confirmgongji(mpnum, Rscene[tscen[menu]].menpai) > 0 then
            begin
              if selectGongjiRole(snum, tscen[menu], battle_id) then
              begin
                NewTalk(0, 200, -2, 0, 0, 0, 0, 1);
                where := 0;
                Rrole[0].weizhi := -1;
                resetpallet;
                instruct_14;
                instruct_13;
                for i := 0 to 479 do
                  for i1 := 0 to 479 do
                    Fway[i, i1] := -1;
                FindWay(Mx, My, -2);
                Moveman(Mx, My, Rscene[tscen[menu]].MainEntranceX1, Rscene[tscen[menu]].MainEntranceY1);
                nowstep := Fway[Rscene[tscen[menu]].MainEntranceX1, Rscene[tscen[menu]].MainEntranceY1] - 1;
                while nowstep >= 0 do
                begin
                  if sign(linex[nowstep] - Mx) < 0 then
                    MFace := 0
                  else if sign(linex[nowstep] - Mx) > 0 then
                    MFace := 3
                  else if sign(liney[nowstep] - My) > 0 then
                    MFace := 1
                  else MFace := 2;
                  MStep := 6 - nowstep mod 6;
                  Mx := linex[nowstep];
                  My := liney[nowstep];
                  Dec(nowstep);
                  adddate(2);
                  DrawMMap;
                  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                  SDL_Delay(GameSpeed + 10);
                  if inship = 1 then
                  begin
                    shipx := My;
                    shipy := Mx;
                  end;
                  if (shipy = Mx) and (shipx = My) then
                  begin
                    inship := 1;
                  end;
                end;

                Mx := Rscene[tscen[menu]].MainEntranceX1;
                My := Rscene[tscen[menu]].MainEntranceY1;
                Sx := Rscene[tscen[menu]].EntranceX;
                Sy := Rscene[tscen[menu]].EntranceY;
                Cx := Sx;
                Cy := Sy;
                CurScene := tscen[menu];
                where := 1;
                Rrole[0].weizhi := CurScene;
                resetpallet;
                instruct_14;
                InitialScene;
                DrawScene;
                instruct_13;
                ShowSceneName(CurScene);
                Redraw;
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                NewTalk(0, 201, -2, 0, 0, 0, 0, 1);

                clearrole(snum, -1);
                if Battle(0, 0, -3, battle_id) then
                  NewTalk(0, 202, -2, 0, 0, 0, 0, 1)
                else NewTalk(0, 203, -2, 0, 0, 0, 0, 1);
                instruct_14;
                gotommap(-1, -1);
                instruct_13;
                exit;
              end
              else
              begin
                Redraw;
                drawgongji(max0, line, row, menu, menutop);
                SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                SDL_Delay(5 * (GameSpeed + 10));
              end;
            end
            else
            begin
              Redraw;
              drawgongji(max0, line, row, menu, menutop);
              SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
              SDL_Delay(5 * (GameSpeed + 10));
            end;
          end;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x > x) and (event.button.x < x + 550) and (event.button.y > y + 52) and
          (event.button.y < y + 266) then
        begin
          menup := menu;
          menu := menutop + (event.button.x - x) div 110 + ((event.button.y - y - 52) div 22) * line;
          if menu > max0 then
            menu := -1;
          if menu < 0 then
            menu := -1;
        end
        else
        begin
          menup := menu;
          menu := -1;
        end;
        if menup <> menu then
        begin
          Redraw;
          drawgongji(max0, line, row, menu, menutop);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;

      end;
    end;
  end;

  //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(30, 30);
end;

procedure zhanlin(mpnum, snum: integer);
var
  i, j, tmp, n, mpnum2, addsw: integer;
  str: WideString;
begin
  clearrole(snum, -1);
  mpnum2 := Rscene[snum].menpai;
  Dec(Rmenpai[Rscene[snum].menpai].jvdian);
  Inc(Rmenpai[mpnum].jvdian);
  Rscene[snum].menpai := mpnum;

  addsw := 10 + random(10);
  Dec(Rmenpai[mpnum2].shengwang, addsw);
  Inc(Rmenpai[mpnum].shengwang, addsw);
  Inc(Rmenpai[mpnum2].kzq, 10);
  Inc(Rmenpai[mpnum2].dzq, 10);
  Inc(Rmenpai[mpnum2].czsd, 10);
  for j := 0 to 9 do
  begin
    Rmenpai[mpnum].aziyuan[j] := Rmenpai[mpnum].aziyuan[j] + Rscene[snum].addziyuan[j];
    Rmenpai[mpnum2].aziyuan[j] := Rmenpai[mpnum2].aziyuan[j] - Rscene[snum].addziyuan[j];
  end;
  changempgx(mpnum, mpnum2, -100);
  tmp := -1;
  n := 0;
  if Rmenpai[mpnum2].zongduo = snum then
  begin
    for i := 0 to length(Rscene) - 1 do
    begin
      if (Rscene[i].menpai = mpnum2) and (Rscene[i].lwc > tmp) then
      begin
        tmp := Rscene[i].lwc;
        n := i;
      end;
    end;
    if tmp >= 0 then
    begin
      Rmenpai[mpnum2].zongduo := n;
      for i := 0 to length(Rrole) - 1 do
      begin
        if (Rrole[i].MenPai = Rscene[snum].menpai) and (Rrole[i].weizhi = snum) then
        begin
          Rrole[i].weizhi := n;
          Rrole[i].nweizhi := 14;
          Inc(Rrole[i].dtime, 5);
        end;
      end;
    end
    else
    begin
      x50[$7200] := mpnum;
      x50[$7201] := mpnum2;
      if mpnum2 = Rrole[0].menpai then
      begin
        ShowTitle(13, $15);
        instruct_15;
        exit;
      end;
      if Rmenpai[mpnum2].endevent > 0 then
        CallEvent(Rmenpai[mpnum2].endevent);
      for i := 0 to length(Rscene) - 1 do
      begin
        if (Rscene[i].menpai = mpnum2) then
        begin
          Rscene[i].menpai := mpnum;
          Inc(Rmenpai[mpnum].jvdian);
          for j := 0 to 9 do
          begin
            Rmenpai[mpnum].aziyuan[j] := Rmenpai[mpnum].aziyuan[j] + Rscene[i].addziyuan[i];
            Rmenpai[mpnum2].aziyuan[j] := Rmenpai[mpnum2].aziyuan[j] - Rscene[i].addziyuan[i];
          end;

        end;
      end;
      Rmenpai[mpnum2].jvdian := 0;
      Rmenpai[mpnum2].zongduo := -1;
      if mpnum = Rrole[0].MenPai then
      begin
        for i := 0 to 399 do
        begin
          if (Rmpmagic[mpnum2][i] > 0) and (Rmagic[Rmpmagic[mpnum2][i]].Ismichuan = 0) and
            (Ritem[Rmagic[Rmpmagic[mpnum2][i]].miji].Rate > 15) then
          begin
            for j := 0 to 399 do
            begin
              if Rmpmagic[mpnum][j] = Rmpmagic[mpnum2][i] then
                break;
            end;
            if (j > 399) and (randomf1 < 2000) then
            begin
              instruct_2(Rmagic[Rmpmagic[mpnum2][i]].miji, 1);
            end;
          end;
        end;
      end;
      for i := 0 to length(Rrole) - 1 do
      begin
        if Rrole[i].MenPai = mpnum2 then
        begin
          if (i >= 300) and (i < 500) then
          begin
            Rrole[i].HeadNum := -1;
            Rrole[i].currentHP := 0;
          end
          else
          begin
            Rrole[i].nweizhi := 20;
            Rrole[i].dtime := 1000;
            Rrole[i].currentHP := 0;
          end;
        end;
      end;
      Inc(addsw, 50 + Rmenpai[mpnum2].shengwang div 10);
      str := '���������桿' + gbktounicode(@Rmenpai[mpnum2].Name) + '��' + gbktounicode(@Rmenpai[mpnum].Name) +
        '�������������ϏĴ������@һ��....';
      addtips(str);
    end;
  end;
  setbuild(snum);
  initialMPdiaodu;
end;

function confirmgongji(mpnum1, mpnum2: integer): integer;
var
  i, key, x, y, tmp: integer;
  str: WideString;
begin
  x := CENTER_X - 120;
  y := 200;
  Result := -1;

  case Rmenpai[mpnum1].guanxi[mpnum2] of
    0..99:
    begin
      str := 'Ҫ�����𔳆�';
      key := 0;
    end;
    100..299:
    begin
      str := 'Ҫ�������ˆ�';
      key := 1;
    end;
    300..699:
    begin
      str := 'Ҫ��������������';
      key := 2;
    end;
    700..899:
    begin
      str := 'Ҫ�����кÄ�����';
      key := 3;
    end;
    900..1000:
    begin
      str := 'Ҫ�����ֵ��T�Ɇ�';
      key := 4;
    end;
  end;
  setlength(menuengstring2, 0);
  setlength(menustring2, 3);
  menustring2[0] := str;
  menustring2[1] := '�M��';
  menustring2[2] := 'ȡ��';
  if CommonMenu22(x, y + 60, 240) = 0 then
  begin
    Rmenpai[mpnum1].guanxi[mpnum2] := Rmenpai[mpnum1].guanxi[mpnum2] div 2;
    Rmenpai[mpnum2].guanxi[mpnum1] := Rmenpai[mpnum2].guanxi[mpnum1] div 2;
    case key of
      0:
      begin
        for i := 0 to length(Rmenpai) - 1 do
        begin
          if Rmenpai[mpnum1].guanxi[i] < 300 then
          begin
            if random(3) = 0 then
            begin
              tmp := -random(30);
              changempgx(mpnum1, i, tmp);
            end;
          end;
          if Rmenpai[mpnum2].guanxi[i] >= 700 then
          begin
            if random(4) = 0 then
            begin
              tmp := -random(50);
              changempgx(mpnum1, i, tmp);
            end;
          end;
        end;
      end;
      1:
      begin
        for i := 0 to length(Rmenpai) - 1 do
        begin
          if Rmenpai[mpnum1].guanxi[i] < 300 then
          begin
            if random(2) = 0 then
            begin
              tmp := -random(30);
              changempgx(mpnum1, i, tmp);
            end;
          end;
          if Rmenpai[mpnum2].guanxi[i] >= 700 then
          begin
            if random(3) = 0 then
            begin
              tmp := -random(50);
              changempgx(mpnum1, i, tmp);
            end;
          end;
        end;
      end;
      2:
      begin
        for i := 0 to length(Rmenpai) - 1 do
        begin
          tmp := -random(50);
          changempgx(mpnum1, i, tmp);
          if Rmenpai[mpnum2].guanxi[i] >= 700 then
          begin
            if random(2) = 0 then
            begin
              tmp := -random(70);
              changempgx(mpnum1, i, tmp);
            end;
          end;
        end;
      end;
      3:
      begin
        for i := 0 to length(Rmenpai) - 1 do
        begin
          tmp := -random(100);
          changempgx(mpnum1, i, tmp);
          if Rmenpai[mpnum1].guanxi[i] >= 700 then
          begin
            if random(3) = 0 then
            begin
              tmp := -random(100);
              changempgx(mpnum1, i, tmp);
            end;
          end;
          if Rmenpai[mpnum2].guanxi[i] >= 700 then
          begin
            if random(3) = 0 then
            begin
              tmp := -random(110);
              changempgx(mpnum1, i, tmp);
            end;
          end;
        end;
        if random(3) = 0 then
          changempse(mpnum1, -1);
      end;
      4:
      begin
        for i := 0 to length(Rmenpai) - 1 do
        begin
          tmp := -random(200);
          changempgx(mpnum1, i, tmp);
          if Rmenpai[mpnum1].guanxi[i] >= 700 then
          begin
            tmp := -random(250);
            changempgx(mpnum1, i, tmp);
          end;
          if Rmenpai[mpnum2].guanxi[i] >= 700 then
          begin
            tmp := -random(280);
            changempgx(mpnum1, i, tmp);
          end;
        end;
      end;
    end;
    Result := 1;
  end
  else
    Result := -1;
end;

procedure drawgongji(max0, line, row, menu, menutop: integer);
var
  x, y: integer;
  str: WideString;
begin
  x := 40;
  y := CENTER_Y - 160;
  display_imgFromSurface(GONGJI_PIC.pic, 0, 0);
  DrawRectangle(x, y, 560, 52, 0, ColColor(255), 50);
  str := '�������������x��Ҫ�����ĵ��c������������';
  DrawShadowText(@str[1], CENTER_X - length(str) * 10 - 9, y + 15, ColColor($21), ColColor($23));
  DrawWideScrollMenu(x, y + 52, line, row, menutop, max0, menu);
end;


procedure DrawWideScrollMenu(x, y, line, row, menutop, max0, menu: integer);
var
  m, p, i: integer;
begin
  m := min(min(line * row, max0 + 1 - menutop), max0 + 1);
  DrawRectangle(x, y, line * 110 + 10, row * 22 + 6, 0, ColColor(255), 30);
  if length(menuEngString) > 0 then
    p := 1
  else
    p := 0;
  for i := menutop to menutop + m - 1 do
  begin
    if i = menu then
    begin
      DrawShadowText(@menuString[i][1], x - 17 + 110 * ((i - menutop) mod line), y + 2 + 22 *
        ((i - menutop) div line), ColColor($64), ColColor($66));
      if p = 1 then
        DrawEngShadowText(@menuEngString[i][1], x + 73 + 110 * ((i - menutop) mod line), y +
          2 + 22 * ((i - menutop) div line), ColColor($64), ColColor($66));
    end
    else
    begin
      DrawShadowText(@menuString[i][1], x - 17 + 110 * ((i - menutop) mod line), y + 2 + 22 *
        ((i - menutop) div line), ColColor($5), ColColor($7));
      if p = 1 then
        DrawEngShadowText(@menuEngString[i][1], x + 73 + 110 * ((i - menutop) mod line), y +
          2 + 22 * ((i - menutop) div line), ColColor($5), ColColor($7));
    end;
  end;

end;


procedure anpai(rnum: integer);
var
  i, i1, i2, mpnum, snum, rm: integer;
begin

  mpnum := Rrole[rnum].menpai;
  snum := Rrole[rnum].weizhi;
  if mpnum <> Rscene[snum].menpai then
    exit;
  if (mpnum < 0) or (snum < 0) then
    exit;
  rm := random(Rrole[rnum].lwq + 2 * Rrole[rnum].msq + 2 * Rrole[rnum].ldq + Rrole[rnum].qtq);
  if rm < Rrole[rnum].lwq then
  begin
    for i := 0 to Rscene[snum].lwc do
    begin
      if SceAnpai[snum][i] < 0 then
      begin
        Rrole[rnum].dtime := 1;
        Rrole[rnum].nweizhi := i;
        setrole(snum, rnum, 1);
        break;
      end;
    end;
    if i > Rscene[snum].lwc then
    begin
      for i1 := 0 to 9 do
      begin
        if Rscene[snum].lianjie[i1] < 0 then
          break;
        if Rscene[Rscene[snum].lianjie[i1]].menpai <> mpnum then
          continue;
        if Rscene[Rscene[snum].lianjie[i1]].lwc > -1 then
        begin
          for i := 0 to Rscene[Rscene[snum].lianjie[i1]].lwc do
          begin
            if SceAnpai[Rscene[snum].lianjie[i1]][i] < 0 then
            begin
              Rrole[rnum].dtime := 1;
              Rrole[rnum].nweizhi := i;
              setrole(Rscene[snum].lianjie[i1], rnum, 1);
              break;
            end;
          end;
          if i <= Rscene[Rscene[snum].lianjie[i1]].lwc then
            break;
        end;
      end;
    end;
  end
  else if (rm - Rrole[rnum].lwq) < Rrole[rnum].msq then
  begin
    for i := 0 to Rscene[snum].cjg do
    begin
      if SceAnpai[snum][i + 5] < 0 then
      begin
        Rrole[rnum].dtime := 1;
        Rrole[rnum].nweizhi := i + 5;
        setrole(snum, rnum, 1);
        break;
      end;
    end;
    if i > Rscene[snum].cjg then
    begin
      for i1 := 0 to 9 do
      begin
        if Rscene[snum].lianjie[i1] < 0 then
          break;
        if Rscene[Rscene[snum].lianjie[i1]].menpai <> mpnum then
          continue;
        if Rscene[Rscene[snum].lianjie[i1]].cjg > -1 then
        begin
          for i := 0 to Rscene[Rscene[snum].lianjie[i1]].cjg do
          begin
            if SceAnpai[Rscene[snum].lianjie[i1]][i + 5] < 0 then
            begin
              Rrole[rnum].dtime := 1;
              Rrole[rnum].nweizhi := i + 5;
              setrole(Rscene[snum].lianjie[i1], rnum, 1);
              break;
            end;
          end;
          if i <= Rscene[Rscene[snum].lianjie[i1]].cjg then
            break;
        end;
      end;
    end;
  end
  else if (rm - Rrole[rnum].lwq - Rrole[rnum].msq) < Rrole[rnum].msq then
  begin
    if (SceAnpai[snum][10] < 0) and (Rscene[snum].bgskg > 0) then
    begin
      Rrole[rnum].dtime := 1;
      Rrole[rnum].nweizhi := 10;
      setrole(snum, rnum, 1);
    end
    else
    begin
      for i1 := 0 to 9 do
      begin
        if Rscene[snum].lianjie[i1] < 0 then
          break;
        if Rscene[Rscene[snum].lianjie[i1]].menpai <> mpnum then
          continue;
        if Rscene[Rscene[snum].lianjie[i1]].bgskg > 0 then
        begin
          if SceAnpai[Rscene[snum].lianjie[i1]][10] < 0 then
          begin
            Rrole[rnum].dtime := 1;
            Rrole[rnum].nweizhi := 10;
            setrole(Rscene[snum].lianjie[i1], rnum, 1);
            break;
          end;
        end;
      end;
    end;
  end
  else if (rm - Rrole[rnum].lwq - 2 * Rrole[rnum].msq) < Rrole[rnum].ldq then
  begin
    if (SceAnpai[snum][11] < 0) and (Rscene[snum].ldlkg > 0) then
    begin
      Rrole[rnum].dtime := 1;
      Rrole[rnum].nweizhi := 11;
      setrole(snum, rnum, 1);
    end
    else
    begin
      for i1 := 0 to 9 do
      begin
        if Rscene[snum].lianjie[i1] < 0 then
          break;
        if Rscene[Rscene[snum].lianjie[i1]].menpai <> mpnum then
          continue;
        if Rscene[Rscene[snum].lianjie[i1]].ldlkg > 0 then
        begin
          if SceAnpai[Rscene[snum].lianjie[i1]][11] < 0 then
          begin
            Rrole[rnum].dtime := 1;
            Rrole[rnum].nweizhi := 11;
            setrole(Rscene[snum].lianjie[i1], rnum, 1);
            break;
          end;
        end;
      end;
    end;
  end
  else if (rm - Rrole[rnum].lwq - 2 * Rrole[rnum].msq - Rrole[rnum].ldq) < Rrole[rnum].ldq then
  begin
    if (SceAnpai[snum][12] < 0) and (Rscene[snum].bqckg > 0) then
    begin
      Rrole[rnum].dtime := 1;
      Rrole[rnum].nweizhi := 12;
      setrole(snum, rnum, 1);
    end
    else
    begin
      for i1 := 0 to 9 do
      begin
        if Rscene[snum].lianjie[i1] < 0 then
          break;
        if Rscene[Rscene[snum].lianjie[i1]].menpai <> mpnum then
          continue;
        if Rscene[Rscene[snum].lianjie[i1]].bqckg > 0 then
        begin
          if SceAnpai[Rscene[snum].lianjie[i1]][12] < 0 then
          begin
            Rrole[rnum].dtime := 1;
            Rrole[rnum].nweizhi := 12;
            setrole(Rscene[snum].lianjie[i1], rnum, 1);
            break;
          end;
        end;
      end;
    end;
  end;
end;

procedure setrole(snum, rnum, mods: integer);
var
  tweizhi, tmpx, tmpy, i: integer;

begin
  if mods = 1 then
  begin
    tweizhi := Rrole[rnum].nweizhi;
    if ((tweizhi > -1) and (tweizhi < 5)) then
    begin
      tmpy := Rscene[snum].lwcx[tweizhi] + 1;
      tmpx := Rscene[snum].lwcy[tweizhi];
      Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 0] := rnum * 10 + 1;
      if Rrole[rnum].Impression > 0 then
        DData[snum, SData[snum, 3, tmpx, tmpy], 5] := (Rrole[rnum].Impression + 3) * 2;
      Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 6 + tweizhi;
      SceAnpai[snum][tweizhi] := rnum;
    end
    else if ((tweizhi > 4) and (tweizhi < 10)) then
    begin
      tmpy := Rscene[snum].cjgx[tweizhi - 5];
      tmpx := Rscene[snum].cjgy[tweizhi - 5] + 1;
      Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 0] := rnum * 10 + 1;
      if Rrole[rnum].Impression > 0 then
        DData[snum, SData[snum, 3, tmpx, tmpy], 5] := (Rrole[rnum].Impression + 2) * 2;
      Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 6 + tweizhi;
      SceAnpai[snum][tweizhi] := rnum;
    end
    else if tweizhi = 10 then
    begin
      tmpy := Rscene[snum].bgsx;
      tmpx := Rscene[snum].bgsy + 1;
      Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 0] := rnum * 10 + 1;
      if Rrole[rnum].Impression > 0 then
        DData[snum, SData[snum, 3, tmpx, tmpy], 5] := (Rrole[rnum].Impression + 2) * 2;
      Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 6 + tweizhi;
      SceAnpai[snum][tweizhi] := rnum;
    end
    else if tweizhi = 11 then
    begin
      tmpy := Rscene[snum].ldlx + 1;
      tmpx := Rscene[snum].ldly;
      Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 0] := rnum * 10 + 1;
      if Rrole[rnum].Impression > 0 then
        DData[snum, SData[snum, 3, tmpx, tmpy], 5] := (Rrole[rnum].Impression + 3) * 2;
      Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 6 + tweizhi;
      SceAnpai[snum][tweizhi] := rnum;
    end
    else if tweizhi = 12 then
    begin
      tmpy := Rscene[snum].bqcx;
      tmpx := Rscene[snum].bqcy - 1;
      Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 0] := rnum * 10 + 1;
      if Rrole[rnum].Impression > 0 then
        DData[snum, SData[snum, 3, tmpx, tmpy], 5] := (Rrole[rnum].Impression + 1) * 2;
      Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 6 + tweizhi;
      SceAnpai[snum][tweizhi] := rnum;
    end;
  end
  else
  begin
    if rnum > 0 then
    begin
      if snum < 0 then
        snum := curscene;
      tweizhi := Rrole[rnum].nweizhi;
      if ((tweizhi > -1) and (tweizhi < 5)) then
      begin
        tmpy := Rscene[snum].lwcx[tweizhi] + 1;
        tmpx := Rscene[snum].lwcy[tweizhi];
        DData[snum, SData[snum, 3, tmpx, tmpy], 0] := 0;
        DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 0;
        Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 0;
        SceAnpai[snum][tweizhi] := -1;
      end
      else if ((tweizhi > 4) and (tweizhi < 10)) then
      begin
        tmpy := Rscene[snum].cjgx[tweizhi - 5];
        tmpx := Rscene[snum].cjgy[tweizhi - 5] + 1;
        Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 0] := 0;
        DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 0;
        Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 0;
        SceAnpai[snum][tweizhi] := -1;
      end
      else if tweizhi = 10 then
      begin
        tmpy := Rscene[snum].bgsx;
        tmpx := Rscene[snum].bgsy + 1;
        Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 0] := 0;
        DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 0;
        Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 0;
        SceAnpai[snum][tweizhi] := -1;
      end
      else if tweizhi = 11 then
      begin
        tmpy := Rscene[snum].ldlx + 1;
        tmpx := Rscene[snum].ldly;
        Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 0] := 0;

        DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 0;
        Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 0;
        SceAnpai[snum][tweizhi] := -1;
      end
      else if tweizhi = 12 then
      begin
        tmpy := Rscene[snum].bqcx;
        tmpx := Rscene[snum].bqcy - 1;
        Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 0] := 0;

        DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 0;
        Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 0;
        SceAnpai[snum][tweizhi] := -1;
      end;
    end
    else
    begin
      if snum < 0 then
        snum := curscene;
      for i := 0 to Rscene[snum].zlwc do
      begin
        tmpy := Rscene[snum].lwcx[i] + 1;
        tmpx := Rscene[snum].lwcy[i];
        if (tmpy < 0) or (tmpx < 0) then
          continue;
        if SData[snum, 3, tmpx, tmpy] > 0 then
        begin
          DData[snum, SData[snum, 3, tmpx, tmpy], 0] := 0;
          DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 0;
          Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 0;
          SceAnpai[snum][i] := -1;
        end;
      end;
      for i := 0 to Rscene[snum].zcjg do
      begin
        tmpy := Rscene[snum].cjgx[i];
        tmpx := Rscene[snum].cjgy[i] + 1;
        if (tmpy < 0) or (tmpx < 0) then
          continue;
        if SData[snum, 3, tmpx, tmpy] > 0 then
        begin
          DData[snum, SData[snum, 3, tmpx, tmpy], 0] := 0;
          DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 0;
          Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 0;
          SceAnpai[snum][i + 5] := -1;
        end;
      end;

      tmpy := Rscene[snum].bgsx;
      tmpx := Rscene[snum].bgsy + 1;
      if (tmpy >= 0) and (tmpx >= 0) and (Rscene[snum].bgskg > 0) then
      begin
        if Sdata[snum, 3, tmpx, tmpy] >= 0 then
        begin
          Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 0] := 0;
          DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 0;
          Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 0;
          SceAnpai[snum][10] := -1;
        end;
      end;

      tmpy := Rscene[snum].ldlx + 1;
      tmpx := Rscene[snum].ldly;
      if (tmpy >= 0) and (tmpx >= 0) and (Rscene[snum].ldlkg > 0) then
      begin
        if Sdata[snum, 3, tmpx, tmpy] >= 0 then
        begin
          Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 0] := 0;
          DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 0;
          Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 0;
          SceAnpai[snum][11] := -1;
        end;
      end;

      tmpy := Rscene[snum].bqcx;
      tmpx := Rscene[snum].bqcy - 1;
      if (tmpy >= 0) and (tmpx >= 0) and (Rscene[snum].bqckg > 0) then
      begin
        if Sdata[snum, 3, tmpx, tmpy] >= 0 then
        begin
          Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 0] := 0;
          DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 0;
          Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 0;
          SceAnpai[snum][12] := -1;
        end;
      end;
    end;
  end;
end;

procedure joinmenpai(rnum, shifu: integer);
var
  str: WideString;
begin
  if shifu = -1 then
  begin
    zhuchu(rnum);
    exit;
  end;
  if (rnum > -1) and (rnum < length(Rrole) - 1) then
  begin
    if (Rrole[rnum].MenPai > 0) and (Rrole[rnum].MenPai < 40) then
    begin
      zhuchu(rnum);
      exit;
    end;
    if shifu >= 0 then
    begin
      Rrole[rnum].bssx := Rmenpai[Rrole[shifu].MenPai].dizi;
      Rrole[rnum].scsx := Rrole[shifu].scsx + 1;
      Rrole[rnum].shifu := shifu;
      Rmenpai[Rrole[shifu].MenPai].dizi := Rmenpai[Rrole[shifu].MenPai].dizi + 1;
      Dec(Rmenpai[Rrole[shifu].MenPai].aziyuan[3]);
      Rrole[rnum].MenPai := Rrole[shifu].MenPai;
      Rrole[rnum].weizhi := Rrole[shifu].weizhi;
      Rrole[rnum].nweizhi := -1;
      Rrole[rnum].dtime := 0;
      str := '����������' + GBKTOUNICODE(@Rrole[rnum].Name) + '����' + GBKTOUNICODE(@Rmenpai[Rrole[shifu].MenPai].Name);
      if (rnum = 0) or (shifu = 0) then
      begin
        DrawShadowText(@str[1], CENTER_X - 140, 40, ColColor($5), ColColor($7));
        SDL_UpdateRect2(screen, 0, 0, 561, 316);
        SDL_Delay(50 * (GameSpeed + 10));
      end;
      {else addtips(str); ����̫���ˣ�ɾ��}
    end;
  end;
end;

procedure changejiaoqing(rnum, Count: integer);
var
  str: WideString;
begin

  Inc(Rrole[rnum].jiaoqing, Count);
  Rrole[rnum].jiaoqing := max(-100, Rrole[rnum].jiaoqing);
  Rrole[rnum].jiaoqing := min(100, Rrole[rnum].jiaoqing);
  {str:=gbktounicode(@Rrole[0].name)+'�c'+gbktounicode(@Rrole[rnum].name)+'�����׃';
  drawshadowtext(@str[1], center_x - 12*length(str)-10 , 40, colcolor($5), colcolor($7));
  str := format('%4d', [count]);
  drawshadowtext(@str[1], center_x + 12*length(str)+10 , 40, colcolor($5), colcolor($7));

  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  SDL_Delay((500 * GameSpeed) div 10+500);}

end;

function sjqiecuo(rnum, jump1, jump2: integer): integer;
var
  i, btnum, rrnum, k,k1,k2, tr1, tr2: integer;
  trnum: array of smallint;
  zjmvalue,mvalue:double;
begin
  Result := jump2;
  btnum := random(50) + 1;
  if rnum > -1 then
  begin
    if Battle(btnum, 1, rnum, -1) then
      Result := jump1;
  end
  else
  begin
    k := 0;
    tr1 := 0;
    tr2 := 100;
    rrnum := -1;
    for i := 1 to length(Rrole) - 1 do
      if (Rrole[i].menpai = Rrole[0].MenPai) and (Rrole[i].dtime < 5) then
      begin
        setlength(trnum, k + 1);
        trnum[k] := i;
        Inc(k);
      end;
    k:=k-1;
    if k<0 then
      exit;
    levsort(trnum);
    k1:=-1;
    zjmvalue:=aotosetmagic(0,1);

    for i:=k  downto 0 do
    begin
      mvalue:=aotosetmagic(trnum[i],1);
      if (1.0 * (power(Rrole[trnum[i]].Level*15 + 100,1.8)) * mvalue)  > (1.0 * (power(Rrole[0].Level*15 + 100,1.8)) * zjmvalue) then
      begin
        k1:=i;
        break;
      end;
    end;

    if k1 < 0 then
      k1:=0;
    k2:=3;
    if k1 + k2 > k then
      k2:=k-k1+1;
    rrnum:=trnum[k1 + random(k2)];

    if Battle(btnum, 1, rrnum, -1) then
      Result := jump1;
  end;
end;

function menpaibattle(snum, mpnum1, mpnum2, jump1, jump2: integer): integer;
var
  mods, i: integer;
begin

  Result := jump2;

  for i := 0 to 19 do
    if mpbdata[i].key < 0 then
      break;
  mpbdata[i].key := 1;
  mpbdata[i].id := i;
  mpbdata[i].daytime := -1;
  mpbdata[i].attmp := mpnum1;
  mpbdata[i].defmp := mpnum2;
  mpbdata[i].snum := snum;
  if mpnum1 = Rrole[0].menpai then
  begin
    mods := -3;
    setlength(mpbdata[i].bteam[1].RoleArr, 1);
    mpbdata[i].bteam[1].rolearr[0].rnum := 863 + i;
    mpbdata[i].bteam[1].rolearr[0].isin := 0;
  end
  else if mpnum2 = Rrole[0].MenPai then
  begin
    mods := -2;
    setlength(mpbdata[i].bteam[0].RoleArr, 1);
    mpbdata[i].bteam[0].RoleArr[0].rnum := 863 + i;
    mpbdata[i].bteam[0].rolearr[0].isin := 0;
  end;
  if Battle(0, 1, mods, i) then
    Result := jump1;

end;

function xuanze2(jump1, jump2: integer): integer;
var
  menu: integer;
begin
  setlength(menuString, 0);
  setlength(menuString, 3);
  menuString[1] := 'Ҫ��';
  menuString[0] := 'ȡ��';
  menu := CommonMenu2(CENTER_X - 49, CENTER_Y - 50, 98);
  if menu = 1 then Result := jump1 else Result := jump2;
  Redraw;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

end;

procedure addmpshengwang(mpnum, value: integer);
var
  str: WideString;
begin
  if mpnum = -2 then
    mpnum := Rrole[0].menpai;
  Inc(Rmenpai[mpnum].shengwang, value);
  Rmenpai[mpnum].shengwang := max(0, Rmenpai[mpnum].shengwang);
  Rmenpai[mpnum].shengwang := min(1000, Rmenpai[mpnum].shengwang);
end;


//ljyinvader edit start

//����Ƿ�����

function iszhangmen(rnum, snum, jump1, jump2: integer): integer;
var
  i: integer;
begin
  Result := jump2;
  if snum = -2 then
  begin
    for i := 0 to length(Rmenpai) - 1 do
      if Rmenpai[i].zmr = rnum then Result := jump1;
  end
  else
  begin
    if snum = -1 then snum := curscene;
    if rmenpai[Rscene[snum].menpai].zmr = rnum then Result := jump1;
  end;
end;

//�������

function IsInMenpai(rnum, mpnum, jump1, jump2: integer): integer;
begin
  if mpnum = -1 then mpnum := Rscene[CurScene].menpai;
  Result := jump2;
  if Rrole[rnum].menpai = mpnum then Result := jump1;
end;

//�ж��Ѻö�

function chkyouhao(rnum, top, bottom, jump1, jump2: integer): integer;
var
  youhao: integer;
begin
  if rnum = -1 then rnum := Ddata[CurScene, CurEvent, 0] div 10;
  if top = 0 then top := 100;
  youhao := getyouhao(rnum);
  Result := jump2;
  if (youhao <= top) and (youhao >= bottom) then Result := jump1;
end;

function getyouhao(rnum: integer): integer;
var
  youhao: double;
  max0, min0, n: integer;
begin
  min0 := -100;
  max0 := 100;
  if Rrole[rnum].jiaoqing <= 0 then
    max0 := 0
  else if Rrole[rnum].jiaoqing < 5 then
    max0 := 5
  else if Rrole[rnum].jiaoqing < 10 then
    max0 := 10;
  youhao := power(Rrole[0].Repute, 0.7) * Rrole[rnum].swq / 180;
  youhao := youhao + (Rrole[0].Ethics - 50) * Rrole[rnum].pdq / 50;
  n := Rrole[0].Ethics - Rrole[rnum].Ethics;
  if abs(n) > 10 then
    n := -(abs(n) - 10)
  else
    n := abs(abs(n) - 10) * 9;
  youhao := youhao + n * Rrole[rnum].pdq / 90;
  youhao := youhao + (2 - (min(abs(Rrole[0].xiangxing - Rrole[rnum].xiangxing), 10 -
    (abs(Rrole[0].xiangxing - Rrole[rnum].xiangxing))))) * Rrole[rnum].xxq / 5;
  youhao := youhao + sign(Rrole[rnum].jiaoqing) * power(abs(Rrole[rnum].jiaoqing), 1.05) * Rrole[rnum].jqq / 50;
  Result := min(max0, max(round(youhao), min0));
end;


//��������ƶ�

function instruct_89(n1, n2, n3, jump1, jump2: integer): integer;
begin
  Result := jump2;
  if (rmenpai[n1].shane <= n2) and (rmenpai[n1].shane >= n3) then Result := jump1;
end;




//ljyinvader edit end

//luke edit strat

procedure zjcjg;
var
  n, k, k1, k2, tm, ltmp, zhiwujc6, zhiwujc9, mpnum, Aptitude: integer;
  tmp, lv: array[0..29] of integer;
  str: WideString;
  key: boolean;
begin
  mpnum := Rrole[0].MenPai;
  if Rmenpai[mpnum].zhiwu[6] >= 0 then zhiwujc6 :=
      Rrole[Rmenpai[mpnum].zhiwu[6]].Repute * Rrole[Rmenpai[mpnum].zhiwu[6]].level div 300
  else zhiwujc6 := 0;
  if Rmenpai[mpnum].zhiwu[9] >= 0 then zhiwujc9 :=
      Rrole[Rmenpai[mpnum].zhiwu[9]].Repute * Rrole[Rmenpai[mpnum].zhiwu[9]].level div 300
  else zhiwujc9 := 0;
  if CheckEquipSet(Rrole[0].equip[0], Rrole[0].equip[1], Rrole[0].equip[2], Rrole[0].equip[3]) = 2 then Aptitude := 100
  else Aptitude := Rrole[0].Aptitude;
  n := 0;
  for k := 0 to 29 do
  begin
    if Rrole[0].lmagic[k] <= 0 then break;
    if (Rrole[0].maglevel[k] < 400) and (Rrole[0].maglevel[k] >= 0) and
      (Rmagic[Rrole[0].lmagic[k]].magictype <> 5) then
    begin
      tmp[n] := k;
      Inc(n);
    end;
  end;
  if (n > 0) then
  begin

    tm := random(n);
    ltmp := Rrole[0].maglevel[tmp[tm]];
    Inc(Rrole[0].maglevel[tmp[tm]], round((Rrole[0].level * 3 + 30 - ltmp div 10) * (100 + random(100)) * (100 + zhiwujc6) / 50000));
    if random(150) < (Aptitude + 50) then
      Inc(Rrole[0].maglevel[tmp[tm]], round((Rrole[0].level * 3 + 30 - ltmp div 10) * (100 + random(100)) *
        (100 + zhiwujc6) / 50000));
    if Rrole[0].maglevel[tmp[tm]] > 999 then
      Rrole[0].maglevel[tmp[tm]] := 999;
    if ((Rrole[0].maglevel[tmp[tm]] div 100) > (ltmp div 100)) then
    begin
      str := gbktounicode(@Rrole[0].Name) + '��' + gbktounicode(@(Rmagic[Rrole[0].lmagic[tmp[tm]]].Name)) +
        '������' + IntToStr(Rrole[0].maglevel[tmp[tm]] div 100 + 1) + '��';
      EatOneItem(0, Rmagic[Rrole[0].lMagic[tmp[tm]]].miji, True);
      if Rrole[0].MagLevel[tmp[tm]] div 100 >= 2 then
        if Rrole[0].PracticeBook >= 0 then
          if Ritem[Rrole[0].PracticeBook].Magic = Rrole[0].lMagic[tmp[tm]] then
          begin
            instruct_32(Rrole[0].PracticeBook, 1);
            Rrole[0].PracticeBook := -1;
          end;
    end
    else str := gbktounicode(@Rrole[0].Name) + '������' + gbktounicode(@(Rmagic[Rrole[0].lmagic[tmp[tm]]].Name));
    DrawShadowText(@str[1], CENTER_X - length(str) * 10, 55, ColColor($21), ColColor($23));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay(50 * (GameSpeed + 10));
    Redraw;
  end
  else
  begin
    n := 0;
    for k := 0 to 29 do
    begin
      if Rrole[0].lmagic[k] <= 0 then break;
      for k1 := 0 to 399 do
      begin
        if Rrole[0].lmagic[k] = rmpmagic[mpnum][k1] then break;
        if rmpmagic[mpnum][k1] < 0 then
        begin
          for k2 := 0 to MAX_ITEM_AMOUNT - 1 do
          begin
            if Ritemlist[k2].number = Rmagic[Rrole[0].lmagic[k]].miji then break;
            if Ritemlist[k2].number < 0 then
            begin
              tmp[n] := Rrole[0].lmagic[k];
              lv[n] := Rrole[0].maglevel[k] div 100;
              Inc(n);
              break;
            end;
          end;
          break;
        end;
      end;
    end;
    if (n > 0) then
    begin
      tm := random(n);
      if (randomf1 < 1 + Aptitude * lv[tm] * (100 + zhiwujc9) div 270) then
      begin
        instruct_32(Rmagic[tmp[tm]].miji, 1);
        str := gbktounicode(@Rrole[0].Name) + '����' + gbktounicode(@(Ritem[Rmagic[tmp[tm]].miji].Name));
        DrawShadowText(@str[1], CENTER_X - length(str) * 12, 55, ColColor($21), ColColor($23));
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        SDL_Delay(50 * (GameSpeed + 10));
        Redraw;
      end;
    end;
  end;
end;

procedure zjbgsmenu;
var
  str: WideString;
  menu, menup, mpnum, x, y, w, max0, rst: integer;
begin
  mpnum := Rrole[0].menpai;
  menu := 0;
  x := CENTER_X + 40;
  y := CENTER_Y - 100;
  w := 50;
  max0 := 4;
  str := '����Ҫ�]�P���գ�';
  DrawRectangle(x - 64, y - 25, 160, 26, 0, ColColor(0, 255), 30);
  DrawShadowText(@str[1], x - 64, y - 24, ColColor($21), ColColor($23));
  setlength(menuString, 0);
  setlength(menuString, 5);
  setlength(menuEngString, 0);
  menuString[0] := '����';
  menuString[1] := 'ʮ��';
  menuString[2] := 'إ��';
  menuString[3] := 'ئ��';
  menuString[4] := 'ȡ��';
  SDL_EnableKeyRepeat(10, 100);
  ShowCommonMenu(x, y, w, max0, menu);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYDown:
      begin
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          menu := menu + 1;
          if menu > max0 then
            menu := 0;
          ShowCommonMenu(x, y, w, max0, menu);
          SDL_UpdateRect2(screen, x, y, w + 1, max0 * 22 + 29);
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          menu := menu - 1;
          if menu < 0 then
            menu := max0;
          ShowCommonMenu(x, y, w, max0, menu);
          SDL_UpdateRect2(screen, x, y, w + 1, max0 * 22 + 29);
        end;
      end;

      SDL_KEYUP:
      begin
        if ((event.key.keysym.sym = SDLK_ESCAPE)) then
        begin
          rst := 4;
          Redraw;
          SDL_UpdateRect2(screen, x, y, w + 1, max0 * 22 + 29);
          break;
        end;
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          rst := menu;
          //Redraw;
          SDL_UpdateRect2(screen, x, y, w + 1, max0 * 22 + 29);
          break;
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          rst := 4;
          Redraw;
          SDL_UpdateRect2(screen, x, y, w + 1, max0 * 22 + 29);
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          rst := menu;
          //Redraw;
          SDL_UpdateRect2(screen, x, y, w + 1, max0 * 22 + 29);
          break;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x >= x) and (event.button.x < x + w) and (event.button.y > y) and
          (event.button.y < y + max0 * 22 + 29) then
        begin
          menup := menu;
          menu := (event.button.y - y - 2) div 22;
          if menu > max0 then
            menu := max0;
          if menu < 0 then
            menu := 0;
          if menup <> menu then
          begin
            ShowCommonMenu(x, y, w, max0, menu);
            SDL_UpdateRect2(screen, x, y, w + 1, max0 * 22 + 29);
          end;
        end;
      end;
    end;
  end;
  //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(30, 30);
  case rst of
    0: zjbgs(5);
    1: zjbgs(10);
    2: zjbgs(20);
    3: zjbgs(30);
    4: exit;
  end;
end;

procedure zjbgs(day: integer);
var
  n, j, k, k1, k2, tm, ltmp, zhiwujc9, mpnum, Aptitude, tneigong: integer;
  tmp, lv: array[0..29] of integer;
  str: WideString;
  key: boolean;
begin
  mpnum := Rrole[0].menpai;
  str := '0';
  if Rmenpai[mpnum].zhiwu[9] >= 0 then zhiwujc9 :=
      Rrole[Rmenpai[mpnum].zhiwu[9]].Repute * Rrole[Rmenpai[mpnum].zhiwu[9]].level div 300
  else zhiwujc9 := 0;
  n := 0;
  for j := 0 to day - 1 do
  begin
    n := 0;
    for k := 0 to 29 do
    begin
      if Rrole[0].lmagic[k] <= 0 then break;
      if (Rmagic[Rrole[0].lmagic[k]].magictype = 5) and ((Rrole[0].maglevel[k] div 100) <
        Rmagic[Rrole[0].lmagic[k]].MaxLevel) then
      begin
        tmp[n] := k;

        Inc(n);
      end;
    end;
    if n > 0 then
    begin
      tm := random(n);
      ltmp := Rrole[0].maglevel[tmp[tm]];
      Inc(Rrole[0].maglevel[tmp[tm]], round((Rrole[0].level div 3 + 10) * (100 + random(100)) *
        (100 + zhiwujc9) / 100000));
      if Rrole[0].maglevel[tmp[tm]] div 100 > Rmagic[Rrole[0].lmagic[tmp[tm]]].MaxLevel then
        Rrole[0].maglevel[tmp[tm]] := Rmagic[Rrole[0].lmagic[tmp[tm]]].MaxLevel * 100;
      if ((Rrole[0].maglevel[tmp[tm]] div 100) > (ltmp div 100)) then
      begin
        EatOneItem(0, Rmagic[Rrole[0].lMagic[tmp[tm]]].miji, True);
        if Rrole[0].MagLevel[tmp[tm]] div 100 >= 2 then
          if Rrole[0].PracticeBook >= 0 then
            if Ritem[Rrole[0].PracticeBook].Magic = Rrole[0].lMagic[tmp[tm]] then
            begin
              instruct_32(Rrole[0].PracticeBook, 1);
              Rrole[0].PracticeBook := -1;
            end;
        str := gbktounicode(@Rrole[0].Name) + '��' + gbktounicode(@(Rmagic[Rrole[0].lmagic[tmp[tm]]].Name)) +
          '������' + IntToStr(Rrole[0].maglevel[tmp[tm]] div 100 + 1) + '��';
        DrawShadowText(@str[1], CENTER_X - length(str) * 10, 55, ColColor($21), ColColor($23));
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        SDL_Delay(50 * (GameSpeed + 10));
        Redraw;
      end;
    end
    else
    begin
      n := 0;
      for k := 0 to 29 do
      begin
        if Rrole[0].lmagic[k] <= 0 then break;
        if Rmagic[Rrole[0].lmagic[k]].magictype = 5 then
        begin
          for k1 := 0 to 9 do
          begin
            if Rmenpai[mpnum].neigong[k1] <= 0 then break;
            if Rmenpai[mpnum].neigong[k1] = Rrole[0].lmagic[k] then
            begin
              tmp[n] := Rrole[0].lmagic[k];
              lv[n] := Rrole[0].maglevel[k] div 100;
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
        if CheckEquipSet(Rrole[0].equip[0], Rrole[0].equip[1], Rrole[0].equip[2], Rrole[0].equip[3]) = 2 then
          Aptitude := 100
        else Aptitude := Rrole[0].Aptitude;
        for k := 0 to 29 do
        begin
          if Rrole[0].lmagic[k] <= 0 then break;
          if (Rmagic[Rrole[0].lmagic[k]].magictype <> 5) then
          begin
            if (Rmagic[Rrole[0].lmagic[k]].teshu[0] = 0) and ((Rmagic[Rrole[0].lmagic[k]].teshumod[0] = -1)) then
              break;
            for k1 := 0 to 9 do
            begin
              if (Rmagic[Rrole[0].lmagic[k]].teshu[k1] = tneigong) and
                ((Rmagic[Rrole[0].lmagic[k]].teshumod[k1] = 0) or
                (Rmagic[Rrole[0].lmagic[k]].teshumod[k1] = mpnum)) then
                break;
              if Rmagic[Rrole[0].lmagic[k]].teshu[k1] = 0 then
              begin
                if randomf2 < (40 + Aptitude) * lv[tm] * (100 + zhiwujc9) div 360 then
                begin
                  Rmagic[Rrole[0].lmagic[k]].teshu[k1] := tneigong;
                  Rmagic[Rrole[0].lmagic[k]].teshumod[k1] := mpnum;
                  str := gbktounicode(@Rrole[0].Name) + '��' + gbktounicode(@(Rmagic[tneigong].Name)) +
                    '�c' + gbktounicode(@(Rmagic[Rrole[0].lmagic[k]].Name)) + '�ڕ�؞ͨ';
                  DrawShadowText(@str[1], CENTER_X - length(str) * 12, 55, ColColor($21), ColColor($23));
                  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
                  SDL_Delay(50 * (GameSpeed + 10));
                  Redraw;
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
  end;
  instruct_14;
  dayto(day, 0);
  instruct_13;
  if str = '0' then
  begin
    str := gbktounicode(@Rrole[0].Name) + '�ޟ��˃ȹ�';
    DrawShadowText(@str[1], CENTER_X - length(str) * 12, 55, ColColor($21), ColColor($23));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_Delay(50 * (GameSpeed + 10));
    Redraw;
  end;

end;

procedure zjldl;
var
  n, j, k, k1, k2, tm, ltmp, zhiwujc7, mpnum, Aptitude, tneigong: integer;
  tmp, lv: array[0..29] of integer;
  str: WideString;
  key: boolean;
  db1, db2: double;
begin
  mpnum := Rrole[0].menpai;
  if Rmenpai[mpnum].zhiwu[7] >= 0 then zhiwujc7 :=
      Rrole[Rmenpai[mpnum].zhiwu[7]].Repute * Rrole[Rmenpai[mpnum].zhiwu[7]].level div 300
  else zhiwujc7 := 0;
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
    db1 := Rrole[0].level * Rrole[0].fuyuan;
    db2 := Ritem[k].rate * (100 + zhiwujc7);
    db1 := db1 * db2 / 200000;
    if (random(100) < db1) then
    begin
      instruct_32(k, 1);
      str := gbktounicode(@Rrole[0].Name) + '���u��' + gbktounicode(@(Ritem[k].Name));
      DrawShadowText(@str[1], CENTER_X - length(str) * 12, 55, ColColor($21), ColColor($23));
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      SDL_Delay(50 * (GameSpeed + 10));
      Redraw;
    end;
  end;
end;

procedure zjdzt;
var
  n, j, k, k1, k2, tm, ltmp, zhiwujc7, mpnum, Aptitude, tneigong: integer;
  tmp, lv: array[0..29] of integer;
  str: WideString;
  key: boolean;
  db1, db2: double;
begin
  mpnum := Rrole[0].menpai;
  if Rmenpai[mpnum].zhiwu[7] >= 0 then zhiwujc7 :=
      Rrole[Rmenpai[mpnum].zhiwu[7]].Repute * Rrole[Rmenpai[mpnum].zhiwu[7]].level div 300
  else zhiwujc7 := 0;
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
    db1 := Rrole[0].level * Rrole[0].fuyuan;
    db2 := Ritem[k].rate * (100 + zhiwujc7);
    db1 := db1 * db2 / 200000;
    if (random(100) < db1) then
    begin
      instruct_32(k, 1);
      str := gbktounicode(@Rrole[0].Name) + '�u���' + gbktounicode(@(Ritem[k].Name));
      DrawShadowText(@str[1], CENTER_X - length(str) * 12, 55, ColColor($21), ColColor($23));
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      SDL_Delay(50 * (GameSpeed + 10));
      Redraw;
    end;
  end;
end;

procedure xiugaievent(snum, enum, anum, value, atime: integer);
var
  addtime, i, tmp: integer;
begin
  if atime = 0 then addtime := 0
  else addtime := timetonum;
  if anum = 1 then
  begin
    Sdata[snum, 3, Ddata[snum, enum, 10], Ddata[snum, enum, 9]] := value;
    for i := 0 to 17 do
    begin
      tmp := Ddata[snum, value, i];
      Ddata[snum, value, i] := Ddata[snum, enum, i];
      Ddata[snum, enum, i] := tmp;
    end;
  end
  else Ddata[snum, enum, anum] := value + addtime;
end;

procedure addziyuan(mpnum, zynum, value: integer);
var
  str, str2, zyname: WideString;

begin
  if mpnum = -2 then mpnum := Rrole[0].MenPai;
  if (zynum < 0) or (zynum > 9) then exit;
  Rmenpai[mpnum].ziyuan[zynum] := Rmenpai[mpnum].ziyuan[zynum] + value;
  Rmenpai[mpnum].ziyuan[zynum] := max(-9999, Rmenpai[mpnum].ziyuan[zynum]);
  Rmenpai[mpnum].ziyuan[zynum] := min(9999, Rmenpai[mpnum].ziyuan[zynum]);
  case zynum of
    0: zyname := '�F�V';
    1: zyname := 'ʯ��';
    2: zyname := 'ľ��';
    3: zyname := 'ʳ��';
    4: zyname := '��̿';
    5: zyname := '��ˎ';
    6: zyname := '��ľ';
    7: zyname := '����';
    8: zyname := 'ϡ��';
    9: zyname := '���F';
  end;
  str := gbktounicode(@Rmenpai[mpnum].Name) + '��' + zyname + '�YԴ��׃';
  str2 := format('%4d', [value]);
  str := str + str2;
  addtips(str);
end;

function checkmpgx(mpnum, top, low, jump1, jump2: integer): integer;
begin
  if Rrole[0].MenPai < 0 then Result := jump2
  else if (Rmenpai[Rrole[0].MenPai].guanxi[mpnum] < low) or (Rmenpai[Rrole[0].MenPai].guanxi[mpnum] > top) then
    Result := jump2
  else Result := jump1;
end;

procedure changempgx(mpnum1, mpnum2, value: integer);
begin
  if mpnum1 = -1 then
    if Rrole[0].menpai > 0 then
      mpnum1 := Rrole[0].menpai;
  if mpnum2 = -1 then
    if Rrole[0].menpai > 0 then
      mpnum2 := Rrole[0].menpai;
  if (mpnum1 >= 0) and (mpnum2 >= 0) and (mpnum1 <> mpnum2) then
  begin
    Rmenpai[mpnum1].guanxi[mpnum2] := Rmenpai[mpnum1].guanxi[mpnum2] + value;
    Rmenpai[mpnum2].guanxi[mpnum1] := Rmenpai[mpnum2].guanxi[mpnum1] + value;
    Rmenpai[mpnum1].guanxi[mpnum2] := max(0, Rmenpai[mpnum1].guanxi[mpnum2]);
    Rmenpai[mpnum1].guanxi[mpnum2] := min(1000, Rmenpai[mpnum1].guanxi[mpnum2]);
    Rmenpai[mpnum2].guanxi[mpnum1] := max(0, Rmenpai[mpnum2].guanxi[mpnum1]);
    Rmenpai[mpnum2].guanxi[mpnum1] := min(1000, Rmenpai[mpnum2].guanxi[mpnum1]);
  end;
end;

function checkmpsw(mpnum, top, low, jump1, jump2: integer): integer;
begin
  Result := jump2;
  if mpnum = -1 then
  begin
    if Rrole[0].MenPai > 0 then mpnum := Rrole[0].MenPai;
  end;
  if mpnum > 0 then
  begin
    if (Rmenpai[mpnum].shengwang >= low) and (Rmenpai[mpnum].shengwang <= top) then Result := jump1;
  end;
end;

function checkmpse(mpnum, top, low, jump1, jump2: integer): integer;
begin
  Result := jump2;
  if mpnum = -1 then
  begin
    if Rrole[0].MenPai > 0 then mpnum := Rrole[0].MenPai;
  end;
  if mpnum > 0 then
  begin
    if (Rmenpai[mpnum].shane >= low) and (Rmenpai[mpnum].shane <= top) then Result := jump1;
  end;
end;

procedure changempse(mpnum, value: integer);
begin
  Rmenpai[mpnum].shane := Rmenpai[mpnum].shane + value;
  Rmenpai[mpnum].shane := max(-3, Rmenpai[mpnum].shane);
  Rmenpai[mpnum].shane := min(3, Rmenpai[mpnum].shane);
end;

function checkeventpar(snum, enum, pnum, top, low, jump1, jump2: integer): integer;
begin
  Result := jump1;
  if (Ddata[snum, enum, pnum] < low) or (Ddata[snum, enum, pnum] > top) then Result := jump2;
end;

function checkfy(xishu, jump1, jump2: integer): integer;
var
  i, alllev: integer;
  allfy, fy: double;
begin
  allfy := 0;
  alllev := 0;
  for i := 0 to 5 do
  begin
    if teamlist[i] >= 0 then
    begin
      allfy := allfy + Rrole[teamlist[i]].fuyuan * Rrole[teamlist[i]].Level;
      alllev := alllev + Rrole[teamlist[i]].Level;
    end;
  end;
  if alllev > 0 then fy := allfy / alllev
  else
  begin
    Result := jump2;
    exit;
  end;
  if randomf2 * xishu <= (fy + 50) * 6400 then Result := jump1
  else Result := jump2;

end;

procedure roledie(rnum: integer);
var
  i: integer;
begin
  if Rmenpai[Rrole[rnum].menpai].zmr = rnum then jiwei(Rrole[rnum].menpai, rnum);
  Rrole[rnum].nweizhi := 20;
  Rrole[rnum].dtime := 1000;
  if (Rrole[rnum].menpai > 0) and (Rrole[rnum].menpai < 40) then
  begin
    for i := 0 to 9 do
    begin
      if Rmenpai[Rrole[rnum].menpai].zhiwu[i] = rnum then Rmenpai[Rrole[rnum].menpai].zhiwu[i] := -1;
    end;
  end;

end;

procedure jiwei(mpnum, rnum: integer);
var
  i, k, big: integer;
  trnum: array of integer;
begin
  k := 0;
  big := -1;
  for i := 0 to length(Rrole) - 1 do
  begin
    if (Rrole[i].menpai = mpnum) and (Rrole[i].nweizhi <> 20) then
    begin
      setlength(trnum, k + 1);
      trnum[k] := i;
      if Rrole[i].bssx < big then big := Rrole[i].bssx;
      Inc(k);
    end;
  end;
  jiweisort(trnum, big);
  givezhangmen(trnum[0], rnum);
end;

procedure changezhongcheng(rnum, value: integer);
begin
  Inc(Rrole[rnum].zhongcheng, value);
  Rrole[rnum].zhongcheng := max(0, Rrole[rnum].zhongcheng);
  Rrole[rnum].zhongcheng := min(100, Rrole[rnum].zhongcheng);
end;

procedure talktotips(talknum: integer);

begin
  addtips(talktostr(talknum));
end;

function talktostr(talknum: integer): WideString;
var
  alen, ch, sh, n, namelen, i, j, t1, grp, idx, offset, len, i1, i2, c: integer;
  np3, np1, np2, tp, p1, ap: pchar;
  actorarray, name1, name2, talkarray: array of byte;
  str: array of char;
  pword: array[0..1] of uint16;
  strs: WideString;

begin

  pword[1] := 0;
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
  sh := 0;
  while ((puint16(tp + ch))^ shl 8 <> 0) and ((puint16(tp + ch))^ shr 8 <> 0) do
  begin
    pword[0] := (puint16(tp + ch))^;
    if (pword[0] and $FF = 0) or (pword[0] and $FF00 = 0) then break;
    if (pword[0] shr 8 <> 0) and (pword[0] shl 8 <> 0) then
    begin
      if (pword[0] = $2626) or (pword[0] = $2525) or (pword[0] = $2424) then
      begin
        case pword[0] of
          $2626: np3 := ap; //&&��ʾ����
          $2525: np3 := np2; //%%��ʾ��
          $2424: np3 := np1; //$$��ʾ��
        end;
        i := 0;

        while (puint16(np3 + i)^ shr 8 <> 0) and (puint16(np3 + i)^ shl 8 <> 0) do
        begin
          for j := 0 to 1 do
          begin
            setlength(str, sh + 1);
            str[sh] := (np3 + i)^;
            sh := sh + 1;
            i := i + 1;
            ch := ch + 1;
          end;
        end;
      end
      else
      begin
        for j := 0 to 1 do
        begin
          setlength(str, sh + 1);
          str[sh] := (tp + ch)^;
          sh := sh + 1;
          ch := ch + 1;
        end;
      end;

    end
    else break;

  end;

  Result := gbktounicode(@str[0]);

end;
//�S�C����

procedure suijijiangli(mpnum, mods, value: integer);
var
  tp, zy, i, n: integer;
  str: WideString;
begin
  if mpnum = -1 then mpnum := Rrole[0].MenPai;
  case mods of
    0:
    begin
      if (mpnum > 0) and (mpnum < 40) then
      begin
        if value > 19 then tp := randomf1 div 1000
        else tp := (randomf1) div 1112;
        if tp < 4 then zy := 1 + value div 2 + random(abs(value) div 2) * sign(value)
        else if tp = 4 then zy := 1 + value div 2 + random(abs(value)) * sign(value)
        else if tp < 9 then zy := 1 + value div 4 + random(abs(value) div 4) * sign(value)
        else zy := 1 + value div 10 + random(abs(value) div 10) * sign(value);
        addziyuan(mpnum, tp, zy);
      end;
    end;
    1:
    begin

      tp := randommiji(value);

      if tp < 0 then
        exit;
      instruct_32(tp, 1);
      str := gbktounicode(@Rmenpai[mpnum].Name) + '�@��' + gbktounicode(@Ritem[tp].Name);
      addtips(str);
    end;
    2:
    begin

      tp := randomyaopin(value);
      if tp < 0 then
        exit;
      instruct_32(tp, n);
      str := gbktounicode(@Rmenpai[mpnum].Name) + '�@��' + gbktounicode(@Ritem[tp].Name);
      addtips(str);

    end;
    3:
    begin

      tp := randomzhuangbei(value);
      if tp < 0 then
        exit;
      instruct_32(tp, 1);
      str := gbktounicode(@Rmenpai[mpnum].Name) + '�@��' + gbktounicode(@Ritem[tp].Name);
      addtips(str);

    end;
    4:
    begin

      tp := randomxiyouzhuangbei;
      if tp < 0 then
        exit;
      instruct_32(tp, 1);
      str := gbktounicode(@Rmenpai[mpnum].Name) + '�@��' + gbktounicode(@Ritem[tp].Name);
      addtips(str);

    end;
  end;
end;

procedure addteamjiaoqing(value: integer);
var
  i: integer;
begin
  for i := 1 to 5 do
  begin
    if teamlist[i] > -1 then changejiaoqing(Rrole[teamlist[i]].ListNum, value);
  end;
end;

procedure gotommap(x, y: integer);
begin
  if (x >= 0) and (x < 480) and (y >= 0) and (y <= 480) then
  begin
    Mx := y;
    My := x;
  end;
  nowstep := -1;
  ReSetEntrance;
  Where := 0;
  Rrole[0].weizhi := -1;
  resetpallet;
end;

procedure randomrole(mpnum, EthicsUp, EthicsDown, ReputeUp, ReputeDown, jqUp, jqDown, sex, v1, v2, yn, Rtype: integer);
var
  i, k, tmp: integer;
  trnum: array of smallint;

begin
  x50[v1] := -1;
  x50[v2] := -1;
  if (EthicsUp = 0) and (EthicsDown = 0) then EthicsUp := 100;
  if (ReputeUp = 0) and (ReputeDown = 0) then ReputeUp := 1000;
  if (Reputedown <= 0) then Reputedown := 1;
  k := 0;
  if mpnum = -2 then
  begin
    for i := 1 to length(Rrole) - 1 do
    begin
      if (Rrole[i].israndomed = 1) or (ischoushi(i,Rrole[0].menpai)) then continue;
      if Rrole[0].MenPai > 0 then
        if (Rmenpai[Rrole[0].MenPai].zmr = i) or (Rrole[i].MenPai = Rrole[0].menpai) then
          continue;
      if yn = 0 then
      begin
        if Rrole[i].zhongcheng = -2 then
        begin
          if (Rrole[i].Ethics >= EthicsDown) and (Rrole[i].Ethics <= Ethicsup) and
            (Rrole[i].Repute >= ReputeDown) and (Rrole[i].Repute <= ReputeUp) and
            ((Rrole[i].sexual = sex) or (sex = 3)) and (Rrole[i].dtime < 1) and
            (Rrole[i].jiaoqing >= jqdown) and (Rrole[i].jiaoqing <= jqUp) then
          begin
            if Rtype > 0 then
            begin
              if Rrole[i].Rtype = Rtype then
              begin
                setlength(trnum, k + 1);
                trnum[k] := i;
                Inc(k);
              end;
            end
            else
            begin
              setlength(trnum, k + 1);
              trnum[k] := i;
              Inc(k);
            end;
          end;
        end;
      end
      else
      begin
        if (Rrole[i].Ethics >= EthicsDown) and (Rrole[i].Ethics <= Ethicsup) and
          (Rrole[i].Repute >= ReputeDown) and (Rrole[i].Repute <= ReputeUp) and
          ((Rrole[i].sexual = sex) or (sex = 3)) and (Rrole[i].dtime < 1) and
          (Rrole[i].jiaoqing >= jqdown) and (Rrole[i].jiaoqing <= jqUp) then
        begin
          if Rtype > 0 then
          begin
            if Rrole[i].Rtype = Rtype then
            begin
              setlength(trnum, k + 1);
              trnum[k] := i;
              Inc(k);
            end;
          end
          else
          begin
            setlength(trnum, k + 1);
            trnum[k] := i;
            Inc(k);
          end;
        end;
      end;
    end;
  end
  else if mpnum = -3 then
  begin
    for i := 1 to length(Rrole) - 1 do
    begin
      if Rrole[i].israndomed = 1 then continue;
      if Rrole[0].MenPai > 0 then
        if Rmenpai[Rrole[0].MenPai].zmr <> i then
        begin
          if yn = 0 then
          begin
            if Rrole[i].zhongcheng = -2 then
            begin
              if (Rrole[i].Ethics >= EthicsDown) and (Rrole[i].Ethics <= Ethicsup) and
                (Rrole[i].Repute >= ReputeDown) and (Rrole[i].Repute <= ReputeUp) and
                ((Rrole[i].sexual = sex) or (sex = 3)) and (Rrole[i].menpai = Rrole[0].menpai) and
                (Rrole[i].dtime < 1) and (Rrole[i].jiaoqing >= jqdown) and (Rrole[i].jiaoqing <= jqUp) then
              begin
                if Rtype > 0 then
                begin
                  if Rrole[i].Rtype = Rtype then
                  begin
                    setlength(trnum, k + 1);
                    trnum[k] := i;
                    Inc(k);
                  end;
                end
                else
                begin
                  setlength(trnum, k + 1);
                  trnum[k] := i;
                  Inc(k);
                end;
              end;
            end;
          end
          else
          begin
            if (Rrole[i].Ethics >= EthicsDown) and (Rrole[i].Ethics <= Ethicsup) and
              (Rrole[i].Repute >= ReputeDown) and (Rrole[i].Repute <= ReputeUp) and
              ((Rrole[i].sexual = sex) or (sex = 3)) and (Rrole[i].menpai = Rrole[0].menpai) and
              (Rrole[i].dtime < 1) and (Rrole[i].jiaoqing >= jqdown) and (Rrole[i].jiaoqing <= jqUp) then
            begin
              if Rtype > 0 then
              begin
                if Rrole[i].Rtype = Rtype then
                begin
                  setlength(trnum, k + 1);
                  trnum[k] := i;
                  Inc(k);
                end;
              end
              else
              begin
                setlength(trnum, k + 1);
                trnum[k] := i;
                Inc(k);
              end;
            end;
          end;
        end;
    end;
  end
  else if mpnum = -1 then
  begin
    for i := 1 to length(Rrole) - 1 do
    begin
      if (Rrole[i].israndomed = 1)or (ischoushi(i,Rrole[0].menpai)) then continue;
      if Rrole[0].MenPai > 0 then
        if (Rrole[i].MenPai = Rrole[0].menpai) then
          continue;
      if yn = 0 then
      begin
        if Rrole[i].zhongcheng = -2 then
        begin
          if (Rrole[i].Ethics >= EthicsDown) and (Rrole[i].Ethics <= Ethicsup) and
            (Rrole[i].Repute >= ReputeDown) and (Rrole[i].Repute <= ReputeUp) and
            ((Rrole[i].sexual = sex) or (sex = 3)) and (Rrole[i].menpai > 0) and
            (Rrole[i].menpai <> Rrole[0].menpai) and (Rrole[i].dtime < 1) and
            (Rrole[i].jiaoqing >= jqdown) and (Rrole[i].jiaoqing <= jqUp) then
          begin
            if Rtype > 0 then
            begin
              if Rrole[i].Rtype = Rtype then
              begin
                setlength(trnum, k + 1);
                trnum[k] := i;
                Inc(k);
              end;
            end
            else
            begin
              setlength(trnum, k + 1);
              trnum[k] := i;
              Inc(k);
            end;
          end;
        end;
      end
      else
      begin
        if (Rrole[i].Ethics >= EthicsDown) and (Rrole[i].Ethics <= Ethicsup) and
          (Rrole[i].Repute >= ReputeDown) and (Rrole[i].Repute <= ReputeUp) and
          ((Rrole[i].sexual = sex) or (sex = 3)) and (Rrole[i].menpai > 0) and
          (Rrole[i].menpai <> Rrole[0].menpai) and (Rrole[i].dtime < 1) and (Rrole[i].jiaoqing >= jqdown) and
          (Rrole[i].jiaoqing <= jqUp) then
        begin
          if Rtype > 0 then
          begin
            if Rrole[i].Rtype = Rtype then
            begin
              setlength(trnum, k + 1);
              trnum[k] := i;
              Inc(k);
            end;
          end
          else
          begin
            setlength(trnum, k + 1);
            trnum[k] := i;
            Inc(k);
          end;
        end;
      end;
    end;
  end
  else
  begin
    for i := 1 to length(Rrole) - 1 do
    begin
      if Rrole[i].israndomed = 1 then continue;
      if Rrole[0].MenPai > 0 then
        if (Rmenpai[Rrole[0].MenPai].zmr = i) or ((Rrole[i].MenPai = Rrole[0].menpai) and (Rrole[i].dtime > 0)) then
          continue;
      if yn = 0 then
      begin
        if Rrole[i].zhongcheng = -2 then
        begin
          if (Rrole[i].Ethics >= EthicsDown) and (Rrole[i].Ethics <= Ethicsup) and
            (Rrole[i].Repute >= ReputeDown) and (Rrole[i].Repute <= ReputeUp) and
            ((Rrole[i].sexual = sex) or (sex = 3)) and (Rrole[i].menpai = mpnum) and
            (Rrole[i].dtime < 1) and (Rrole[i].jiaoqing >= jqdown) and (Rrole[i].jiaoqing <= jqUp) then
          begin
            if Rtype > 0 then
            begin
              if Rrole[i].Rtype = Rtype then
              begin
                setlength(trnum, k + 1);
                trnum[k] := i;
                Inc(k);
              end;
            end
            else
            begin
              setlength(trnum, k + 1);
              trnum[k] := i;
              Inc(k);
            end;
          end;
        end;
      end
      else
      begin
        if (Rrole[i].Ethics >= EthicsDown) and (Rrole[i].Ethics <= Ethicsup) and
          (Rrole[i].Repute >= ReputeDown) and (Rrole[i].Repute <= ReputeUp) and
          ((Rrole[i].sexual = sex) or (sex = 3)) and (Rrole[i].menpai = mpnum) and
          (Rrole[i].dtime < 1) and (not (ischoushi(i, Rrole[0].MenPai))) and (Rrole[i].jiaoqing >= jqdown) and
          (Rrole[i].jiaoqing <= jqUp) then
        begin
          if Rtype > 0 then
          begin
            if Rrole[i].Rtype = Rtype then
            begin
              setlength(trnum, k + 1);
              trnum[k] := i;
              Inc(k);
            end;
          end
          else
          begin
            setlength(trnum, k + 1);
            trnum[k] := i;
            Inc(k);
          end;
        end;
      end;
    end;
  end;
  if k > 0 then
  begin
    tmp := randomf3 * k div 10000;
    if trnum[tmp] > 0 then
    begin
      x50[v1] := trnum[tmp];
      x50[v2] := Rrole[trnum[tmp]].Impression;
      Rrole[trnum[tmp]].israndomed := 1;
    end;
  end;
end;

procedure clearrole(snum, rnum: integer);
var
  i: integer;
begin
  setrole(snum, rnum, 0);
end;

function checkjiaoqing(rnum, up, low, jump1, jump2: integer): integer;
begin
  if rnum = -1 then rnum := Ddata[CurScene, CurEvent, 0] div 10;
  Result := jump2;
  if (Rrole[rnum].jiaoqing >= low) and (Rrole[rnum].jiaoqing <= up) then
    Result := jump1;
end;

procedure changewardata(e1, wnum, dnum, value: integer);
var
  sta, offset, l, i, i1, i2, j, x, y, fieldnum, k, tmp: integer;
begin
  wnum := e_GetValue(0, e1, wnum);
  dnum := e_GetValue(1, e1, dnum);
  value := e_GetValue(2, e1, value);

  sta := FileOpen('resource\war.sta', fmopenread);
  l := sizeof(warsta);
  offset := wnum * l;
  FileSeek(sta, offset, 0);
  FileRead(sta, warsta, l);
  FileClose(sta);
  sta := FileOpen('resource\war.sta', fmopenwrite);
  WarSta.Data[dnum div 2] := value;
  FileSeek(sta, offset, 0);
  FileWrite(sta, warsta.Data[0], l);
  FileClose(sta);

end;

procedure rolejicheng(rnum1, rnum2: integer);
var
  i, tmp: integer;
  tmps: char;
begin
  tmp := Rrole[rnum1].headnum;
  Rrole[rnum1].headnum := Rrole[rnum2].headnum;
  Rrole[rnum2].HeadNum := tmp;
  tmp := Rrole[rnum1].sexual;
  Rrole[rnum1].sexual := Rrole[rnum2].sexual;
  Rrole[rnum2].sexual := tmp;
  for i := 0 to 9 do
  begin
    tmps := Rrole[rnum1].Name[i];
    Rrole[rnum1].Name[i] := Rrole[rnum2].Name[i];
    Rrole[rnum2].Name[i] := tmps;
    tmps := Rrole[rnum1].nick[i];
    Rrole[rnum1].nick[i] := Rrole[rnum2].nick[i];
    Rrole[rnum2].nick[i] := tmps;
  end;

end;

function aotobuildrole(mpnum, level, x1, x2: integer): integer;
var
  i, i1, j, k, k1, m1, readf, count1, count2, a1, a2: integer;
  add1: array[0..2] of integer;
  add2: array[0..4] of integer;
  tmag: array of smallint;
  tmp1, tmp2, tmp3, tmp4, tmp5: double;
  filename: string;
  fdata1, fdata2: array[0..9999] of byte;
  name1, name2: array of array[0..5] of char;

begin
  Result := -1;
  if (level < 1) or (level > MAX_LEVEL) then level := 1;
  for i := 300 to 599 do
  begin
    if Rrole[i].headNum > 0 then continue;
    Rrole[i].ListNum := i;
    Rrole[i].Rtype := Rmenpai[mpnum].identity;
    if Rmenpai[mpnum].sexy in [0, 2] then
    begin
      Rrole[i].Sexual := Rmenpai[mpnum].sexy;
      Rrole[i].HeadNum := Rmenpai[mpnum].mdizipic;
      Rrole[i].Impression := Rmenpai[mpnum].mdizigrp;
    end
    else if Rmenpai[mpnum].sexy = 1 then
    begin
      Rrole[i].Sexual := Rmenpai[mpnum].sexy;
      Rrole[i].HeadNum := Rmenpai[mpnum].fdizipic;
      Rrole[i].Impression := Rmenpai[mpnum].fdizigrp;
    end
    else if Rmenpai[mpnum].sexy = 3 then
    begin
      case random(2) of
        0:
        begin
          Rrole[i].Sexual := 0;
          Rrole[i].HeadNum := Rmenpai[mpnum].mdizipic;
          Rrole[i].Impression := Rmenpai[mpnum].mdizigrp;
        end;
        1:
        begin
          Rrole[i].Sexual := 1;
          Rrole[i].HeadNum := Rmenpai[mpnum].fdizipic;
          Rrole[i].Impression := Rmenpai[mpnum].fdizigrp;
        end;
      end;
    end;
    filename := 'resource\bjx';
    readf := FileOpen(filename, fmopenread);
    FileSeek(readf, 0, 0);
    FileRead(readf, fdata1[0], 10000);
    FileClose(readf);
    i1 := 0;
    k := 0;
    k1 := 0;
    setlength(name1, 1);
    while i1 < 10000 do
    begin
      if (fdata1[i1] = 101) and (fdata1[i1 + 1] = 100) then
      begin
        setlength(name1, k);
        count1 := k;
        break;
      end;
      if (fdata1[i1] = 13) and (fdata1[i1 + 1] = 10) then
      begin
        name1[k][k1] := char(0);
        name1[k][k1 + 1] := char(0);
        setlength(name1, k + 2);
        i1 := i1 + 1;
        k1 := 0;
        Inc(k);
      end
      else
      begin
        name1[k][k1] := char(fdata1[i1]);
        Inc(k1);
      end;
      Inc(i1);
    end;
    if Rrole[i].Sexual in [0, 2] then
      filename := 'resource\msm'
    else filename := 'resource\fsm';
    readf := FileOpen(filename, fmopenread);
    FileSeek(readf, 0, 0);
    FileRead(readf, fdata2[0], 10000);
    FileClose(readf);
    i1 := 0;
    k := 0;
    k1 := 0;
    setlength(name2, 1);
    while i1 < 10000 do
    begin
      if (fdata2[i1] = 101) and (fdata2[i1 + 1] = 100) then
      begin
        setlength(name2, k);
        count2 := k;
        break;
      end;
      if (fdata2[i1] = 13) and (fdata2[i1 + 1] = 10) then
      begin
        name2[k][k1] := char(0);
        name2[k][k1 + 1] := char(0);
        setlength(name2, k + 2);
        i1 := i1 + 1;
        k1 := 0;
        Inc(k);
      end
      else
      begin
        name2[k][k1] := char(fdata2[i1]);
        Inc(k1);
      end;
      Inc(i1);
    end;
    count1 := random(count1);
    count2 := random(count2);
    k := 0;
    k1 := 0;
    for i1 := 0 to 9 do
    begin
      if (k1 = 0) and (name1[count1][k] = char(0)) and (name1[count1][k + 1] = char(0)) then
      begin
        k := 0;
        Inc(k1);
      end;
      if (k1 = 1) and (name2[count2][k] = char(0)) and (name2[count2][k + 1] = char(0)) then
      begin
        Rrole[i].Name[i1] := char(0);
        Rrole[i].Name[i1 + 1] := char(0);
        break;
      end;
      if k1 = 0 then
      begin
        Rrole[i].Name[i1] := name1[count1][k];
        Inc(k);
      end
      else
      begin
        Rrole[i].Name[i1] := name2[count2][k];
        Inc(k);
      end;
    end;

    Rrole[i].IncLife := 1 + random(10);
    Rrole[i].MaxHP := 50 + random(50);
    Rrole[i].MaxMP := 50 + random(50);
    Rrole[i].CurrentHP := Rrole[i].MaxHP;
    Rrole[i].CurrentMP := Rrole[i].MaxMP;
    Rrole[i].MPType := random(2);
    for i1 := 0 to 2 do
    begin
      add1[i1] := 0;
    end;
    for i1 := 0 to 4 do
    begin
      add2[i1] := 0;
    end;
    for i1 := 0 to 3 do
    begin
      if (randomf1 div 100) < Rmenpai[mpnum].ShengWang div (10 + 30 * i1) then
      begin
        a1 := random(3);
        add1[a1] := add1[a1] + 10;
      end;
    end;
    for i1 := 0 to 3 do
    begin
      if (randomf2 div 100) < Rmenpai[mpnum].ShengWang div (10 + 30 * i1) then
      begin
        a2 := random(5);
        add2[a2] := add2[a2] + 10;
      end;
    end;
    Rrole[i].Attack := 21 + random(20) + add1[0];
    Rrole[i].Speed := 21 + random(20) + add1[1];
    Rrole[i].Defence := 21 + random(20 + add1[2]);
    Rrole[i].Medcine := 0;
    Rrole[i].UsePoi := 0;
    Rrole[i].MedPoi := 0;
    Rrole[i].Fist := 21 + random(20) + add2[0];
    Rrole[i].Sword := 21 + random(20 + add2[1]);
    Rrole[i].Knife := 21 + random(20) + add2[2];
    Rrole[i].Unusual := 21 + random(20) + add2[3];
    Rrole[i].HidWeapon := 21 + random(20 + add2[4]);
    Rrole[i].xiangxing := random(10);
    Rrole[i].Aptitude := 1 + random(100);
    Rrole[i].fuyuan := min(100, 100 - Rrole[i].Aptitude + random(11));
    Rrole[i].Ethics := random(51) - 25 + (Rmenpai[mpnum].shane + 3) * 15;
    Rrole[i].Ethics := max(0, Rrole[i].Ethics);
    Rrole[i].Ethics := min(100, Rrole[i].Ethics);
    Rrole[i].Repute := random(50) + 1;
    Rrole[i].level := level;
    Rrole[i].zhongcheng := 100;
    if mpnum = Rrole[0].menpai then
      Rrole[i].zhongcheng := min(100, 50 + getyouhao(i));
    Rrole[i].zhongcheng := min(100, max(0, Rrole[i].zhongcheng));
    Rrole[i].ExpForBook := 1000 + 2 * random(Rmenpai[mpnum].ShengWang);
    for i1 := 0 to 29 do
    begin
      Rrole[i].LMagic[i1] := 0;
      Rrole[i].MagLevel[i1] := 0;
    end;
    aotosetmagic(i);
    i1 := 1;
    while (i1 < level) do
    begin
      Rrole[i].MaxHP := Rrole[i].MaxHP + (150 + 15 * random(Rrole[i].IncLife)) div 10;
      if Rrole[i].MaxHP > MAX_HP then Rrole[i].MaxHP := MAX_HP;
      Rrole[i].CurrentHP := Rrole[i].MaxHP;

      Rrole[i].MaxMP := Rrole[i].MaxMP + (300 - 15 * random(Rrole[i].IncLife)) div 10;
      if Rrole[i].MaxMP > MAX_MP then Rrole[i].MaxMP := MAX_MP;
      Rrole[i].CurrentMP := Rrole[i].MaxMP;

      Rrole[i].Attack := Rrole[i].Attack + Rrole[i].Level mod 2;
      Rrole[i].Speed := Rrole[i].Speed + Rrole[i].Level mod 2;
      Rrole[i].Defence := Rrole[i].Defence + Rrole[i].Level mod 2;

      Rrole[i].PhyPower := MAX_PHYSICAL_POWER;
      Rrole[i].Hurt := 0;
      Rrole[i].Poision := 0;
      for j := 43 to 54 do
        Rrole[i].Data[j] := min(Rrole[i].Data[j], MaxProList[j]);
      Inc(i1);
    end;
    tmp1 := random(100) + 1;
    tmp2 := random(100) + 1;
    Rrole[i].swq := round(tmp1 * tmp2 / 100);
    Rrole[i].pdq := round(tmp1 * (100 - tmp2) / 100);
    Rrole[i].xxq := round((100 - tmp1) * tmp2 / 100);
    Rrole[i].jqq := 100 - Rrole[i].swq - Rrole[i].pdq - Rrole[i].xxq;
    tmp1 := random(100) + 1;
    tmp2 := random(100) + 1;
    tmp3 := random(100) + 1;
    Rrole[i].lwq := round(tmp1 * tmp2 / 100);
    Rrole[i].msq := round(tmp1 * (100 - tmp2) * tmp3 / 10000);
    Rrole[i].ldq := round(tmp1 * (100 - tmp2) * (100 - tmp3) / 10000);
    Rrole[i].qtq := 100 - Rrole[i].lwq - 2 * Rrole[i].msq - 2 * Rrole[i].ldq;

    if x1 >= 0 then
      x50[x1] := i;
    if x2 >= 0 then
      x50[x2] := Rrole[i].Impression;
    Result := i;
    break;
  end;
end;

procedure addtishi(talknum, btime, dtime: integer);
var
  pword: array[0..1] of uint16;
  strs: WideString;
  i, grp, idx, offset, len, Count: integer;
  talkarray: array of byte;
  tp: pchar;
begin
  if length(Rtishi) <= 0 then
  begin
    len := 0;
  end
  else
  begin
    len := length(Rtishi);
  end;
  if btime = 0 then btime := timetonum;
  for i := 0 to length(Rtishi) - 1 do
  begin
    if Rtishi[i].talknum = talknum then
    begin
      Rtishi[i].btime := btime;
      Rtishi[i].dtime := dtime;
      exit;
    end;
  end;
  setlength(Rtishi, len + 1);
  Rtishi[len].talknum := talknum;
  Rtishi[len].btime := btime;
  Rtishi[len].dtime := dtime;
end;

procedure gettishi(ntime, x1: integer);
var
  i, n, tmp: integer;
  tishiarr, tishinum: array of smallint;

begin
  n := 0;
  if ntime = 0 then ntime := timetonum;
  for i := 0 to length(Rtishi) - 1 do
  begin
    if (Rtishi[i].btime <= ntime) and (Rtishi[i].btime + Rtishi[i].dtime > ntime) then
    begin
      setlength(tishiarr, n + 1);
      tishiarr[n] := Rtishi[i].talknum;
      setlength(tishinum, n + 1);
      tishinum[n] := i;
      Inc(n);
    end;
  end;
  x50[x1] := 1356;
  if n > 0 then
  begin
    tmp := random(n);
    x50[x1] := tishiarr[tmp];
    for i := tishinum[tmp] to length(Rtishi) - 2 do
    begin
      Rtishi[i] := Rtishi[i + 1];
    end;
    tmp := length(Rtishi);
    setlength(Rtishi, tmp - 1);
  end;
end;

function ischoushi(rnum, mpnum: integer): boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to 1 do
    if Rrole[rnum].Choushi[i] = mpnum then
    begin
      Result := True;
      break;
    end;

end;

//������ƺ��ĶԻ�

procedure NewTalk2(rnum, talknum, showhead, place, ex, color, ey: integer);
var
  alen, newcolor, headnum, frame, namenum, color1, color2, nh, nw, ch, c1, r1, n, namelen,
  i, t1, grp, idx, offset, len, i1, i2, face, c, nx, ny, hx, hy, hw, hh, x, y, w, h, cell, row: integer;
  np3, np, np1, np2, np4, tp, p1, pp1, ap, app: pchar;
  actorarray, actorarray1, talkarray, namearray, name1, name2: array of byte;
  pword: array[0..1] of uint16;
  wd, str: string;
  na2: array[0..9] of char;
  temp2: WideString;
begin
  if color = 0 then color := 28515;
  frame := 0;

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

  //read name
  //read name
{  if namenum > 0 then
  begin
    idx := fileopen(NAME_IDX, fmopenread);
    grp := fileopen(NAME_GRP, fmopenread);
    fileseek(idx, (namenum - 1) * 4, 0);
    fileread(idx, offset, 4);
    fileread(idx, namelen, 4);

    namelen := (namelen - offset);

    setlength(namearray, namelen + 1);
    fileseek(grp, offset, 0);
    fileread(grp, namearray[0], namelen);
    fileclose(idx);
    fileclose(grp);
    for i := 0 to namelen - 2 do
    begin
      namearray[i] := namearray[i] xor $FF;
    end;
    np := @namearray[0];
  end
  else if namenum = -2 then
  begin
    for i := 0 to length(rrole) - 1 do
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
  end;   }

  if rnum < 0 then
  begin
    rnum := eventcaller(ex, ey);
  end;

  p1 := @Rrole[rnum].Name;
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
  namenum := rnum;
  headnum := Rrole[rnum].headnum;

  p1 := @Rrole[0].Name;
  alen := length(p1) + 2;
  setlength(actorarray, alen);
  ap := @actorarray[0];
  for n := 0 to alen - 3 do
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
    if ((showhead = 0) or (showhead = -2)) and (headnum >= 0) then
    begin
      DrawHeadPic(headnum, hx, hy);
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
          SDL_Delay(50 * (GameSpeed + 10));
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
        else if (pword[0] = $2626) or (pword[0] = $2525) or (pword[0] = $2424) or (pword[0] = $2121) or
          (pword[0] = $7E7E) or (pword[0] = $5B5B) then
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
            $2121: //!!�@ʾ�Q��
            begin
              chenghu(rnum, 0);
              np3 := @chenghuname;
            end;
            $7E7E: np3 := @Rrole[rnum].Name;

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

procedure levsort(var arr: array of smallint);
var
  i, j, key: integer;
  mvalue1,mvalue2:double;
begin
  for i := length(arr) - 2 downto 0 do
  begin
    key := arr[i];
    mvalue1:= aotosetmagic(key,1);
    for j := i + 1 to length(arr) - 1 do
    begin
      mvalue2:= aotosetmagic(arr[j],1);
      if (1.0*(Rrole[arr[j]].level + 30) * mvalue2) > (1.0*(Rrole[key].level + 30) * mvalue1) then
      begin
        arr[j - 1] := arr[j];
        arr[j] := key;
      end;
    end;
  end;
end;

function SelectGongjiRole(snum, snum2: integer; var battle_id: integer): boolean;
var
  i, i1, i2, x, y, mpnum, max0, j, k1, pnum, page, npage, menupage, menupp, menudzp, menudz, Count, len, len0: integer;
  trole, mrole: array of smallint;
  str, word: WideString;
  strs: array[0..1] of WideString;
begin
  x := 40;
  y := CENTER_Y - 160;
  Count := 0;
  Result := False;
  mpnum := Rscene[snum].menpai;
  max0 := 0;
  strs[0] := 'ǰ�';
  strs[1] := '���';
  for i := 0 to length(Rrole) - 1 do
  begin
    if ((Rrole[i].weizhi = snum) and (Rrole[i].menpai = mpnum) and (Rrole[i].dtime < 2)) or
      (Rrole[i].teamstate in [1, 2]) then
    begin
      setlength(trole, max0 + 1);
      trole[max0] := i;
      setlength(mrole, max0 + 1);
      mrole[max0] := 0;
      Inc(max0);
    end;
  end;
  Dec(max0);
  setlength(menustring2, 3);
  setlength(menuengstring2, 0);
  menustring2[0] := '�_��Ҫ�M���᣿';
  menustring2[1] := '�_��';
  menustring2[2] := 'ȡ��';
  Redraw;
  menupage := -1;
  menudz := -1;
  str := '��ѡ���c�M�����ˆT������x��Ո��ESC�_�J';
  pnum := 7;
  page := max0 div pnum;
  npage := 0;
  k1 := min(pnum - 1, max0 - npage * pnum);
  drawmultiRole(Trole, mrole, mpnum, 0, k1, max0, pnum, x, y, menudz);
  DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
  word := '��' + IntToStr(npage + 1) + '�';
  DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
  DrawRectangle(x + 185, y + 230, 120, 28, 0, ColColor(255), 30);
  for i := 0 to 1 do
    if i = menupage then
    begin
      DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($64), ColColor($66));
    end
    else
    begin
      DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($5), ColColor($7));
    end;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYDOWN:
      begin
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          menudz := menudz + 1;
          if menudz - npage * pnum >= pnum then
          begin
            npage := npage + 1;
            if npage > page then npage := 0;
          end;
          Redraw;
          k1 := min(pnum - 1, max0 - npage * pnum);
          drawmultirole(Trole, mrole, mpnum, npage * pnum, npage * pnum + k1, max0, pnum, x, y, menudz);
          DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
          word := '��' + IntToStr(npage + 1) + '�';
          DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
          DrawRectangle(x + 185, y + 230, 120, 28, 0, ColColor(255), 30);
          for i := 0 to 1 do
            if i = menupage then
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($64), ColColor($66));
            end
            else
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($5), ColColor($7));
            end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          menudz := menudz - 1;
          if menudz < npage * pnum then
          begin
            npage := npage - 1;
            if npage < 0 then npage := page;
          end;
          Redraw;
          k1 := min(pnum - 1, max0 - npage * pnum);
          drawmultirole(Trole, mrole, mpnum, npage * pnum, npage * pnum + k1, max0, pnum, x, y, menudz);
          DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
          word := '��' + IntToStr(npage + 1) + '�';
          DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
          DrawRectangle(x + 185, y + 230, 120, 28, 0, ColColor(255), 30);
          for i := 0 to 1 do
            if i = menupage then
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($64), ColColor($66));
            end
            else
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($5), ColColor($7));
            end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
      SDL_KEYUP:
      begin
        if ((event.key.keysym.sym = SDLK_ESCAPE)) and (where <= 2) then
        begin
          if Count > 0 then
          begin
            if CommonMenu22(CENTER_X - 110, y + 40, 220) = 0 then
            begin
              Result := True;
              for i := 0 to 19 do
                if mpbdata[i].key < 0 then
                  break;
              if i > 19 then
              begin
                str := '��������';
                Result := False;
                Redraw;
                DrawRectangle(CENTER_X - length(str) * 12, y + 14, 120, 24, 0, ColColor(255), 40);
                DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor($13), ColColor($15));
                SDL_UpdateRect2(screen, CENTER_X - length(str) * 12, y + 15, 120, 24);
                SDL_Delay(500 * (GameSpeed + 10));
                break;
              end;
              battle_id := i;
              mpbdata[i].key := 1;
              mpbdata[i].daytime := -1;
              mpbdata[i].attmp := Rscene[snum].MenPai;
              mpbdata[i].defmp := Rscene[snum2].menpai;
              mpbdata[i].snum := snum2;
              setlength(mpbdata[i].BTeam[1].RoleArr, 1);
              mpbdata[i].BTeam[1].RoleArr[0].rnum := 863 + i;
              mpbdata[i].BTeam[1].RoleArr[0].snum := Rrole[trole[i1]].weizhi;
              mpbdata[i].BTeam[1].RoleArr[0].isin := 0;
              len0 := 0;
              for i1 := 0 to length(mrole) - 1 do
              begin
                if mrole[i1] = 1 then
                begin
                  setlength(mpbdata[i].BTeam[0].RoleArr, len0 + 1);
                  mpbdata[i].BTeam[0].RoleArr[len0].rnum := trole[i1];
                  mpbdata[i].BTeam[0].RoleArr[len0].snum := Rrole[trole[i1]].weizhi;
                  mpbdata[i].BTeam[0].RoleArr[len0].isin := 0;
                  Rrole[trole[i1]].weizhi := snum2;
                  Rrole[trole[i1]].nweizhi := 16;
                  Rrole[trole[i1]].dtime := 1000;
                  Inc(len0);
                end;
              end;
            end;
          end;
          Redraw;
          break;
        end;
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          if menudz >= 0 then
          begin
            if mrole[menudz] = 0 then
            begin
              mrole[menudz] := 1;
              Inc(Count);
            end
            else
            begin
              mrole[menudz] := 0;
              Dec(Count);
            end;
            Redraw;
            k1 := min(pnum - 1, max0 - npage * pnum);
            drawmultirole(Trole, mrole, mpnum, npage * pnum, npage * pnum + k1, max0, pnum, x, y, menudz);
            DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
            word := '��' + IntToStr(npage + 1) + '�';
            DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
            DrawRectangle(x + 185, y + 230, 120, 28, 0, ColColor(255), 30);
            for i := 0 to 1 do
              if i = menupage then
              begin
                DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($64), ColColor($66));
              end
              else
              begin
                DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($5), ColColor($7));
              end;
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) and (where <= 2) then
        begin
          if Count > 0 then
          begin
            if CommonMenu22(CENTER_X - 110, y + 40, 220) = 0 then
            begin
              Result := True;
              for i := 0 to 19 do
                if mpbdata[i].key < 0 then
                  break;
              if i > 19 then
              begin
                str := '��������';
                Result := False;
                Redraw;
                DrawRectangle(CENTER_X - length(str) * 12, y + 14, 120, 24, 0, ColColor(255), 40);
                DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor($13), ColColor($15));
                SDL_UpdateRect2(screen, CENTER_X - length(str) * 12, y + 15, 120, 24);
                SDL_Delay(50 * (GameSpeed + 10));
                break;
              end;
              battle_id := i;
              mpbdata[i].key := 1;
              mpbdata[i].daytime := -1;
              mpbdata[i].attmp := Rscene[snum].MenPai;
              mpbdata[i].defmp := Rscene[snum2].menpai;
              mpbdata[i].snum := snum2;
              setlength(mpbdata[i].BTeam[1].RoleArr, 1);
              mpbdata[i].BTeam[1].RoleArr[0].rnum := 863 + i;
              mpbdata[i].BTeam[1].RoleArr[0].snum := Rrole[trole[i1]].weizhi;
              mpbdata[i].BTeam[1].RoleArr[0].isin := 0;
              len0 := 0;
              for i1 := 0 to length(mrole) - 1 do
              begin
                if mrole[i1] = 1 then
                begin
                  setlength(mpbdata[i].BTeam[0].RoleArr, len0 + 1);
                  mpbdata[i].BTeam[0].RoleArr[len0].rnum := trole[i1];
                  mpbdata[i].BTeam[0].RoleArr[len0].snum := Rrole[trole[i1]].weizhi;
                  mpbdata[i].BTeam[0].RoleArr[len0].isin := 0;
                  Rrole[trole[i1]].weizhi := snum2;
                  Rrole[trole[i1]].nweizhi := 16;
                  Rrole[trole[i1]].dtime := 1000;
                  Inc(len0);
                end;
              end;
            end;
          end;
          Redraw;
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          case menupage of
            0:
            begin
              npage := npage - 1;
              if npage < 0 then npage := page;
            end;
            1:
            begin
              npage := npage + 1;
              if npage > page then npage := 0;
            end;
          end;
          if menudz >= 0 then
          begin
            if mrole[menudz] = 0 then
            begin
              mrole[menudz] := 1;
              Inc(Count);
            end
            else
            begin
              mrole[menudz] := 0;
              Dec(Count);
            end;
          end;
          Redraw;
          k1 := min(pnum - 1, max0 - npage * pnum);
          drawmultiRole(Trole, mrole, mpnum, npage * pnum, npage * pnum + k1, max0, pnum, x, y, menudz);
          DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
          word := '��' + IntToStr(npage + 1) + '�';
          DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
          DrawRectangle(x + 185, y + 230, 120, 28, 0, ColColor(255), 30);
          for i := 0 to 1 do
            if i = menupage then
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($64), ColColor($66));
            end
            else
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($5), ColColor($7));
            end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        menupp := menupage;
        menupage := -1;
        menudzp := menudz;
        menudz := -1;
        if (event.button.x >= x + 190) and (event.button.x < x + 310) and (event.button.y > y + 230) and
          (event.button.y < y + 259) then
        begin
          menupp := menupage;
          menupage := (event.button.x - x - 185) div 60;
          if menupage > 1 then
            menupage := -1;
          if menupage < 0 then
            menupage := -1;
        end;
        if (event.button.x >= x + 40) and (event.button.x < x + 360) and (event.button.y > y + 75) and
          (event.button.y < y + 97 + 22 * k1) then
        begin
          menudzp := menudz;
          menudz := ((event.button.y - y - 75) div 22) + npage * pnum;
          if menudz > max0 then
            menudz := -1
          else if menudz < 0 then
            menudz := -1;
        end;
        if (menupp <> menupage) or (menudzp <> menudz) then
        begin
          Redraw;
          k1 := min(pnum - 1, max0 - npage * pnum);
          drawmultirole(Trole, mrole, mpnum, npage * pnum, npage * pnum + k1, max0, pnum, x, y, menudz);
          DrawShadowText(@str[1], CENTER_X - length(str) * 12, y + 15, ColColor(249), ColColor(252));
          word := '��' + IntToStr(npage + 1) + '�';
          DrawShadowText(@word[1], CENTER_X - length(word) * 10 - 40, y + 265, ColColor($5), ColColor($7));
          DrawRectangle(x + 185, y + 230, 120, 28, 0, ColColor(255), 30);
          for i := 0 to 1 do
            if i = menupage then
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($64), ColColor($66));
            end
            else
            begin
              DrawShadowText(@strs[i][1], x + 175 + i * 60, y + 230 + 2, ColColor($5), ColColor($7));
            end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
    end;
  end;
  //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(30, 30);

end;

procedure drawMultirole(Trole, mrole: array of smallint; mpnum, bg, ed, max0, pnum, x, y, menu: integer);
var
  i, i1, i2, i3, n, k1, col1, col2: integer;
  strs: array[0..4] of WideString;
  word: WideString;
  wordtmp: array of array[0..5] of WideString;
begin
  n := 0;

  strs[0] := '����';
  strs[1] := '��B';
  strs[2] := '�Є�';
  strs[3] := ' ǰ�';
  strs[4] := ' ���';
  display_imgFromSurface(DIZI_PIC.pic, 0, 0);
  DrawRectangle(x - 30, y, 590, 315, 0, ColColor(255), 50);
  for i := 0 to 2 do
  begin
    DrawShadowText(@strs[i][1], x + 160 * i + 40, y + 45, ColColor($5), ColColor($7));
  end;
  if (ed >= 0) and (max0 >= ed) and ((ed - bg) >= 0) then
  begin
    k1 := ed - bg;
    setlength(wordtmp, k1 + 1);
    if (menu >= bg) and (menu <= ed) then
      DrawRectangle(x, y + 75 + 22 * (menu mod pnum), 560, 22, 0, ColColor(64), 20);
    i1 := bg;
    repeat
      begin
        wordtmp[n][0] := gbktounicode(@Rrole[trole[i1]].Name);
        wordtmp[n][1] := zhuangtaistr(trole[i1]);
        wordtmp[n][2] := xingdongstr(trole[i1]);
        if mrole[i1] = 0 then
        begin
          col1 := $41;
          col2 := $48;
        end
        else
        begin
          col1 := $66;
          col2 := $68;
        end;
        for i2 := 0 to 2 do
        begin
          DrawShadowText(@wordtmp[n][i2][1], x + 160 * i2 + 40, y + 75 + 22 * n, ColColor(col1), ColColor(col2));
        end;
        n := n + 1;
        if n > k1 then n := 0;
        Inc(i1);
      end;
    until i1 > ed;
  end;
end;

procedure showqingbao;
var
  i, x, y, w, max0, maxshow: integer;
  tsnum: array of smallint;
begin
  x := 5;
  y := 15;
  w := 110;
  maxshow := 18;

  max0 := 0;
  setlength(menuEngString, 0);
  setlength(menuString, 0);
  for i := 0 to length(Rscene) - 1 do
  begin
    if (Rscene[i].menpai > 0) and (Rscene[i].MainEntranceY1 > 0) and (Rscene[i].MainEntranceX1 > 0) then
    begin
      setlength(menuString, max0 + 1);
      menuString[max0] := gbktounicode(@Rscene[i].Name);
      setlength(tsnum, max0 + 1);
      tsnum[max0] := i;
      Inc(max0);
    end;
  end;
  max0 := max0 - 1;
  CommonScrollQingbao(x, y, w, max0, maxshow, tsnum);

end;

procedure CommonScrollQingbao(x, y, w, max0, maxshow: integer; tsnum: array of smallint);
var
  menu, menup, menutop: integer;
begin
  menu := 0;
  menutop := 0;
  SDL_EnableKeyRepeat(10, 100);

  maxshow := min(max0 + 1, maxshow);
  showcommonscrollQingbao(x, y, w, max0, maxshow, menu, menutop, tsnum);

  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYdown:
      begin
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          menu := menu + 1;
          if menu - menutop >= maxshow then
          begin
            menutop := menutop + 1;
          end;
          if menu > max0 then
          begin
            menu := 0;
            menutop := 0;
          end;
          showcommonscrollQingbao(x, y, w, max0, maxshow, menu, menutop, tsnum);

        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          menu := menu - 1;
          if menu <= menutop then
          begin
            menutop := menu;
          end;
          if menu < 0 then
          begin
            menu := max0;
            menutop := menu - maxshow + 1;
            if menutop < 0 then menutop := 0;
          end;
          showcommonscrollQingbao(x, y, w, max0, maxshow, menu, menutop, tsnum);

        end;
        if (event.key.keysym.sym = SDLK_PAGEDOWN) then
        begin
          menu := menu + maxshow;
          menutop := menutop + maxshow;
          if menu > max0 then
          begin
            menu := max0;
          end;
          if menutop > max0 - maxshow + 1 then
          begin
            menutop := max0 - maxshow + 1;
          end;
          showcommonscrollQingbao(x, y, w, max0, maxshow, menu, menutop, tsnum);

        end;
        if (event.key.keysym.sym = SDLK_PAGEUP) then
        begin
          menu := menu - maxshow;
          menutop := menutop - maxshow;
          if menu < 0 then
          begin
            menu := 0;
          end;
          if menutop < 0 then
          begin
            menutop := 0;
          end;
          showcommonscrollQingbao(x, y, w, max0, maxshow, menu, menutop, tsnum);

        end;

      end;

      SDL_KEYup:
      begin
        if ((event.key.keysym.sym = SDLK_ESCAPE)) and (where <= 2) then
        begin

          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
          {if (event.key.keysym.sym = sdlk_return) or (event.key.keysym.sym = sdlk_space) then
          begin
            result := menu;
            Redraw;
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            break;
          end; }
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) and (where <= 2) then
        begin

          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
          {if (event.button.button = sdl_button_left) then
          begin
            result := menu;
            Redraw;
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            break;
          end;}
        if (event.button.button = sdl_button_wheeldown) then
        begin
          menu := menu + 1;
          if menu - menutop >= maxshow then
          begin
            menutop := menutop + 1;
          end;
          if menu > max0 then
          begin
            menu := 0;
            menutop := 0;
          end;
          showcommonscrollQingbao(x, y, w, max0, maxshow, menu, menutop, tsnum);

        end;
        if (event.button.button = sdl_button_wheelup) then
        begin
          menu := menu - 1;
          if menu <= menutop then
          begin
            menutop := menu;
          end;
          if menu < 0 then
          begin
            menu := max0;
            menutop := menu - maxshow + 1;
            if menutop < 0 then
            begin
              menutop := 0;
            end;
          end;
          showcommonscrollQingbao(x, y, w, max0, maxshow, menu, menutop, tsnum);

        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x >= x) and (event.button.x < x + w) and (event.button.y > y) and
          (event.button.y < y + max0 * 22 + 29) then
        begin
          menup := menu;
          menu := (event.button.y - y - 2) div 22 + menutop;
          if menu > max0 then
            menu := max0;
          if menu < 0 then
            menu := 0;
          if menup <> menu then
          begin
            showcommonscrollQingbao(x, y, w, max0, maxshow, menu, menutop, tsnum);

          end;
        end;
      end;
    end;
  end;
  //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(30, 30);
end;

procedure showcommonscrollQingbao(x, y, w, max0, maxshow, menu, menutop: integer; tsnum: array of smallint);
var
  i, i1, m, Count: integer;
  str: WideString;
  strs: array[0..7] of WideString;
  zyname: array[0..9] of WideString;
begin

  strs[0] := '�T�ɣ�';
  strs[1] := '�T���P�S��';
  strs[2] := '��������';
  strs[3] := '���ؽ���';
  strs[4] := '���ص��Ӕ���';
  strs[5] := 'λ�ã�';
  strs[6] := '�a����';
  strs[7] := '�B�ӣ�';
  zyname[0] := '�F�V';
  zyname[1] := 'ʯ��';
  zyname[2] := 'ľ��';
  zyname[3] := 'ʳ��';
  zyname[4] := '��̿';
  zyname[5] := '��ˎ';
  zyname[6] := '��ľ';
  zyname[7] := '����';
  zyname[8] := 'ϡ��';
  zyname[9] := '���F';
  display_imgFromSurface(SKILL_PIC, 0, 0); //ȱͼ
  //showmessage(inttostr(y));
  m := min(maxshow, max0 + 1);
  DrawRectangle(x, y, w, m * 22 + 6, 0, ColColor(255), 30);
  DrawRectangle(x + w + 10, y, 500, 32, 0, ColColor(255), 30);
  DrawRectangle(x + w + 10, y + 40, 500, 350, 0, ColColor(255), 50);
  for i := menutop to menutop + m - 1 do
  begin
    if i = menu then
    begin
      DrawShadowText(@menuString[i][1], x - 17, y + 2 + 22 * (i - menutop), ColColor($64), ColColor($66));
    end
    else
    begin
      DrawShadowText(@menuString[i][1], x - 17, y + 2 + 22 * (i - menutop), ColColor($5), ColColor($7));
    end;
  end;
  if (menu >= 0) and (menu < length(tsnum)) then
  begin
    str := '����������������' + menuString[menu] + '����������������';
    DrawShadowText(@str[1], x + w + 45 + 10, y + 5, ColColor(0, $5), ColColor(0, $7));

    DrawShadowText(@strs[0][1], x + w, y + 50, ColColor(0, $21), ColColor(0, $23));
    str := gbktounicode(@Rmenpai[Rscene[tsnum[menu]].menpai].Name);
    DrawShadowText(@str[1], x + w + 80, y + 49, ColColor(0, $30), ColColor(0, $32));

    DrawShadowText(@strs[1][1], x + w + 250, y + 50, ColColor(0, $21), ColColor(0, $23));
    str := format('%4d', [Rmenpai[Rscene[tsnum[menu]].menpai].guanxi[0]]);
    DrawShadowText(@str[1], x + w + 110 + 250, y + 49, ColColor(0, $30), ColColor(0, $32));

    DrawShadowText(@strs[2][1], x + w, y + 77, ColColor(0, $21), ColColor(0, $23));
    str := format('%4d', [Rscene[tsnum[menu]].zlwc + 1]);
    if Rscene[tsnum[menu]].zlwc < 0 then
      str := '�o';
    DrawShadowText(@str[1], x + w + 110, y + 76, ColColor($30), ColColor($32));
    DrawShadowText(@strs[3][1], x + w + 250, y + 77, ColColor(0, $21), ColColor(0, $23));
    str := format('%4d', [Rscene[tsnum[menu]].zcjg + 1]);
    if Rscene[tsnum[menu]].zcjg < 0 then
      str := '�o';
    DrawShadowText(@str[1], x + w + 110 + 250, y + 76, ColColor($30), ColColor($32));

    Count := 0;
    for i := 0 to length(Rrole) - 1 do
    begin
      if (Rrole[i].menpai = Rscene[tsnum[menu]].menpai) and (Rrole[i].weizhi = tsnum[menu]) then
        Inc(Count);
    end;
    DrawShadowText(@strs[4][1], x + w, y + 104, ColColor(0, $21), ColColor(0, $23));
    str := format('%4d', [Count]);
    DrawShadowText(@str[1], x + w + 110, y + 103, ColColor($30), ColColor($32));

    DrawShadowText(@strs[5][1], x + w + 250, y + 104, ColColor(0, $21), ColColor(0, $23));
    str := format('%4d', [Rscene[tsnum[menu]].MainEntranceY1]) + '��' +
      format('%4d', [Rscene[tsnum[menu]].MainEntranceX1]);
    DrawShadowText(@str[1], x + w + 60 + 250, y + 103, ColColor(0, $30), ColColor(0, $32));


    DrawShadowText(@strs[6][1], x + w, y + 180, ColColor($5), ColColor($7));
    for i := 0 to 9 do
    begin
      DrawShadowText(@zyname[i][1], x + w + 100 * (i mod 5), y + 207 + 22 * (i div 5),
        ColColor(0, $21), ColColor(0, $23));
      str := format('%4d', [Rscene[tsnum[menu]].addziyuan[i]]);
      DrawShadowText(@str[1], x + w + 40 + 100 * (i mod 5), y + 206 + 22 * (i div 5), ColColor($30), ColColor($32));
    end;
    DrawShadowText(@strs[7][1], x + w, y + 285, ColColor($5), ColColor($7));
    for i := 0 to 9 do
    begin
      if (Rscene[tsnum[menu]].lianjie[i] >= 0) then
      begin
        str := gbktounicode(@Rscene[Rscene[tsnum[menu]].lianjie[i]].Name);
        DrawShadowText(@str[1], x + w + 100 * (i mod 5), y + 312 + 22 * (i div 5), ColColor(0, $21), ColColor(0, $23));

      end;
    end;

  end;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
end;

procedure ShutSceSheshi(snum: integer);
var
  i: integer;
begin
  for i := 0 to Rscene[snum].lwc do
  begin
    if (Rscene[snum].lwcx[i] > 0) and (Rscene[snum].lwcy[i] > 0) then
    begin
      DData[snum, SData[snum, 3, Rscene[snum].lwcy[i], Rscene[snum].lwcx[i]], 15] :=
        abs(DData[snum, SData[snum, 3, Rscene[snum].lwcy[i], Rscene[snum].lwcx[i]], 15] - 1);
    end;
  end;
  for i := 0 to Rscene[snum].cjg do
  begin
    if (Rscene[snum].cjgx[i] > 0) and (Rscene[snum].cjgy[i] > 0) then
    begin
      DData[snum, SData[snum, 3, Rscene[snum].cjgy[i], Rscene[snum].cjgx[i]], 15] :=
        abs(DData[snum, SData[snum, 3, Rscene[snum].cjgy[i], Rscene[snum].cjgx[i]], 15] - 1);
    end;
  end;
  DData[snum, SData[snum, 3, Rscene[snum].bgsy, Rscene[snum].bgsx], 15] :=
    abs(DData[snum, SData[snum, 3, Rscene[snum].bgsy, Rscene[snum].bgsx], 15] - 1);
  DData[snum, SData[snum, 3, Rscene[snum].ldly, Rscene[snum].ldlx], 15] :=
    abs(DData[snum, SData[snum, 3, Rscene[snum].ldly, Rscene[snum].ldlx], 15] - 1);
  DData[snum, SData[snum, 3, Rscene[snum].bqcy, Rscene[snum].bqcx], 15] :=
    abs(DData[snum, SData[snum, 3, Rscene[snum].bqcy, Rscene[snum].bqcx], 15] - 1);
end;

procedure BuildBattle(ID, dtime, gongjimp, fangyump, snum, rnum: integer);
var
  i, i1, i2: integer;
  str: WideString;
begin
  for i := 0 to 19 do
    if mpbdata[i].key < 0 then
      break;
  if i > 19 then
  begin
    str := '��������';
    Redraw;
    DrawRectangle(CENTER_X - length(str) * 12, 54, 120, 24, 0, ColColor(255), 40);
    DrawShadowText(@str[1], CENTER_X - length(str) * 12, 55, ColColor($13), ColColor($15));
    SDL_UpdateRect2(screen, CENTER_X - length(str) * 12, 54, 120, 24);
    SDL_Delay(50 * (GameSpeed + 10));
    exit;
  end;
  x50[id] := i;
  mpbdata[i].key := 1;
  mpbdata[i].daytime := dtime;
  mpbdata[i].attmp := gongjimp;
  mpbdata[i].defmp := fangyump;
  mpbdata[i].snum := snum;
  if rnum = 0 then
  begin

    setlength(mpbdata[i].BTeam[0].RoleArr, 1);
    mpbdata[i].BTeam[0].RoleArr[0].rnum := 0;
    mpbdata[i].BTeam[0].RoleArr[0].snum := CurScene;
    mpbdata[i].BTeam[0].RoleArr[0].isin := 0;
    setlength(mpbdata[i].BTeam[1].RoleArr, 1);
    mpbdata[i].BTeam[1].RoleArr[0].rnum := 863 + i;
    mpbdata[i].BTeam[1].RoleArr[0].snum := snum;
    mpbdata[i].BTeam[1].RoleArr[0].isin := 0;

    Rrole[0].weizhi := -1;
    where := 0;
    resetpallet;
    instruct_14;
    instruct_13;
    for i1 := 0 to 479 do
      for i2 := 0 to 479 do
        Fway[i1, i2] := -1;
    FindWay(Mx, My, -2);
    Moveman(Mx, My, Rscene[snum].MainEntranceX1, Rscene[snum].MainEntranceY1);
    nowstep := Fway[Rscene[snum].MainEntranceX1, Rscene[snum].MainEntranceY1] - 1;
    while nowstep >= 0 do
    begin
      if sign(linex[nowstep] - Mx) < 0 then
        MFace := 0
      else if sign(linex[nowstep] - Mx) > 0 then
        MFace := 3
      else if sign(liney[nowstep] - My) > 0 then
        MFace := 1
      else MFace := 2;
      MStep := 6 - nowstep mod 6;
      Mx := linex[nowstep];
      My := liney[nowstep];
      Dec(nowstep);
      adddate(3);
      DrawMMap;
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      SDL_Delay(5 * (GameSpeed + 10));
      if inship = 1 then
      begin
        shipx := My;
        shipy := Mx;
      end;
      if (shipy = Mx) and (shipx = My) then
      begin
        inship := 1;
      end;
    end;

    Mx := Rscene[snum].MainEntranceX1;
    My := Rscene[snum].MainEntranceY1;
    Sx := Rscene[snum].EntranceX;
    Sy := Rscene[snum].EntranceY;
    Cx := Sx;
    Cy := Sy;
    CurScene := snum;
    where := 1;
    Rrole[0].weizhi := CurScene;
    resetpallet;
    instruct_14;
    InitialScene;
    DrawScene;
    instruct_13;
    ShowSceneName(CurScene);
    Redraw;
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    NewTalk(0, 201, -2, 0, 0, 0, 0, 1);

    clearrole(snum, -1);
    Battle(0, 0, -3, i);
    instruct_14;
    InitialScene;
    DrawScene;
    instruct_13;
  end
  else
  begin
    Rscene[snum].inbattle := 1;
    str := gbktounicode(@Rmenpai[gongjimp].Name);
    str := str + '��' + gbktounicode(@Rscene[fangyump].Name) + '�l�ӹ�����';
    addtips(str);
    mpbdata[i].key := 1;
    mpbdata[i].daytime := dtime;
    mpbdata[i].attmp := gongjimp;
    mpbdata[i].defmp := fangyump;
    mpbdata[i].snum := snum;
    setlength(mpbdata[i].BTeam[3].RoleArr, 1);
    mpbdata[i].BTeam[3].RoleArr[0].rnum := 863 + i;
    mpbdata[i].BTeam[3].RoleArr[0].snum := snum;
    mpbdata[i].BTeam[3].RoleArr[0].isin := 0;
    mpbdata[i].BTeam[3].RoleArr[0].mag := 0;
    setlength(mpbdata[i].BTeam[2].RoleArr, 1);
    mpbdata[i].BTeam[2].RoleArr[0].rnum := rnum;
    mpbdata[i].BTeam[2].RoleArr[0].snum := Rrole[rnum].weizhi;
    mpbdata[i].BTeam[2].RoleArr[0].isin := 0;
    mpbdata[i].BTeam[2].RoleArr[0].mag := GetGeliveAblemag(rnum);
    Rrole[rnum].weizhi := snum;
    Rrole[rnum].nweizhi := 16;
    Rrole[rnum].dtime := 1000;
  end;

end;

procedure AddBattleRole(sign, ID, a, rnum1, rnum2, rnum3, rnum4, rnum5: integer);
var
  i, k, len, len1: integer;
  Rnum: array[0..4] of integer;
begin
  id := e_GetValue(0, sign, id);
  a := e_GetValue(1, sign, a);
  rnum[0] := e_GetValue(2, sign, rnum1);
  rnum[1] := e_GetValue(3, sign, rnum2);
  rnum[2] := e_GetValue(4, sign, rnum3);
  rnum[3] := e_GetValue(5, sign, rnum4);
  rnum[4] := e_GetValue(6, sign, rnum5);
  k := 0;
  for i := 0 to 4 do
    if (rnum[i] > 0) and (rnum[i] < length(Rrole)) then
      Inc(k);
  len := length(mpbdata[id].BTeam[a].RoleArr);
  for i := 0 to k - 1 do
  begin
    setlength(mpbdata[id].BTeam[a].RoleArr, len + 1);
    mpbdata[id].BTeam[a].RoleArr[len].rnum := rnum[i];
    mpbdata[id].BTeam[a].RoleArr[len].snum := Rrole[rnum[i]].weizhi;
    mpbdata[id].BTeam[a].RoleArr[len].isin := 0;
    mpbdata[id].BTeam[a].RoleArr[len].mag := GetGeliveableMag(rnum[i]);
    Rrole[rnum[i]].weizhi := mpbdata[id].snum;
    Rrole[rnum[i]].nweizhi := 16;
    Rrole[rnum[i]].dtime := 1000;
  end;

end;

procedure SecChangeMp(snum, mpnum: integer);
begin
  Rscene[snum].menpai := mpnum;
end;



procedure NewShop(cnum: integer);

var
  i, i1, i2, i3, j, k, k1, n, page, npage, pnum, x, y, w, menu, menup, menuz, menuzp, menud,
  menudp, menuyn, menudz, menudzp, money: integer;
  buylist: array[0..17] of TNewShop;
  strs: array[0..5] of WideString;
  word, str: WideString;
  wordtmp: array of array[0..5] of WideString;
begin
  SDL_EnableKeyRepeat(10, 100);
  Redraw;
  k := 0;
  j := 0;
  x := 40;
  y := CENTER_Y - 160;
  w := 120;
  pnum := 7;
  totalprice := 0;
  for i := 0 to 17 do
  begin
    if (Rshop[cnum].shopItem[i].amount * Rshop[cnum].shopItem[i].inum) > 0 then
    begin
      buylist[k].Item := Rshop[cnum].shopitem[i].inum;
      buylist[k].Amount := Rshop[cnum].shopitem[i].amount;
      buylist[k].Price := Ritem[Rshop[cnum].shopitem[i].inum].price;
      buylist[k].Seclectamount := 0;
      buylist[k].index := i;
      buylist[k].own_num := 0;
      for i1 := 0 to MAX_ITEM_AMOUNT - 1 do
      begin
        if RItemList[i1].Number = buylist[k].Item then
        begin
          buylist[k].own_num := RItemList[i1].Amount;
          break;
        end; //end if
      end;
      totalprice := totalprice + buylist[k].Seclectamount * buylist[k].Price;
      k := k + 1;
    end;
  end;
  money := 0;
  for i := 0 to MAX_ITEM_AMOUNT - 1 do
  begin
    if RItemList[i].Number = MONEY_ID then
    begin
      money := RItemList[i].Amount;
      break;
    end;
  end; //end for
  page := max(0, (k - 1)) div pnum;

  strs[0] := ' ǰ�';
  strs[1] := ' ���';
  strs[2] := ' ُ�I';
  strs[3] := ' ����';
  strs[4] := ' ȡ��';
  strs[5] := '������ͯ�şo�ۡ�����';

  menu := -1;
  menup := -1;
  menuyn := -1;
  menudz := -1;
  npage := 0;
  if k > 0 then
  begin

    k1 := min(pnum - 1, k - npage * pnum - 1);
    drawnewshop(buylist, npage * pnum, npage * pnum + k1, k - 1, pnum, money, x, y, menudz);
    DrawShadowText(@strs[5][1], CENTER_X - length(strs[5]) * 12, y + 15, ColColor(249), ColColor(252));
    str := format('%3d', [npage + 1]);
    word := '��     �';
    DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25 - 30, y + 265, ColColor($5), ColColor($7));
    DrawShadowText(@str[1], CENTER_X - 25 - 30, y + 265, ColColor($5), ColColor($7));
    DrawRectangle(CENTER_X - 120 - 50, y + 230, 265, 28, 0, ColColor(255), 30);
    for i := 0 to 4 do
      if i = menu then
      begin
        DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
      end
      else
      begin
        DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
      end;

    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    while (SDL_WaitEvent(@event) >= 0) do
    begin
      CheckBasicEvent;
      case event.type_ of
        SDL_KEYUP:
        begin
          if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
          begin
            k1 := min(pnum - 1, k - npage * pnum - 1);
            if (menudz > -1) and (menudz < k1) then
              menudz := menudz + 1
            else if menudz = k1 then
            begin
              menu := 0;
              menudz := -1;
            end
            else if (menu >= 0) and (menu < 4) then
            begin
              menudz := -1;
              menu := menu + 1;
            end
            else if menu = 4 then
            begin
              menudz := 0;
              menu := -1;
            end
            else if k1 > -1 then
            begin
              menudz := 0;
              menu := -1;
            end;

            Redraw;
            drawnewshop(buylist, npage * pnum, npage * pnum + k1, k - 1, pnum, money, x, y, menudz);
            DrawShadowText(@strs[5][1], CENTER_X - length(strs[5]) * 12, y + 15, ColColor(249), ColColor(252));
            str := format('%3d', [npage + 1]);
            word := '��     �';
            DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25 - 30, y + 265, ColColor($5), ColColor($7));
            DrawShadowText(@str[1], CENTER_X - 25 - 30, y + 265, ColColor($5), ColColor($7));
            DrawRectangle(CENTER_X - 120 - 50, y + 230, 265, 28, 0, ColColor(255), 30);
            for i := 0 to 4 do
              if i = menu then
              begin
                DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
              end
              else
              begin
                DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
              end;

            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

          end;
          if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
          begin
            k1 := min(pnum - 1, k - npage * pnum - 1);
            if (menudz > 0) and (menudz <= k1) then
              menudz := menudz - 1
            else if menudz = 0 then
            begin
              menudz := -1;
              menu := 4;
            end
            else if (menu > 0) then
            begin
              menudz := -1;
              menu := menu - 1;
            end
            else if menu = 0 then
            begin
              menudz := k1;
              menu := -1;
            end
            else if k1 > -1 then
            begin
              menudz := 0;
              menu := -1;
            end;

            Redraw;

            drawnewshop(buylist, npage * pnum, npage * pnum + k1, k - 1, pnum, money, x, y, menudz);
            DrawShadowText(@strs[5][1], CENTER_X - length(strs[5]) * 12, y + 15, ColColor(249), ColColor(252));
            str := format('%3d', [npage + 1]);
            word := '��     �';
            DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25 - 30, y + 265, ColColor($5), ColColor($7));
            DrawShadowText(@str[1], CENTER_X - 25 - 30, y + 265, ColColor($5), ColColor($7));
            DrawRectangle(CENTER_X - 120 - 50, y + 230, 265, 28, 0, ColColor(255), 30);
            for i := 0 to 4 do
              if i = menu then
              begin
                DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
              end
              else
              begin
                DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
              end;

            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;
          if (event.key.keysym.sym = SDLK_RIGHT) or (event.key.keysym.sym = SDLK_KP6) then
          begin
            k1 := min(pnum - 1, k - npage * pnum - 1);
            if (menu >= 0) and (menu < 4) then
              menu := menu + 1
            else if menu = 4 then
            begin
              menu := 0;
            end
            else
            begin
              menudz := -1;
              menu := 0;
            end;
            Redraw;
            drawnewshop(buylist, npage * pnum, npage * pnum + k1, k - 1, pnum, money, x, y, menudz);
            DrawShadowText(@strs[5][1], CENTER_X - length(strs[5]) * 12, y + 15, ColColor(249), ColColor(252));
            str := format('%3d', [npage + 1]);
            word := '��     �';
            DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25 - 30, y + 265, ColColor($5), ColColor($7));
            DrawShadowText(@str[1], CENTER_X - 25 - 30, y + 265, ColColor($5), ColColor($7));
            DrawRectangle(CENTER_X - 120 - 50, y + 230, 265, 28, 0, ColColor(255), 30);
            for i := 0 to 4 do
              if i = menu then
              begin
                DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
              end
              else
              begin
                DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
              end;

            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;
          if (event.key.keysym.sym = SDLK_LEFT) or (event.key.keysym.sym = SDLK_KP4) then
          begin
            k1 := min(pnum - 1, k - npage * pnum - 1);
            if (menu > 0) and (menu <= 4) then
              menu := menu - 1
            else if menu = 0 then
            begin
              menu := 4;
            end
            else
            begin
              menudz := -1;
              menu := 4;
            end;
            Redraw;

            drawnewshop(buylist, npage * pnum, npage * pnum + k1, k - 1, pnum, money, x, y, menudz);
            DrawShadowText(@strs[5][1], CENTER_X - length(strs[5]) * 12, y + 15, ColColor(249), ColColor(252));
            str := format('%3d', [npage + 1]);
            word := '��     �';
            DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25 - 30, y + 265, ColColor($5), ColColor($7));
            DrawShadowText(@str[1], CENTER_X - 25 - 30, y + 265, ColColor($5), ColColor($7));
            DrawRectangle(CENTER_X - 120 - 50, y + 230, 265, 28, 0, ColColor(255), 30);
            for i := 0 to 4 do
              if i = menu then
              begin
                DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
              end
              else
              begin
                DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
              end;

            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;
          if ((event.key.keysym.sym = SDLK_ESCAPE)) and (where <= 2) then
          begin
            Redraw;
            break;
          end;
          if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
          begin
            if (menudz >= 0) and (menudz <= k1) then
            begin
              if (buylist[npage * pnum + menudz].Seclectamount < buylist[npage * pnum + menudz].Amount) then
              begin
                if (totalprice + buylist[npage * pnum + menudz].Price <= money) then
                begin
                  Inc(buylist[npage * pnum + menudz].Seclectamount);
                  Inc(totalprice, buylist[npage * pnum + menudz].Price);
                end;
              end;

            end
            else if menu = 0 then
            begin
              npage := npage - 1;
              if npage < 0 then npage := page;
            end
            else if menu = 1 then
            begin
              npage := npage + 1;
              if npage > page then npage := 0;
            end
            else if menu = 2 then
            begin
              for i := 0 to k - 1 do //���ף�������
              begin
                if buylist[i].Seclectamount > 0 then
                begin
                  instruct_32(Rshop[cnum].Shopitem[buylist[i].index].inum, buylist[i].Seclectamount);
                  instruct_32(MONEY_ID, -(buylist[i].Price * buylist[i].Seclectamount));
                  Rshop[cnum].shopitem[buylist[i].index].Amount :=
                    Rshop[cnum].Shopitem[buylist[i].index].Amount - buylist[i].Seclectamount;
                  buylist[i].Amount := buylist[i].Amount - buylist[i].Seclectamount;
                  buylist[i].Seclectamount := 0; //���ý�������
                end; //end if seclectamount
              end; //end for
              Redraw;
              break;
            end
            else if menu = 3 then
            begin
              for j := 0 to k - 1 do
              begin
                buylist[j].Seclectamount := 0;
              end;
              totalprice := 0;
            end
            else if menu = 4 then
            begin
              Redraw;
              break;
            end;
            Redraw;
            k1 := min(pnum - 1, k - npage * pnum - 1);
            drawnewshop(buylist, npage * pnum, npage * pnum + k1, k - 1, pnum, money, x, y, menudz);
            DrawShadowText(@strs[5][1], CENTER_X - length(strs[5]) * 12, y + 15, ColColor(249), ColColor(252));
            str := format('%3d', [npage + 1]);
            word := '��     �';
            DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25 - 30, y + 265, ColColor($5), ColColor($7));
            DrawShadowText(@str[1], CENTER_X - 25 - 30, y + 265, ColColor($5), ColColor($7));
            DrawRectangle(CENTER_X - 120 - 50, y + 230, 265, 28, 0, ColColor(255), 30);
            for i := 0 to 4 do
              if i = menu then
              begin
                DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
              end
              else
              begin
                DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
              end;

            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;
        end;
        SDL_MOUSEBUTTONUP:
        begin
          if (event.button.button = SDL_BUTTON_RIGHT) and (where <= 2) then
          begin
            Redraw;
            break;
          end;
          if (event.button.button = SDL_BUTTON_LEFT) then
          begin
            if menu >= 0 then
            begin
              case menu of
                0:
                begin
                  npage := npage - 1;
                  if npage < 0 then npage := page;
                end;
                1:
                begin
                  npage := npage + 1;
                  if npage > page then npage := 0;
                end;
                2:
                begin
                  for i := 0 to k - 1 do //���ף�������
                  begin
                    if buylist[i].Seclectamount > 0 then
                    begin
                      instruct_32(Rshop[cnum].Shopitem[buylist[i].index].inum, buylist[i].Seclectamount);
                      instruct_32(MONEY_ID, -(buylist[i].Price * buylist[i].Seclectamount));
                      Rshop[cnum].shopitem[buylist[i].index].Amount :=
                        Rshop[cnum].Shopitem[buylist[i].index].Amount - buylist[i].Seclectamount;
                      buylist[i].Amount := buylist[i].Amount - buylist[i].Seclectamount;
                      buylist[i].Seclectamount := 0; //���ý�������
                    end; //end if seclectamount
                  end; //end for
                  Redraw;
                  break;
                end;
                3:
                begin
                  for j := 0 to k - 1 do
                  begin
                    buylist[j].Seclectamount := 0;
                  end;
                  totalprice := 0;
                end;
                4:
                begin
                  Redraw;
                  break;
                end;
              end;
              Redraw;
              k1 := min(pnum - 1, k - npage * pnum - 1);
              drawnewshop(buylist, npage * pnum, npage * pnum + k1, k - 1, pnum, money, x, y, menudz);
              DrawShadowText(@strs[5][1], CENTER_X - length(strs[5]) * 12, y + 15, ColColor(249), ColColor(252));
              str := format('%3d', [npage + 1]);
              word := '��     �';
              DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25 - 30, y + 265, ColColor($5), ColColor($7));
              DrawShadowText(@str[1], CENTER_X - 25 - 30, y + 265, ColColor($5), ColColor($7));
              DrawRectangle(CENTER_X - 120 - 50, y + 230, 265, 28, 0, ColColor(255), 30);
              for i := 0 to 4 do
                if i = menu then
                begin
                  DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2,
                    ColColor($64), ColColor($66));
                end
                else
                begin
                  DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
                end;

              SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            end
            else if (menudz >= 0) and (menudz <= k1) then
            begin
              if (buylist[npage * pnum + menudz].Seclectamount < buylist[npage * pnum + menudz].Amount) then
              begin
                if (totalprice + buylist[npage * pnum + menudz].Price <= money) then
                begin
                  Inc(buylist[npage * pnum + menudz].Seclectamount);
                  Inc(totalprice, buylist[npage * pnum + menudz].Price);
                end;
              end;
              Redraw;
              k1 := min(pnum - 1, k - npage * pnum - 1);
              drawnewshop(buylist, npage * pnum, npage * pnum + k1, k - 1, pnum, money, x, y, menudz);
              DrawShadowText(@strs[5][1], CENTER_X - length(strs[5]) * 12, y + 15, ColColor(249), ColColor(252));
              str := format('%3d', [npage + 1]);
              word := '��     �';
              DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25 - 30, y + 265, ColColor($5), ColColor($7));
              DrawShadowText(@str[1], CENTER_X - 25 - 30, y + 265, ColColor($5), ColColor($7));
              DrawRectangle(CENTER_X - 120 - 50, y + 230, 265, 28, 0, ColColor(255), 30);
              for i := 0 to 4 do
                if i = menu then
                begin
                  DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2,
                    ColColor($64), ColColor($66));
                end
                else
                begin
                  DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
                end;
              SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            end;
          end;
        end;
        SDL_MOUSEMOTION:
        begin
          if (event.button.x >= CENTER_X - 50 - 120) and (event.button.x < CENTER_X - 60 - 120 + 249) and
            (event.button.y > y + 231) and (event.button.y < y + 256) then
          begin
            menudz := -1;
            menup := menu;
            menu := (event.button.x - CENTER_X + 50 + 120) div 50;
            if menu > 4 then
              menu := -1;
            if menu < 0 then
              menu := -1;
          end
          else if (event.button.x >= x + 10) and (event.button.x < x + 480) and
            (event.button.y > y + 75) and (event.button.y < y + 100 + 22 * k1) then
          begin
            menu := -1;
            menudzp := menudz;
            menudz := (event.button.y - y - 75) div 22;
            if menudz > k1 then
              menudz := -1;
            if menudz < 0 then
              menudz := -1;
          end
          else
          begin
            menup := menu;
            menu := -1;
            menudzp := menudz;
            menudz := -1;
          end;
          if (menup <> menu) or (menudzp <> menudz) then
          begin
            Redraw;
            k1 := min(pnum - 1, k - npage * pnum - 1);
            drawnewshop(buylist, npage * pnum, npage * pnum + k1, k - 1, pnum, money, x, y, menudz);
            DrawShadowText(@strs[5][1], CENTER_X - length(strs[5]) * 12, y + 15, ColColor(249), ColColor(252));
            str := format('%3d', [npage + 1]);
            word := '��     �';
            DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25 - 30, y + 265, ColColor($5), ColColor($7));
            DrawShadowText(@str[1], CENTER_X - 25 - 30, y + 265, ColColor($5), ColColor($7));
            DrawRectangle(CENTER_X - 120 - 50, y + 230, 265, 28, 0, ColColor(255), 30);
            for i := 0 to 4 do
              if i = menu then
              begin
                DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
              end
              else
              begin
                DrawShadowText(@strs[i][1], CENTER_X - 67 - 120 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
              end;

            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;

        end;

      end;
    end;
    //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
    event.key.keysym.sym := 0;
    event.button.button := 0;
    SDL_EnableKeyRepeat(30, 30);

  end;
end;

procedure drawnewshop(buylist: array of TNewshop; bg, ed, max0, pnum, money, x, y, menu: integer);
var
  i, i1, i2, i3, n, k1: integer;
  strs: array[0..4] of WideString;
  word: WideString;
  wordtmp: array of array[0..5] of WideString;

begin
  n := 0;
  strs[0] := '��Ʒ';
  strs[1] := '�΃r';
  strs[2] := '؛��';
  strs[3] := '����';
  strs[4] := '����';
  DrawRectangle(x - 30, y, 590, 315, 0, ColColor(255), 50);
  str(money, word);
  word := '����������' + format('%5d', [money]);
  DrawShadowText(@word[1], CENTER_X - 200 - length(word) * 10, y + 15, ColColor(49), ColColor(47));
  str(totalprice, word);
  word := '���ѹ��㣺' + format('%5d', [totalprice]);

  DrawShadowText(@word[1], CENTER_X + 80, y + 15, ColColor(49), ColColor(47));

  for i := 0 to 4 do
  begin
    DrawShadowText(@strs[i][1], x + 20 + 95 * i, y + 45, ColColor($5), ColColor($7));
  end;

  if (ed >= 0) and (max0 >= ed) and ((ed - bg) >= 0) then
  begin
    k1 := ed - bg;
    setlength(wordtmp, k1 + 1);
    if (menu >= 0) and (k1 >= 0) then DrawRectangle(x + 10, y + 75 + 22 * (menu mod pnum),
        540, 22, 0, ColColor(64), 20);
    for i := bg to ed do
    begin
      wordtmp[n][0] := gbktounicode(@Ritem[buylist[i].item].Name);
      wordtmp[n][1] := format('%3d', [buylist[i].Price]);
      wordtmp[n][2] := format('%3d', [buylist[i].Amount]);
      wordtmp[n][3] := format('%3d', [buylist[i].own_num]);
      wordtmp[n][4] := format('%3d', [buylist[i].Seclectamount]);
      DrawShadowText(@wordtmp[n][0][1], x + 0, y + 75 + 22 * n, ColColor($41), ColColor($48));
      for i2 := 1 to 4 do
      begin
        DrawShadowText(@wordtmp[n][i2][1], x + 50 + 95 * i2, y + 75 + 22 * n, ColColor($41), ColColor($48));
      end;
      n := n + 1;
      if n > k1 then n := 0;
    end;
  end;
end;

procedure addexpn(rnum, exp: integer);
var
  i, len: integer;
  str: WideString;
begin
  if rnum >= 0 then
  begin
    Rrole[rnum].exp := Rrole[rnum].exp + exp;

    DrawRectangle(CENTER_X - 70, CENTER_Y - 150 - 1, 220, 24, 0, ColColor(0, 255), 30);
    str := gbktounicode(@Rrole[rnum].Name);
    str := str + '�õ����';
    len := length(str);
    DrawShadowText(@str[1], CENTER_X - 70, CENTER_Y - 150, ColColor($5), ColColor($7));
    str := format('%5d', [exp]);
    DrawShadowText(@str[1], CENTER_X - 60 + len * 17, CENTER_Y - 150, ColColor($5), ColColor($7));
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    WaitAnyKey;
  end;
end;
//�����Tʹ�òˆ�

procedure showdizi2(mpnum: integer);
var
  i, i1, i2, i3, j, k, k1, n, page, npage, pnum, x, y, w, menu, menup, menuyn, menudz, menudzp: integer;
  trole: array[0..49] of smallint;
  strs: array[0..11] of WideString;
  word, str: WideString;
  wordtmp: array of array[0..5] of WideString;
begin
  SDL_EnableKeyRepeat(10, 100);
  Redraw;
  k := 0;
  j := 0;
  if mpnum = -1 then mpnum := Rrole[0].MenPai;
  if mpnum < 0 then exit;
  x := 40;
  y := CENTER_Y - 160;
  w := 120;
  pnum := 7;
  for i := 0 to length(Rrole) - 1 do
  begin
    if Rrole[i].menpai = mpnum then
    begin
      trole[k] := i;
      k := k + 1;
    end;
  end;
  page := max(0, (k - 1)) div pnum;
  strs[0] := '���';
  strs[1] := '���T�˲�������Լ���';
  strs[2] := ' ǰ�';
  strs[3] := ' ���';
  strs[4] := '������������������������' + gbktounicode(@Rmenpai[mpnum].Name) + '������������������������';
  strs[5] := '�';
  strs[6] := '���T�˲��ܼ�����飡';
  strs[7] := '���Լ��ѽ�������У�';
  strs[8] := 'ԓ�����ѽ�������У�';
  strs[9] := 'ԓ����o�����룡';
  strs[10] := '�㲻��������ң�';
  strs[11] := 'ԓ���ﲻ�������';
  setlength(menuString, 2);
  menuString[0] := ' �_�J';
  menuString[1] := ' ȡ��';
  menu := -1;
  menup := -1;

  menuyn := -1;
  menudz := -1;
  npage := 0;
  if k > 0 then
  begin

    k1 := min(pnum - 1, k - npage * pnum - 1);
    drawdizi(@Trole[0], mpnum, 0, k1, k - 1, pnum, x, y, menudz);
    DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));

    str := format('%3d', [npage + 1]);
    word := '��     �';
    DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
    DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
    DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
    for i := 0 to 1 do
      if i = menu then
      begin
        DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
      end
      else
      begin
        DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
      end;
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    while (SDL_WaitEvent(@event) >= 0) do
    begin
      CheckBasicEvent;
      case event.type_ of
        SDL_KEYUP:
        begin
          if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
          begin
            menudz := menudz + 1;
            if menudz >= pnum then
            begin
              npage := npage + 1;
              if npage > page then npage := 0;
              menudz := 0;
            end;
            Redraw;
            k1 := min(pnum - 1, k - npage * pnum - 1);
            drawdizi(@Trole[0], mpnum, npage * pnum, npage * pnum + k1, k - 1, pnum, x, y, menudz);
            DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));

            str := format('%3d', [npage + 1]);
            word := '��     �';
            DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
            DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
            DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
            for i := 0 to 1 do
              if i = menu then
              begin
                DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
              end
              else
              begin
                DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
              end;
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

          end;
          if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
          begin
            menudz := menudz - 1;
            if menudz < 0 then
            begin
              npage := npage - 1;
              if npage < 0 then npage := page;
              menudz := min(pnum - 1, k - npage * pnum - 1);
            end;
            Redraw;

            k1 := min(pnum - 1, k - npage * pnum - 1);
            drawdizi(@Trole[0], mpnum, npage * pnum, npage * pnum + k1, k - 1, pnum, x, y, menudz);
            DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));

            str := format('%3d', [npage + 1]);
            word := '��     �';
            DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
            DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
            DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
            for i := 0 to 1 do
              if i = menu then
              begin
                DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
              end
              else
              begin
                DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
              end;
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;
          if ((event.key.keysym.sym = SDLK_ESCAPE)) and (where <= 2) then
          begin
            Redraw;
            break;
          end;
          if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
          begin
            if (menudz >= 0) and (menudz <= k1) then
            begin
              newshowstatus(trole[npage * pnum + menudz]);
              WaitAnyKey;
              Redraw;
              k1 := min(pnum - 1, k - npage * pnum - 1);
              drawdizi(@Trole[0], mpnum, npage * pnum, npage * pnum + k1, k - 1, pnum, x, y, menudz);
              DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));

              str := format('%3d', [npage + 1]);
              word := '��     �';
              DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
              DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
              DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
              for i := 0 to 1 do
                if i = menu then
                begin
                  DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
                end
                else
                begin
                  DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
                end;
              SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            end;
          end;
        end;
        SDL_MOUSEBUTTONUP:
        begin
          if (event.button.button = SDL_BUTTON_RIGHT) and (where <= 2) then
          begin
            Redraw;
            break;
          end;
          if (event.button.button = SDL_BUTTON_LEFT) then
          begin

            case menu of
              0:
              begin
                npage := npage - 1;
                if npage < 0 then npage := page;
              end;
              1:
              begin
                npage := npage + 1;
                if npage > page then npage := 0;
              end;
            end;
            Redraw;

            k1 := min(pnum - 1, k - npage * pnum - 1);
            drawdizi(@Trole[0], mpnum, npage * pnum, npage * pnum + k1, k - 1, pnum, x, y, menudz);
            DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));

            str := format('%3d', [npage + 1]);
            word := '��     �';
            DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
            DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
            DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
            for i := 0 to 1 do
              if i = menu then
              begin
                DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
              end
              else
              begin
                DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
              end;
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            if (menudz >= 0) and (menudz <= k1) then
            begin
              newshowstatus(trole[npage * pnum + menudz]);
              WaitAnyKey;
              Redraw;
              k1 := min(pnum - 1, k - npage * pnum - 1);
              drawdizi(@Trole[0], mpnum, npage * pnum, npage * pnum + k1, k - 1, pnum, x, y, menudz);
              DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));

              str := format('%3d', [npage + 1]);
              word := '��     �';
              DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
              DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
              DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
              for i := 0 to 1 do
                if i = menu then
                begin
                  DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
                end
                else
                begin
                  DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
                end;
              SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            end;
          end;
        end;
        SDL_MOUSEMOTION:
        begin
          if (event.button.x >= CENTER_X - 80) and (event.button.x < CENTER_X + w) and
            (event.button.y > y + 232) and (event.button.y < y + 259) then
          begin

            menudzp := menudz;
            menudz := -1;
            menup := menu;
            menu := (event.button.x - CENTER_X + 47) div 50;
            if menu > 1 then
              menu := -1;
            if menu < 0 then
              menu := -1;
          end


          else if (event.button.x >= x + 10) and (event.button.x < x + 480) and
            (event.button.y > y + 75) and (event.button.y < y + 100 + 22 * k1) then
          begin
            menup := menu;
            menu := -1;

            menudzp := menudz;
            menudz := (event.button.y - y - 75) div 22;
            if menudz > k1 then
              menudz := -1;
            if menudz < 0 then
              menudz := -1;
          end
          else
          begin

            menup := menu;
            menu := -1;

            menudzp := menudz;
            menudz := -1;
          end;
          if (menup <> menu) or (menudzp <> menudz) then
          begin
            Redraw;

            k1 := min(pnum - 1, k - npage * pnum - 1);
            drawdizi(@Trole[0], mpnum, npage * pnum, npage * pnum + k1, k - 1, pnum, x, y, menudz);
            DrawShadowText(@strs[4][1], CENTER_X - length(strs[4]) * 10, y + 15, ColColor(249), ColColor(252));

            str := format('%3d', [npage + 1]);
            word := '��     �';
            DrawShadowText(@word[1], CENTER_X - length(word) * 10 + 25, y + 265, ColColor($5), ColColor($7));
            DrawShadowText(@str[1], CENTER_X - 25, y + 265, ColColor($5), ColColor($7));
            DrawRectangle(CENTER_X - 50, y + 230, w, 28, 0, ColColor(255), 30);
            for i := 0 to 1 do
              if i = menu then
              begin
                DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($64), ColColor($66));
              end
              else
              begin
                DrawShadowText(@strs[2 + i][1], CENTER_X - 67 + i * 50, y + 230 + 2, ColColor($5), ColColor($7));
              end;
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;

        end;

      end;
    end;
    //��ռ��̼�������ֵ, ����Ӱ�����ಿ��
    event.key.keysym.sym := 0;
    event.button.button := 0;
    SDL_EnableKeyRepeat(30, 30);

  end;
end;

procedure Feventcaller(code, e, x, y: integer);
var
  i: integer;
begin
  x50[e] := -1;
  x := e_GetValue(0, code, x);
  y := e_GetValue(1, code, y);
  x50[e] := eventcaller(x, y);
  if x50[e] < 0 then
  begin
    for i := 0 to length(Rrole) - 1 do
    begin
      if (Rrole[i].Impression = Ddata[CurScene, CurEvent, 5] div 2) or (Rrole[i].Impression +
        1 = Ddata[CurScene, CurEvent, 5] div 2) or (Rrole[i].Impression + 2 = Ddata[CurScene, CurEvent, 5] div 2) or
        (Rrole[i].Impression + 3 = Ddata[CurScene, CurEvent, 5] div 2) then
      begin
        x50[e] := i;
        break;
      end;
    end;
  end;
end;

function RoleEvent(key, key2, rnum, snum, x, y, face, Ytime, enum1, enum2, enum3, pic0, picE,
  picB, picD, Btime, dtime, Rtime, Jtime, act, Gtime, Genum, reX, jump1, jump2: smallint): smallint;
var
  i, j, tg: integer;
begin
  Result := jump2;

  rnum := e_GetValue(0, key, rnum);
  snum := e_GetValue(1, key, snum);
  x := e_GetValue(2, key, x);
  y := e_GetValue(3, key, y);
  face := e_GetValue(4, key, face);
  Ytime := e_GetValue(5, key, Ytime);
  enum1 := e_GetValue(6, key, enum1);
  enum2 := e_GetValue(7, key, enum2);
  enum3 := e_GetValue(8, key, enum3);
  pic0 := e_GetValue(9, key, pic0);
  picE := e_GetValue(10, key, picE);
  picB := e_GetValue(11, key, picB);
  picD := e_GetValue(12, key, picD);
  Btime := e_GetValue(13, key, Btime);
  Dtime := e_GetValue(14, key, Dtime);
  Rtime := e_GetValue(15, key, Rtime);
  Jtime := e_GetValue(0, key2, Jtime);
  act := e_GetValue(1, key2, act);
  Gtime := e_GetValue(2, key2, Gtime);
  Genum := e_GetValue(3, key2, Genum);
  reX := e_GetValue(4, key2, reX);
  X50[rex] := -1;
  if (rnum > 0) and (snum = 0) and (x = 0) and (y = 0) and (dtime = 0) then
  begin
    for i := RccRole.Count - 1 downto 0 do
    begin
      if RccRole.adds[i].rnum = rnum then
      begin
        instruct_3([RccRole.adds[i].snum, RccRole.adds[i].DNum, 0, -2, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0]);
        Rrole[RccRole.adds[i].rnum].lsweizhi := -1;
        Rrole[RccRole.adds[i].rnum].lsnweizhi := -1;
        Rrole[RccRole.adds[i].rnum].lsfangxiang := 0;
        if Rrole[RccRole.adds[i].rnum].dtime < 1000 then
          Rrole[RccRole.adds[i].rnum].dtime := 0;
        for j := i to RccRole.Count - 2 do
        begin
          RccRole.adds[j].Rnum := RccRole.adds[j + 1].Rnum;
          RccRole.adds[j].snum := RccRole.adds[j + 1].snum;
          RccRole.adds[j].Dnum := RccRole.adds[j + 1].Dnum;
          RccRole.adds[j].Dtime := RccRole.adds[j + 1].Dtime;
        end;
        setlength(RccRole.adds, RccRole.Count - 1);
        Dec(RccRole.Count);
        break;
      end;
    end;
    exit;
  end;
  if (rnum = 0) and (snum >= 0) and (x >= 0) and (y >= 0) and (dtime = 0) and (enum1 = 0) and
    (enum2 = 0) and (enum3 = 0) and (pic0 = 0) and (picE = 0) and (picB = 0) and (picD = 0) then
  begin
    for i := RccRole.Count - 1 downto 0 do
    begin
      if (RccRole.adds[i].Rnum = 0) and (RccRole.adds[i].snum = snum) then
      begin
        if (Ddata[snum, RccRole.adds[i].DNum, 9] = x) and (Ddata[snum, RccRole.adds[i].DNum, 10] = y) then
        begin
          instruct_3([snum, RccRole.adds[i].DNum, 0, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
          for j := i to RccRole.Count - 2 do
          begin
            RccRole.adds[j].Rnum := RccRole.adds[j + 1].Rnum;
            RccRole.adds[j].snum := RccRole.adds[j + 1].snum;
            RccRole.adds[j].Dnum := RccRole.adds[j + 1].Dnum;
            RccRole.adds[j].Dtime := RccRole.adds[j + 1].Dtime;
          end;
          setlength(RccRole.adds, RccRole.Count - 1);
          Dec(RccRole.Count);
          break;
        end;
      end;
    end;
    exit;
  end;

  if (snum < 0) or (x > 63) or (x < 0) or (y > 63) or (y < 0) or not (face in [0..3]) or
    (enum1 < 0) or (dtime < 0) or ((rnum > 0) and(Rrole[rnum].dtime > Ytime)) or (rnum < 0) then
    exit;
  for i := 200 to 399 do
  begin
    if Ddata[snum, i, 1] <= 0 then
    begin
      Result := jump1;
      X50[rex] := i;
      if (pic0 <= 0) and (rnum > 0) then
      begin
        pic0 := (Rrole[rnum].Impression + face) * 2;
        picE := 0;
        picB := 0;
        picD := 0;
      end;
      if Btime <= 0 then
        Btime := timetonum - Btime;
      tg := rnum * 10 + 1;
      if (enum1 = 0) and (enum2 = 0) and (enum3 > 0) then
        tg := 0;
      instruct_3([snum, i, tg, i, enum1, enum2, enum3, pic0, picE, picB, picD, x, y, Btime,
        dtime, Rtime, Jtime, act, Gtime, Genum]);
      if rnum > 0 then
      begin
        Rrole[rnum].dtime := Rrole[rnum].dtime + (btime - timetonum) + dtime;
        Rrole[rnum].lsweizhi := snum;
        Rrole[rnum].lsnweizhi := i;
        Rrole[rnum].lsfangxiang := face;
        if (Rrole[rnum].weizhi >= 0) and (Rrole[rnum].nweizhi >= 0) and (Rrole[rnum].MenPai <= 0) then
          xiugaievent(Rrole[rnum].weizhi, Rrole[rnum].nweizhi, 11, 1, 0);
      end;
      Inc(RccRole.Count);
      setlength(RccRole.adds, RccRole.Count);
      RccRole.adds[RccRole.Count - 1].Rnum := rnum;
      RccRole.adds[RccRole.Count - 1].snum := snum;
      RccRole.adds[RccRole.Count - 1].DNum := i;
      RccRole.adds[RccRole.Count - 1].Dtime := Btime + Dtime;
      break;
    end;
  end;

end;

procedure addrenwu(key, num, talknum, status, day: smallint);
var
  len: integer;
  fgrp, fidx: string;
begin
  num := e_GetValue(0, key, num);
  talknum := e_GetValue(1, key, talknum);
  status := e_GetValue(2, key, status);
  day := e_GetValue(3, key, day);
  if num < 0 then
  begin
    len := length(Rrenwu);
    if len <= 0 then
    begin
      setlength(Rrenwu, 1);
      len := 0;
    end
    else
    begin
      setlength(Rrenwu, len + 1);
    end;
    x50[num] := len;
    num := len;
    Rrenwu[num].status := status;
  end;
  len := length(Rrenwu);
  if num < len then
  begin
    Rrenwu[num].num := num;
    if talknum > 0 then
      Rrenwu[num].talknum := talknum;
    if status > 0 then
      Rrenwu[num].status := status;
    if day > 0 then
    begin
      day := day mod 360;
      Rrenwu[num].moon := day div 30 + 1;
      Rrenwu[num].day := day mod 30 + 1;
    end
    else
    begin

      Rrenwu[num].moon := wdate[2];
      Rrenwu[num].day := wdate[3];
    end;
  end;
  fgrp := 'resource\talk.GRP';
  FIDX := 'resource\talk.idx';
  Rrenwu[num].talks := TalktoWidestring(num, FGRP, FIDX);
end;

//�³�ս��������Ա
procedure AddEnemyNextFight(key,rnum,team:integer);
var
  len:integer;
begin
  rnum := e_GetValue(0, key, rnum);
  team := e_GetValue(1, key, team);
  inc(xunchou.num);
  setlength(xunchou.rnumlist,xunchou.num);
  setlength(xunchou.team,xunchou.num);
  xunchou.rnumlist[xunchou.num - 1]:=rnum;
  xunchou.team[xunchou.num - 1]:=team;
end;

end.