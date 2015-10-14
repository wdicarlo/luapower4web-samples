require "xavante"
require "xavante.filehandler"
--require "xavante.cgiluahandler"
require "xavante.redirecthandler"
require "wsapi.xavante"
require "orbit.ophandler"
--require "debugger"()

-- Define here where Xavante HTTP documents scripts are located
local webDir = "."

local simplerules = {

    { -- URI remapping example
        match = "^[^%./]*/$",
        with = xavante.redirecthandler,
        params = {"hello.ws"}
    },

    { -- cgiluahandler example
        match = {"%.ws$", "%.ws/.*$", "%.lp$", "%.lp/.*$", "%.lua$", "%.lua/.*$" },
       
        with = wsapi.xavante.makeGenericHandler (webDir)
    },

    { -- filehandler example
        match = ".",
        with = xavante.filehandler,
        params = {baseDir = webDir}
    },

    { -- Orbit pages handler
        match = {"%.op$", "%.op/.*$" },
        with = orbit.ophandler.makeHandler (webDir, {})
    },
}

xavante.HTTP{
    server = {host = "*", port = 8080},

    defaultHost = {
        rules = simplerules

    },
}

xavante.start()
