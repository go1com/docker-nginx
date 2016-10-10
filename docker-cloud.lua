module("resty.docker-cloud", package.seeall)

_VERSION = '0.1.0'

function service_nodes(hostname)
    local upstream = "127.0.0.1:8080"

    if string.find(hostname, ".go1.service") then
        local service, env = string.match(hostname, '([%a%w-_]+).([%a%w-_]+)')

        if env == "go1" then
            env = "production"
        end
--        For using docker-cloud, we need to have stackname == [service]-[env]
        upstream = "web." .. service .. "-" .. env
    end
    return upstream

end