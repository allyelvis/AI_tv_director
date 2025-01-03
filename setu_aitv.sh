#!/bin/bash

# Aenzbi TV Director Update Script

set -e

echo "Starting Aenzbi TV Director update process..."

# Update app/dashboard/page.tsx
echo "Updating app/dashboard/page.tsx..."
cat << 'EOF' > app/dashboard/page.tsx
"use client"

import { useState, useEffect } from 'react'
import { useSession } from "next-auth/react"
import { useRouter } from "next/navigation"
import { motion } from "framer-motion"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import Dashboard from '@/components/Dashboard'
import AIControlPanel from '@/components/AIControlPanel'
import VideoSwitcher from '@/components/VideoSwitcher'
import ReplaySystem from '@/components/ReplaySystem'
import GraphicsOverlay from '@/components/GraphicsOverlay'
import AIInsights from '@/components/AIInsights'
import AudioMixer from '@/components/AudioMixer'
import PlayerTracking from '@/components/PlayerTracking'
import SentimentAnalysis from '@/components/SentimentAnalysis'
import HighlightGenerator from '@/components/HighlightGenerator'
import AutomatedCommentary from '@/components/AutomatedCommentary'
import PredictiveAnalytics from '@/components/PredictiveAnalytics'
import AIDecisionLog from '@/components/AIDecisionLog'
import Timeline from '@/components/Timeline'
import NarrativeEngine from '@/components/NarrativeEngine'
import NetworkStatus from '@/components/NetworkStatus'
import StreamingControl from '@/components/StreamingControl'
import StreamingQualityControl from '@/components/StreamingQualityControl'
import ErrorBoundary from '@/components/ErrorBoundary'
import ProductionChat from '@/components/ProductionChat'
import MultiViewLayout from '@/components/MultiViewLayout'
import SocialMediaFeed from '@/components/SocialMediaFeed'
import AICameraSwitcher from '@/components/AICameraSwitcher'
import SlowMotionReplay from '@/components/SlowMotionReplay'
import TeamPerformance from '@/components/TeamPerformance'
import MultiScreenDiffusion from '@/components/MultiScreenDiffusion'
import LanguageTranslator from '@/components/LanguageTranslator'
import FileConverter from '@/components/FileConverter'

