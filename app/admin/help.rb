ActiveAdmin.register_page "Help" do
  menu :priority => 10

  content do
    div :class => 'help-content' do
      h2 "Welcome to the Paddlesports North America member database."
      para "This version of the PNA database is designed primarily to store data collected from members through traditional means ( ie. paper forms ). Because of this, help content is organized into typical use cases organized around those forms."

      h3 "Entering a new member"
      para "Any individual who interacts with PNA in some way ( take a course, assessment, etc. ) gets entered into the system as a 'member', reguardless of their actual paid membership status."
      ol do
        li "Click 'Members' in the main menu."
        li "Click 'New Member' in the top right of your screen."
        li "Enter in all relevant information."
        li "Click 'Create Member' to submit the data."
      end

      h3 "Enter or renew a membership"
      para "In order to keep an accurate record of everyones active membership history, a new 'Membership' record will be entered for every membership renewal."
      ol do
        li "From the 'Members' screen, seach for the target member using the filters on the right."
        li "Click 'View' on the member record in question."
        li "From the menu on the right, click 'Memberships'"
        li "Click the 'New Membership' button in the top right."
        li "Enter required information."
        li "Click the 'Create Membership' button at the bottom of the form."
      end

      h3 "Course Notifications"
      para "A Course Notification record is entered when a coach sends in course information to register a course with PNA."
      ol do
        li "Click 'Courses' in the top menu."
        li "Click the 'New Course' button in the top right corner of the page."
        li "Enter in all required information."
        li "Click the 'Create Course' button at the bottom of the form."
      end

      h3 "Enter course results"
      para "Course results are entered upon recipt of a Course Report and associated documentation."
      ol do
        li "Click 'Courses' in the top menu."
        li "Search for the course using the filters on the right. If the course does not exist it may need to be created."
        li "Click 'View' on the target course."
        li "Click 'Manage Students'."
        li "Click 'New Course Participant'."
        li "Enter in required information."
        li "Click the 'Create Course Participant' button at the bottom of the form."
        li "On the Course Participant Detail screen, click 'Add Another Particiipant' and repeat as needed."
      end

      h3 "Enter CR/LR Forms"
      ol do
        li "Click 'Members' in the top menu."
        li "Search for the member in question using the filters on the right."
        li "Click 'View' on the target member record."
        li "Click 'Coaching Registration' or 'Leadership Registration' in the menu on the right."
        li "Click the 'New Coaching / Leadership Registration' botton in the top right corner of the page."
        li "Enter in relevant information."
        li "Click 'Create Coaching / Leadership Registration' to save the data."
      end
    end
  end
end
