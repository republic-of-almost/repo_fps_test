--[[

  Config
  --
  Simple test setup.

]]--

repo.conf = {

  engine_version = Version.Init,

  info = {
    title  = "Simple Test",
    author = "",
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