export default function DashboardPage() {
  const { data: session, status } = useSession()
  const router = useRouter()

  const [activeCamera, setActiveCamera] = useState(1)
  const [aiMode, setAIMode] = useState('auto')
  const [replayMode, setReplayMode] = useState(false)
  const [graphicsVisible, setGraphicsVisible] = useState(true)
  const [gameState, setGameState] = useState({
    score: { home: 0, away: 0 },
    time: '00:00',
    possession: 'home',
    period: 1
  })
  const [aiInsights, setAIInsights] = useState('')
  const [audioLevels, setAudioLevels] = useState({ commentary: 80, crowd: 60, fieldMic: 40 })
  const [playerPositions, setPlayerPositions] = useState([])
  const [playerPerformances, setPlayerPerformances] = useState([])
  const [sentiment, setSentiment] = useState({ positive: 60, neutral: 30, negative: 10 })
  const [highlights, setHighlights] = useState([])
  const [commentary, setCommentary] = useState('')
  const [predictions, setPredictions] = useState({ homeWinProbability: 50, nextScoringTeam: 'home' })
  const [aiDecisions, setAIDecisions] = useState([])
  const [timelineEvents, setTimelineEvents] = useState([])
  const [playerStats, setPlayerStats] = useState({
    player1: { name: 'John Doe', team: 'home', stats: { points: 10, assists: 5, rebounds: 3 } },
    player2: { name: 'Jane Smith', team: 'away', stats: { points: 12, assists: 3, rebounds: 7 } },
  })
  const [teamHistory, setTeamHistory] = useState({
    home: { recentForm: ['W', 'W', 'L', 'W', 'L'], headToHead: ['W', 'L', 'W'] },
    away: { recentForm: ['L', 'W', 'W', 'L', 'W'], headToHead: ['L', 'W', 'L'] },
  })
  const [socialTrends, setSocialTrends] = useState(['#GameOfTheYear', '#UnderDogStory', '#RecordBreakingPerformance'])
  const [activeCameras, setActiveCameras] = useState([1, 2, 3, 4])
  const [slowMotionReplay, setSlowMotionReplay] = useState({
    id: '1',
    timestamp: '00:15:30',
    description: 'Spectacular goal from outside the box!',
    videoUrl: '/sample-replay.mp4'
  })
  const [teamPerformance, setTeamPerformance] = useState({
    homeTeam: {
      name: 'Home Team',
      stats: {
        points: 78,
        fieldGoalPercentage: 45,
        threePointPercentage: 35,
        freeThrowPercentage: 80,
        rebounds: 30,
        assists: 15,
        steals: 7,
        blocks: 3
      }
    },
    awayTeam: {
      name: 'Away Team',
      stats: {
        points: 72,
        fieldGoalPercentage: 42,
        threePointPercentage: 33,
        freeThrowPercentage: 75,
        rebounds: 28,
        assists: 13,
        steals: 5,
        blocks: 2
      }
    }
  })
  const [diffusionScreens, setDiffusionScreens] = useState(['Main Camera', 'Player Close-up', 'Crowd View'])

  useEffect(() => {
    if (status === "unauthenticated") {
      router.push("/login")
    }
  }, [status, router])

  useEffect(() => {
    const timer = setInterval(() => {
      // Simulate game state changes
      setGameState(prevState => ({
        ...prevState,
        time: updateGameTime(prevState.time),
        possession: Math.random() > 0.5 ? 'home' : 'away',
        score: {
          home: Math.random() > 0.95 ? prevState.score.home + 1 : prevState.score.home,
          away: Math.random() > 0.95 ? prevState.score.away + 1 : prevState.score.away
        }
      }))

      // Simulate other state changes
      setPlayerPositions(generateRandomPlayerPositions())
      setPlayerPerformances(generatePlayerPerformances())
      setSentiment(generateRandomSentiment())
      if (Math.random() > 0.9) {
        const newHighlight = { 
          id: Date.now(), 
          time: gameState.time, 
          description: generateHighlightDescription()
        }
        setHighlights(prevHighlights => [...prevHighlights, newHighlight].slice(-5))
      }
      setCommentary(generateCommentary(gameState))
      setPredictions(generatePredictions(gameState))

      if (aiMode === 'auto') {
        const decision = makeAIDecision(gameState, playerPositions, sentiment)
        setAIDecisions(prevDecisions => [decision, ...prevDecisions].slice(0, 10))
      }

      // Update player stats and team performance
      updatePlayerStats()
      updateTeamPerformance()
    }, 2000)

    return () => clearInterval(timer)
  }, [gameState, aiMode])

  const handleCameraSwitch = (cameraId: number) => {
    setActiveCamera(cameraId)
  }

  const handleAIModeChange = (mode: string) => {
    setAIMode(mode)
  }

  const handleReplayToggle = () => {
    setReplayMode(!replayMode)
  }

  const handleGraphicsToggle = () => {
    setGraphicsVisible(!graphicsVisible)
  }

  const handleAudioLevelChange = (channel: string, level: number) => {
    setAudioLevels(prevLevels => ({ ...prevLevels, [channel]: level }))
  }

  const handleAddDiffusionScreen = (screen: string) => {
    setDiffusionScreens(prevScreens => [...prevScreens, screen])
  }

  const handleRemoveDiffusionScreen = (index: number) => {
    setDiffusionScreens(prevScreens => prevScreens.filter((_, i) => i !== index))
  }

  if (status === "loading") {
    return <div>Loading...</div>
  }

  if (!session) {
    return null
  }

  return (
    <ErrorBoundary>
      <div className="flex flex-col h-screen bg-gray-100 dark:bg-gray-900">
        <motion.header 
          className="bg-white dark:bg-gray-800 shadow"
          initial={{ opacity: 0, y: -50 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <div className="max-w-7xl mx-auto py-4 px-4 sm:px-6 lg:px-8 flex justify-between items-center">
            <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Aenzbi TV Director Dashboard</h1>
            <NetworkStatus />
          </div>
        </motion.header>
        <main className="flex-grow flex overflow-hidden">
          <Tabs defaultValue="live" className="flex-grow flex flex-col">
            <div className="bg-white dark:bg-gray-800 shadow-sm">
              <TabsList className="justify-start px-4 py-2 max-w-7xl mx-auto">
                <TabsTrigger value="live">Live Feed</TabsTrigger>
                <TabsTrigger value="analytics">Analytics</TabsTrigger>
                <TabsTrigger value="controls">Controls</TabsTrigger>
                <TabsTrigger value="production">Production</TabsTrigger>
                <TabsTrigger value="tools">Tools</TabsTrigger>
              </TabsList>
            </div>
            <div className="flex-grow overflow-auto p-6">
              <TabsContent value="live" className="h-full">
                <LiveFeedTab
                  activeCamera={activeCamera}
                  gameState={gameState}
                  graphicsVisible={graphicsVisible}
                  playerStats={playerStats}
                  sentiment={sentiment}
                  highlights={highlights}
                />
              </TabsContent>
              <TabsContent value="analytics" className="h-full">
                <AnalyticsTab
                  gameState={gameState}
                  playerStats={playerStats}
                  teamHistory={teamHistory}
                  socialTrends={socialTrends}
                  highlights={highlights}
                  sentiment={sentiment}
                  playerPositions={playerPositions}
                  playerPerformances={playerPerformances}
                  teamPerformance={teamPerformance}
                  commentary={commentary}
                  predictions={predictions}
                  timelineEvents={timelineEvents}
                />
              </TabsContent>
              <TabsContent value="controls" className="h-full">
                <ControlsTab
                  aiMode={aiMode}
                  onAIModeChange={handleAIModeChange}
                  activeCamera={activeCamera}
                  onCameraSwitch={handleCameraSwitch}
                  gameState={gameState}
                  replayMode={replayMode}
                  onReplayToggle={handleReplayToggle}
                  graphicsVisible={graphicsVisible}
                  onGraphicsToggle={handleGraphicsToggle}
                  audioLevels={audioLevels}
                  onAudioLevelChange={handleAudioLevelChange}
                  highlights={highlights}
                  aiDecisions={aiDecisions}
                  slowMotionReplay={slowMotionReplay}
                  diffusionScreens={diffusionScreens}
                  onAddDiffusionScreen={handleAddDiffusionScreen}
                  onRemoveDiffusionScreen={handleRemoveDiffusionScreen}
                />
              </TabsContent>
              <TabsContent value="production" className="h-full">
                <ProductionTab
                  activeCameras={activeCameras}
                />
              </TabsContent>
              <TabsContent value="tools" className="h-full">
                <ToolsTab />
              </TabsContent>
            </div>
          </Tabs>
        </main>
      </div>
    </ErrorBoundary>
  )
}

function LiveFeedTab({ activeCamera, gameState, graphicsVisible, playerStats, sentiment, highlights }) {
  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 h-full">
      <Card className="lg:col-span-2">
        <CardHeader>
          <CardTitle>Live Feed</CardTitle>
        </CardHeader>
        <CardContent>
          <Dashboard 
            activeCamera={activeCamera} 
            gameState={gameState}
            graphicsVisible={graphicsVisible}
          />
        </CardContent>
      </Card>
      <div className="space-y-6">
        <AIInsights gameState={gameState} playerStats={playerStats} />
        <SentimentAnalysis sentiment={sentiment} />
        <HighlightGenerator highlights={highlights} />
      </div>
    </div>
  )
}

function AnalyticsTab({ gameState, playerStats, teamHistory, socialTrends, highlights, sentiment, playerPositions, playerPerformances, teamPerformance, commentary, predictions, timelineEvents }) {
  return (
    <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <NarrativeEngine 
        gameState={gameState}
        playerStats={playerStats}
        teamHistory={teamHistory}
        socialTrends={socialTrends}
        highlights={highlights}
        sentiment={sentiment}
      />
      <PlayerTracking 
        positions={playerPositions}
        performances={playerPerformances}
      />
      <TeamPerformance 
        homeTeam={teamPerformance.homeTeam}
        awayTeam={teamPerformance.awayTeam}
      />
      <AutomatedCommentary commentary={commentary} />
      <PredictiveAnalytics predictions={predictions} />
      <Timeline events={timelineEvents} />
    </div>
  )
}

function ControlsTab({ aiMode, onAIModeChange, activeCamera, onCameraSwitch, gameState, replayMode, onReplayToggle, graphicsVisible, onGraphicsToggle, audioLevels, onAudioLevelChange, highlights, aiDecisions, slowMotionReplay, diffusionScreens, onAddDiffusionScreen, onRemoveDiffusionScreen }) {
  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <AIControlPanel mode={aiMode} onModeChange={onAIModeChange} />
      <VideoSwitcher activeCamera={activeCamera} onCameraSwitch={onCameraSwitch} />
      <AICameraSwitcher onCameraSwitch={onCameraSwitch} gameState={gameState} />
      <ReplaySystem isActive={replayMode} onToggle={onReplayToggle} />
      <GraphicsOverlay isVisible={graphicsVisible} onToggle={onGraphicsToggle} />
      <AudioMixer levels={audioLevels} onLevelChange={onAudioLevelChange} />
      <HighlightGenerator highlights={highlights} />
      <AIDecisionLog decisions={aiDecisions} />
      <StreamingControl />
      <StreamingQualityControl />
      <SlowMotionReplay replayData={slowMotionReplay} />
      <MultiScreenDiffusion
        screens={diffusionScreens}
        onAddScreen={onAddDiffusionScreen}
        onRemoveScreen={onRemoveDiffusionScreen}
      />
    </div>
  )
}

