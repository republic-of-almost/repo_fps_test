--[[

  Debug
  --
  Keyboard: F2 toggle mouse capture

]]--

env = {}

--

function
wired.on_start(entity)

  env.time = 0.0
  env.count = 200

  entity.name = "Environment"

  for i = 1, env.count do

    -- Add Child --

    local ent  = Entity.new()
    ent.name   = "Env"
    ent.parent = entity

    ent.material = Material.new()

  end

end

--

function
wired.on_update(entity)

  local delta_time = 0.16

  env.time = env.time + (delta_time * 0.01)

  for i = 1, env.count do

    local radius = 15

    local time = i

    local x = Math.cos(time + env.time)
    local z = Math.sin(time + env.time)

    local half_root_two = Math.RootTwo / 2

    y = Math.floor(i / 20)
    x = Math.clamp(x, -half_root_two, half_root_two) * (radius + y)
    z = Math.clamp(z, -half_root_two, half_root_two) * (radius + y)

    -- Get Child --

    local ent = entity:get_child(i - 1)

    -- Material --

    ent.material.color = Color.new(1.0, y / 10.0, 1.0, 1.0)

    -- Transform --

    start_scale = 1.0
    end_scale = 4.0

    -- rand_scale = Vector3.new(Math.rand_range(start_scale, end_scale), Math.rand_range(start_scale, end_scale), Math.rand_range(start_scale, end_scale))
    local scale = 2.0
    local scale_out = scale
    local scale_up = scale * (i / 10)

    new_scale = Vector3.new(scale_out, scale_up, scale_out)

    -- rand_position = Vector3.new(Math.rand_range(1,2), rand_scale.y + i - 1, Math.rand_range(1,2))
    rand_position = Vector3.new(x, y ,z)

    ent.transform.position = rand_position
    ent.transform.scale    = new_scale

  end

end
