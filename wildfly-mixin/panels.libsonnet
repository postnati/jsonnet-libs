local g = import './g.libsonnet';
local commonlib = import 'common-lib/common/main.libsonnet';

{
  new(this)::
    {
      local signals = this.signals,

      requestsPanel:
        g.panel.timeSeries.new('Requests')
        + g.panel.timeSeries.panelOptions.withDescription('Requests rate over time')
        + g.panel.timeSeries.queryOptions.withTargets([
          signals.requests.requestsRate.asTarget()
          + g.query.prometheus.withIntervalFactor(2),
        ])
        + g.panel.timeSeries.standardOptions.withUnit('reqps'),
      requestErrorsPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Request Errors',
          targets=[signals.requests.requestErrorsRate.asTarget() { interval: '5m' }],
          description='Rate of requests that result in 500 over time'
        )
        + g.panel.timeSeries.standardOptions.withUnit('reqps')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      networkReceivedThroughputPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Network Received Throughput',
          targets=[signals.network.networkReceivedThroughput.asTarget() { interval: '5m' }],
          description='Throughput rate of data received over time'
        )
        + g.panel.timeSeries.standardOptions.withUnit('binBps')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      networkSentThroughputPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Network Sent Throughput',
          targets=[signals.network.networkSentThroughput.asTarget() { interval: '5m' }],
          description='Throughput rate of data sent over time'
        )
        + g.panel.timeSeries.standardOptions.withUnit('binBps')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      connectionsActivePanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Active Connections',
          targets=[signals.connections.connectionsActive.asTarget() { interval: '5m' }],
          description='Active connections to the datasource over time'
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      connectionsIdlePanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Idle Connections',
          targets=[signals.connections.connectionsIdle.asTarget() { interval: '5m' }],
          description='Idle connections to the datasource over time'
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      transactionsCreatedPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Created Transactions',
          targets=[signals.transactions.transactionsCreated.asTarget() { interval: '5m' }],
          description='Number of transactions that were created over time'
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      transactionsInFlightPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'In-flight Transactions',
          targets=[signals.transactions.transactionsInFlight.asTarget() { interval: '5m' }],
          description='Number of transactions that are in-flight over time'
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      transactionsAbortedPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Aborted Transactions',
          targets=[signals.transactions.transactionsAborted.asTarget() { interval: '5m' }],
          description='Number of transactions that have been aborted over time'
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      sessionsActivePanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Active Sessions',
          targets=[signals.sessions.activeSessions.asTarget() { interval: '5m' }],
          description='Number of active sessions to deployment over time'
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      sessionsExpiredPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Expired Sessions',
          targets=[signals.sessions.expiredSessions.asTarget() { interval: '5m' }],
          description='Number of sessions that have expired for a deployment over time'
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      sessionsRejectedPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Rejected Sessions',
           targets=[signals.sessions.rejectedSessions.asTarget() { interval: '5m' }],
          description='Number of sessions that have been rejected from a deployment over time'
        )
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
    },
}