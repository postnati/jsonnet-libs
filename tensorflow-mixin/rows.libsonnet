local g = import './g.libsonnet';
local panels = import './panels.libsonnet';

{
  new(this): {
    modelPanels:
      g.panel.row.new('Model')
      + g.panel.row.withCollapsed(false)
      + g.panel.row.withPanels([
        this.grafana.panels.modelRequestRatePanel { gridPos+: { w: 24 } },
        this.grafana.panels.modelPredictRequestLatencyPanel { gridPos+: { w: 12 } },
        this.grafana.panels.modelPredictRuntimeLatencyPanel { gridPos+: { w: 12 } },
      ]),

    servingOverviewPanels:
      g.panel.row.new('Serving overview')
      + g.panel.row.withCollapsed(false)
      + g.panel.row.withPanels([
        this.grafana.panels.graphBuildCalls { gridPos+: { w: 12 } },
        this.grafana.panels.graphRuns { gridPos+: { w: 12 } },
        this.grafana.panels.graphBuildTime { gridPos+: { w: 12 } },
        this.grafana.panels.graphRunTime { gridPos+: { w: 12 } },
        // this.grafana.panels.batchQueuingLatencyPanel { gridPos+: { w: 12 } },
        // this.grafana.panels.batchQueueThroughput { gridPos+: { w: 12 } },
      ]),
  },
}
