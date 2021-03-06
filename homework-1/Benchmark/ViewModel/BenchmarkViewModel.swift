

import Foundation

class BenchmarkViewModel {
    
    let timers:[TimerItem]
    var isAutoUpdateChart = true
    var updatedRow = 0
    
    private var timer:Timer?
    private var launchedTimers: [Int:TimerItem] = [:]
    private var pausedTimers: [Int:TimerItem] = [:]
    
    private var binder:((ViewModelState) -> ())? = nil
    
    init(provider:TimerItemsProvider?) {
        if provider != nil {
            self.timers = provider?.getTimersList() ?? [TimerItem]()
        } else {
            self.timers = [TimerItem]()
            print("TimerItemsProvider error")
        }
        
    }
    
    func bind(_ binder: @escaping (ViewModelState) -> ()) {
        self.binder = binder
        self.initializeTickingTimer()
    }
    
    func unBind() {
        self.binder = nil
    }
    
    func didSelectTimer(row: Int){
        let timerItem = timers[row]
        
        if launchedTimers[row] != nil {
            timerItem.showPlayButton()
            pausedTimers[row] = timers[row]
            launchedTimers.removeValue(forKey: row)
        } else {
            timerItem.showPauseButton()
            launchedTimers[row] = timers[row]
            pausedTimers.removeValue(forKey: row)
        }
        updateCell(row: row)
    }
    
    private func updateCell(row:Int) {
        self.updatedRow = row
        self.binder?(.result)
    }
    
    private func initializeTickingTimer(){
        let interval = 0.1
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            for(index, timer) in self.launchedTimers {
                timer.incrementDuration(interval)
                self.updateCell(row: index)
            }
            
            for(index, timer) in self.pausedTimers {
                timer.incrementPausedTime(interval)
                self.updateCell(row: index)
            }
        }
    }
}
