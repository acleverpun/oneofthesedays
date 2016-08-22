return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.17.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 100,
  height = 100,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 3,
  properties = {},
  tilesets = {
    {
      name = "Roguelike",
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
      name = "ground",
      x = 0,
      y = 0,
      width = 100,
      height = 100,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJzt100KwjAQgNGA1kOptZfy5/pGEKyhdiXOYN7i7Qc+ZkKmUsoEAAAAAAD8pV0jep6etS000QM9svnUQY9cXaLn6d2m2jaGBHP16liNjVOCuXrR7sNZj1BL+6CHHuiRzePtWHov9Iixthv76vp0SzBrD9Z62Im8PfzVf+NSXjfpUN5vlRsVa74rblW8+a7YDQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD4njvz4JUG"
    },
    {
      type = "tilelayer",
      name = "roads",
      x = 0,
      y = 0,
      width = 100,
      height = 100,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJzt2QFOgmAYgGGUtrIu0jFKO0frHtUxirpGF2l5omjCoj9IRMhv9Tzbtwnq5v53PzrJMgAAAAAAGM9inmWn1ZzNvz73PDvMZ/rPlmWDVTVXPXo85eX5xjCOel+sGnOR7JE+PTTZT93hMmnRtkf0mN6yo0M9d+WsZ5t51GNyt9WanyQdjsu5H/D9occ46i71pC0+6BGLHrHoEYsesegRix6x6BGLHrGkPW7KtS+q9dfj96U91uXaX9sfB9N2vXrLN12aw3fF7PN/wJeW/z6GcD9quCnWTo/hxlq75j57bTzuGtqN1cOeGIcesegRS9913Pa69PnFUZad591Du6l6MEzXOqbn7Y/pFT/8Nk3Pp8cPyXHbfXR2s881Ztt77Y/dTdmD3ekRix6x6BGLHrHo8XfoAQAAAAAAAAAAAAAAAAAAAAAAAADU3gEBFX5U"
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
          x = 513,
          y = 703,
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
          type = "tiles/WarpTile",
          shape = "rectangle",
          x = 481,
          y = 639,
          width = 14,
          height = 14,
          rotation = 0,
          gid = 1707,
          visible = true,
          properties = {
            ["map"] = "sample_indoor.lua"
          }
        }
      }
    },
    {
      type = "tilelayer",
      name = "objects",
      x = 0,
      y = 0,
      width = 100,
      height = 100,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["collidable"] = true
      },
      encoding = "base64",
      compression = "zlib",
      data = "eJzt2k2O0zAUwPE2bdesGIGQho9TzHACJDYwIHEBQNNhxQkQUkF8Cs4Ae+AUM0jAmi2IBcMtsFVbuK/vOU6mEST8f5KVxkmTkV/t53gyGgEAAAAAAABAP12v/vZfMAxXK30rj9fVec+U+j3iVMy366LSt9FCaU+tLpq7YwfJ8efGuVeI0xorFrK9rf7gnRXH3rj9t1X+HO8h8VhT1z/iVusP31zd91Av+4RVh7xc/9D6iSXtE1/H63Uo0yYWuXlUeuxBwf1PEa8VVgzitm4OW5qT0/PI47a6vCHPlUpzcnoeedyWG6vks0RpLmnrnSvvXfnQ7W3+aSXPH965FrF4mfmOv54ct366cuzKr+a3GoySXK6NU+c30FfkuHXBzcsuunJpfPJr91XJvErub4f9NCavZ+X3ZE5l0+ZVsT/cn9rf227QpjvuOoeT1TpiotPmVVr+iLRxaicTNzRz0ufySMvdab4uyTdz14fuTerPGzJtrJKxSNtpz21vhM83w9aaR+WeM2TbX3P5567b3//P45HL3XHMKm2nW+H8VzW5/XZF25fKrau3lVtz+UHuMbXJGxY5/zqdfH46Wy8vGsyXh6zu/4Ca9Pd+6H7fR658DL/zNIc3mRNjSYuBXMeQbZ46mPwpXpu1wi7GyCGRbZq2+ZGIzTzUl8xTrWfArtcp+yiu5Wq517f5k+myzXdny3I5jPd+nnQnmSvxv43NkzGZT1b7iNYfzoSt71u839OtR9NlH/Dl8XS1P6RiHK33e7y6dSvGrnqfxqPR51C+GGvhzGH7hzXdzaEt+6c0Zrn3g8kftq0NXCNta+tdx7jPc2H3Fg1++/QNAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAID3G4h4gQ4="
    },
    {
      type = "tilelayer",
      name = "roofs",
      x = 0,
      y = 0,
      width = 100,
      height = 100,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["collidable"] = false
      },
      encoding = "base64",
      compression = "zlib",
      data = "eJzt17EuBEEYB/A5uSvwDBqd3qFGhUaj8QxEQ6vRewuOxyCh5SHo1Uh8m4hcuLu1uTm7Ob9fMslmtpjJ/9vZbzclAAAAAAAAABjfZoz5ujfBl6VWSi91bwLGtDBT9w7ot6cewD/30E7psV33LprvJjK6zZzT9+zv4nq2k9JcJ+860+goMnrLXI8i+9O+7Nfiej3GhnqUWo6MuplzGpT9cfwPnrTyrjNtriOfpxjPcmqkXf8ejVb0+vsJ9HuGG5X5azH3i35/4FxlMyrzote/t8v7/YV6ZFOW+U7FXn8YtVlRn4nZHzB3PiLvy7jX67vfU5vKtv7oe3dbbSpnsDjmequx3tXnml3vrh/OGpKHszFZw/JdHTLflOdiWpXlO6hezkh9nAcAAAAAAAAAAAAAAAAAAAAAAAAAAACAaj4AcbclqQ=="
    }
  }
}
