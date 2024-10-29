Built responsive iOS application using Swift, targeted at helping parents keep up with the events of the high school their students attend.

First, ensure cocoa pods is installed: sudo gem install cocoapods
then do 'pod init' inside Noti folder in terminal

 insert this into podfile: 

pod 'Firebase/Analytics'
pod 'Firebase/Auth'
pod 'Firebase/Firestore'
pod 'Firebase/Database'


We also used SwiftSoup in order to scrape and parse HTML files.

Open up the Noti folder and insert this into the podfile: 'pod 'SwiftSoup''
