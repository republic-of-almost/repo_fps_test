--[[

  Ground Entity
  --
  Creates a ground that the actor can walk on.

]]--

function
repo.on_start(entity)

  -- General --

  entity.name = "Ground"

  -- Position --

  entity.transform.scale    = Vector3.new(10.0, 0.25, 10.0)
  entity.transform.position = Vector3.new(0.0, -0.3, 0.0)

  -- Material --

  entity.material.color = Color.new(0.5, 0.0, 0.5, 1.0)
  entity.material.shader_type = ShaderType.FullbrightLight

end


function
repo.on_update(entity)

end
