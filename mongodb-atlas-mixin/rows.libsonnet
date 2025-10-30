local g = import './g.libsonnet';

{
  new(this): {
    local panels = this.grafana.panels,

    //
    // Cluster overview dashboard rows
    //

    shard:
      g.panel.row.new('Shard')
      + g.panel.row.withPanels([
        panels.shardNodesTable { gridPos: { h: 6, w: 24, x: 0, y: 0 } },
      ]),

    config:
      g.panel.row.new('Config')
      + g.panel.row.withPanels([
        panels.configNodesTable { gridPos: { h: 6, w: 24, x: 0, y: 1 } },
      ]),

    mongos:
      g.panel.row.new('mongos')
      + g.panel.row.withPanels([
        panels.mongosNodesTable { gridPos: { h: 6, w: 24, x: 0, y: 2 } },
      ]),

    performance:
      g.panel.row.new('Performance')
      + g.panel.row.withPanels([
        panels.hardwareIO { gridPos: { h: 6, w: 6, x: 0, y: 3 } },
        panels.hardwareIOWaitTime { gridPos: { h: 6, w: 6, x: 6, y: 3 } },
        panels.hardwareCPUInterruptServiceTime { gridPos: { h: 6, w: 6, x: 12, y: 3 } },
        panels.memoryUsed { gridPos: { h: 6, w: 6, x: 18, y: 3 } },
        panels.diskSpaceUsage { gridPos: { h: 6, w: 6, x: 0, y: 9 } },
        panels.networkRequests { gridPos: { h: 6, w: 6, x: 6, y: 9 } },
        panels.networkThroughput { gridPos: { h: 6, w: 6, x: 12, y: 9 } },
        panels.slowRequests { gridPos: { h: 6, w: 6, x: 18, y: 9 } },
      ]),

    operations:
      g.panel.row.new('Operations')
      + g.panel.row.withPanels([
        panels.connections { gridPos: { h: 6, w: 12, x: 0, y: 4 } },
        panels.readwriteOperations { gridPos: { h: 12, w: 6, x: 12, y: 4 } },
        panels.operations { gridPos: { h: 12, w: 6, x: 18, y: 4 } },
        panels.readwriteLatency { gridPos: { h: 6, w: 12, x: 0, y: 10 } },
      ]),

    locks:
      g.panel.row.new('Locks')
      + g.panel.row.withPanels([
        panels.currentQueue { gridPos: { h: 6, w: 12, x: 0, y: 5 } },
        panels.activeClientOperations { gridPos: { h: 6, w: 12, x: 12, y: 5 } },
        panels.databaseDeadlocks { gridPos: { h: 6, w: 12, x: 0, y: 11 } },
        panels.databaseWaitsAcquiringLock { gridPos: { h: 6, w: 12, x: 12, y: 11 } },
      ]),

    // Placeholder for other dashboards (will be expanded in phase 2)
    overview:
      g.panel.row.new('Overview')
      + g.panel.row.withPanels([
        panels.hardwareIO { gridPos: { h: 8, w: 24, x: 0, y: 0 } },
      ]),
  },
}