function ProductionTab({ activeCameras }) {
  return (
    <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <MultiViewLayout activeCameras={activeCameras} />
      <ProductionChat />
      <SocialMediaFeed />
    </div>
  )
}

function ToolsTab() {
  return (
    <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
      <LanguageTranslator />
      <FileConverter />
    </div>
  )
}

// Helper functions (unchanged)
function updateGameTime(time: string): string {
  const [minutes, seconds] = time.split(':').map(Number)
  const newSeconds = (seconds + 2) % 60
  const newMinutes = seconds + 2 >= 60 ? (minutes + 1) % 45 : minutes
  return `${newMinutes.toString().padStart(2, '0')}:${newSeconds.toString().padStart(2, '0')}`
}

function generateRandomPlayerPositions() {
  return Array.from({ length: 22 }, (_, i) => ({
    id: i + 1,
    x: Math.random() * 100,
    y: Math.random() * 100,
    team: i < 11 ? 'home' : 'away'
  }))
}

function generatePlayerPerformances() {
  return Array.from({ length: 10 }, (_, i) => ({
    id: i + 1,
    name: `Player ${i + 1}`,
    team: i < 5 ? 'home' : 'away',
    stats: {
      points: Math.floor(Math.random() * 30),
      assists: Math.floor(Math.random() * 10),
      rebounds: Math.floor(Math.random() * 15),
      steals: Math.floor(Math.random() * 5)
    }
  }))
}

