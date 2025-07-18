local g = import './g.libsonnet';

{
  local link = g.dashboard.link,
  new(this):
    {
      tensorflowOverview:
        link.link.new('TensorFlow logs', '/d/tensorflow-logs')
        + link.link.options.withKeepTime(true),

      otherDashboards:
        link.dashboards.new('All dashboards', this.config.dashboardTags)
        + link.dashboards.options.withIncludeVars(true)
        + link.dashboards.options.withKeepTime(true)
        + link.dashboards.options.withAsDropdown(true),
    }
    +
    if this.config.enableLokiLogs then
      {
        logs:
          link.link.new('TensorFlow logs', '/d/tensorflow-logs')
          + link.link.options.withKeepTime(true),
      }
    else {},
}
