import { useEffect, useMemo, useRef, useState } from 'react'
import './App.css'

const drills = [
  {
    id: 'possession-box',
    name: 'Possession box',
    summary: 'Quick passing and receiving under pressure in a compact grid.',
    objective: 'Improve first touch, angles of support, and fast circulation.',
    duration: '15 min',
    players: '8-12 players',
    setup: '20 x 20 yard grid with two neutral targets on opposite sides.',
    skills: ['Passing', 'Scanning', 'Communication'],
    coachingPoints: [
      'Open body shape before the ball arrives.',
      'Support underneath and beyond the ball carrier.',
      'Limit touches to increase decision speed.',
    ],
    steps: [
      'Start with 4v2 inside the grid and two outside targets.',
      'Score by connecting five passes or switching through a target.',
      'Rotate defenders every 60 seconds to keep intensity high.',
    ],
    formation: [
      { id: 'p1', label: 'GK', color: 'goalkeeper', x: 8, y: 50 },
      { id: 'p2', label: 'D1', color: 'defender', x: 24, y: 28 },
      { id: 'p3', label: 'D2', color: 'defender', x: 24, y: 72 },
      { id: 'p4', label: 'M1', color: 'midfielder', x: 46, y: 30 },
      { id: 'p5', label: 'M2', color: 'midfielder', x: 50, y: 55 },
      { id: 'p6', label: 'M3', color: 'midfielder', x: 44, y: 78 },
      { id: 'p7', label: 'F1', color: 'forward', x: 72, y: 36 },
      { id: 'p8', label: 'F2', color: 'forward', x: 76, y: 68 },
    ],
  },
  {
    id: 'finishing-wave',
    name: 'Finishing wave',
    summary: 'Layered attacking pattern ending with runs into the box and a finish.',
    objective: 'Build timing between wide players, midfield runners, and strikers.',
    duration: '20 min',
    players: '10-14 players',
    setup: 'Half pitch with wide channels, mannequins, and a full-size goal.',
    skills: ['Finishing', 'Crossing', 'Movement'],
    coachingPoints: [
      'Attack the cross with front-post, penalty spot, and back-post runs.',
      'Finish first time whenever the service allows it.',
      'Recover quickly into starting lines to keep repetitions high.',
    ],
    steps: [
      'Ball starts with the central midfielder who combines wide.',
      'Wide player drives forward and serves into three attacking runners.',
      'Restart immediately from the opposite side after each finish.',
    ],
    formation: [
      { id: 'p1', label: 'GK', color: 'goalkeeper', x: 8, y: 50 },
      { id: 'p2', label: 'LB', color: 'defender', x: 22, y: 18 },
      { id: 'p3', label: 'CB', color: 'defender', x: 25, y: 42 },
      { id: 'p4', label: 'CB', color: 'defender', x: 25, y: 58 },
      { id: 'p5', label: 'RB', color: 'defender', x: 22, y: 82 },
      { id: 'p6', label: 'CM', color: 'midfielder', x: 44, y: 50 },
      { id: 'p7', label: 'LW', color: 'forward', x: 62, y: 16 },
      { id: 'p8', label: 'AM', color: 'midfielder', x: 64, y: 48 },
      { id: 'p9', label: 'RW', color: 'forward', x: 62, y: 84 },
      { id: 'p10', label: 'ST', color: 'forward', x: 82, y: 50 },
    ],
  },
  {
    id: 'press-triggers',
    name: 'Press triggers',
    summary: 'Team pressing shape focused on cues, cover shadows, and compactness.',
    objective: 'Coordinate the first line of pressure with support behind the ball.',
    duration: '18 min',
    players: '12-16 players',
    setup: 'Two-thirds pitch split into three horizontal zones with mini goals.',
    skills: ['Defending', 'Transitions', 'Team shape'],
    coachingPoints: [
      'Press aggressively on poor touches or backwards passes.',
      'Second defender locks play to one side while third defender screens forward options.',
      'Back line squeezes up as the press travels toward the ball.',
    ],
    steps: [
      'Start with the ball in the opposition back line and set the pressing trap.',
      'Award extra points for regains in the middle zone followed by a shot within five seconds.',
      'Reset from the coach after each goal, escape, or ball out of play.',
    ],
    formation: [
      { id: 'p1', label: 'GK', color: 'goalkeeper', x: 8, y: 50 },
      { id: 'p2', label: 'LB', color: 'defender', x: 24, y: 18 },
      { id: 'p3', label: 'LCB', color: 'defender', x: 26, y: 38 },
      { id: 'p4', label: 'RCB', color: 'defender', x: 26, y: 62 },
      { id: 'p5', label: 'RB', color: 'defender', x: 24, y: 82 },
      { id: 'p6', label: '6', color: 'midfielder', x: 44, y: 50 },
      { id: 'p7', label: '8', color: 'midfielder', x: 50, y: 30 },
      { id: 'p8', label: '8', color: 'midfielder', x: 50, y: 70 },
      { id: 'p9', label: 'LW', color: 'forward', x: 70, y: 22 },
      { id: 'p10', label: '9', color: 'forward', x: 74, y: 50 },
      { id: 'p11', label: 'RW', color: 'forward', x: 70, y: 78 },
    ],
  },
]