function generateRandomSentiment() {
  const positive = Math.floor(Math.random() * 60) + 20
  const neutral = Math.floor(Math.random() * (80 - positive))
  const negative = 100 - positive - neutral
  return { positive, neutral, negative }
}

function generateHighlightDescription() {
  const descriptions = [
    "Spectacular goal from outside the box!",
    "Incredible save by the goalkeeper!",
    "Brilliant through-ball leading to a goal",
    "Powerful header from the corner kick",
    "Skillful dribble past three defenders"
  ]
  return descriptions[Math.floor(Math.random() * descriptions.length)]
}

function generateCommentary(gameState) {
  const phrases = [
    `The score is now ${gameState.score.home}-${gameState.score.away}.`,
    `${gameState.possession === 'home' ? 'Home' : 'Away'} team in possession.`,
    `We're at ${gameState.time} in the ${gameState.period === 1 ? 'first' : 'second'} half.`,
    'The crowd is getting excited!',
    'What a fantastic display of skill!',
    'The tension is palpable as we approach the final minutes.'
  ]
  return phrases[Math.floor(Math.random() * phrases.length)]
}

function generatePredictions(gameState) {
  const scoreDiff = gameState.score.home - gameState.score.away
  const timeRemaining = 90 - parseInt(gameState.time.split(':')[0])
  const homeWinProbability = Math.min(Math.max((50 + scoreDiff * 10 + (45 - timeRemaining) * scoreDiff / 45), 0), 100)
  const nextScoringTeam = Math.random() > homeWinProbability / 100 ? 'away' : 'home'
  return { homeWinProbability, nextScoringTeam }
}

function makeAIDecision(gameState, playerPositions, sentiment) {
  const decisions = [
    { action: 'Switch to close-up camera', reason: 'Key player has possession' },
    { action: 'Prepare instant replay', reason: 'Potential goal-scoring opportunity' },
    { action: 'Display team statistics', reason: 'Lull in game action' },
    { action: 'Increase crowd audio', reason: 'Rising excitement levels' },
    { action: 'Switch to tactical view', reason: 'Complex play formation detected' }
  ]
  return decisions[Math.floor(Math.random() * decisions.length)]
}

