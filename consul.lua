module("resty.consul", package.seeall)

_VERSION = '0.1.0'

function service_nodes(hostname)
    local http = require "resty.http"
    local json = require "cjson"
    local hc = http:new()

    local upstream = "127.0.0.1:8080"

    if string.find(hostname, ".go1.service") then
        local service, env = string.match(hostname, '([%a%w-_]+).([%a%w-_]+)')

        if env == "go1" then
            env = "production"
        end

        local consul = os.getenv("CONSUL_CONNECT")

        if consul == nil then
            consul = "127.0.0.1:8500"
        end

        local res, err = hc:request_uri("http://" .. consul .. "/v1/catalog/service/" .. service .. "?tag=" .. env, {
            method = "GET"
        })

        if not res then
            return upstream
        else
            local nodes = json.decode(res.body)
            if #nodes > 0 then
                math.randomseed(os.time())
                node = math.random(#nodes)
                upstream = nodes[node]["Address"] .. ":" .. nodes[node]["ServicePort"]
            end
        end
        return upstream
    else
        return upstream
    end

end