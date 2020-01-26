

import Foundation

protocol TimerItemsProvider {
    func getTimersList() -> [TimerItem]
}

class TimerItemsService: TimerItemsProvider {
    let timerCount: Int
    
    init(timerCount:Int = 30) {
        self.timerCount = timerCount
    }
    func getTimersList() -> [TimerItem] {
        var timers = [TimerItem]()
        for _ in 0...self.timerCount {
            timers.append(TimerItem())
        }
        return timers
    }
}
