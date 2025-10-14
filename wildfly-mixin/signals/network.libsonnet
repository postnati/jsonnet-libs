// for Network related signals
function(this)
  {
    filteringSelector: this.filteringSelector,
    groupLabels: this.groupLabels,
    instanceLabels: this.instanceLabels,
    enableLokiLogs: this.enableLokiLogs,
    aggLevel: 'none',
    aggFunction: 'avg',
    alertsInterval: '5m',
    discoveryMetric: {
      prometheus: 'wildfly_undertow_request_count_total',
    },
    signals: {
      networkReceivedThroughput: {
        name: 'Network Received Throughput',
        nameShort: 'Network Received',
        type: 'raw',
        description: 'Throughput rate of data received over time',
        unit: 'reqps',
        sources: {
          prometheus: {
            expr: 'rate(wildfly_undertow_bytes_received_total_bytes{%(queriesSelector)s}[$__rate_interval])',
            legendCustomTemplate: '{{ server }} - {{ http_listener }} - {{ https_listener }}',
          },
        },
      },
      networkSentThroughput: {
        name: 'Network Sent Throughput',
        nameShort: 'Network Sent',
        type: 'raw',
        description: 'Throughput rate of data sent over time',
        unit: 'reqps',
        sources: {
          prometheus: {
            expr: 'rate(wildfly_undertow_bytes_sent_total_bytes{%(queriesSelector)s}[$__rate_interval])',
            legendCustomTemplate: '{{server}} - {{http_listener}}{{https_listener}}',
          },
        },
      },
    },
  }