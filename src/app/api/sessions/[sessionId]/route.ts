import { NextResponse } from 'next/server';
import { v4 as uuidv4 } from 'uuid';

export async function GET(
  request: Request,
  { params }: { params: { sessionId: string } }
) {
  try {
    // Mock session data - in production, fetch from database
    const session = {
      id: params.sessionId,
      userId: uuidv4(),
      startTime: new Date(Date.now() - 3600000).toISOString(),
      endTime: new Date().toISOString(),
      duration: 3600,
      distance: 1500,
      laps: 60,
      metrics: {
        avgPace: 120,
        heartRate: Array.from({ length: 60 }, (_, i) => ({
          timestamp: new Date(Date.now() - (60 - i) * 60000).toISOString(),
          value: Math.floor(Math.random() * (180 - 120) + 120)
        })),
        position: Array.from({ length: 60 }, (_, i) => ({
          timestamp: new Date(Date.now() - (60 - i) * 60000).toISOString(),
          x: Math.sin(i * 0.1) * 0.5,
          y: Math.cos(i * 0.1) * 0.5
        }))
      }
    };

    return NextResponse.json(session);
  } catch (error) {
    return NextResponse.json(
      { error: 'Session not found' },
      { status: 404 }
    );
  }
}