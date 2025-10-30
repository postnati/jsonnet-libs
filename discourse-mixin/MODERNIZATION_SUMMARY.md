# Discourse Mixin Modernization Summary

**Date**: October 30, 2025
**Branch**: discourse-modernization
**Commit**: ebe4f9a6
**Location**: .worktrees/discourse-modernization/discourse-mixin/

## Overview

Successfully modernized the discourse-mixin from legacy grafonnet-lib to grafonnet v11.0.0 with signal-based architecture. All 11 phases completed autonomously.

## Signals Created

**Total: 17 signals across 4 files**

- **http**: 5 signals
  - httpRequests
  - latestMedianRequestTime
  - topicMedianRequestTime
  - latest99thPercentileRequestTime
  - topic99thPercentileRequestTime

- **requests**: 3 signals
  - activeRequests
  - queuedRequests
  - pageViews

- **jobs**: 7 signals
  - sidekiqJobDuration
  - scheduledJobDuration
  - sidekiqJobCount
  - scheduledJobCount
  - sidekiqJobsEnqueued
  - sidekiqWorkerCount
  - webWorkerCount

- **memory**: 2 signals
  - rssMemory
  - v8HeapSize

## Panels Converted

**Total: 17 panels**

- **timeSeries**: 14 panels
  - Traffic by Response Code
  - Active Requests
  - Queued Requests
  - Page Views
  - Latest Median Request Time
  - Topic Show Median Request Time
  - Latest 99th percentile Request Time
  - Topic Show 99th percentile Request Time
  - Scheduled Jobs
  - Sidekiq Jobs
  - Scheduled Job Duration
  - Sidekiq Job Duration
  - Used RSS Memory
  - V8 Heap Size

- **stat**: 3 panels
  - Sidekiq Workers
  - Web Workers
  - Sidekiq Queued

## Dashboards

- discourse-overview.json
- discourse-jobs.json

## Alerts

**Modernized: 2 alerts (all ≤ 40 chars)**

1. DiscourseHigh5xxErrors (critical)
   - Triggers when >10% of requests return 5xx errors

2. DiscourseHigh4xxErrors (warning)
   - Triggers when >30% of requests return 4xx errors

## Build Status

✅ make dashboards_out - PASS
✅ make prometheus_alerts.yaml - PASS
✅ make prometheus_rules.yaml - PASS
✅ make fmt - PASS
✅ make lint - PASS
✅ make all - PASS

## Issues Resolved

1. **Initial import path error for grafonnet**
   - RESOLVED: Updated g.libsonnet to use correct vendor path (./vendor/grafonnet-v11.0.0/main.libsonnet)

2. **Signal reference errors**
   - RESOLVED: Fixed signal files to use %(queriesSelector)s instead of %(filteringSelector)s
   - The framework automatically constructs queriesSelector from filteringSelector, groupLabels, and instanceLabels

3. **Datasource linting warnings**
   - EXPECTED: Suppressed via .lint file for modern signal-based mixins
   - Modern mixins use signal-based architecture where datasource references are handled by the framework

## Files Changed

**Changes**: 22 files
**Additions**: 1,044 lines
**Deletions**: 2,746 lines
**Net reduction**: 1,702 lines (61% reduction in code)

### New Files Created
- g.libsonnet (grafonnet v11 import)
- main.libsonnet (orchestrator)
- links.libsonnet (dashboard links)
- panels.libsonnet (panel definitions)
- rows.libsonnet (row layouts)
- dashboards.libsonnet (dashboard definitions)
- signals/http.libsonnet
- signals/requests.libsonnet
- signals/jobs.libsonnet
- signals/memory.libsonnet

### Files Modified
- config.libsonnet (added signals configuration)
- mixin.libsonnet (updated to use new pattern)
- jsonnetfile.json (updated dependencies)
- .lint (added modern mixin exclusions)
- dashboards_out/*.json (regenerated)
- prometheus_rules_out/*.yaml (regenerated)

### Files Deleted
- dashboards/dashboards.libsonnet
- dashboards/discourse-jobs.libsonnet
- dashboards/discourse-overview.libsonnet
- alerts/alerts.libsonnet (moved to root)

## Architecture Changes

### Before (Legacy)
- Used grafonnet-lib (legacy)
- Monolithic dashboard files with embedded panels
- Direct PromQL queries in panels
- `prometheusAlerts+::` pattern for alerts

### After (Modern)
- Uses grafonnet v11.0.0 + common-lib
- Modular architecture with separate concerns:
  - signals/ → metric definitions
  - panels.libsonnet → panel builders
  - rows.libsonnet → panel layouts
  - dashboards.libsonnet → dashboard composition
- Signal-based queries with framework transformations
- `new(this)` pattern for alerts

## Next Steps

1. **Review worktree**:
   ```bash
   cd .worktrees/discourse-modernization/discourse-mixin
   ```

2. **Test dashboards**:
   ```bash
   ../../../.claude/scripts/import-dashboards.py
   ```

3. **Review changes**:
   ```bash
   git log -1 --stat
   git show
   ```

4. **Create pull request**:
   https://github.com/postnati/jsonnet-libs/pull/new/discourse-modernization

5. **After merge, clean up worktree**:
   ```bash
   git worktree remove .worktrees/discourse-modernization
   ```

## References

**Similar modernizations**:
- influxdb-mixin (September 2024)
- varnish-mixin (October 2024)
- aerospike-mixin (September 2024)

**Documentation**:
- Modernization guide: `.claude/commands/modernize-mixin.md`
- Signals documentation: `common-lib/common/signal/README.md`