const playerColors = {
  goalkeeper: 'player goalkeeper',
  defender: 'player defender',
  midfielder: 'player midfielder',
  forward: 'player forward',
}

const clamp = (value, min, max) => Math.min(max, Math.max(min, value))
const cloneFormation = (formation) => formation.map((player) => ({ ...player }))
const initialLayouts = Object.fromEntries(
  drills.map((drill) => [drill.id, cloneFormation(drill.formation)]),
)
const initialActivePlayers = Object.fromEntries(
  drills.map((drill) => [drill.id, drill.formation[0]?.id ?? null]),
)

function App() {
  const [selectedDrillId, setSelectedDrillId] = useState(drills[0].id)
  const [layouts, setLayouts] = useState(initialLayouts)
  const [activePlayerIds, setActivePlayerIds] = useState(initialActivePlayers)
  const selectedDrill = useMemo(
    () => drills.find((drill) => drill.id === selectedDrillId) ?? drills[0],
    [selectedDrillId],
  )
  const pitchRef = useRef(null)
  const dragRef = useRef(null)
  const players = layouts[selectedDrillId] ?? cloneFormation(selectedDrill.formation)
  const activePlayerId =
    activePlayerIds[selectedDrillId] ?? selectedDrill.formation[0]?.id ?? null

  useEffect(() => {
    const handlePointerMove = (event) => {
      if (!dragRef.current || !pitchRef.current) {
        return
      }

      const rect = pitchRef.current.getBoundingClientRect()
      const x = clamp(((event.clientX - rect.left) / rect.width) * 100, 4, 96)
      const y = clamp(((event.clientY - rect.top) / rect.height) * 100, 6, 94)

      setLayouts((currentLayouts) => ({
        ...currentLayouts,
        [dragRef.current.drillId]: currentLayouts[dragRef.current.drillId].map((player) =>
          player.id === dragRef.current.playerId ? { ...player, x, y } : player,
        ),
      }))
    }

    const handlePointerUp = () => {
      dragRef.current = null
    }

    window.addEventListener('pointermove', handlePointerMove)
    window.addEventListener('pointerup', handlePointerUp)

    return () => {
      window.removeEventListener('pointermove', handlePointerMove)
      window.removeEventListener('pointerup', handlePointerUp)
    }
  }, [])

  const selectedPlayer = players.find((player) => player.id === activePlayerId) ?? players[0]

  const startDrag = (playerId) => (event) => {
    event.preventDefault()
    dragRef.current = { drillId: selectedDrillId, playerId }
    setActivePlayerIds((currentActivePlayers) => ({
      ...currentActivePlayers,
      [selectedDrillId]: playerId,
    }))
  }

  const resetLayout = () => {
    setLayouts((currentLayouts) => ({
      ...currentLayouts,
      [selectedDrillId]: cloneFormation(selectedDrill.formation),
    }))
    setActivePlayerIds((currentActivePlayers) => ({
      ...currentActivePlayers,
      [selectedDrillId]: selectedDrill.formation[0]?.id ?? null,
    }))
  }

  return (
    <main className="app-shell">
      <section className="hero-panel">
        <div>
          <p className="eyebrow">React drill planner</p>
          <h1>Open Soccer Drill AI</h1>
          <p className="hero-copy">
            Build sessions in the browser, drag players on the pitch, and keep setup,
            coaching points, and drill details together in one view.
          </p>
        </div>
        <div className="hero-actions">
          <div>
            <span className="stat-label">Active drill</span>
            <strong>{selectedDrill.name}</strong>
          </div>
          <button type="button" onClick={resetLayout}>
            Reset formation
          </button>
        </div>
      </section>

      <section className="workspace">
        <aside className="sidebar card">
          <div className="sidebar-header">
            <h2>Drills</h2>
            <span>{drills.length} presets</span>
          </div>
          <div className="drill-list">
            {drills.map((drill) => (
              <button
                key={drill.id}
                type="button"
                className={`drill-card ${drill.id === selectedDrill.id ? 'selected' : ''}`}
                onClick={() => setSelectedDrillId(drill.id)}
              >
                <span className="drill-meta">{drill.duration} • {drill.players}</span>
                <strong>{drill.name}</strong>
                <p>{drill.summary}</p>
                <div className="tag-row">
                  {drill.skills.map((skill) => (
                    <span key={skill} className="tag">
                      {skill}
                    </span>
                  ))}
                </div>
              </button>
            ))}
          </div>
        </aside>

        <section className="board card">
          <div className="board-header">
            <div>
              <h2>{selectedDrill.name}</h2>
              <p>{selectedDrill.objective}</p>
            </div>
            <div className="board-summary">
              <span>{selectedDrill.duration}</span>
              <span>{selectedDrill.players}</span>
            </div>
          </div>

          <div className="pitch-wrapper" ref={pitchRef}>
            <div className="pitch">
              <div className="pitch-line halfway" />
              <div className="pitch-circle" />
              <div className="penalty-area left" />
              <div className="penalty-area right" />
              <div className="goal-box left" />
              <div className="goal-box right" />
              {players.map((player) => (
                <button
                  key={player.id}
                  type="button"
                  className={`${playerColors[player.color]} ${player.id === activePlayerId ? 'active' : ''}`}
                  style={{ left: `${player.x}%`, top: `${player.y}%` }}
                  onPointerDown={startDrag(player.id)}
                  onClick={() =>
                    setActivePlayerIds((currentActivePlayers) => ({
                      ...currentActivePlayers,
                      [selectedDrillId]: player.id,
                    }))
                  }
                  aria-label={`Move ${player.label}`}
                >
                  {player.label}
                </button>
              ))}
            </div>
          </div>

          <div className="board-footer">
            <div className="player-detail">
              <h3>Selected player</h3>
              {selectedPlayer ? (
                <>
                  <strong>{selectedPlayer.label}</strong>
                  <span>
                    Position: {Math.round(selectedPlayer.x)}% / {Math.round(selectedPlayer.y)}%
                  </span>
                </>
              ) : (
                <span>Select a player on the pitch.</span>
              )}
            </div>
            <p className="hint">Drag any marker to customise the setup for your session.</p>
          </div>
        </section>

        <aside className="details card">
          <div>
            <h2>Drill details</h2>
            <p>{selectedDrill.setup}</p>
          </div>

          <div>
            <h3>Session flow</h3>
            <ol>
              {selectedDrill.steps.map((step) => (
                <li key={step}>{step}</li>
              ))}
            </ol>
          </div>

          <div>
            <h3>Coaching points</h3>
            <ul>
              {selectedDrill.coachingPoints.map((point) => (
                <li key={point}>{point}</li>
              ))}
            </ul>
          </div>

          <div>
            <h3>Skills focus</h3>
            <div className="tag-row">
              {selectedDrill.skills.map((skill) => (
                <span key={skill} className="tag strong">
                  {skill}
                </span>
              ))}
            </div>
          </div>
        </aside>
      </section>
    </main>
  )
}

export default App
