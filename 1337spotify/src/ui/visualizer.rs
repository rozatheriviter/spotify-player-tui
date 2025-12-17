use ratatui::{
    layout::Rect,
    widgets::{BarChart, Block, Borders},
    Frame,
};

use crate::state::UIStateGuard;
use crate::state::VisualizerType;

pub fn render_visualizer(frame: &mut Frame, ui: &UIStateGuard, rect: Rect) {
    match ui.visualizer_type {
        VisualizerType::Bar => render_bar_visualizer(frame, ui, rect),
        VisualizerType::Wave => render_wave_visualizer(frame, ui, rect),
    }
}

fn render_bar_visualizer(frame: &mut Frame, ui: &UIStateGuard, rect: Rect) {
    let time = std::time::SystemTime::now()
        .duration_since(std::time::UNIX_EPOCH)
        .unwrap()
        .as_millis();

    // Ensure we don't divide by zero if width is small
    let n_bars = if rect.width > 0 { rect.width / 4 } else { 0 };
    if n_bars == 0 {
        return;
    }

    let data: Vec<(&str, u64)> = (0..n_bars)
        .map(|i| {
            // Create a more organic wave pattern using sine waves
            let x = i as f64;
            let t = time as f64 / 100.0;

            // Combine multiple sine waves for a more complex pattern
            let wave1 = ((x * 0.2 + t * 0.5).sin() + 1.0) * 30.0;
            let wave2 = ((x * 0.5 - t * 0.8).sin() + 1.0) * 15.0;
            let wave3 = ((x * 0.1 + t * 0.2).sin() + 1.0) * 5.0;

            // Add some noise based on index to simulate frequency bands
            let noise = ((i * 7) % 13) as f64;

            let val = (wave1 + wave2 + wave3 + noise) as u64;
            ("", val.min(100))
        })
        .collect();

    let barchart = BarChart::default()
        .block(Block::default().borders(Borders::NONE))
        .data(&data)
        .bar_width(3)
        .bar_gap(1)
        .bar_style(ui.theme.playback_progress_bar())
        .value_style(ui.theme.playback_progress_bar_unfilled());

    frame.render_widget(barchart, rect);
}

fn render_wave_visualizer(frame: &mut Frame, ui: &UIStateGuard, rect: Rect) {
    use ratatui::symbols::Marker;
    use ratatui::widgets::{Chart, Dataset, Axis, GraphType};

    let time = std::time::SystemTime::now()
        .duration_since(std::time::UNIX_EPOCH)
        .unwrap()
        .as_millis() as f64 / 200.0;

    let points: Vec<(f64, f64)> = (0..rect.width)
        .map(|i| {
            let x = i as f64;
            let y = ((x * 0.2 + time).sin() * 50.0) + 50.0;
            (x, y)
        })
        .collect();

    let points2: Vec<(f64, f64)> = (0..rect.width)
        .map(|i| {
            let x = i as f64;
            let y = ((x * 0.3 - time * 1.5).sin() * 40.0) + 50.0;
            (x, y)
        })
        .collect();

    let datasets = vec![
        Dataset::default()
            .marker(Marker::Braille)
            .style(ui.theme.playback_progress_bar())
            .graph_type(GraphType::Line)
            .data(&points),
        Dataset::default()
            .marker(Marker::Braille)
            .style(ui.theme.playback_progress_bar_unfilled())
            .graph_type(GraphType::Line)
            .data(&points2),
    ];

    let chart = Chart::new(datasets)
        .block(Block::default().borders(Borders::NONE))
        .x_axis(Axis::default().bounds([0.0, rect.width as f64]))
        .y_axis(Axis::default().bounds([0.0, 100.0]));

    frame.render_widget(chart, rect);
}
