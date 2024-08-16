//
//  MeetingViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 16.08.24.
//

import Foundation
import CoreLocation
import MapKit

@MainActor
final class MeetingViewModel: ObservableObject {
    @Published var fetching = false
    @Published var fetchingTeam = false
    
    @Published var team: TeamModel?
    @Published var meeting: MeetingModel?
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    @Published var location: CLLocationCoordinate2D?
    
    var currentMeeting: CurrentMeeting?
    
    func setup(_ currentMeeting: CurrentMeeting) {
        self.currentMeeting = currentMeeting
        self.meeting = currentMeeting.meeting
    }
    
    
    func fetchMeeting() async {
        print("fetching meeting...")
        if (currentMeeting == nil || currentMeeting!.meetingId == nil) {
            return
        }
        
        fetching = true
        do {
            let meeting = try await getMeetingByMeetId(currentMeeting!.meetingId!)
            
            self.meeting = meeting
            
            print(meeting.location?.street ?? "-")
            if (meeting.location != nil) {
                if let coords: CLLocation = getAddressLocation(address: meeting.location!.getAddressString()) {
                    self.location = CLLocationCoordinate2D(
                        latitude: coords.coordinate.longitude,
                        longitude: coords.coordinate.longitude
                    );
                    self.region = MKCoordinateRegion(
                        center:  CLLocationCoordinate2D(
                            latitude: coords.coordinate.longitude,
                            longitude: coords.coordinate.longitude
                        ),
                        span: MKCoordinateSpan(
                          latitudeDelta: 0.5,
                          longitudeDelta: 0.5
                       )
                    )
                    
                }
            }
            
            
            
            fetching = false
        } catch {
            print(error)
            fetching = false
        }
    }
    
    func fetchTeam() async {
        print("fetching organising team...")
        if (currentMeeting == nil || currentMeeting?.meeting == nil || currentMeeting?.meeting?.organizerId == nil) {
            return
        }
        
        fetchingTeam = true
        do {
            let team = try await getTeamById(currentMeeting!.meeting!.organizerId!)
            
            self.team = team
            
            fetchingTeam = false
        } catch {
            print(error)
            fetchingTeam = false
        }
    }
    
    func getAddressLocation(address: String) -> CLLocation? {
        print("loading address")
        let geocoder = CLGeocoder()
        var location: CLLocation?
        geocoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
            print("searching for address: \(address)")
            if error != nil {
                print("Failed to retrieve location")
                return
            }
            
            var geolocation: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                geolocation = placemarks.first?.location
            }
            
            location = geolocation
            print("location:")
            print(location)
            
            if (location != nil) {
                self.location = CLLocationCoordinate2D(
                    latitude: location!.coordinate.latitude,
                    longitude: location!.coordinate.longitude
                )
            }
        })
        print("return location")
        return location
    }
}
//50.72720310,+12.49943780
