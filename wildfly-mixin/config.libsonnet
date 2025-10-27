{
  local this = self,
  enableMultiCluster: false,
  filteringSelector: 'job="integrations/wildfly"',
  groupLabels: if self.enableMultiCluster then ['job', 'cluster'] else ['job'],
  logLabels: ['job', 'cluster', 'instance'],
  instanceLabels: ['instance'],

  dashboardTags: [self.uid],
  uid: 'wildfly',
  dashboardNamePrefix: 'Wildfly',
  dashboardPeriod: 'now-1h',
  dashboardTimezone: 'default',
  dashboardRefresh: '1m',
  metricsSource: 'prometheus',  // metrics source for signals

  // Logging configuration
  enableLokiLogs: true,
  extraLogLabels: ['level', 'severity'],  // Required by logs-lib
  logsVolumeGroupBy: 'level',
  showLogsVolume: true,

    // alerts thresholds
  alertsErrorRequestErrorRate: '30',
  alertsErrorRejectedSessions: '20',

  // Signals configuration
  signals+: {
    requests: (import './signals/requests.libsonnet')(this),
    network: (import './signals/network.libsonnet')(this),
    connections: (import './signals/connections.libsonnet')(this),
    sessions: (import './signals/sessions.libsonnet')(this),
    transactions: (import './signals/transactions.libsonnet')(this),
  },
}
