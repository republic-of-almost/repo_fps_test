--[[

  Debug
  --
  Keyboard: F2 toggle mouse capture

]]--

debug = {}

--

function
repo.on_start(entity)

  entity.name = "Debug"

  debug.kb = Keyboard.new()
  debug.ms = Mouse.new()

end

--

function
repo.on_update(entity)

  if(debug.kb:is_key_up_on_frame(Key.F2)) then
    debug.ms.capture = not debug.ms.capture
  end

end
