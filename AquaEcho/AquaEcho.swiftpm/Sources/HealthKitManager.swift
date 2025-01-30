import HealthKit

class HealthKitManager: ObservableObject {
    private let healthStore = HKHealthStore()
    private let swimWorkoutType = HKObjectType.workoutType()
    
    @Published var isAuthorized: Bool = false
    @Published var swimSessions: [HKWorkout] = []
    
    init() {
        requestAuthorization()
    }
    
    func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit is not available on this device")
            return
        }
        
        let typesToRead: Set<HKObjectType> = [
            HKObjectType.workoutType(),
            HKObjectType.quantityType(forIdentifier: .distanceSwimming)!,
            HKObjectType.quantityType(forIdentifier: .swimmingStrokeCount)!,
            HKObjectType.quantityType(forIdentifier: .heartRate)!
        ]
        
        let typesToShare: Set<HKSampleType> = [
            HKObjectType.workoutType(),
            HKObjectType.quantityType(forIdentifier: .distanceSwimming)!,
            HKObjectType.quantityType(forIdentifier: .swimmingStrokeCount)!
        ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { success, error in
            DispatchQueue.main.async {
                self.isAuthorized = success
                if success {
                    self.loadRecentSessions()
                } else if let error = error {
                    print("HealthKit authorization failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func saveSwimSession(duration: TimeInterval, distance: Double, laps: Int) {
        guard isAuthorized else { return }
        
        let swimWorkout = HKWorkout(
            activityType: .swimming,
            start: Date().addingTimeInterval(-duration),
            end: Date(),
            duration: duration,
            totalEnergyBurned: nil,
            totalDistance: HKQuantity(unit: .meter(), doubleValue: distance),
            device: .local(),
            metadata: [
                "laps": laps,
                "pool_length": UserDefaults.standard.integer(forKey: "poolLength")
            ]
        )
        
        healthStore.save(swimWorkout) { success, error in
            if let error = error {
                print("Failed to save workout: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.loadRecentSessions()
                }
            }
        }
    }
    
    func loadRecentSessions() {
        guard isAuthorized else { return }
        
        let calendar = Calendar.current
        let endDate = Date()
        let startDate = calendar.date(byAdding: .month, value: -1, to: endDate)!
        
        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: endDate,
            options: .strictStartDate
        )
        
        let sortDescriptor = NSSortDescriptor(
            key: HKSampleSortIdentifierEndDate,
            ascending: false
        )
        
        let query = HKSampleQuery(
            sampleType: swimWorkoutType,
            predicate: predicate,
            limit: 50,
            sortDescriptors: [sortDescriptor]
        ) { [weak self] _, samples, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to load workouts: \(error.localizedDescription)")
                    return
                }
                
                self?.swimSessions = samples as? [HKWorkout] ?? []
            }
        }
        
        healthStore.execute(query)
    }
    
    func calculateStats(for timeFrame: StatsView.TimeFrame) -> SwimStats {
        var stats = SwimStats()
        let calendar = Calendar.current
        let endDate = Date()
        
        let startDate: Date
        switch timeFrame {
        case .week:
            startDate = calendar.date(byAdding: .day, value: -7, to: endDate)!
        case .month:
            startDate = calendar.date(byAdding: .month, value: -1, to: endDate)!
        case .year:
            startDate = calendar.date(byAdding: .year, value: -1, to: endDate)!
        }
        
        let relevantSessions = swimSessions.filter { session in
            session.startDate >= startDate && session.startDate <= endDate
        }
        
        stats.totalDistance = relevantSessions.reduce(0) { $0 + ($1.totalDistance?.doubleValue(for: .meter()) ?? 0) }
        stats.totalDuration = relevantSessions.reduce(0) { $0 + $1.duration }
        stats.averagePace = stats.totalDistance > 0 ? stats.totalDuration / (stats.totalDistance / 100) : 0
        
        return stats
    }
}

struct SwimStats {
    var totalDistance: Double = 0
    var totalDuration: TimeInterval = 0
    var averagePace: TimeInterval = 0
}