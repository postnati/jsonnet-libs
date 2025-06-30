local g = import './g.libsonnet';
local logslib = import 'logs-lib/logs/main.libsonnet';

{
  local root = self,
  
  new(this)::
    local prefix = this.config.dashboardNamePrefix;
    local links = this.grafana.links;
    local tags = this.config.dashboardTags;
    local uid = g.util.string.slugify(this.config.uid);
    local vars = this.grafana.variables;
    local annotations = this.grafana.annotations;
    local refresh = this.config.dashboardRefresh;
    local period = this.config.dashboardPeriod;
    local timezone = this.config.dashboardTimezone;
    local panels = this.grafana.panels;

    {
        'tensorflow-overview':
            g.dashboard.new(prefix + ' Overview')
            + g.dashboard.withPanels(
                g.util.wrapPanels(
                    [
                        
                    ]
                )
            )
            + g.dashboard.withTags(tags)
            + g.dashboard.withUid(uid)
            + g.dashboard.withLinks(std.objectValues(links))
            + g.dashboard.withTimezone(timezone)
            + g.dashboard.withRefresh(refresh)
            + g.dashboard.time.withFrom(period)
            + g.dashboard.withVariables(vars)
            + g.dashboard.withAnnotations(std.objectValues(annotations)),
    }
} 
