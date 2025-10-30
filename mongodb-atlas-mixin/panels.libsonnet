local g = import './g.libsonnet';
local commonlib = import 'common-lib/common/main.libsonnet';

{
  new(this): {
    local signals = this.signals,

    // Placeholder panel - minimal implementation for build success
    diskOps:
      g.panel.timeSeries.new('Disk operations')
      + g.panel.timeSeries.panelOptions.withDescription('Disk read and write operations per second.')
      + g.panel.timeSeries.queryOptions.withTargets([
        signals.hardware.diskReadCount.asTarget(),
        signals.hardware.diskWriteCount.asTarget(),
      ])
      + g.panel.timeSeries.standardOptions.withUnit('ops'),
  },
}
