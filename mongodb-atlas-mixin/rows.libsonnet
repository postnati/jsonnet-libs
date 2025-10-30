local g = import './g.libsonnet';

{
  new(this): {
    local panels = this.grafana.panels,

    overview:
      g.panel.row.new('Overview')
      + g.panel.row.withPanels([
        panels.diskOps { gridPos: { h: 8, w: 24, x: 0, y: 0 } },
      ]),
  },
}
