local g = import './g.libsonnet';
local commonlib = import 'common-lib/common/main.libsonnet';

{
  new(this)::
    {
      local signals = this.signals,

      requestsPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Requests',
          targets=[signals.requests.requestsRate.asTarget() { interval: '1m' }],
          description='Requests rate over time'
        )
        + g.panel.timeSeries.standardOptions.withUnit('reqps')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      requestErrorsPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Request Errors',
          targets=[signals.requests.requestErrorsRate.asTarget() { interval: '1m' }],
          description='Rate of requests that result in 500 over time'
        )
        + g.panel.timeSeries.standardOptions.withUnit('reqps')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      networkReceivedThroughputPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Network Received Throughput',
          targets=[signals.network.networkReceivedThroughput.asTarget() { interval: '1m' }],
          description='Throughput rate of data received over time'
        )
        + g.panel.timeSeries.standardOptions.withUnit('reqps')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      networkSentThroughputPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Network Sent Throughput',
          targets=[signals.network.networkSentThroughput.asTarget() { interval: '1m' }],
          description='Throughput rate of data sent over time'
        )
        + g.panel.timeSeries.standardOptions.withUnit('reqps')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      connectionsActivePanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Active Connections',
          targets=[signals.connections.connectionsActive.asTarget() { interval: '1m' }],
          description='Active connections to the datasource over time'
        )
        + g.panel.timeSeries.standardOptions.withUnit('reqps')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      connectionsIdlePanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Idle Connections',
          targets=[signals.connections.connectionsIdle.asTarget() { interval: '1m' }],
          description='Idle connections to the datasource over time'
        )
        + g.panel.timeSeries.standardOptions.withUnit('reqps')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      transactionsCreatedPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Created Transactions',
          targets=[signals.transactions.transactionsCreated.asTarget() { interval: '1m' }],
          description='Number of transactions that were created over time'
        )
        + g.panel.timeSeries.standardOptions.withUnit('reqps')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      transactionsInFlightPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'In-flight Transactions',
          targets=[signals.transactions.transactionsInFlight.asTarget() { interval: '1m' }],
          description='Number of transactions that are in-flight over time'
        )
        + g.panel.timeSeries.standardOptions.withUnit('reqps')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      transactionsAbortedPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Aborted Transactions',
          targets=[signals.transactions.transactionsAborted.asTarget() { interval: '1m' }],
          description='Number of transactions that have been aborted over time'
        )
        + g.panel.timeSeries.standardOptions.withUnit('reqps')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
    },
}