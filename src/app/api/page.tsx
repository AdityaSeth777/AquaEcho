import dynamic from 'next/dynamic';
import 'swagger-ui-react/swagger-ui.css';
import type { SwaggerUIProps } from 'swagger-ui-react';

const SwaggerUI = dynamic<SwaggerUIProps>(
  () => import('swagger-ui-react').then(mod => mod.default),
  { ssr: false }
);


const apiSpec = {
  openapi: '3.0.0',
  info: {
    title: 'AquaEcho API',
    version: '1.0.0',
    description: 'API documentation for AquaEcho swimming assistant'
  },
  servers: [
    {
      url: 'https://api.aquaecho.com/v1',
      description: 'Production server'
    },
    {
      url: 'http://localhost:3000/api',
      description: 'Development server'
    }
  ],
  components: {
    securitySchemes: {
      bearerAuth: {
        type: 'http',
        scheme: 'bearer',
        bearerFormat: 'JWT'
      }
    }
  },
  paths: {
    '/auth/login': {
      post: {
        tags: ['Authentication'],
        summary: 'User login',
        requestBody: {
          required: true,
          content: {
            'application/json': {
              schema: {
                type: 'object',
                required: ['email', 'password'],
                properties: {
                  email: {
                    type: 'string',
                    format: 'email'
                  },
                  password: {
                    type: 'string',
                    format: 'password'
                  }
                }
              }
            }
          }
        },
        responses: {
          '200': {
            description: 'Successful login',
            content: {
              'application/json': {
                schema: {
                  type: 'object',
                  properties: {
                    token: {
                      type: 'string'
                    },
                    user: {
                      type: 'object',
                      properties: {
                        id: {
                          type: 'string'
                        },
                        email: {
                          type: 'string'
                        },
                        name: {
                          type: 'string'
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    },
    '/sessions/{sessionId}': {
      get: {
        tags: ['Sessions'],
        summary: 'Get session details',
        security: [{ bearerAuth: [] }],
        parameters: [
          {
            name: 'sessionId',
            in: 'path',
            required: true,
            schema: {
              type: 'string'
            }
          }
        ],
        responses: {
          '200': {
            description: 'Session details',
            content: {
              'application/json': {
                schema: {
                  type: 'object',
                  properties: {
                    id: {
                      type: 'string'
                    },
                    userId: {
                      type: 'string'
                    },
                    startTime: {
                      type: 'string',
                      format: 'date-time'
                    },
                    endTime: {
                      type: 'string',
                      format: 'date-time'
                    },
                    duration: {
                      type: 'number'
                    },
                    distance: {
                      type: 'number'
                    },
                    laps: {
                      type: 'number'
                    },
                    metrics: {
                      type: 'object',
                      properties: {
                        avgPace: {
                          type: 'number'
                        },
                        heartRate: {
                          type: 'array',
                          items: {
                            type: 'object',
                            properties: {
                              timestamp: {
                                type: 'string',
                                format: 'date-time'
                              },
                              value: {
                                type: 'number'
                              }
                            }
                          }
                        },
                        position: {
                          type: 'array',
                          items: {
                            type: 'object',
                            properties: {
                              timestamp: {
                                type: 'string',
                                format: 'date-time'
                              },
                              x: {
                                type: 'number'
                              },
                              y: {
                                type: 'number'
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    },
    '/analytics/session': {
      post: {
        tags: ['Analytics'],
        summary: 'Submit session analytics',
        security: [{ bearerAuth: [] }],
        requestBody: {
          required: true,
          content: {
            'application/json': {
              schema: {
                type: 'object',
                required: ['sessionId', 'duration', 'distance', 'laps', 'metrics'],
                properties: {
                  sessionId: {
                    type: 'string'
                  },
                  duration: {
                    type: 'number'
                  },
                  distance: {
                    type: 'number'
                  },
                  laps: {
                    type: 'number'
                  },
                  metrics: {
                    type: 'object',
                    properties: {
                      avgPace: {
                        type: 'number'
                      },
                      heartRate: {
                        type: 'array',
                        items: {
                          type: 'object'
                        }
                      },
                      position: {
                        type: 'array',
                        items: {
                          type: 'object'
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        },
        responses: {
          '200': {
            description: 'Analytics processed successfully',
            content: {
              'application/json': {
                schema: {
                  type: 'object',
                  properties: {
                    status: {
                      type: 'string'
                    },
                    sessionId: {
                      type: 'string'
                    },
                    processed: {
                      type: 'string',
                      format: 'date-time'
                    },
                    insights: {
                      type: 'object',
                      properties: {
                        performanceScore: {
                          type: 'number'
                        },
                        efficiencyRating: {
                          type: 'string'
                        },
                        recommendations: {
                          type: 'array',
                          items: {
                            type: 'string'
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
};

export default function APIPage() {
  return (
    <div className="min-h-screen pt-16 bg-white">
      <SwaggerUI spec={apiSpec} />
    </div>
  );
}