// Cluster-level signals for OpenSearch
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
      prometheus: 'opensearch_cluster_status',
    },
    signals: {
      cluster_status: {
        name: 'Cluster status',
        description: 'Overall cluster health status as a numeric code.',
        type: 'gauge',
        aggLevel: 'group',
        aggFunction: 'min',
        sources: {
          prometheus: {
            expr: 'opensearch_cluster_status{%(queriesSelectorGroupOnly)s}',
            legendCustomTemplate: '{{opensearch_cluster}}',
          },
        },
      },
      cluster_nodes_number: {
        name: 'Node count',
        description: 'The number of running nodes across the OpenSearch cluster.',
        type: 'gauge',
        aggLevel: 'group',
        aggFunction: 'min',
        sources: {
          prometheus: {
            expr: 'opensearch_cluster_nodes_number{%(queriesSelectorGroupOnly)s}',
            legendCustomTemplate: '{{opensearch_cluster}}',
          },
        },
      },
      cluster_datanodes_number: {
        name: 'Data node count',
        description: 'The number of data nodes in the OpenSearch cluster.',
        type: 'gauge',
        aggLevel: 'group',
        aggFunction: 'min',
        sources: {
          prometheus: {
            expr: 'opensearch_cluster_datanodes_number{%(queriesSelectorGroupOnly)s}',
            legendCustomTemplate: '{{opensearch_cluster}}',
          },
        },
      },
      cluster_shards_number_total: {
        name: 'Shard count',
        description: 'The number of shards in the OpenSearch cluster across all indices.',
        type: 'gauge',
        aggLevel: 'group',
        aggFunction: 'max',
        sources: {
          prometheus: {
            expr: 'opensearch_cluster_shards_number{%(queriesSelectorGroupOnly)s}',
            legendCustomTemplate: '{{opensearch_cluster}}',
            aggKeepLabels: ['type'],
          },
        },
      },
      cluster_shards_number_by_type: {
        name: 'Shard status',
        description: 'Shard status counts across the Opensearch cluster.',
        type: 'gauge',
        aggLevel: 'group',
        aggFunction: 'min',
        sources: {
          prometheus: {
            expr: 'opensearch_cluster_shards_number{%(queriesSelectorGroupOnly)s}',
            legendCustomTemplate: '{{type}}',
            aggKeepLabels: ['type'],
          },
        },
      },
      cluster_shards_active_percent: {
        name: 'Active shards %%',
        description: 'Percent of active shards across the OpenSearch cluster.',
        type: 'gauge',
        aggLevel: 'group',
        aggFunction: 'min',
        unit: 'percent',
        sources: {
          prometheus: {
            expr: 'opensearch_cluster_shards_active_percent{%(queriesSelectorGroupOnly)s}',
            legendCustomTemplate: '{{opensearch_cluster}}',
          },
        },
      },
      cluster_pending_tasks_number: {
        name: 'Pending tasks',
        description: 'The number of tasks waiting to be executed across the OpenSearch cluster.',
        type: 'raw',
        sources: {
          prometheus: {
            expr: 'avg by(' + this.groupAggList + ') (opensearch_cluster_pending_tasks_number{%(queriesSelector)s})',
          },
        },
      },
      cluster_task_max_wait_seconds: {
        name: 'Max task wait time',
        description: 'The max wait time for tasks to be executed across the OpenSearch cluster.',
        type: 'raw',
        unit: 's',
        sources: {
          prometheus: {
            expr: 'max by(' + this.groupAggList + ') (opensearch_cluster_task_max_waiting_time_seconds{%(queriesSelector)s})',
          },
        },
      },
      indices_indexing_index_count_avg: {
        name: 'Total documents',
        description: 'The total count of documents indexed across the OpenSearch cluster.',
        type: 'raw',
        unit: 'count',
        sources: {
          prometheus: {
            expr: 'avg by(' + this.groupAggList + ') (opensearch_indices_indexing_index_count{%(queriesSelector)s})',
          },
        },
      },
      indices_store_size_bytes_avg: {
        name: 'Store size',
        description: 'The total size of the store across the OpenSearch cluster.',
        type: 'raw',
        unit: 'bytes',
        sources: {
          prometheus: {
            expr: 'avg by(' + this.groupAggList + ') (opensearch_indices_store_size_bytes{%(queriesSelector)s})',
          },
        },
      },
    },
  }
