# NWRUG

The website of the North West Ruby User Group, a Manchester-based user group for
people interested in the Ruby programming language. It tells members when and
where the group is meeting, keeps an archive of past meetups, and publishes a
calendar feed.

## Language

### Meetups

**Event**:
A single NWRUG meetup, held at a Venue or online. Every Event that members can
see has been committed to by an organiser.
_Avoid_: Meeting, meetup, talk

**Scheduled Event**:
An Event that exists as a record, meaning a meetup a member can rely on turning
up to.
_Avoid_: Confirmed event, real event

**Provisional Date**:
The date the group would meet if it followed its usual pattern, being the third
Thursday of the month at 18:30. It is a proposal rather than a commitment: no
Event exists for it, and no organiser has agreed to it. Used to pre-fill a new
Event, and shown to members only when explicitly hedged as unconfirmed.
_Avoid_: Next event, default date, next date

**Upcoming**:
Scheduled Events on or after today, soonest first. The boundary is midnight in
the group's own timezone, not the server's.
_Avoid_: Future, forthcoming

**Previous**:
Scheduled Events before today, most recent first. The archive.
_Avoid_: Past, historic, old

**Online Event**:
An Event with no Venue, held remotely.
_Avoid_: Remote event, virtual event

### Places

**Venue**:
A physical place where an Event is held, in or near Manchester. An Online Event
has no Venue.
_Avoid_: Location, place, address

### People

**Member**:
Somebody interested in NWRUG who visits the site to find out about Events. Has
no account and never signs in, because everything a Member needs is public.
_Avoid_: Visitor, user, attendee

**Organiser**:
Somebody who can sign in to create and amend Events and Quizzes. The only kind
of account that exists; there is no public sign-up and no role hierarchy.
_Avoid_: User, admin, editor

**Maintainer**:
Somebody who changes the site's code and deploys it. Volunteers, working in
short and widely spaced sessions, so anything that cannot be rediscovered
quickly has to be written down.
_Avoid_: Developer, contributor, admin

### Other content

**Quiz**:
A Ruby code quiz published on the site, independent of any Event.
_Avoid_: Challenge, puzzle

**Slug**:
The human-readable identifier an Event or Quiz is addressed by in a URL. Once
published it never changes, because old slugs are linked to from elsewhere on
the web.
_Avoid_: Permalink, handle, path

### Delivery

**Feature test**:
A test that drives the site the way a Member or Organiser would, through pages
and forms. The only kind of test that is allowed to prove a controller works.
_Avoid_: Integration test, system test, acceptance test

**Unit test**:
A test that exercises one object directly, without going through a page. The
only kind of test that is allowed to prove everything other than a controller
works.
_Avoid_: Model test, spec
