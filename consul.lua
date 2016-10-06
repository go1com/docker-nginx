module("resty.consul", package.seeall)

_VERSION = '0.1.0'

function service_nodes(hostname)
    local http = require "resty.http"
    local json = require "cjson"
    local hc = http:new()

    local upstream = ""

    if string.find(hostname, ".go1.service") then
        local service, env = string.match(hostname, '([%a%w-_]+).([%a%w-_]+)')

        if env == "go1" then
            env = "production"
        end

        local consul = os.getenv("CONSUL_CONNECT")

        if consul == nil then
            consul = "127.0.0.1:8500"
        end

        local ok, code, headers, status, body = hc:request {
            url = "http://".. consul .. "/v1/catalog/service/" .. service .. "?tag=" .. env,
            method = "GET"
        }

        if body then
            local nodes = json.decode(body)
            node = math.random(1, #nodes)
            upstream = nodes[node]["Address"] .. ":" .. nodes[node]["ServicePort"]
        end
        return upstream
    else
        return "127.0.0.1:8080"
    end

end