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

  for i = 0, env.count do

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

  for i = 0, env.count do

    local radius = 15
    local time = i
    local half_root_two = Math.RootTwo * 0.5

    local x = Math.cos(time + env.time)
    local z = Math.sin(time + env.time)

    y = Math.floor(i / 20)
    x = Math.clamp(x, -half_root_two, half_root_two) * (radius + y)
    z = Math.clamp(z, -half_root_two, half_root_two) * (radius + y)

    -- Get Child --

    local ent = entity:get_child(i)

    -- Material --

    ent.material.color = Color.new(1.0, y / 10.0, 1.0, 1.0)

    -- Transform --

    local scale = 2.0
    local scale_up = scale * (i / 10)

    ent.transform.position = Vector3.new(x, y ,z)
    ent.transform.scale    = Vector3.new(scale, scale_up, scale)

  end

end
