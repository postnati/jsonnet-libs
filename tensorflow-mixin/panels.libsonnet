local g = import './g.libsonnet';
local commonlib = import 'common-lib/common/main.libsonnet';

{
  new(this)::
    {
      local t = this.grafana.targets,

      modelRequestRatePanel:
        commonlib.panels.generic.timeSeries.base.new(
            title='Model Request Rate',
            description='Rate of requests over time for the selected model. Grouped by statuses.',
            targets=[t.modelRequestRate]
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
    }
}