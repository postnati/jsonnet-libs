local g = import './g.libsonnet';
local commonlib = import 'common-lib/common/main.libsonnet';

{
  new(this)::
    {
      local signals = this.signals,

      modelRequestRatePanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Model request rate',
          targets=[signals.serving.modelRequestRate.asTarget()],
          description='Rate of requests over time for the selected model. Grouped by statuses.'
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withGradientMode('opacity')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineInterpolation('linear')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineWidth(2)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false)
        + g.panel.timeSeries.standardOptions.withUnit('reqps')
        + g.panel.timeSeries.options.legend.withCalcs([])
        + g.panel.timeSeries.options.legend.withDisplayMode('list')
        + g.panel.timeSeries.options.tooltip.withMode('multi')
        + g.panel.timeSeries.options.tooltip.withSort('desc')
        + g.panel.timeSeries.panelOptions.withPluginVersion(),

      modelPredictRequestLatencyPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Model predict request latency',
          targets=[signals.serving.modelPredictRequestLatency.asTarget()],
          description='Average request latency of predict requests for the selected model.'
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withGradientMode('opacity')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineInterpolation('linear')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineWidth(2)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false)
        + g.panel.timeSeries.standardOptions.withUnit('µs')
        + g.panel.timeSeries.options.legend.withCalcs([])
        + g.panel.timeSeries.options.legend.withDisplayMode('list')
        + g.panel.timeSeries.options.tooltip.withMode('multi')
        + g.panel.timeSeries.options.tooltip.withSort('desc')
        + g.panel.timeSeries.panelOptions.withPluginVersion(),

      modelPredictRuntimeLatencyPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Model predict runtime latency',
          targets=[signals.serving.modelPredictRuntimeLatency.asTarget()],
          description='Average runtime latency to fulfill a predict request for the selected model.'
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withGradientMode('opacity')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineInterpolation('linear')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineWidth(2)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false)
        + g.panel.timeSeries.standardOptions.withUnit('µs')
        + g.panel.timeSeries.options.legend.withCalcs([])
        + g.panel.timeSeries.options.legend.withDisplayMode('list')
        + g.panel.timeSeries.options.tooltip.withMode('multi')
        + g.panel.timeSeries.options.tooltip.withSort('desc')
        + g.panel.timeSeries.panelOptions.withPluginVersion(),

      graphBuildCalls:
        commonlib.panels.generic.timeSeries.base.new(
          'Graph build calls',
          targets=[signals.serving.graphBuildCalls.asTarget()],
          description='Number of times TensorFlow Serving has created a new client graph.'
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withGradientMode('opacity')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineInterpolation('linear')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineWidth(2)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false)
        + g.panel.timeSeries.standardOptions.withUnit('none')
        + g.panel.timeSeries.options.legend.withCalcs([])
        + g.panel.timeSeries.options.legend.withDisplayMode('list')
        + g.panel.timeSeries.options.tooltip.withMode('multi')
        + g.panel.timeSeries.options.tooltip.withSort('desc')
        + g.panel.timeSeries.panelOptions.withPluginVersion(),

      graphRuns:
        commonlib.panels.generic.timeSeries.base.new(
          'Graph runs',
          targets=[signals.serving.graphRuns.asTarget()],
          description='Number of graph executions.'
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withGradientMode('opacity')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineInterpolation('linear')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineWidth(2)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false)
        + g.panel.timeSeries.standardOptions.withUnit('none')
        + g.panel.timeSeries.options.legend.withCalcs([])
        + g.panel.timeSeries.options.legend.withDisplayMode('list')
        + g.panel.timeSeries.options.tooltip.withMode('multi')
        + g.panel.timeSeries.options.tooltip.withSort('desc')
        + g.panel.timeSeries.panelOptions.withPluginVersion(),

      graphBuildTime:
        commonlib.panels.generic.timeSeries.base.new(
          'Graph build time',
          targets=[signals.serving.graphBuildTime.asTarget()],
          description='Amount of time Tensorflow has spent creating new client graphs.'
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withGradientMode('opacity')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineInterpolation('linear')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineWidth(2)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false)
        + g.panel.timeSeries.standardOptions.withUnit('µs')
        + g.panel.timeSeries.options.legend.withCalcs([])
        + g.panel.timeSeries.options.legend.withDisplayMode('list')
        + g.panel.timeSeries.options.tooltip.withMode('multi')
        + g.panel.timeSeries.options.tooltip.withSort('desc')
        + g.panel.timeSeries.panelOptions.withPluginVersion(),

      graphRunTime:
        commonlib.panels.generic.timeSeries.base.new(
          'Graph run time',
          targets=[signals.serving.graphRunTime.asTarget()],
          description='Amount of time spent executing graphs.'
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withGradientMode('opacity')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineInterpolation('linear')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineWidth(2)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false)
        + g.panel.timeSeries.standardOptions.withUnit('µs')
        + g.panel.timeSeries.options.legend.withCalcs([])
        + g.panel.timeSeries.options.legend.withDisplayMode('list')
        + g.panel.timeSeries.options.tooltip.withMode('multi')
        + g.panel.timeSeries.options.tooltip.withSort('desc')
        + g.panel.timeSeries.panelOptions.withPluginVersion(),

      batchQueuingLatencyPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Batch queuing latency',
          targets=[signals.serving.batchQueuingLatency.asTarget()],
          description='Current latency in the batching queue.'
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withGradientMode('opacity')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineInterpolation('smooth')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineWidth(2)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false)
        + g.panel.timeSeries.standardOptions.withUnit('µs')
        + g.panel.timeSeries.options.legend.withCalcs([])
        + g.panel.timeSeries.options.legend.withDisplayMode('list')
        + g.panel.timeSeries.options.tooltip.withMode('multi')
        + g.panel.timeSeries.options.tooltip.withSort('desc')
        + g.panel.timeSeries.panelOptions.withPluginVersion(),

      batchQueueThroughput:
        commonlib.panels.generic.timeSeries.base.new(
          'Batch queue throughput',
          targets=[signals.serving.batchQueueThroughput.asTarget()],
          description='Rate of batch queue throughput over time.'
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withGradientMode('opacity')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineInterpolation('smooth')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withLineWidth(2)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false)
        + g.panel.timeSeries.standardOptions.withUnit('reqps')
        + g.panel.timeSeries.options.legend.withCalcs([])
        + g.panel.timeSeries.options.legend.withDisplayMode('list')
        + g.panel.timeSeries.options.tooltip.withMode('multi')
        + g.panel.timeSeries.options.tooltip.withSort('desc')
        + g.panel.timeSeries.panelOptions.withPluginVersion(),
    },
}