local running = (luci.sys.call('pidof ipfs > /dev/null') == 0)

if running then
    state_msg = '<b><font color="green">' .. translate('kubo running') .. '</font></b>'
else
    state_msg = '<b><font color="red">' .. translate('kubo not run') .. '</font></b>'
end

local m = Map(
    'kubo',
    translate('Kubo'),
    translate('An IPFS implementation in Go') ..
    ' <br/> <br/> ' .. translate('kubo state') .. ' : ' .. state_msg .. '<br/> <br/>'
)

s = m:section(TypedSection, 'kubo')
s.addremove = false
s.anonymous = true

-- 基础设置
s:tab("basic", translate("Basic Setting"))

enable                        = s:taboption('basic', Flag, 'enabled', translate('run kubo as daemon'))
enable.rmempty                = false

workdir                       = s:taboption('basic', Value, 'workdir', translate('kubo working dir'))
workdir.rmempty               = false
workdir.placeholder           = '/etc/kubo'
workdir.default               = '/etc/kubo'
workdir.datatype              = "string"

enable_gc                     = s:taboption('basic', Flag, 'enable_gc', translate('Enable gc flag'))
enable.rmempty                = false

enable_namesys_pubsub         = s:taboption('basic', Flag, 'enable_namesys_pubsub', translate('Enable IPNS over pubsub'))
enable_namesys_pubsub.rmempty = false

return m
