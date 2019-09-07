
import Foundation

struct EventList: Codable {
    let code: Int
    let success: Bool
    let message: String
    let result: [Result]

    enum CodingKeys: String, CodingKey {
        case code
        case success
        case message
        case result
    }

    struct Result: Codable, TimestampToDateConvertible {
        let fldEventID: String
        let fldEventSlug: String
        let fldEventTitle: String
        let fldEventDid: String
        let fldEventCategory: String
        let fldEventSeats: String
        let fldEventInstructor: String
        let fldEventDate: String
        let fldEventStarttime: String
        let fldEventEndtime: String
        let fldEventRegdateEnd: String
        let fldEventDescriptionSmall: String
        let fldEventDescriptionBig: String
        let fldEventLocation: String
        let fldEventAddress1: String
        let fldEventAddress2: String
        let fldEventCityCountry: String
        let fldEventZipcode: String
        let fldEventLat: String
        let fldEventLong: String
        let fldEventView: String
        let fldEventFPSLevel: String
        let fldEventStatus: String
        let fldEventType: String
        let fldCreated: String
        let attendanceCount: Int
        let waitingCount: Int
        let registorCount: Int
        let remainingAttendanceCount: Int
        let fldEventImage: String

        enum CodingKeys: String, CodingKey {
            case fldEventID = "fld_event_id"
            case fldEventSlug = "fld_event_slug"
            case fldEventTitle = "fld_event_title"
            case fldEventDid = "fld_event_did"
            case fldEventCategory = "fld_event_category"
            case fldEventSeats = "fld_event_seats"
            case fldEventInstructor = "fld_event_instructor"
            case fldEventDate = "fld_event_date"
            case fldEventStarttime = "fld_event_starttime"
            case fldEventEndtime = "fld_event_endtime"
            case fldEventRegdateEnd = "fld_event_regdate_end"
            case fldEventDescriptionSmall = "fld_event_description_small"
            case fldEventDescriptionBig = "fld_event_description_big"
            case fldEventLocation = "fld_event_location"
            case fldEventAddress1 = "fld_event_address_1"
            case fldEventAddress2 = "fld_event_address_2"
            case fldEventCityCountry = "fld_event_city_country"
            case fldEventZipcode = "fld_event_zipcode"
            case fldEventLat = "fld_event_lat"
            case fldEventLong = "fld_event_long"
            case fldEventView = "fld_event_view"
            case fldEventFPSLevel = "fld_event_fps_level"
            case fldEventStatus = "fld_event_status"
            case fldEventType = "fld_event_type"
            case fldCreated = "fld_created"
            case attendanceCount = "attendance_count"
            case waitingCount = "waiting_count"
            case registorCount = "registor_count"
            case remainingAttendanceCount = "remaining_attendance_count"
            case fldEventImage = "fld_event_image"
        }
    }
}
