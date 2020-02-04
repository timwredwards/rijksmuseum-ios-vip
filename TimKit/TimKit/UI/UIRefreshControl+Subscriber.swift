import UIKit
import Combine

extension UIRefreshControl: Subscriber {
    public func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    public func receive(_ input: Bool) -> Subscribers.Demand {
        switch (input, isRefreshing) {
        case (true, false):
            beginRefreshingWithAnimation()
        case (false, true):
            endRefreshing()
        default:
            break
        }
        return .unlimited
    }

    public func receive(completion: Subscribers.Completion<Never>) { }
}

