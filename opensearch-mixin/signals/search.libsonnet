// Search operation signals for OpenSearch
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
      prometheus: 'opensearch_index_search_query_current_number',
    },
    signals: {
      search_query_current_avg: {
        name: 'Search queries in-flight',
        description: 'In-flight search queries.',
        type: 'raw',
        unit: 'ops',
        sources: {
          prometheus: {
            expr: 'avg by (job,opensearch_cluster,index) (opensearch_index_search_query_current_number{opensearch_cluster!="",job=~"$job",opensearch_cluster=~"$opensearch_cluster",index=~"$index", context=~"total"})',
            legendCustomTemplate: '{{index}} - query',
          },
        },
      },
      search_fetch_current_avg: {
        name: 'Search fetch in-flight',
        description: 'In-flight fetch operations.',
        type: 'raw',
        unit: 'ops',
        sources: {
          prometheus: {
            expr: 'avg by (job,opensearch_cluster,index) (opensearch_index_search_fetch_current_number{opensearch_cluster!="",job=~"$job",opensearch_cluster=~"$opensearch_cluster",index=~"$index", context=~"total"})',
            legendCustomTemplate: '{{index}} - fetch',
          },
        },
      },
      search_scroll_current_avg: {
        name: 'Search scroll in-flight',
        description: 'In-flight scroll operations.',
        type: 'raw',
        unit: 'ops',
        sources: {
          prometheus: {
            expr: 'avg by (job,opensearch_cluster,index) (opensearch_index_search_scroll_current_number{opensearch_cluster!="",job=~"$job",opensearch_cluster=~"$opensearch_cluster",index=~"$index", context=~"total"})',
            legendCustomTemplate: '{{index}} - scroll',
          },
        },
      },
      search_query_latency_avg: {
        name: 'Search query latency (avg)',
        description: 'Average query latency.',
        type: 'raw',
        unit: 's',
        sources: {
          prometheus: {
            expr: 'avg by (job,opensearch_cluster,index) (increase(opensearch_index_search_query_time_seconds{opensearch_cluster!="",job=~"$job",opensearch_cluster=~"$opensearch_cluster",index=~"$index"}[$__interval:]) / clamp_min(increase(opensearch_index_search_query_count{opensearch_cluster!="",job=~"$job",opensearch_cluster=~"$opensearch_cluster",index=~"$index", context="total"}[$__interval:]), 1))',
            legendCustomTemplate: '{{index}} - query',
          },
        },
      },
      search_fetch_latency_avg: {
        name: 'Search fetch latency (avg)',
        description: 'Average fetch latency.',
        type: 'raw',
        unit: 's',
        sources: {
          prometheus: {
            expr: 'avg by (job,opensearch_cluster,index) (increase(opensearch_index_search_fetch_time_seconds{opensearch_cluster!="",job=~"$job",opensearch_cluster=~"$opensearch_cluster",index=~"$index", context="total"}[$__interval:]) / clamp_min(increase(opensearch_index_search_fetch_count{opensearch_cluster!="",job=~"$job",opensearch_cluster=~"$opensearch_cluster",index=~"$index", context="total"}[$__interval:]), 1))',
            legendCustomTemplate: '{{index}} - fetch',
          },
        },
      },
      search_scroll_latency_avg: {
        name: 'Search scroll latency (avg)',
        description: 'Average scroll latency.',
        type: 'raw',
        unit: 's',
        sources: {
          prometheus: {
            expr: 'avg by (job,opensearch_cluster,index) (increase(opensearch_index_search_scroll_time_seconds{opensearch_cluster!="",job=~"$job",opensearch_cluster=~"$opensearch_cluster",index=~"$index", context="total"}[$__interval:]) / clamp_min(increase(opensearch_index_search_scroll_count{opensearch_cluster!="",job=~"$job",opensearch_cluster=~"$opensearch_cluster",index=~"$index", context="total"}[$__interval:]), 1))',
            legendCustomTemplate: '{{index}} - scroll',
          },
        },
      },
      request_cache_hit_rate: {
        name: 'Request cache hit rate %%',
        description: 'Request cache hit rate.',
        type: 'raw',
        unit: 'percent',
        sources: {
          prometheus: {
            expr: 'avg by(job,opensearch_cluster,index) (100 * (opensearch_index_requestcache_hit_count{opensearch_cluster!="",job=~"$job",opensearch_cluster=~"$opensearch_cluster",index=~"$index", context="total"}) / clamp_min(opensearch_index_requestcache_hit_count{opensearch_cluster!="",job=~"$job",opensearch_cluster=~"$opensearch_cluster",index=~"$index", context="total"} + opensearch_index_requestcache_miss_count{opensearch_cluster!="",job=~"$job",opensearch_cluster=~"$opensearch_cluster",index=~"$index", context="total"}, 1))',
            legendCustomTemplate: '{{index}} - request',
          },
        },
      },
      query_cache_hit_rate: {
        name: 'Query cache hit rate %%',
        description: 'Query cache hit rate.',
        type: 'raw',
        unit: 'percent',
        sources: {
          prometheus: {
            expr: 'avg by(job,opensearch_cluster,index) (100 * (opensearch_index_querycache_hit_count{opensearch_cluster!="",job=~"$job",opensearch_cluster=~"$opensearch_cluster",index=~"$index", context="total"}) / clamp_min(opensearch_index_querycache_hit_count{opensearch_cluster!="",job=~"$job",opensearch_cluster=~"$opensearch_cluster",index=~"$index", context="total"} + opensearch_index_querycache_miss_number{opensearch_cluster!="",job=~"$job",opensearch_cluster=~"$opensearch_cluster",index=~"$index", context="total"}, 1))',
            legendCustomTemplate: '{{index}} - query',
          },
        },
      },
      query_cache_evictions: {
        name: 'Query cache evictions',
        description: 'Query cache evictions per interval.',
        type: 'raw',
        unit: 'count',
        sources: {
          prometheus: {
            expr: 'avg by(' + this.groupAggList + ') (increase(opensearch_index_querycache_evictions_count{%(queriesSelector)s, context="total"}[$__interval:]))',
          },
        },
      },
      request_cache_evictions: {
        name: 'Request cache evictions',
        description: 'Request cache evictions per interval.',
        type: 'raw',
        unit: 'count',
        sources: {
          prometheus: {
            expr: 'avg by(' + this.groupAggList + ') (increase(opensearch_index_requestcache_evictions_count{%(queriesSelector)s, context="total"}[$__interval:]))',
          },
        },
      },
      fielddata_evictions: {
        name: 'Fielddata evictions',
        description: 'Fielddata evictions per interval.',
        type: 'raw',
        unit: 'count',
        sources: {
          prometheus: {
            expr: 'avg by(' + this.groupAggList + ') (increase(opensearch_index_fielddata_evictions_count{%(queriesSelector)s, context="total"}[$__interval:]))',
          },
        },
      },
      query_cache_memory: {
        name: 'Query cache memory bytes',
        description: 'Query cache memory.',
        type: 'raw',
        unit: 'bytes',
        sources: {
          prometheus: {
            expr: 'avg by(' + this.groupAggList + ') (opensearch_index_querycache_memory_size_bytes{%(queriesSelector)s, context="total"})',
          },
        },
      },
      request_cache_memory: {
        name: 'Request cache memory bytes',
        description: 'Request cache memory.',
        type: 'raw',
        unit: 'bytes',
        sources: {
          prometheus: {
            expr: 'avg by(' + this.groupAggList + ') (opensearch_index_requestcache_memory_size_bytes{%(queriesSelector)s, context="total"})',
          },
        },
      },
    },
  }