function updatePlayerStats() {
  setPlayerStats(prevStats => ({
    ...prevStats,
    player1: {
      ...prevStats.player1,
      stats: {
        ...prevStats.player1.stats,
        points: prevStats.player1.stats.points + (Math.random() > 0.8 ? 2 : 0),
        assists: prevStats.player1.stats.assists + (Math.random() > 0.9 ? 1 : 0),
        rebounds: prevStats.player1.stats.rebounds + (Math.random() > 0.85 ? 1 : 0),
      }
    },
    player2: {
      ...prevStats.player2,
      stats: {
        ...prevStats.player2.stats,
        points: prevStats.player2.stats.points + (Math.random() > 0.8 ? 2 : 0),
        assists: prevStats.player2.stats.assists + (Math.random() > 0.9 ? 1 : 0),
        rebounds: prevStats.player2.stats.rebounds + (Math.random() > 0.85 ? 1 : 0),
      }
    }
  }))
}

function updateTeamPerformance() {
  setTeamPerformance(prevPerformance => ({
    homeTeam: {
      ...prevPerformance.homeTeam,
      stats: {
        ...prevPerformance.homeTeam.stats,
        points: prevPerformance.homeTeam.stats.points + (Math.random() > 0.7 ? 2 : 0),
        rebounds: prevPerformance.homeTeam.stats.rebounds + (Math.random() > 0.6 ? 1 : 0),
        assists: prevPerformance.homeTeam.stats.assists + (Math.random() > 0.8 ? 1 : 0),
        steals: prevPerformance.homeTeam.stats.steals + (Math.random() > 0.9 ? 1 : 0),
        blocks: prevPerformance.homeTeam.stats.blocks + (Math.random() > 0.95 ? 1 : 0),
      }
    },
    awayTeam: {
      ...prevPerformance.awayTeam,
      stats: {
        ...prevPerformance.awayTeam.stats,
        points: prevPerformance.awayTeam.stats.points + (Math.random() > 0.7 ? 2 : 0),
        rebounds: prevPerformance.awayTeam.stats.rebounds + (Math.random() > 0.6 ? 1 : 0),
        assists: prevPerformance.awayTeam.stats.assists + (Math.random() > 0.8 ? 1 : 0),
        steals: prevPerformance.awayTeam.stats.steals + (Math.random() > 0.9 ? 1 : 0),
        blocks: prevPerformance.awayTeam.stats.blocks + (Math.random() > 0.95 ? 1 : 0),
      }
    }
  }))
}
EOF

# Update app/layout.tsx
echo "Updating app/layout.tsx..."
cat << 'EOF' > app/layout.tsx
import Link from "next/link"
import { AenzbiLogo } from '@/components/AenzbiLogo'
import { ThemeProvider } from "@/components/theme-provider"
import { Toaster } from "@/components/ui/toaster"
import { Inter } from 'next/font/google'

const inter = Inter({ subsets: ['latin'] })

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <ThemeProvider attribute="class" defaultTheme="system" enableSystem>
          <div className="flex h-screen bg-gray-100 dark:bg-gray-900">
            <nav className="w-64 bg-white dark:bg-gray-800 p-4 hidden md:block">
              <div className="flex items-center mb-8">
                <AenzbiLogo className="h-8 w-8 mr-2" />
                <span className="text-2xl font-bold">Aenzbi TV Director</span>
              </div>
              <ul className="space-y-2">
                <li>
                  <Link href="/dashboard" className="block p-2 rounded hover:bg-gray-200 dark:hover:bg-gray-700">
                    Dashboard
                  </Link>
                </li>
                <li>
                  <Link href="/profile" className="block p-2 rounded hover:bg-gray-200 dark:hover:bg-gray-700">
                    Profile
                  </Link>
                </li>
                <li>
                  <Link href="/subscription" className="block p-2 rounded hover:bg-gray-200 dark:hover:bg-gray-700">
                    Subscription
                  </Link>
                </li>
                <li>
                  <Link href="/customize" className="block p-2 rounded hover:bg-gray-200 dark:hover:bg-gray-700">
                    Customize
                  </Link>
                </li>
                <li>
                  <Link href="/users" className="block p-2 rounded hover:bg-gray-200 dark:hover:bg-gray-700">
                    User Management
                  </Link>
                </li>
                <li>
                  <Link href="/settings" className="block p-2 rounded hover:bg-gray-200 dark:hover:bg-gray-700">
                    Settings
                  </Link>
                </li>
              </ul>
            </nav>
            <main className="flex-1 overflow-y-auto">
              {children}
            </main>
          </div>
          <Toaster />
        </ThemeProvider>
      </body>
    </html>
  )
}
EOF

echo "Update process completed successfully!"

# Make the script executable
chmod +x update_aenzbi_tv_director.sh

echo "Script is now executable. Run it with ./update_aenzbi_tv_director.sh"