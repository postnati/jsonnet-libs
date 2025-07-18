{
  local this = self,
  filteringSelector: 'job="integrations/tensorflow"',
  groupLabels: ['job', 'cluster'],
  logLabels: ['cluster'],
  instanceLabels: ['instance'],

  dashboardTags: [self.uid],
  uid: 'tensorflow',
  dashboardNamePrefix: 'TensorFlow',
  dashboardPeriod: 'now-30m',
  dashboardTimezone: 'default',
  dashboardRefresh: '1m',
  metricsSource: 'prometheus',  // metrics source for signals

  // Logging configuration
  enableLokiLogs: true,
  extraLogLabels: ['level'],  // Required by logs-lib
  logsVolumeGroupBy: 'level',
  showLogsVolume: true,

  // Signals configuration
  signals+: {
    serving: (import './signals/serving.libsonnet')(this),
  },
}
