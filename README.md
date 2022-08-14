[![Swift Version][swift-image]][swift-url]
[![CI](https://github.com/drewbrns/sample-sports-events-streaming/actions/workflows/CI.yml/badge.svg)](https://github.com/drewbrns/sample-sports-events-streaming/actions/workflows/CI.yml)
# Sample Sports Events Streaming App
App to display a list of events, stream selected event and a list of schedule (EPG)

Things to note:
1. This app simulates pagination by allowing users to infinitely scroll until 100 items are loaded from the remote api.
2. User would see duplicates because the api was called multiple times and received the same data after reach call.
3. After user scrolls back to the top of the page, the duplicates would be evident since all the data is sorted based on Date in ascending order. 

See images below

<figure>
<img src="https://user-images.githubusercontent.com/1307074/184551545-4dd9b4b2-1bac-4746-a9ee-d92a1bb4f024.png" width="292.5"/>
<figcaption><b>Fig.1 - List as it is being infinitely scrolled</b></figcaption><p>&nbsp;</p>
</figure>

<figure>
<img src="https://user-images.githubusercontent.com/1307074/184551547-10bf5e03-a53e-4788-ad94-a95d3b0daf95.png" width="292.5"/>
<figcaption><b>Fig.2 - List with duplicates sorted by date in ascending order</b></figcaption>
</figure>

## Requirements
- iOS 15.5+
- Xcode 13.4+

[swift-image]:https://img.shields.io/badge/swift-5.6-orange.svg
[swift-url]:https://swift.org/
