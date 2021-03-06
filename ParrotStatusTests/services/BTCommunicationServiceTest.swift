import XCTest
import AEXML
import Quick
import Nimble
import IOBluetooth

@testable import ParrotStatus

class ParrotZikApiMock: ParrotZik2Api {

    var getAsyncApplicationVersionWasCalled = false
    var getAsyncNoiseCancellationStatusWasCalled = false
    var getAsyncBatteryInfoWasCalled = false
    var getAsyncFriendlyNameWasCalled = false
    var getAsyncNoiseControlStatusWasCalled = false
    var getAsyncEqualizerStatusWasCalled = false
    var getAsyncFlightModeStatusWasCalled = false
    var getAsyncConcertHallStatusWasCalled = false
    var getAsyncheadDetectionStatusWasCalled = false

    func reset() {
        getAsyncApplicationVersionWasCalled = false
        getAsyncNoiseCancellationStatusWasCalled = false
        getAsyncBatteryInfoWasCalled = false
        getAsyncFriendlyNameWasCalled = false
        getAsyncNoiseControlStatusWasCalled = false
        getAsyncEqualizerStatusWasCalled = false
    }

    func allApiWereCalled() -> Bool {
        return getAsyncApplicationVersionWasCalled &&
        getAsyncNoiseCancellationStatusWasCalled &&
        getAsyncBatteryInfoWasCalled &&
        getAsyncFriendlyNameWasCalled &&
        getAsyncNoiseControlStatusWasCalled &&
        getAsyncEqualizerStatusWasCalled &&
        getAsyncFlightModeStatusWasCalled
    }

    override func getAsyncApplicationVersion() -> Bool {
        getAsyncApplicationVersionWasCalled = true
        return true
    }

    override func getAsyncNoiseCancellationStatus() -> Bool {
        getAsyncNoiseCancellationStatusWasCalled = true
        return true
    }

    override func getAsyncBatteryInfo() -> Bool {
        getAsyncBatteryInfoWasCalled = true
        return true
    }

    override func getAsyncFriendlyName() -> Bool {
        getAsyncFriendlyNameWasCalled = true
        return true
    }

    override func getAsyncNoiseControlStatus() -> Bool {
        getAsyncNoiseControlStatusWasCalled = true
        return true
    }

    override func getAsyncEqualizerStatus() -> Bool {
        getAsyncEqualizerStatusWasCalled = true
        return true
    }

    override func getAsyncFlightModeStatus() -> Bool {
        getAsyncFlightModeStatusWasCalled = true
        return true
    }

    override func getAsyncConcertHallStatus() -> Bool {
        getAsyncConcertHallStatusWasCalled = true
        return true
    }

    override func getAsyncheadDetectionStatus() -> Bool {
        getAsyncheadDetectionStatusWasCalled = true
        return true
    }

}

class ZikResponseHandlerMock: ZikResponseHandler {}

class BTCommunicationServiceTest: QuickSpec {

    override func spec() {
        var parrotZikApiMock = ParrotZikApiMock()
        var zikResponseHandlerMock = ZikResponseHandlerMock()
        var serviceUnderTest: BTCommunicationService!

        func initializationMessage() -> [UInt8] {
            return  [UInt8(0), UInt8(3), UInt8(2)]
        }

        beforeEach {
            serviceUnderTest = BTCommunicationService(api: parrotZikApiMock,
                zikResponseHandler: zikResponseHandlerMock)
            parrotZikApiMock.reset()
        }

        describe("Parrot status communication service") {
            it("should call zik api service and get headphone state") {
                var data = initializationMessage()
                serviceUnderTest
                    .rfcommChannelData(IOBluetoothRFCOMMChannel(), data: &data, length: 3)
                expect(parrotZikApiMock.allApiWereCalled()).to(beTrue())
            }
        }
    }

}
