local g = import './g.libsonnet';
local commonlib = import 'common-lib/common/main.libsonnet';

{
  new(this): {
    local signals = this.signals,

    //
    // Inventory table panels (for shard, config, mongos nodes)
    //

    shardNodesTable:
      g.panel.table.new('Shard nodes')
      + g.panel.table.panelOptions.withDescription('An inventory table for shard nodes in the environment.')
      + g.panel.table.queryOptions.withTargets([
        g.query.prometheus.new(
          '${prometheus_datasource}',
          'mongodb_network_bytesIn{job=~"$job",cl_name=~"$cl_name"}'
        )
        + g.query.prometheus.withInstant(true),
      ])
      + g.panel.table.queryOptions.withTransformations([
        { id: 'reduce', options: { labelsToFields: true, reducers: ['lastNotNull'] } },
        { id: 'organize', options: {
          excludeByName: { Field: true, 'Last *': true, __name__: true, job: true, org_id: true, process_port: true },
          indexByName: { Field: 6, 'Last *': 11, __name__: 7, cl_name: 1, cl_role: 2, group_id: 0, instance: 3, job: 8, org_id: 9, process_port: 10, rs_nm: 4, rs_state: 5 },
          renameByName: { cl_name: 'Cluster', cl_role: 'Role', group_id: 'Group', instance: 'Node', rs_nm: 'Replica set', rs_state: 'State' },
        } },
        { id: 'filterByValue', options: { filters: [{ config: { id: 'equal', options: { value: 'shardsvr' } }, fieldName: 'Role' }], match: 'all', type: 'include' } },
      ])
      + g.panel.table.standardOptions.color.withMode('thresholds')
      + g.panel.table.standardOptions.withMappings([
        g.panel.table.standardOptions.mapping.ValueMap.withType()
        + g.panel.table.standardOptions.mapping.ValueMap.withOptions({
          '1': { index: 0, text: 'Primary' },
          '2': { index: 1, text: 'Secondary' },
        }),
      ])
      + g.panel.table.standardOptions.withOverrides([
        g.panel.table.fieldOverride.byName.new('cl_role')
        + g.panel.table.fieldOverride.byName.withProperty('custom.width', 150),
        g.panel.table.fieldOverride.byName.new('rs_state')
        + g.panel.table.fieldOverride.byName.withProperty('custom.width', 100),
        g.panel.table.fieldOverride.byName.new('rs_nm')
        + g.panel.table.fieldOverride.byName.withProperty('custom.width', 250),
        g.panel.table.fieldOverride.byName.new('cl_name')
        + g.panel.table.fieldOverride.byName.withProperty('custom.width', 300),
        g.panel.table.fieldOverride.byName.new('group_id')
        + g.panel.table.fieldOverride.byName.withProperty('custom.width', 300),
        g.panel.table.fieldOverride.byName.new('State')
        + g.panel.table.fieldOverride.byName.withProperty('custom.cellOptions', { type: 'color-text' })
        + g.panel.table.fieldOverride.byName.withProperty('mappings', [
          { options: { '1': { color: 'green', index: 0, text: 'Primary' }, '2': { color: 'yellow', index: 1, text: 'Secondary' } }, type: 'value' },
        ]),
      ]),

    configNodesTable:
      g.panel.table.new('Config nodes')
      + g.panel.table.panelOptions.withDescription('An inventory table for config nodes in the environment.')
      + g.panel.table.queryOptions.withTargets([
        g.query.prometheus.new(
          '${prometheus_datasource}',
          'mongodb_network_bytesIn{job=~"$job",cl_name=~"$cl_name"}'
        )
        + g.query.prometheus.withInstant(true),
      ])
      + g.panel.table.queryOptions.withTransformations([
        { id: 'reduce', options: { labelsToFields: true, reducers: ['lastNotNull'] } },
        { id: 'organize', options: {
          excludeByName: { Field: true, 'Last *': true, __name__: true, job: true, org_id: true, process_port: true },
          indexByName: { Field: 6, 'Last *': 11, __name__: 7, cl_name: 1, cl_role: 2, group_id: 0, instance: 3, job: 8, org_id: 9, process_port: 10, rs_nm: 4, rs_state: 5 },
          renameByName: { cl_name: 'Cluster', cl_role: 'Role', group_id: 'Group', instance: 'Node', rs_nm: 'Replica set', rs_state: 'State' },
        } },
        { id: 'filterByValue', options: { filters: [{ config: { id: 'equal', options: { value: 'configsvr' } }, fieldName: 'Role' }], match: 'all', type: 'include' } },
      ])
      + g.panel.table.standardOptions.color.withMode('thresholds')
      + g.panel.table.standardOptions.withMappings([
        g.panel.table.standardOptions.mapping.ValueMap.withType()
        + g.panel.table.standardOptions.mapping.ValueMap.withOptions({
          '1': { index: 0, text: 'Primary' },
          '2': { index: 1, text: 'Secondary' },
        }),
      ])
      + g.panel.table.standardOptions.withOverrides([
        g.panel.table.fieldOverride.byName.new('cl_role')
        + g.panel.table.fieldOverride.byName.withProperty('custom.width', 150),
        g.panel.table.fieldOverride.byName.new('rs_state')
        + g.panel.table.fieldOverride.byName.withProperty('custom.width', 100),
        g.panel.table.fieldOverride.byName.new('rs_nm')
        + g.panel.table.fieldOverride.byName.withProperty('custom.width', 250),
        g.panel.table.fieldOverride.byName.new('cl_name')
        + g.panel.table.fieldOverride.byName.withProperty('custom.width', 300),
        g.panel.table.fieldOverride.byName.new('group_id')
        + g.panel.table.fieldOverride.byName.withProperty('custom.width', 300),
        g.panel.table.fieldOverride.byName.new('State')
        + g.panel.table.fieldOverride.byName.withProperty('custom.cellOptions', { type: 'color-text' })
        + g.panel.table.fieldOverride.byName.withProperty('mappings', [
          { options: { '1': { color: 'green', index: 0, text: 'Primary' }, '2': { color: 'yellow', index: 1, text: 'Secondary' } }, type: 'value' },
        ]),
      ]),

    mongosNodesTable:
      g.panel.table.new('mongos nodes')
      + g.panel.table.panelOptions.withDescription('An inventory table for mongos nodes in the environment.')
      + g.panel.table.queryOptions.withTargets([
        g.query.prometheus.new(
          '${prometheus_datasource}',
          'mongodb_network_bytesIn{job=~"$job",cl_name=~"$cl_name"}'
        )
        + g.query.prometheus.withInstant(true),
      ])
      + g.panel.table.queryOptions.withTransformations([
        { id: 'reduce', options: { labelsToFields: true, reducers: ['lastNotNull'] } },
        { id: 'organize', options: {
          excludeByName: { Field: true, 'Last *': true, __name__: true, job: true, org_id: true, process_port: true, rs_state: true },
          indexByName: { Field: 6, 'Last *': 11, __name__: 7, cl_name: 1, cl_role: 2, group_id: 0, instance: 3, job: 8, org_id: 9, process_port: 10, rs_nm: 4, rs_state: 5 },
          renameByName: { cl_name: 'Cluster', cl_role: 'Role', group_id: 'Group', instance: 'Node', rs_nm: 'Replica set' },
        } },
        { id: 'filterByValue', options: { filters: [{ config: { id: 'equal', options: { value: 'mongos' } }, fieldName: 'Role' }], match: 'all', type: 'include' } },
      ])
      + g.panel.table.standardOptions.color.withMode('thresholds')
      + g.panel.table.standardOptions.withMappings([
        g.panel.table.standardOptions.mapping.ValueMap.withType()
        + g.panel.table.standardOptions.mapping.ValueMap.withOptions({
          '1': { index: 0, text: 'Primary' },
          '2': { index: 1, text: 'Secondary' },
        }),
      ])
      + g.panel.table.standardOptions.withOverrides([
        g.panel.table.fieldOverride.byName.new('cl_role')
        + g.panel.table.fieldOverride.byName.withProperty('custom.width', 150),
        g.panel.table.fieldOverride.byName.new('rs_state')
        + g.panel.table.fieldOverride.byName.withProperty('custom.width', 100),
        g.panel.table.fieldOverride.byName.new('rs_nm')
        + g.panel.table.fieldOverride.byName.withProperty('custom.width', 250),
        g.panel.table.fieldOverride.byName.new('cl_name')
        + g.panel.table.fieldOverride.byName.withProperty('custom.width', 300),
        g.panel.table.fieldOverride.byName.new('group_id')
        + g.panel.table.fieldOverride.byName.withProperty('custom.width', 300),
      ]),

    //
    // Performance section panels
    //

    hardwareIO:
      g.panel.timeSeries.new('Hardware I/O')
      + g.panel.timeSeries.panelOptions.withDescription("The number of read and write I/O's processed.")
      + g.panel.timeSeries.queryOptions.withTargets([
        signals.hardware.diskReadCount.asTarget(),
        signals.hardware.diskWriteCount.asTarget(),
      ])
      + g.panel.timeSeries.standardOptions.withUnit('iops')
      + g.panel.timeSeries.options.tooltip.withMode('multi')
      + g.panel.timeSeries.options.tooltip.withSort('desc')
      + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
      + g.panel.timeSeries.fieldConfig.defaults.custom.stacking.withMode('normal'),

    hardwareIOWaitTime:
      g.panel.timeSeries.new('Hardware I/O wait time / $__interval')
      + g.panel.timeSeries.panelOptions.withDescription('The amount of time spent waiting for I/O requests.')
      + g.panel.timeSeries.queryOptions.withTargets([
        signals.hardware.diskReadTime.asTarget()
        + g.query.prometheus.withInterval('1m'),
        signals.hardware.diskWriteTime.asTarget()
        + g.query.prometheus.withInterval('1m'),
      ])
      + g.panel.timeSeries.standardOptions.withUnit('ms')
      + g.panel.timeSeries.options.tooltip.withMode('multi')
      + g.panel.timeSeries.options.tooltip.withSort('desc')
      + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
      + g.panel.timeSeries.fieldConfig.defaults.custom.stacking.withMode('normal'),

    hardwareCPUInterruptServiceTime:
      g.panel.timeSeries.new('Hardware CPU interrupt service time / $__interval')
      + g.panel.timeSeries.panelOptions.withDescription('The amount of time spent servicing CPU interrupts.')
      + g.panel.timeSeries.queryOptions.withTargets([
        signals.hardware.cpuIrqTime.asTarget()
        + g.query.prometheus.withInterval('1m'),
      ])
      + g.panel.timeSeries.standardOptions.withUnit('ms')
      + g.panel.timeSeries.options.tooltip.withMode('multi')
      + g.panel.timeSeries.options.tooltip.withSort('desc')
      + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10),

    memoryUsed:
      g.panel.timeSeries.new('Memory used')
      + g.panel.timeSeries.panelOptions.withDescription('The amount of RAM and virtual memory being used.')
      + g.panel.timeSeries.queryOptions.withTargets([
        signals.memory.memoryResident.asTarget(),
        signals.memory.memoryVirtual.asTarget(),
      ])
      + g.panel.timeSeries.standardOptions.withUnit('mbytes')
      + g.panel.timeSeries.options.tooltip.withMode('multi')
      + g.panel.timeSeries.options.tooltip.withSort('desc')
      + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10),

    diskSpaceUsage:
      g.panel.timeSeries.new('Disk space usage')
      + g.panel.timeSeries.panelOptions.withDescription('The percentage of hardware space used.')
      + g.panel.timeSeries.queryOptions.withTargets([
        signals.hardware.diskSpaceUtilization.asTarget(),
      ])
      + g.panel.timeSeries.standardOptions.withUnit('percentunit')
      + g.panel.timeSeries.standardOptions.withMin(0)
      + g.panel.timeSeries.standardOptions.withMax(1)
      + g.panel.timeSeries.options.tooltip.withMode('multi')
      + g.panel.timeSeries.options.tooltip.withSort('desc')
      + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10),

    networkRequests:
      g.panel.timeSeries.new('Network requests')
      + g.panel.timeSeries.panelOptions.withDescription('The number of distinct requests that the server has received.')
      + g.panel.timeSeries.queryOptions.withTargets([
        signals.network.networkRequests.asTarget(),
      ])
      + g.panel.timeSeries.standardOptions.withUnit('reqps')
      + g.panel.timeSeries.options.tooltip.withMode('multi')
      + g.panel.timeSeries.options.tooltip.withSort('desc')
      + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10),

    networkThroughput:
      g.panel.timeSeries.new('Network throughput')
      + g.panel.timeSeries.panelOptions.withDescription('The number of bytes sent and received over network connections.')
      + g.panel.timeSeries.queryOptions.withTargets([
        signals.network.networkBytesIn.asTarget(),
        signals.network.networkBytesOut.asTarget(),
      ])
      + g.panel.timeSeries.standardOptions.withUnit('Bps')
      + g.panel.timeSeries.options.tooltip.withMode('multi')
      + g.panel.timeSeries.options.tooltip.withSort('desc')
      + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
      + g.panel.timeSeries.fieldConfig.defaults.custom.stacking.withMode('normal'),

    slowRequests:
      g.panel.timeSeries.new('Slow requests')
      + g.panel.timeSeries.panelOptions.withDescription('The rate of DNS and SSL operations that took longer than 1 second.')
      + g.panel.timeSeries.queryOptions.withTargets([
        signals.network.networkSlowDNS.asTarget(),
        signals.network.networkSlowSSL.asTarget(),
      ])
      + g.panel.timeSeries.standardOptions.withUnit('reqps')
      + g.panel.timeSeries.options.tooltip.withMode('multi')
      + g.panel.timeSeries.options.tooltip.withSort('desc')
      + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10),

    //
    // Operations section panels
    //

    connections:
      g.panel.timeSeries.new('Connections')
      + g.panel.timeSeries.panelOptions.withDescription('The rate of incoming connections to the cluster created.')
      + g.panel.timeSeries.queryOptions.withTargets([
        signals.connections.connectionsCreated.asTarget(),
      ])
      + g.panel.timeSeries.standardOptions.withUnit('conns/s')
      + g.panel.timeSeries.options.tooltip.withMode('multi')
      + g.panel.timeSeries.options.tooltip.withSort('desc')
      + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10),

    readwriteOperations:
      g.panel.timeSeries.new('Read/Write operations')
      + g.panel.timeSeries.panelOptions.withDescription('The number of read and write operations.')
      + g.panel.timeSeries.queryOptions.withTargets([
        signals.operations.opLatenciesReadsOps.asTarget(),
        signals.operations.opLatenciesWritesOps.asTarget(),
      ])
      + g.panel.timeSeries.standardOptions.withUnit('ops')
      + g.panel.timeSeries.options.tooltip.withMode('multi')
      + g.panel.timeSeries.options.tooltip.withSort('desc')
      + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
      + g.panel.timeSeries.fieldConfig.defaults.custom.stacking.withMode('normal'),

    operations:
      g.panel.pieChart.new('Operations')
      + g.panel.pieChart.panelOptions.withDescription('The number of insert, query, update, and delete operations.')
      + g.panel.pieChart.queryOptions.withTargets([
        signals.operations.opCountersInsert.asTarget()
        + g.query.prometheus.withInterval('1m'),
        signals.operations.opCountersQuery.asTarget()
        + g.query.prometheus.withInterval('1m'),
        signals.operations.opCountersUpdate.asTarget()
        + g.query.prometheus.withInterval('1m'),
        signals.operations.opCountersDelete.asTarget()
        + g.query.prometheus.withInterval('1m'),
      ])
      + g.panel.pieChart.options.reduceOptions.withCalcs(['lastNotNull'])
      + g.panel.pieChart.options.legend.withDisplayMode('table')
      + g.panel.pieChart.options.legend.withPlacement('bottom')
      + g.panel.pieChart.options.legend.withValues(['value'])
      + g.panel.pieChart.options.tooltip.withMode('multi')
      + g.panel.pieChart.options.tooltip.withSort('desc'),

    readwriteLatency:
      g.panel.timeSeries.new('Read/Write latency / $__interval')
      + g.panel.timeSeries.panelOptions.withDescription('The latency for read and write operations.')
      + g.panel.timeSeries.queryOptions.withTargets([
        signals.operations.opLatenciesReadsLatency.asTarget()
        + g.query.prometheus.withInterval('1m'),
        signals.operations.opLatenciesWritesLatency.asTarget()
        + g.query.prometheus.withInterval('1m'),
      ])
      + g.panel.timeSeries.standardOptions.withUnit('µs')
      + g.panel.timeSeries.options.tooltip.withMode('multi')
      + g.panel.timeSeries.options.tooltip.withSort('desc')
      + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
      + g.panel.timeSeries.fieldConfig.defaults.custom.stacking.withMode('normal'),

    //
    // Locks section panels
    //

    currentQueue:
      g.panel.timeSeries.new('Current queue')
      + g.panel.timeSeries.panelOptions.withDescription('The number of reads and writes queued because of a lock.')
      + g.panel.timeSeries.queryOptions.withTargets([
        signals.locks.globalLockQueueReaders.asTarget(),
        signals.locks.globalLockQueueWriters.asTarget(),
      ])
      + g.panel.timeSeries.options.tooltip.withMode('multi')
      + g.panel.timeSeries.options.tooltip.withSort('desc')
      + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
      + g.panel.timeSeries.fieldConfig.defaults.custom.stacking.withMode('normal'),

    activeClientOperations:
      g.panel.timeSeries.new('Active client operations')
      + g.panel.timeSeries.panelOptions.withDescription('The number of reads and writes being actively performed by connected clients.')
      + g.panel.timeSeries.queryOptions.withTargets([
        signals.locks.globalLockActiveReaders.asTarget(),
        signals.locks.globalLockActiveWriters.asTarget(),
      ])
      + g.panel.timeSeries.options.tooltip.withMode('multi')
      + g.panel.timeSeries.options.tooltip.withSort('desc')
      + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
      + g.panel.timeSeries.fieldConfig.defaults.custom.stacking.withMode('normal'),

    databaseDeadlocks:
      g.panel.timeSeries.new('Database deadlocks / $__interval')
      + g.panel.timeSeries.panelOptions.withDescription('The number of deadlocks for database level locks.')
      + g.panel.timeSeries.queryOptions.withTargets([
        signals.locks.dbDeadlockExclusive.asTarget()
        + g.query.prometheus.withInterval('1m'),
        signals.locks.dbDeadlockIntentExclusive.asTarget()
        + g.query.prometheus.withInterval('1m'),
        signals.locks.dbDeadlockShared.asTarget()
        + g.query.prometheus.withInterval('1m'),
        signals.locks.dbDeadlockIntentShared.asTarget()
        + g.query.prometheus.withInterval('1m'),
      ])
      + g.panel.timeSeries.options.legend.withPlacement('right')
      + g.panel.timeSeries.options.tooltip.withMode('multi')
      + g.panel.timeSeries.options.tooltip.withSort('desc')
      + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
      + g.panel.timeSeries.fieldConfig.defaults.custom.stacking.withMode('normal'),

    databaseWaitsAcquiringLock:
      g.panel.timeSeries.new('Database waits acquiring lock / $__interval')
      + g.panel.timeSeries.panelOptions.withDescription('The number of times lock acquisitions encounter waits for database level locks.')
      + g.panel.timeSeries.queryOptions.withTargets([
        signals.locks.dbWaitCountExclusive.asTarget()
        + g.query.prometheus.withInterval('1m'),
        signals.locks.dbWaitCountIntentExclusive.asTarget()
        + g.query.prometheus.withInterval('1m'),
        signals.locks.dbWaitCountShared.asTarget()
        + g.query.prometheus.withInterval('1m'),
        signals.locks.dbWaitCountIntentShared.asTarget()
        + g.query.prometheus.withInterval('1m'),
      ])
      + g.panel.timeSeries.options.legend.withPlacement('right')
      + g.panel.timeSeries.options.tooltip.withMode('multi')
      + g.panel.timeSeries.options.tooltip.withSort('desc')
      + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
      + g.panel.timeSeries.fieldConfig.defaults.custom.stacking.withMode('normal'),
  },
}
