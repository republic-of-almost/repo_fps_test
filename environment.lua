--[[

  Environment
  --
  Adds the cubes for the environment

]]--

env = {}

--

function
repo.on_start(entity)

  env.time = 0.0
  env.count = 200

  entity.name = "Environment"

  for i = 1, env.count do

    -- Add Child --

    local ent  = Entity.new()
    ent.name   = "Env"
    ent.parent = entity

    -- Material --

    ent.material = Material.new()

  end

end

--

function
repo.on_update(entity)

  local delta_time = 0.16

  env.time = env.time + (delta_time * 0.01)

  -- Helps with Lua Performance  --

  local pos   = Vector3.new(0,0,0)
  local scale = Vector3.new(1,1,1)
  local color = Color.new(1,1,1,1)

  local cos = Math.cos
  local sin = Math.sin
  local clamp = Math.clamp
  local floor = Math.floor

  for i = 1, env.count do

    local radius = 15
    local time = i
    local half_root_two = Math.RootTwo * 0.5

    local x = cos(time + env.time)
    local z = sin(time + env.time)
    local y = 0.0

    y = floor(i / 20)
    x = clamp(x, -half_root_two, half_root_two) * (radius + y)
    z = clamp(z, -half_root_two, half_root_two) * (radius + y)

    -- Get Child --

    local ent = entity:get_child(i - 1)

    -- Material --

    color.green = y / 10.0

    ent.material.color = color

    -- Transform --

    local default_scale = 2.0
    local scale_up = default_scale * (i / 10)

    pos.x = x;
    pos.y = y;
    pos.z = z;

    scale.x = default_scale
    scale.y = scale_up
    scale.z = default_scale

    ent.transform.position = pos
    ent.transform.scale    = scale

  end

end
