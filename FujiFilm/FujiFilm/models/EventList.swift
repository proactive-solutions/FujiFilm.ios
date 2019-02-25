
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

    struct Result: Codable {
        let fldEventID: String
        let fldEventSlug: String
        let fldEventTitle: String
        let fldEventDid: String
        let fldEventDate: String
        let fldEventInstructor: String
        let fldEventStarttime: String
        let fldEventEndtime: String
        let fldEventDuration: String
        let fldEventLocation: String
        let fldEventAddress1: String
        let fldEventZipcode: String
        let fldEventPostalcode: String
        let fldEventCategory: String
        let fldEventUsertype: String
        let fldEventLat: String
        let fldEventLong: String
        let fldEventDescription: String
        let fldEventImage: String
        let fldEventStatus: String
        let fldEventCreatedAt: String
        let fldEventSeat: String
        let fldLastRegDate: String
        let attendanceCount: Int
        let remainingAttendanceCount: Int

        enum CodingKeys: String, CodingKey {
            case fldEventID = "fld_event_id"
            case fldEventSlug = "fld_event_slug"
            case fldEventTitle = "fld_event_title"
            case fldEventDid = "fld_event_did"
            case fldEventDate = "fld_event_date"
            case fldEventInstructor = "fld_event_instructor"
            case fldEventStarttime = "fld_event_starttime"
            case fldEventEndtime = "fld_event_endtime"
            case fldEventDuration = "fld_event_duration"
            case fldEventLocation = "fld_event_location"
            case fldEventAddress1 = "fld_event_address1"
            case fldEventZipcode = "fld_event_zipcode"
            case fldEventPostalcode = "fld_event_postalcode"
            case fldEventCategory = "fld_event_category"
            case fldEventUsertype = "fld_event_usertype"
            case fldEventLat = "fld_event_lat"
            case fldEventLong = "fld_event_long"
            case fldEventDescription = "fld_event_description"
            case fldEventImage = "fld_event_image"
            case fldEventStatus = "fld_event_status"
            case fldEventCreatedAt = "fld_event_createdAt"
            case fldEventSeat = "fld_event_seat"
            case fldLastRegDate = "fld_last_reg_date"
            case attendanceCount = "attendance_count"
            case remainingAttendanceCount = "remaining_attendance_count"
        }
    }
}
