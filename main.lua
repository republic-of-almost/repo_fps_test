--[[

  Config
  --
  Simple test setup.

]]--

repo.conf = {

  engine_version = Version.Init,

  info = {
    title  = "Simple Test",
    author = "PhilCK",
    desc   = "Test for Repo Engine",
    link   = "www.repoengine.com",
  },

  entities = {
    "actor",
    "ground",
    "debug",
    "environment",
  },
}

-- --[[
--
--   Settings
--   --
--   This table is inserted into every script.
--
-- ]]--
-- repo.settings = {
--
-- }
--
--
-- --[[
--
--   Assets
--   --
--   Loads assets on startup.
--
-- ]]--
-- repo.assets = {
--
--   audio_samples = {
--     "a_walk" = "audio/walk.wav",
--     -- "a_sky"  = "audio/sky.wav",
--   }
--
--   models = {
--     -- "m_box" = "mesh/box.obj",
--   }
--
-- }
