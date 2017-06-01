--[[

  Actor
  --
  An actor moves around the world.

]]--

actor = {}

--

function
repo.on_start(entity)

  -- Nav Mesh --

  local nav_mesh_scale = 7.0
  local nav_triangles = {
     nav_mesh_scale, 0.0, -nav_mesh_scale,
    -nav_mesh_scale, 0.0,  nav_mesh_scale,
     nav_mesh_scale, 0.0,  nav_mesh_scale,

    -nav_mesh_scale, 0.0,  nav_mesh_scale,
     nav_mesh_scale, 0.0, -nav_mesh_scale,
    -nav_mesh_scale, 0.0, -nav_mesh_scale,
  }

  actor.nav_mesh = Nav_mesh.new()
  actor.nav_mesh.triangles = nav_triangles

  -- Settings --

  actor.height = Vector3.new(0,1.0,0)

  -- Setup Actor --

  actor.kb = Keyboard.new()
  actor.ms = Mouse.new()
  actor.accum_pitch = 0.0
  actor.accum_yaw   = 0.0

  actor.ms.capture = true

  -- General --

  entity.name = "Actor"

  -- Child Entities --
  -- Head --

  local head = Entity.new()
  head.name = "Head"
  head.parent = entity

  actor.head_entity = head

  -- Head Transform --

  head.transform.scale = Vector3.new(0.5, 0.5, 0.5)

  local head_pos = Vector3.new(0, Math.GoldenRatio, 0)
  head.transform.position = head_pos

  -- Head Material --

  head.material.color = Color.new(1.0, 1.0, 0.0, 1.0)
  head.material.shader_type = ShaderType.SimpleLight

  -- Body --

  local body = Entity.new()
  body.name = "Body"
  body.parent = entity

  -- Body Transform --

  body.transform.scale = Vector3.new(0.5, 0.5 * Math.GoldenRatio, 0.5)

  -- Body Material --

  body.material.color = Color.new(1.0, 0.0, 1.0, 1.0)
  body.material.shader_type = ShaderType.SimpleLight

  -- Camera --

  local cam = Entity.new()
  cam.name = "Camera"
  cam.parent = head

  -- Camera Transform --

  cam.transform.position = Vector3.new(0.0, 0.0, -0.0)

  -- Camera Data --

  local camera_data = Camera.new()
  camera_data.width = 1.0
  camera_data.height = 1.0
  camera_data.field_of_view = Math.Tau * 0.2
  camera_data.near_plane = 0.1
  camera_data.far_plane = 100.0
  camera_data.clear_depth_buffer = true
  camera_data.clear_color_buffer = true
  cam.camera = camera_data


  -- Inital Ray Test To Get Height --

  local ray_dir    = Vector3.new(0.0, -1.0, 0.0)
  local ray        = Ray.new(entity.transform.position, ray_dir)
  local out_pos    = Vector3.new(0.0,0.0,0.0)

  if(actor.nav_mesh:ray_test(ray, out_pos)) then
    entity.transform.position = out_pos:add(actor.height)
  end

end

--

function
repo.on_update(entity)

  -- General Things --

  delta_time = 0.16
  head_speed = 0.05

  -- Mouse Movement --

  if(actor.ms.capture) then

    actor.accum_pitch = actor.accum_pitch - (delta_time * head_speed * actor.ms.delta.y)
    actor.accum_yaw   = actor.accum_yaw + (delta_time * head_speed * actor.ms.delta.x)

  end

  actor.accum_pitch = Math.clamp(actor.accum_pitch, -Math.TauOverFour, Math.TauOverFour);

  local yaw_axis = Vector3.world_up
  local yaw_rot  = Quaternion.from_axis_angle(yaw_axis, actor.accum_yaw)

  local pitch_axis = Vector3.world_left
  local pitch_rot  = Quaternion.from_axis_angle(pitch_axis, actor.accum_pitch)

  entity.transform.rotation = yaw_rot
  actor.head_entity.transform.rotation = pitch_rot

  -- Keyboard Movement --

  local z_move = 0.0
  local x_move = 0.0

  if(actor.kb:is_key_down(Key.W)) then
    z_move = z_move + 1.0
  end

  if(actor.kb:is_key_down(Key.S)) then
    z_move = z_move - 1.0
  end

  if(actor.kb:is_key_down(Key.A)) then
    x_move = x_move + 1.0
  end

  if(actor.kb:is_key_down(Key.D)) then
    x_move = x_move - 1.0
  end

  -- Movement Math --

  local movement = Vector3.new(x_move, 0.0, z_move)

  if(movement:length() > 0.0001) then

    local normalized_movement = movement:normalize()

    local move_speed = 0.5 * delta_time

    local fwd  = entity.transform.forward:scale(normalized_movement.z * move_speed)
    local left = entity.transform.left:scale(normalized_movement.x * move_speed)

    local move_direction = fwd:add(left)

    -- Apply Movement To Entity --

    local new_step = entity.transform.position;

    new_step = new_step:add(move_direction)

    local ray_dir    = Vector3.new(0.0, -1.0, 0.0)
    local ray        = Ray.new(new_step, ray_dir)
    local out_pos    = Vector3.new(0.0,0.0,0.0)

    -- Find the Next Step --

    if(actor.nav_mesh:ray_test(ray, out_pos)) then

      -- If this ray hit we use its position --

      entity.transform.position = out_pos:add(actor.height)
    else

      -- If it didn't hit look for an alternative step --

      local edge = Edge.new()
      actor.nav_mesh:closest_edge(ray.origin, edge)

      local dir = edge.end_point:subtract(edge.start_point):normalize()
      local dot = dir:dot(move_direction:normalize())

      local side_step = entity.transform.position:add(dir:scale(dot * move_speed))
      local side_step_ray = Ray.new(side_step, ray_dir)

      if(actor.nav_mesh:ray_test(side_step_ray, out_pos)) then
        entity.transform.position = out_pos:add(actor.height)
      end
    end

  end

end
