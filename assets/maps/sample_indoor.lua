return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.17.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 32,
  height = 32,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 3,
  backgroundcolor = { 0, 0, 0 },
  properties = {},
  tilesets = {
    {
      name = "roguelikeSheet_transparent",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 1,
      margin = 0,
      image = "../spritesheets/roguelike/roguelikeSheet_transparent.png",
      imagewidth = 968,
      imageheight = 526,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 1767,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "floor",
      x = 0,
      y = 0,
      width = 32,
      height = 32,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJztk1sKwjAQRYdkrZW2bkC3Zh+7qvnVgPky95IpiaUyB+andDgknIgYhmF8sziRiczq9HtoJ8f2/nf0eJ7AEcjepvR3Hs8AHFeyo/XfBc8FOHqPd2r6b2T+wY/6Sh0zP3oDQeFHfaWOmR+9ndhmKaivrtCP2qxBib8lR/tZm9rO9sDa1Ha2B9Zmzc4Qj88954jf58b3n86f4xfnNwzj/LwAOb+HQA=="
    },
    {
      type = "tilelayer",
      name = "carpet",
      x = 0,
      y = 0,
      width = 32,
      height = 32,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJzt08EJgDAQRNHF5Kr2ZVuWoXalRrsxxyVgwiLu6T+Y25A5LBEBAABWSxBZVbbgu7/nvUPldN7vo8igMkbffW9T92+/ZTa+Z+2jrrxnyv/tUrlDvf9Vec/WPvcH8OYBaiATgA=="
    },
    {
      type = "objectgroup",
      name = "entities",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "player",
          type = "Player",
          shape = "rectangle",
          x = 289,
          y = 287,
          width = 14,
          height = 14,
          rotation = 0,
          gid = 1766,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "zones/DoorZone",
          shape = "rectangle",
          x = 289,
          y = 303,
          width = 14,
          height = 14,
          rotation = 0,
          gid = 1706,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      name = "objects",
      x = 0,
      y = 0,
      width = 32,
      height = 32,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["collidable"] = true
      },
      encoding = "base64",
      compression = "zlib",
      data = "eJxjYBgFo2AUjILBCSwYGRjmAulTDBCaAYkmBB4zQuhIII4g0/5CqBnMjAgxdSYEewEOGgZkgVgOiskBTQTkb+Kgu7Go7SPTDcSAZUzYxQ8DcSYjdjliACH/EwOkgFiCCubgAvuRMLXBfAJ8EDgGxMeB2BIazl041GPTSwjcIMAHgQNIGJ9+bHpHwdAFuNITOemMHICcnhRxiI+CUTAKRsEowA4AI4wdsA=="
    },
    {
      type = "tilelayer",
      name = "details",
      x = 0,
      y = 0,
      width = 32,
      height = 32,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJztzqEBACAMwLABZ3AjT3A5EsT8EImpbQTAv2bLy7V69UFuj+oDAABeBzazAUk="
    }
  }
}
