# SAP HANA Mixin Modernization - Complete Summary

**Date**: October 30, 2025
**Branch**: `saphana-modernization`
**Commit**: `4b29d201`

## Location
`.worktrees/saphana-modernization/sap-hana-mixin/`

## Signals Created

### Total: 32 signals across 9 categories

1. **CPU** (2 signals)
   - `cpu_busy_percent` - Raw CPU usage by core
   - `cpu_busy_percent_by_host` - Aggregated CPU usage by host

2. **Memory** (10 signals)
   - `host_memory_resident_mb` - Resident memory
   - `host_memory_physical_total_mb` - Total physical memory
   - `physical_memory_usage_percent` - Physical memory usage percentage
   - `host_memory_swap_used_mb` - Used swap memory
   - `host_memory_swap_free_mb` - Free swap memory
   - `swap_memory_usage_percent` - Swap memory usage percentage
   - `host_memory_used_total_mb` - SAP HANA memory used
   - `host_memory_alloc_limit_mb` - Memory allocation limit
   - `hana_memory_usage_percent` - HANA memory usage percentage
   - `memory_alloc_limit_percent` - Allocation limit as % of physical
   - `schema_used_memory_mb` - Schema memory usage

3. **Disk** (5 signals)
   - `disk_total_used_size_mb` - Total disk used
   - `disk_total_size_mb` - Total disk size
   - `disk_usage_percent` - Disk usage percentage
   - `disk_io_throughput_kb_second` - Disk I/O throughput
   - `disk_io_throughput_kb_second_by_disk` - I/O throughput by disk device

4. **Network** (4 signals)
   - `network_receive_rate_kb_per_seconds` - Network receive rate
   - `network_receive_rate_kb_per_seconds_by_interface` - Receive rate by interface
   - `network_transmission_rate_kb_per_seconds` - Network transmit rate
   - `network_transmission_rate_kb_per_seconds_by_interface` - Transmit rate by interface

5. **Replication** (2 signals)
   - `sr_replication` - System replication status
   - `sr_ship_delay` - Replication log shipping delay

6. **SQL** (4 signals)
   - `sql_service_elap_per_exec_avg_ms` - SQL execution time
   - `sql_service_elap_per_exec_avg_ms_by_service` - Execution time by service
   - `sql_service_lock_per_exec_ms` - SQL lock time
   - `sql_top_time_consumers_mu` - Top SQL time consumers

7. **Connections** (2 signals)
   - `connections_total_count` - Total connection count
   - `connections_total_count_by_type` - Connections by type/status

8. **Storage** (1 signal)
   - `table_cs_top_mem_total_mb` - Table column store memory

9. **Alerts** (2 signals)
   - `alerts_current_rating` - Current alert count
   - `alerts_current_rating_detail` - Alert details with metadata

## Panels Converted

**Total: 20 panels**

### By Type:
- **timeSeries**: 16 panels
  - CPU usage, Disk usage, Disk I/O throughput (x2)
  - Physical memory usage, SAP HANA memory usage
  - Memory allocation limit, Schema memory usage
  - Network I/O throughput (x2)
  - Average SQL execution time, SQL lock time, SQL top time consumers
  - Connections by type, Top table memory
  - Average replication ship delay

- **stat**: 3 panels
  - Replica status (with value mappings)
  - Total connections
  - Current alerts

- **table**: 1 panel
  - Alerts detail

## Dashboards

1. **sap-hana-system-overview.json** (39.3 KB)
   - 8 rows organized by: Replication, Resources, Network I/O, Disk I/O, SQL, Connections, Storage, Alerts
   - System-level view (filtered by job, sid)

2. **sap-hana-instance-overview.json** (19.9 KB)
   - 4 rows: Instance overview, Memory, Network, SQL
   - Instance-level view (filtered by job, sid, host)

3. **sap-hana-logs.json** (10.9 KB)
   - Loki logs dashboard with volume visualization
   - Filtered by job, sid, host, filename

## Alerts Modernized

**Total: 8 alerts** (all names ≤ 40 characters)

1. `SapHanaHighCpuUtilization` - CPU usage > 80%
2. `SapHanaHighPhysicalMemory` - Physical memory usage > 80%
3. `SapHanaMemAllocBelowLimit` - Memory allocation limit < 90%
4. `SapHanaHighMemoryUsage` - HANA memory usage > 80%
5. `SapHanaHighDiskUtilization` - Disk usage > 80%
6. `SapHanaHighSqlExecutionTime` - SQL execution time > 1s
7. `SapHanaHighReplicationDelay` - Replication delay > 1s (shortened from SapHanaHighReplicationShippingTime)
8. `SapHanaReplicationError` - Replication status == ERROR

