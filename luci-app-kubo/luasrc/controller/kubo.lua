module("luci.controller.kubo", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/kubo") then return end
    entry({ "admin", "services" }, firstchild(), "Services", 44).dependent = false
    entry({ "admin", "services", "kubo" }, cbi("kubo"), _("Kubo"), 100).dependent = false
end
