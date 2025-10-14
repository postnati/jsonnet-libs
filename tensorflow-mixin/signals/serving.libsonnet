local commonlib = import 'common-lib/common/main.libsonnet';

function(this) {
  filteringSelector: this.filteringSelector,
  groupLabels: this.groupLabels,
  instanceLabels: this.instanceLabels,
  enableLokiLogs: this.enableLokiLogs,
  aggLevel: 'none',
  aggFunction: 'avg',
  alertsInterval: '2m',
  discoveryMetric: {
    prometheus: ':tensorflow:serving:request_count',
  },
  signals: {
    modelRequestRate: {
      name: 'Model request rate',
      nameShort: 'Request rate',
      type: 'counter',
      description: 'Rate of requests over time for the selected model. Grouped by statuses.',
      unit: 'reqps',
      sources: {
        prometheus: {
          expr: ':tensorflow:serving:request_count{%(queriesSelector)s}',
          legendCustomTemplate: '{{ instance }} - {{ model_name }}',
        },
      },
    },

    modelPredictRequestLatency: {
      name: 'Model predict request latency',
      nameShort: 'Request latency',
      type: 'gauge',
      description: 'Average request latency of predict requests for the selected model.',
      unit: 'µs',
      sources: {
        prometheus: {
          expr: 'increase(:tensorflow:serving:request_latency_sum{%(queriesSelector)s}[$__rate_interval])/increase(:tensorflow:serving:request_latency_count{%(queriesSelector)s}[$__rate_interval])',
          legendCustomTemplate: '{{ instance }} - {{ model_name }}',
        },
      },
    },

    modelPredictRuntimeLatency: {
      name: 'Model predict runtime latency',
      nameShort: 'Runtime latency',
      type: 'gauge',
      description: 'Average runtime latency to fulfill a predict request for the selected model.',
      unit: 'µs',
      sources: {
        prometheus: {
          expr: 'increase(:tensorflow:serving:runtime_latency_sum{%(queriesSelector)s}[$__rate_interval])/increase(:tensorflow:serving:runtime_latency_count{%(queriesSelector)s}[$__rate_interval])',
          legendCustomTemplate: '{{ instance }} - {{ model_name }}',
        },
      },
    },

    graphBuildCalls: {
      name: 'Graph build calls',
      nameShort: 'Build calls',
      type: 'gauge',
      description: 'Number of graph build calls over time.',
      unit: 'none',
      sources: {
        prometheus: {
          expr: 'increase(:tensorflow:core:graph_build_calls{%(queriesSelector)s}[$__rate_interval])',
          legendCustomTemplate: '{{ instance }}',
        },
      },
    },

    graphRuns: {
      name: 'Graph runs',
      nameShort: 'Runs',
      type: 'gauge',
      description: 'Number of graph runs over time.',
      unit: 'none',
      sources: {
        prometheus: {
          expr: 'increase(:tensorflow:core:graph_runs{%(queriesSelector)s}[$__rate_interval])',
          legendCustomTemplate: '{{ instance }}',
        },
      },
    },

    graphBuildTime: {
      name: 'Graph build time',
      nameShort: 'Build time',
      type: 'gauge',
      description: 'Amount of time Tensorflow has spent creating new client graphs.',
      unit: 'µs',
      sources: {
        prometheus: {
          expr: 'increase(:tensorflow:core:graph_build_time_usecs{%(queriesSelector)s}[$__rate_interval])/increase(:tensorflow:core:graph_build_calls{%(queriesSelector)s}[$__rate_interval])',
          legendCustomTemplate: '{{ instance }}',
        },
      },
    },

    graphRunTime: {
      name: 'Graph run time',
      nameShort: 'Run time',
      type: 'gauge',
      description: 'Amount of time spent executing graphs.',
      unit: 'µs',
      sources: {
        prometheus: {
          expr: 'increase(:tensorflow:core:graph_run_time_usecs{%(queriesSelector)s}[$__rate_interval])/increase(:tensorflow:core:graph_runs{%(queriesSelector)s}[$__rate_interval])',
          legendCustomTemplate: '{{ instance }}',
        },
      },
    },

    batchQueuingLatency: {
      name: 'Batch queuing latency',
      nameShort: 'Queuing latency',
      type: 'gauge',
      description: 'Average time requests spend in the batching queue.',
      unit: 'µs',
      sources: {
        prometheus: {
          expr: 'increase(:tensorflow:serving:batching_session:queuing_latency_sum{%(queriesSelector)s}[$__rate_interval]) / increase(:tensorflow:serving:batching_session:queuing_latency_count[2m])',
          legendCustomTemplate: '{{ instance }}',
        },
      },
    },

    batchQueueThroughput: {
      name: 'Batch queue throughput',
      nameShort: 'Throughput',
      type: 'gauge',
      description: 'Throughput of the batch queue.',
      unit: 'reqps',
      sources: {
        prometheus: {
          expr: 'increase(:tensorflow:serving:batch_queue_throughput{%(queriesSelector)s}[$__rate_interval])',
          legendCustomTemplate: '{{ instance }}',
        },
      },
    },
  },
} 