All alerts modernized to `new(this)` pattern with proper threshold references.

## Build Status

✅ **All builds passing:**
- `make dashboards_out` - PASS
- `make prometheus_alerts.yaml` - PASS
- `make prometheus_rules.yaml` - PASS
- `make fmt` - PASS
- `make lint` - PASS (with expected .lint exclusions)
- `make all` - PASS

## Files Created/Modified

### Created:
- `g.libsonnet` - Grafonnet v11 import
- `main.libsonnet` - Orchestrator
- `links.libsonnet` - Dashboard links
- `panels.libsonnet` - 20 modernized panels
- `rows.libsonnet` - Row definitions
- `dashboards.libsonnet` - Dashboard definitions
- `signals/cpu.libsonnet`
- `signals/memory.libsonnet`
- `signals/disk.libsonnet`
- `signals/network.libsonnet`
- `signals/replication.libsonnet`
- `signals/sql.libsonnet`
- `signals/connections.libsonnet`
- `signals/storage.libsonnet`
- `signals/alerts.libsonnet`
- `dashboards_out/sap-hana-logs.json`

### Modified:
- `jsonnetfile.json` - Added grafonnet v11, common-lib, logs-lib
- `config.libsonnet` - Added signals section, modern structure
- `mixin.libsonnet` - Updated to use main.libsonnet
- `alerts.libsonnet` - Modernized to new(this) pattern
- `.lint` - Added panel-datasource-rule exclusion
- `dashboards_out/sap-hana-system-overview.json`
- `dashboards_out/sap-hana-instance-overview.json`
- `prometheus_rules_out/prometheus_alerts.yaml`

### Deleted:
- `dashboards/dashboards.libsonnet`
- `dashboards/sap-hana-system-overview.libsonnet`
- `dashboards/sap-hana-instance-overview.libsonnet`
- `alerts/alerts.libsonnet`

## Issues Resolved

1. **Fixed g.libsonnet path**: Changed to `vendor/grafonnet-v11.0.0/main.libsonnet` (not `vendor/grafonnet/`)
2. **Added logs-lib dependency**: Required for `enableLokiLogs` support
3. **Added .lint exclusion**: `panel-datasource-rule` (expected for modern signal-based mixins)
4. **Shortened alert name**: `SapHanaHighReplicationShippingTime` → `SapHanaHighReplicationDelay` (40 char limit)

## Git Information

- **Commit**: `4b29d201`
- **Branch**: `saphana-modernization` (pushed to origin)
- **Changes**: 27 files changed, 2534 insertions(+), 4326 deletions(-)
- **Remote**: https://github.com/postnati/jsonnet-libs

## Pull Request

Create PR at: https://github.com/postnati/jsonnet-libs/pull/new/saphana-modernization

## Next Steps

1. **Review worktree**: `cd .worktrees/saphana-modernization/sap-hana-mixin`
2. **Test dashboards** (optional): `../../../.claude/scripts/import-dashboards.py`
3. **Review changes**: `git status`, `git diff master`
4. **Create pull request** using the GitHub link above
5. **Test with actual SAP HANA metrics** if available
6. **Merge to master** after approval

## Reference Mixins Used

- **Primary**: `influxdb-mixin` - Best reference, complete modernization
- **Secondary**: `varnish-mixin` - Good signal patterns
- **Tertiary**: `aerospike-mixin` - Good alert patterns

## Architecture Notes

### Signal Type Decisions:
- **gauge**: Current state metrics (cpu_percent, memory_bytes)
- **counter**: Not used (all SAP HANA metrics are gauges)
- **raw**: Complex expressions (disk_usage_percent, memory ratios with division)

### Label Strategy:
- **groupLabels**: `['job', 'sid']` - System-level filtering
- **instanceLabels**: `['host']` - Instance-level filtering
- **Custom labels**: `core`, `disk`, `interface`, `service`, `sql_type`, `database_name`, `schema_name`, etc.

### Dashboard Variables:
- System overview: Uses `job` and `sid` (host hidden)
- Instance overview: Uses `job`, `sid`, and `host`
- Logs: Uses `job`, `sid`, `host`, and Loki-specific filters

---

**Modernization completed**: October 30, 2025
**All 11 phases completed successfully without errors**
