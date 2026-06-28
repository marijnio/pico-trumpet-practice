pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- trumpet fingering trainer
-- version 2.0 - full range expansion

function _init()
  -- app states: "menu", "reference", "quiz", "result", "play_along"
  state = "menu"
  menu_opt = 1
  ref_idx = 1
  
  -- practice state variables
  score = 0
  total = 0
  is_correct = false
  user_v = {false, false, false}
  user_air = 2
  
  -- play-along state variables
  play_along_timer = 0
  failed = false
  
  -- database of notes (f#3 to g5)
  -- y: standard treble clef positioning (F5 = 24, E4 = 56)
  -- v: valves, air: partial (1-5), w: srs weight, p: pico-8 pitch index (F#3=18 to G5=43)
  notes = {
    -- 1st partial
    {name="f#3", y=80, v={true,true,true}, air=1, p=18},
    {name="g3",  y=76, v={true,false,true}, air=1, p=19},
    {name="g#3", y=76, v={false,true,true}, air=1, p=20},
    {name="a3",  y=72, v={true,true,false}, air=1, p=21},
    {name="bb3", y=68, v={true,false,false}, air=1, p=22},
    {name="b3",  y=68, v={false,true,false}, air=1, p=23},
    {name="c4",  y=64, v={false,false,false}, air=1, p=24},
    -- 2nd partial
    {name="c#4", y=64, v={true,true,true}, air=2, p=25},
    {name="d4",  y=60, v={true,false,true}, air=2, p=26},
    {name="d#4", y=60, v={false,true,true}, air=2, p=27},
    {name="e4",  y=56, v={true,true,false}, air=2, p=28},
    {name="f4",  y=52, v={true,false,false}, air=2, p=29},
    {name="f#4", y=52, v={false,true,false}, air=2, p=30},
    {name="g4",  y=48, v={false,false,false}, air=2, p=31},
    -- 3rd partial
    {name="g#4", y=48, v={false,true,true}, air=3, p=32},
    {name="a4",  y=44, v={true,true,false}, air=3, p=33},
    {name="bb4", y=40, v={true,false,false}, air=3, p=34},
    {name="b4",  y=40, v={false,true,false}, air=3, p=35},
    {name="c5",  y=36, v={false,false,false}, air=3, p=36},
    -- 4th partial
    {name="c#5", y=36, v={true,true,false}, air=4, p=37},
    {name="d5",  y=32, v={true,false,false}, air=4, p=38},
    {name="d#5", y=32, v={false,true,false}, air=4, p=39},
    {name="e5",  y=28, v={false,false,false}, air=4, p=40},
    -- 5th partial
    {name="f5",  y=24, v={true,false,false}, air=5, p=41},
    {name="f#5", y=24, v={false,true,false}, air=5, p=42},
    {name="g5",  y=20, v={false,false,false}, air=5, p=43}
  }
  
  pick_new_note()
end

function pick_new_note()
  note = rnd(notes)
  user_v = {false, false, false}
  user_air = 2 -- default
end

function _update()
  if state == "menu" then
    if btnp(2) then menu_opt = max(1, menu_opt - 1) end
    if btnp(3) then menu_opt = min(3, menu_opt + 1) end
    if btnp(4) then
      if menu_opt == 1 then
        state = "quiz"
        score = 0
        total = 0
        pick_new_note()
      elseif menu_opt == 2 then
        state = "play_along"
        score = 0
        total = 0
        play_along_timer = 0
        failed = false
        pick_new_note()
      else
        state = "reference"
        ref_idx = 1
      end
    end
    
  elseif state == "reference" then
    if btnp(0) then ref_idx = max(1, ref_idx - 1) end
    if btnp(1) then ref_idx = min(#notes, ref_idx + 1) end
    if btnp(5) then state = "menu" end
    
  elseif state == "quiz" then
    if btnp(0) then user_v[1] = not user_v[1] end
    if btnp(1) then user_v[3] = not user_v[3] end
    
    if btn(5) then
      if btnp(2) then user_air = min(5, user_air + 1) end
      if btnp(3) then user_air = max(1, user_air - 1) end
    else
      if btnp(3) then user_v[2] = not user_v[2] end
    end
    
    if btnp(4) then
      total += 1
      local valves_correct = user_v[1] == note.v[1] and 
                             user_v[2] == note.v[2] and 
                             user_v[3] == note.v[3]
      local air_correct = user_air == note.air
      
      if valves_correct and air_correct then
        is_correct = true
        score += 1
        sfx(0)
      else
        is_correct = false
        sfx(1)
      end
      state = "result"
    end
    
  elseif state == "result" then
    if btnp(5) then
      pick_new_note()
      state = "quiz"
    end

  elseif state == "play_along" then
    if btnp(5) then
      stop_pitch()
      state = "menu"
      return
    end
    
    local beat_len = 30
    local cycle_len = 360
    
    if play_along_timer % beat_len == 0 then
      local beat = flr(play_along_timer / beat_len) + 1
      play_click()
      
      if beat == 5 then
        play_pitch(note.p)
      elseif beat == 9 then
        stop_pitch()
      end
    end
    
    local pressed_any = false
    for i=0,4 do
      if btnp(i) then
        pressed_any = true
      end
    end
    
    if pressed_any and not failed then
      failed = true
      sfx(1)
    end
    
    play_along_timer += 1
    
    if play_along_timer >= cycle_len then
      if not failed then
        score += 1
      end
      total += 1
      
      failed = false
      play_along_timer = 0
      pick_new_note()
    end
  end
end

function _draw()
  cls(1)
  
  if state == "menu" then
    rectfill(0, 0, 128, 12, 0)
    print("trumpet trainer", 4, 4, 7)
    
    print("select mode:", 36, 32, 6)
    
    local c1 = menu_opt == 1 and 10 or 6
    local c2 = menu_opt == 2 and 10 or 6
    local c3 = menu_opt == 3 and 10 or 6
    
    print("practice", 48, 50, c1)
    print("play-along", 48, 62, c2)
    print("reference", 48, 74, c3)
    
    local sel_y = 50 + (menu_opt - 1) * 12
    print(">", 40, sel_y, 10)
    print("press \142 to start", 30, 104, 7)
    return
  end
  
  -- header
  rectfill(0, 0, 128, 12, 0)
  print("trumpet trainer", 4, 4, 7)
  
  if state == "quiz" or state == "result" or state == "play_along" then
    local score_str = score.."/"..total
    print(score_str, 124 - #score_str * 4, 4, 10)
  elseif state == "reference" then
    print("reference", 92, 4, 10)
  end
  
  -- treble clef staff
  for i=0,4 do
    local line_y = 24 + (i * 8)
    line(20, line_y, 108, line_y, 7)
  end
  
  local draw_note = state == "reference" and notes[ref_idx] or note
  
  -- dynamic ledger lines
  local l_y = 64
  while l_y <= draw_note.y do
    line(56, l_y, 72, l_y, 7)
    l_y += 8
  end
  
  -- accidentals (sharp/flat)
  local acc = sub(draw_note.name, 2, 2)
  if acc == "#" or acc == "b" then
    print(acc, 54, draw_note.y - 2, 7)
  end
  
  -- note head
  circfill(64, draw_note.y, 4, 10)
  
  draw_valves(34, 100)
  draw_air()
  
  -- ui contextual instructions
  if state == "quiz" then
    print("\139/\131/\145:valves \151+\148/\131:air", 8, 114, 6)
    print("press \142 to submit", 28, 122, 7)
  elseif state == "result" then
    if is_correct then
      rectfill(0, 114, 128, 128, 11)
      print("correct!", 48, 118, 0)
    else
      rectfill(0, 114, 128, 128, 8)
      print("wrong! correct config shown", 12, 118, 7)
    end
  elseif state == "reference" then
    print("\139/\145: navigate notes", 22, 114, 6)
    print("press \151 for menu", 30, 122, 7)
  elseif state == "play_along" then
    print("any key: flag wrong", 34, 14, 6)
    
    local beat = flr(play_along_timer / 30) + 1
    local beat_in_phase = ((beat - 1) % 4) + 1
    
    local phase_name = "prepare"
    if beat > 8 then
      phase_name = "reveal"
    elseif beat > 4 then
      phase_name = "play"
    end
    
    local banner_col = 13
    local text = "prepare"
    if phase_name == "play" then
      banner_col = 10
      text = "play!"
    elseif phase_name == "reveal" then
      banner_col = 11
      text = "revealed"
    end
    
    rectfill(0, 114, 128, 128, banner_col)
    print(text, 64 - #text * 2, 116, 0)
    
    local dot_start_x = 64 - 15
    for i=1,4 do
      local dx = dot_start_x + (i - 1) * 10
      if i == beat_in_phase then
        circfill(dx, 123, 2, 0)
      else
        circ(dx, 123, 2, 0)
      end
    end
    
    if failed then
      rectfill(28, 86, 100, 94, 8)
      print("flagged wrong", 34, 88, 7)
    end
  end
end

function draw_valves(start_x, y)
  local draw_note = state == "reference" and notes[ref_idx] or note
  
  local reveal = true
  if state == "play_along" then
    local beat = flr(play_along_timer / 30) + 1
    if beat <= 8 then
      reveal = false
    end
  end

  for i=1,3 do
    local vx = start_x + (i - 1) * 24
    local active = user_v[i]
    if (state == "result" and not is_correct) or state == "reference" or (state == "play_along" and reveal) then
      active = draw_note.v[i]
    end
    
    rect(vx-2, y-8, vx+10, y+12, 5) 
    if not reveal then
      rectfill(vx, y, vx+8, y+8, 5)
      print("?", vx+3, y+2, 7)
    else
      if active then
        rectfill(vx, y, vx+8, y+8, 12)
        print(i, vx+3, y+2, 0)
      else
        rect(vx, y, vx+8, y+8, 7)
        print(i, vx+3, y+2, 7)
      end
    end
  end
end

function draw_air()
  local draw_note = state == "reference" and notes[ref_idx] or note
  local active_air = user_air
  local col = 12
  
  local reveal = true
  if state == "play_along" then
    local beat = flr(play_along_timer / 30) + 1
    if beat <= 8 then
      reveal = false
    else
      active_air = draw_note.air
      col = 11
    end
  elseif state == "result" then
    active_air = draw_note.air
    col = is_correct and 11 or 8
  elseif state == "reference" then
    active_air = draw_note.air
    col = 11
  end
  
  for i=1,5 do
    local by = 64 - (i * 8)
    local fill_col = 5
    if reveal then
      if active_air == i then
        fill_col = col
      end
    end
    
    rectfill(116, by, 122, by+6, fill_col)
    rect(115, by-1, 123, by+7, 6)
    print(i, 110, by+1, 6)
  end
end

function play_pitch(p)
  local addr = 0x3354
  poke(addr, p)
  poke(addr+1, 40)
  poke(addr+2, p)
  poke(addr+3, 40)
  poke(addr+65, 30)
  poke(addr+66, 0)
  poke(addr+67, 1)
  sfx(5, 3)
end

function stop_pitch()
  sfx(-1, 3)
end

function play_click()
  local addr = 0x3310
  poke(addr, 50)
  poke(addr+1, 51)
  poke(addr+2, 0)
  poke(addr+3, 0)
  poke(addr+65, 2)
  poke(addr+66, 0)
  poke(addr+67, 0)
  sfx(4, 2)
end
