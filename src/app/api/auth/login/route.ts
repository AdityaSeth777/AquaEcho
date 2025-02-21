import { NextResponse } from 'next/server';
import { v4 as uuidv4 } from 'uuid';

export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { email, password } = body;

    // Simple validation
    if (!email || !password) {
      return NextResponse.json(
        { error: 'Email and password are required' },
        { status: 400 }
      );
    }

    // Mock authentication - in production, implement proper auth
    const token = uuidv4();
    
    return NextResponse.json({
      token,
      user: {
        id: uuidv4(),
        email,
        name: 'Demo User'
      }
    });
  } catch (error) {
    return NextResponse.json(
      { error: 'Invalid request' },
      { status: 400 }
    );
  }
}