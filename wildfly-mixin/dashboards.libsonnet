local g = import './g.libsonnet';
local commonlib = import 'common-lib/common/main.libsonnet';
local logslib = import 'logs-lib/logs/main.libsonnet';
{
  local root = self,
  new(this)::

    local links = this.grafana.links;
    local tags = this.config.dashboardTags;
    local uid = g.util.string.slugify(this.config.uid);
    local vars = this.grafana.variables;
    local annotations = this.grafana.annotations;
    local refresh = this.config.dashboardRefresh;
    local period = this.config.dashboardPeriod;
    local timezone = this.config.dashboardTimezone;
    {

      'wildfly-overview.json':
        g.dashboard.new(this.config.dashboardNamePrefix + ' overview')
        + g.dashboard.withPanels(
          g.util.panel.resolveCollapsedFlagOnRows(
            g.util.grid.wrapPanels([
              this.grafana.rows.requestsRow,
              this.grafana.rows.networkRow,
            ])
          )
        ) + root.applyCommon(
          vars.multiInstance,
          uid + '_overview',
          tags,
          links { wildflyOverview+:: {} },
          annotations,
          timezone,
          refresh,
          period,
        ),
      'wildfly-datasource.json':
        g.dashboard.new(this.config.dashboardNamePrefix + ' datasource')
        + g.dashboard.withPanels(
          g.util.panel.resolveCollapsedFlagOnRows(
            g.util.grid.wrapPanels([
              this.grafana.rows.connectionsRow,
              this.grafana.rows.transactionsRow,
            ])
          )
        ) + root.applyCommon(
          vars.multiInstance,
          uid + '_datasource',
          tags,
          links { wildflyDatasource+:: {} },
          annotations,
          timezone,
          refresh,
          period,
        ),

    } + if this.config.enableLokiLogs then {
    } else {},

  applyCommon(vars, uid, tags, links, annotations, timezone, refresh, period):
    g.dashboard.withTags(tags)
    + g.dashboard.withUid(uid)
    + g.dashboard.withLinks(std.objectValues(links))
    + g.dashboard.withTimezone(timezone)
    + g.dashboard.withRefresh(refresh)
    + g.dashboard.time.withFrom(period)
    + g.dashboard.withVariables(vars)
    + g.dashboard.withAnnotations(std.objectValues(annotations)),
}
