# NWRUG Recovery

**Written**: 2026-08-07. **Vocabulary**: see `CONTEXT.md` at the repo root.

> **Read this first if you are starting cold.** Every finding in this document
> was established by observation, not assumption, and each one is stated with
> the evidence that produced it. Several contradict what the repository appears
> to say at a glance. Before disagreeing with a finding, re-run the check
> recorded next to it, because the underlying state may have moved on. The
> "Evidence log" section at the end is the fastest way to re-establish the whole
> picture in one pass, and the "Landmarks" table names every file this work
> touches.

## Sources

The approach draws on two articles supplied when this work was scoped. Both are
worth reading before starting, and are referred to by author throughout:

- Mercedes Bernard, "Legacy code review, part 1":
  <https://mercedesbernard.com/blog/legacy-code-review-pt-1/>. The ordered
  assessment steps there shape the slice sequence, in particular the first one:
  run the application locally, and escalate rather than debug if it takes more
  than an hour.
- Ghinda, "First commits in a Ruby on Rails app":
  <https://allaboutcoding.ghinda.com/first-commits-in-a-ruby-on-rails-app/>. The
  five recommended first commits are adopted selectively; see "Tooling adopted
  from the cited articles".

## Landmarks

Paths and identifiers a cold session would otherwise have to rediscover. Verify
before relying on any of them, since the repository may have moved on.

| What | Where |
| --- | --- |
| Hidden setup blocker | `.bundle/config`, untracked, gitignored via `/.bundle` |
| CI workflow, lint job fails here | `.github/workflows/test-suite.yml` |
| Deploy workflow, to be neutered | `.github/workflows/release.yml` |
| Deploy config, to be split by Destination | `config/deploy.yml`, `.kamal/secrets` |
| CI-only eager loading | `config/environments/test.rb`, line 16 |
| Dead Code of Conduct link | `app/views/pages/code-of-conduct.html.erb` |
| Dead code, delete for 100% | `app/helpers/sessions_helper.rb` |
| Empty test class | `test/models/location_test.rb` |
| No test file at all | `app/helpers/application_helper.rb` |
| Uncovered online branch | `app/controllers/events_controller.rb`, `location_for` |
| Covered only via pages | `app/models/concerns/slugged.rb`, `to_param` |
| Covered only via pages | `app/models/event.rb`, `upcoming` and `previous` scopes |
| Empty directory, to be removed | `test/controllers/` |
| Stale, to be deleted | `.travis.yml`, `docs/server-setup.txt` |
| Misleading gitignore entry | `.gitignore`, the `config/database.yml` line |
| Typo, "the gme dependencies" | `README.md` |
| Production host | `109.107.35.37`, SSH user `ubuntu`, registry `ghcr.io/nwrug` |

## Problem Statement

NWRUG's site works, but nobody can safely change it.

A Member visiting today cannot find out when the group next meets. There is no
Scheduled Event in the future, so the homepage falls back to showing a
Provisional Date under the heading "Next Event", presenting a date nobody has
committed to as though it were a confirmed meetup. The events page lists nothing
upcoming at all. The Code of Conduct links to a definition of unacceptable
behaviour on a domain that no longer exists.

For a Maintainer, the situation is worse than it looks. `main` has not moved in
over a year. Continuous integration reports failure on every branch, so the
signal has stopped meaning anything and eleven pull requests sit unmerged behind
it: nine dependency bumps (#63, #68, #73, #74, #75, #76, #77, #78, #79), a Ruby
upgrade (#67), and one substantive change (#92). The deployment workflow has run
once in its life and failed, so the only proven way to release is a manual
command that nobody has written down. Setting the project up on a fresh machine
does not work, and the reason is invisible because it lives in an untracked file
on the one machine where it does. Sixteen issues are open, twelve of them from a
single audit (#80 to #91), and none has been acted on.

None of these problems is individually hard. Together they form a stall: the
safety equipment needed to change anything is itself the thing that needs
changing, and every possible starting point appears to be blocked by another.

## Solution

Restore the ability to ship, then use it.

Work proceeds as a sequence of small slices. The ordering rule, agreed
explicitly, is that **no infrastructure slice ships unless the Member-facing
slice it unblocks can be named**. This keeps the safety net from becoming the
project.

The first slice is deliberately both: it makes deploying a considered act and
carries a genuine Member-facing fix as its payload, so that proving the pipeline
and delivering value are the same commit. Only once a change has been shown to
reach production does anything else begin.

From there the sequence restores the CI signal, makes a fresh setup work,
introduces coverage measurement, closes the coverage gaps one at a time, and
finally turns on a coverage gate that is green the moment it lands. Riskier
improvements that can break live pages are deliberately held until that gate
exists to catch them.

## User Stories

### Members

1. As a Member, I want to see when NWRUG next meets, so that I can decide whether to come.
2. As a Member, I want a date shown as "Next Event" to be a meetup somebody has actually committed to, so that I do not travel to Manchester for something that was never arranged.
3. As a Member, I want to be told plainly when nothing is scheduled, so that I stop checking and wait for an announcement instead.
4. As a Member, I want to know the group's usual meeting pattern even when nothing is confirmed, so that I can plan roughly around it.
5. As a Member, I want a Provisional Date clearly marked as unconfirmed, so that I can tell it apart from a Scheduled Event at a glance.
6. As a Member, I want the Code of Conduct's definition of unacceptable behaviour to be readable, so that I know what standard I am being held to.
7. As a Member, I want every link in the Code of Conduct to work, so that I can trust the group takes the document seriously.
8. As a Member, I want to know who to contact about an incident, so that I can report something safely.
9. As a Member, I want to subscribe to a calendar feed of Events, so that meetups appear in my calendar without my checking the site.
10. As a Member, I want calendar entries at the correct local time, so that I do not arrive an hour out during British Summer Time.
11. As a Member, I want an Online Event's calendar entry to say it is online, so that I do not travel to a Venue that was never booked.
12. As a Member, I want to browse past Events, so that I can find a talk I remember and the speaker who gave it.
13. As a Member, I want old Event links shared years ago to still resolve, so that the group's history stays reachable from the rest of the web.
14. As a Member, I want to see an Event's Venue and how to get there, so that I can find the room.
15. As a Member, I want an Event shared on social media to show its title and description, so that the link is worth clicking.
16. As a Member, I want the participation page to describe accurately how to get involved, so that I can offer a talk or sponsorship.
17. As a Member, I want contact details on the site to be current, so that I am not directed to a channel the group abandoned.
18. As a Member, I want Event descriptions rendered safely, so that the site cannot be used to attack me.
19. As a Member, I want the site to stay up while it is being changed, so that my visit is not the one that hits a broken deploy.

### Organisers

20. As an Organiser, I want to sign in and create a Scheduled Event, so that Members can see what is coming.
21. As an Organiser, I want a new Event pre-filled with the Provisional Date, so that I am not retyping the third Thursday every month.
22. As an Organiser, I want a new Event pre-filled with the previous Event's Venue, so that the common case takes no effort.
23. As an Organiser, I want to mark an Event as online and have the Venue requirement lifted, so that remote meetups can be published.
24. As an Organiser, I want validation errors shown when I save an incomplete Event, so that I can correct it rather than lose it.
25. As an Organiser, I want an Event's Slug to stay fixed once published, so that links shared with Members keep working.
26. As an Organiser, I want to be prevented from creating two Events with the same Slug, so that I do not silently break an existing link.
27. As an Organiser, I want to edit a published Event, so that I can correct a speaker's name or a room change.
28. As an Organiser, I want to publish a Quiz, so that Members have something to play with between meetups.
29. As an Organiser, I want administrative pages to require signing in, so that Members cannot alter the schedule.
30. As an Organiser, I want to be returned to the page I was trying to reach after signing in, so that authentication does not lose my place.

### Maintainers

31. As a Maintainer, I want `bin/setup` to work on a clean machine with only external dependencies installed, so that a new volunteer can contribute the same day they clone.
32. As a Maintainer, I want the README's setup instructions to match what the project actually needs, so that I am not debugging a native extension build on my first evening.
33. As a Maintainer, I want a green build to mean the code is sound, so that a red build is worth interrupting my evening for.
34. As a Maintainer, I want known security advisories to fail the build, so that vulnerable dependencies cannot be ignored indefinitely.
35. As a Maintainer, I want static analysis to actually run, so that its findings reach me rather than being skipped after an earlier step fails.
36. As a Maintainer, I want dependency staleness reported without failing the build, so that a gate I cannot fix does not train me to ignore CI.
37. As a Maintainer, I want dependency updates to land in one deliberate act rather than nine conflicting ones, so that the effort produces a green signal rather than a queue of rebases.
38. As a Maintainer, I want deploying to require naming a Destination, so that production cannot be reached by accident or by muscle memory.
39. As a Maintainer, I want one documented command that deploys, so that releasing does not depend on somebody remembering how they did it last year.
40. As a Maintainer, I want deploys to happen only when a human asks, so that merging a change does not fire an unproven workflow at the live site.
41. As a Maintainer, I want to be able to add a second Destination later by adding a file, so that a staging environment is not a restructure.
42. As a Maintainer, I want every controller proven by Feature tests, so that I know the site works the way a Member uses it, not merely that the methods run.
43. As a Maintainer, I want everything other than controllers proven by Unit tests, so that behaviour is pinned directly rather than incidentally through a page.
44. As a Maintainer, I want coverage measured before it is enforced, so that the gate arrives green and CI is never knowingly left red.
45. As a Maintainer, I want coverage to read the same locally as in CI, so that I am not chasing a number I cannot reproduce.
46. As a Maintainer, I want dead code removed rather than tested, so that coverage measures something worth measuring.
47. As a Maintainer, I want changes that can break live pages held until the test suite can catch them, so that a safety improvement does not cause an outage.
48. As a Maintainer, I want the words used in issues, pull requests and code to mean one thing each, so that a conversation resumed weeks later does not restart from ambiguity.
49. As a Maintainer, I want stale configuration and documentation removed, so that I do not act on instructions describing a server that no longer exists.
50. As a Maintainer, I want findings recorded with the check that produced them, so that a future session can verify rather than re-derive them.

## Implementation Decisions

Each decision below was taken explicitly and has a reason. Reversing one is
fine; doing so unknowingly is not.

### Testing framework

The project stays on **Minitest**. The original brief was phrased in RSpec terms,
but there is no RSpec anywhere in the project and never has been. The whole
application is 307 lines of Ruby with a passing Minitest suite. Porting
it would be churn with no Member-facing value, which is the opposite of the
agreed approach. The coverage goal is therefore restated framework-neutrally in
terms of Feature tests and Unit tests.

### Deployment

- Deploying is triggered by a **Maintainer running a command**, not by merging.
  `.github/workflows/release.yml` is reduced to `workflow_dispatch` only, by
  removing its `push: branches: [main]` trigger. It stays in the repository as
  the seed of future automation. This closes half of issue #72, "Improve deploy
  pipelines", whose other half is its own observation that the project currently
  deploys regardless of build state.
- A **`bin/deploy` wrapper requires a Destination argument.** Exactly one
  Destination, `production`, is valid. The argument is a safety interlock, not
  configuration: deploying to production should not be four keystrokes. Kamal's
  single `config/deploy.yml` is split into `config/deploy.production.yml`, so
  that `bin/deploy production` resolves to `kamal deploy -d production` and
  adding a second Destination later is adding a file rather than restructuring.
- **The local path is proven before the automated one.** Getting a successful
  deploy from a Maintainer's machine isolates the container, SSH and registry
  concerns from the workflow-syntax concerns, rather than debugging both at once
  through a CI log. Evidence that this path works: the live calendar feed
  contains changes that the workflow never successfully shipped, so a human
  deployed them.
- The first deploy also carries the outstanding dependency bump commit, because
  production is one commit behind `main`. This is expected, not a surprise to
  investigate.

### Dependencies

- The Dependabot backlog is cleared by **one `bundle update`**, not by merging
  the nine pull requests individually. Seven of the nine concern transitive
  dependencies that do not appear in the Gemfile at all: activerecord (#63), uri
  (#68), rack (#73), nokogiri (#74), actionview (#76), activestorage (#77) and
  activesupport (#78). Only bcrypt (#75) and icalendar (#79) are direct. Merging
  them one at a time produces a sequence of `Gemfile.lock` conflicts and keeps
  the build red until the last one lands, so the effort yields no green signal
  along the way. A single update resolves them together and GitHub closes the
  pull requests automatically.
- The **Ruby version upgrade (#67, Ruby 3.4.8 and Bundler 4) is kept separate**.
  It is a language change, not a dependency bump, and belongs in its own slice.
- **Staleness is measured with `libyear-bundler`** (<https://github.com/jaredbeck/libyear-bundler>),
  added as a development dependency and invoked through a `bin/libyear`
  binstub. CI prints the number without acting on it.
- **Staleness is reported, never enforced.** The measurement counts transitive
  dependencies, so a gate can go red because somebody else's gem went quiet,
  which is unfixable locally and the fastest way to re-normalise a red build.
  `bundler-audit` remains a hard gate; libyear is a number printed alongside it.
  This distinction matters because the project has just spent a year
  demonstrating what happens when a gate goes red and nobody can act.

### Coverage

- **Coverage is measured with SimpleCov**, which is test-framework agnostic and
  so unaffected by the Minitest decision above.
- **Two separate runs, because one run cannot answer the question.** SimpleCov
  can group results within a run, but it cannot say which tests covered a line.
  Proving that controllers are covered by Feature tests specifically requires
  running Feature tests alone. There are therefore two rake tasks:
  `rake test:features` over `test/integration`, filtered to `app/controllers`;
  and `rake test:units` over `test/models` and `test/helpers`, filtered to
  exclude `app/controllers`. `bin/rake` runs both, so the habit and the CI
  invocation are unchanged.
- **`SimpleCov.use_merging false`, with separate `coverage_dir` values and
  distinct `command_name` values.** Merging is on by default. Left on, the
  second run absorbs the first, both report full coverage, and the arrangement
  proves nothing while appearing to work. This is the single most likely way for
  this design to fail silently.
- **`track_files` is configured explicitly**, because
  `config/environments/test.rb` line 16 reads
  `config.eager_load = ENV["CI"].present?`. Without it, files not loaded during
  a run are absent locally but reported as uncovered in CI, and the two numbers
  disagree for reasons that look like a bug.
- **The gate arrives green.** Measurement is introduced first with no failure
  threshold. Gaps are then closed one slice at a time. The threshold is switched
  on last, in a change that passes the moment it lands. CI is never knowingly
  left red, because normalising a red build is the specific failure this project
  is recovering from.
- **`test/controllers/` is removed** so that controller Unit tests cannot drift
  into the wrong run and quietly satisfy the goal the wrong way. It currently
  holds nothing but a `.keep` file.
- **Dead code is deleted, not covered.** `app/helpers/sessions_helper.rb` is an
  empty module referenced nowhere and cannot be exercised by a Unit test, so
  removing it is a prerequisite for the target rather than a tidy-up.

### Domain language

- A glossary exists at the repository root and is authoritative for the words
  used in code, issues and pull requests.
- **"Next event" was one name doing two jobs.** A **Scheduled Event** is a
  persisted meetup a Member can rely on. A **Provisional Date** is the computed
  third-Thursday slot, which is a proposal nobody has agreed to. The site
  currently renders the second under a heading that implies the first. The two
  concepts get two names, and a Provisional Date is shown to Members only when
  explicitly hedged as unconfirmed.
- **The glossary leads the code.** `Location` is called a **Venue** in the
  glossary because the existing name reads as coordinates. `User` is called an
  **Organiser** because only organisers have accounts, making the existing name
  actively misleading. Renaming happens opportunistically when a slice touches
  that code anyway, never as a standalone refactor. Expect the glossary and the
  code to disagree on these two names for some time; that is intended, not drift.

### Tooling adopted from the cited articles

Ghinda recommends five first commits. They are taken as follows:

- **Security checks in CI: already done.** Brakeman and bundler-audit are both
  in the `lint` job of `.github/workflows/test-suite.yml`. The recommendation is
  met; the job simply never reaches Brakeman, because bundler-audit exits first.
- **Production console sandboxing: taken early.**
  `config.sandbox_by_default = true` in `config/environments/production.rb` is a
  safe single-line change and can ride along in slice 2 or 3.
- **Strict loading by default: deliberately deferred** until the coverage gate
  exists. `config.active_record.strict_loading_by_default` raises on any lazily
  loaded association, and `app/views/events/show.html.erb` loads a Venue while
  `app/views/events/_form.html.erb` runs a query (issue #88), so enabling it
  early risks breaking live pages while the safety net still has holes.
- **Rubocop: deferred** for the same reason plus one more. A formatter rewrites
  most of a 307-line legacy codebase and destroys the usefulness of `git blame`.
  It is much safer once coverage is complete. It would settle the inconsistent
  `private` indentation visible across the controllers.
- **Rubycritic and reek: deferred**, and partly already scoped. Issue #91
  includes adding a reek configuration.

### Setup

Setup is fixed as its own slice, following Bernard's first step: run the
application locally, and if that takes more than an hour, treat it as a finding
rather than something to push through. The specific blocker is evidence 7 below.
Stale configuration and documentation describing a previous hosting arrangement
(`.travis.yml`, `docs/server-setup.txt`, the misleading `config/database.yml`
line in `.gitignore`, and the "gme" typo in `README.md`) are removed at the same
time, because leaving them is worse than having nothing.

Bernard's later steps are answered as follows, so a cold session need not repeat
them. Language and framework support: Ruby 3.3.6 on Rails 8.0, both current,
with #67 proposing Ruby 3.4.8. Infrastructure: a single host running the
application in a container behind Kamal's proxy, with MySQL on a separate host
reached via `DB_HOST`, and no cache, queue or object store in play. Data model:
four tables (`events`, `locations`, `quizzes`, `users`), six migrations, schema
version `20200812210327`, which matches the latest migration, so `db:prepare` on
a current production database is a no-op. Data integrity: validations exist at
the model layer but the database lacks unique indexes on the slug columns, which
is issue #82.

## Testing Decisions

### What makes a good test here

A test should describe behaviour a Member, an Organiser or a Maintainer could
observe, and should survive a change in how that behaviour is produced. Tests
assert what lands where and what is displayed, not which method was called.
Where fixtures put unrelated records into the same collection, assertions check
for inclusion rather than comparing whole collections, because `test_helper.rb`
loads `fixtures :all`. The existing suite already follows this convention and is
good prior art; PR #92 against `app/models/event.rb` demonstrates it clearly,
including an honest note distinguishing a genuine regression test from a pinning
test that could not be made to fail. Read that PR's description before writing
tests in this codebase.

### Seams

The guiding rule is to prefer existing seams and to place any new seam at the
highest point available. The project has two seams today and gains one.

**Existing, Feature tests.** `test/integration/`, Capybara over rack-test inside
`ActionDispatch::IntegrationTest`. Note these are feature tests despite the
directory name; there is no `ActionDispatch::SystemTestCase` and no browser
driver anywhere in the project. This is the seam for anything a Member or
Organiser can see, including the Code of Conduct page, which has no coverage at
present. Adding it also gives `PagesController` its first coverage, since
`code-of-conduct` and `participate` render implicitly with no action defined.

**Existing, Unit tests.** `test/models/` and `test/helpers/`. Objects exercised
directly. This is the seam for everything else, and where the known coverage
gaps live.

**New, exactly one: `bin/deploy`'s own contract.** The wrapper is exercised as a
subprocess, asserting the safety interlock: invoking it with no Destination
fails, and invoking it with an unknown Destination fails. This is the highest
point at which that behaviour exists. It does not deploy anything. It runs in
the units task, with `bin/` excluded from coverage.

**Deliberately not covered by the suite**: the `release.yml` trigger change,
verified by observing that no run fires on the next merge; and
`config/deploy.production.yml`, verified with `bin/kamal config -d production`.
Both are one-off confirmations, not regressions worth automating.

### Modules to be tested

Known gaps, each its own slice, in the order they are worth closing. Issue
numbers are the existing tracker items that cover them.

| Gap | Where | Issue |
| --- | --- | --- |
| Empty test class, zero assertions | `test/models/location_test.rb` | #84 |
| Broken `online` fixture, blocks the above | `test/fixtures/events.yml` | #80 |
| No test file; 7 methods, all used in views | `app/helpers/application_helper.rb` | #87 |
| `render_markdown` calls `html_safe` on Member-supplied markdown | `app/helpers/application_helper.rb` | #87 |
| Validations beyond `authenticate` untested | `app/models/user.rb` | #83 |
| `to_param` exercised only via pages | `app/models/concerns/slugged.rb` | none |
| `upcoming` and `previous` exercised only via pages | `app/models/event.rb` | none |
| `location_for` online branch unreached | `app/controllers/events_controller.rb` | #85 |

The final row is the one gap on the controller side. The only Feature test
covering the calendar feed uses an Event with a Venue, so the `"Online"` branch
never runs. Issue #85 proposes extracting the feed into an `EventCalendar`
object, which gives that branch a better home than the controller and is the
reason this gap is closed by extraction rather than by another Feature test.

## Out of Scope

- **Migrating to RSpec.** Explicitly rejected; see Implementation Decisions.
- **A staging Destination.** One Destination exists and one is enough. A second
  host and database is real recurring cost and maintenance for a volunteer site
  that ships a few times a year. The design leaves the door open.
- **Restoring automated deploy on merge.** Deferred, not abandoned. The workflow
  stays in the repository and can be reconnected once the manual path is proven
  and a green build is required to merge.
- **Renaming models as a standalone piece of work.** Renames ride along with
  slices that touch the code anyway.
- **Style and code-quality enforcement, and strict loading.** Deferred until
  after the coverage gate, for the reasons given above.
- **The Ruby version upgrade.** Its own slice, after the pipeline works.
- **Publishing an August meetup.** This is a content problem, not a code one. No
  slice here fixes it, and no amount of engineering will. Somebody has to either
  arrange and publish a Scheduled Event or agree that the site should say
  nothing is scheduled.
- **Rewriting the Code of Conduct's substance.** Repointing the dead link is in
  scope. Inlining a definition of unacceptable behaviour into the page, so it
  can never rot again, was considered and rejected for slice 1: it changes the
  group's stated policy, so it needs Tekin's agreement and would block a slice
  whose job is to prove the pipeline. Worth revisiting separately.
- **Issue #91's low-severity tidy-ups**, other than the reek configuration noted
  above. Redundant query, class-method privacy and explicit slug override are
  genuine but rank below everything sequenced here.

## Further Notes

### Slice sequence

Each slice is independently shippable. The "unblocks" column is the ordering
rule in practice: an infrastructure slice has to name what it makes possible.

**Slice 0. Establish deploy access.** A spike, no code. Confirm SSH as `ubuntu`
to `109.107.35.37`, a GHCR token with `write:packages` for `ghcr.io/nwrug`, and
the values of `SECRET_KEY_BASE`, `DB_HOST` and `NWRUG_DATABASE_PASSWORD`.
Everything is blocked on this. Output is either credentials in hand or a written
list of what to request from whom. *Unblocks: every slice below.*

**Slice 1. Make deploying deliberate, and prove it.** One PR: add `bin/deploy`
requiring a Destination; split `config/deploy.yml` into
`config/deploy.production.yml`; strip the `push` trigger from `release.yml`; fix
the dead Code of Conduct link (#70) to point at the Contributor Covenant
standards section. The trigger removal must be in the same PR as anything else,
so that merging cannot fire the unproven workflow at the live site. Then run
`bin/deploy production` and verify against the running site. Closes #70, half of
#72. *Unblocks: shipping anything at all.*

**Slice 2. Restore the CI signal.** One `bundle update`, closing #63, #68, #73
to #79. `bundler-audit` goes green and Brakeman runs for the first time since
2025. Merge #92 immediately behind it, since it is already green apart from the
pre-existing advisories. Optionally add `config.sandbox_by_default`. *Unblocks:
every future PR getting a trustworthy green tick; #86 builds on #92.*

**Slice 3. Make `bin/setup` work on a clean machine.** Handle the `mysql2` build
flag, fix the README, delete `.travis.yml` and `docs/server-setup.txt`, drop the
misleading `.gitignore` line. Add `bin/libyear` and print the number in CI
without failing on it. *Unblocks: a second volunteer contributing at all.*

**Slice 4. Coverage measurement, no gate.** SimpleCov, `rake test:features` and
`rake test:units`, merging off, `track_files` set, `bin/rake` running both,
`test/controllers/` deleted. Reports numbers, fails nothing. *Unblocks: knowing
which of the gaps below are real.*

**Slice 5. Delete `app/helpers/sessions_helper.rb`.** Dead code that can never be
covered. *Unblocks: 100% being arithmetically reachable.*

**Slice 6. Venue model tests (#84), fixing the broken `online` fixture (#80)
first.** The fixture bug has to go first or the tests are written against a lie.

**Slice 7. ApplicationHelper tests and markdown sanitisation (#87).** This one is
Member-facing security, not just coverage: `render_markdown` currently marks
rendered Member-supplied markdown as `html_safe`.

**Slice 8. Organiser validation tests (#83).** Email uniqueness and password
strength, with the database-level index it implies.

**Slice 9. Slug and scope Unit tests, plus unique indexes (#82).** Covers
`to_param` and the `upcoming`/`previous` scopes directly, and adds the database
constraint that the model-level uniqueness validation cannot guarantee alone.

**Slice 10. Extract `EventCalendar` (#85).** Moves the feed out of the
controller and gives the unreached `"Online"` branch a testable home.

**Slice 11. Turn the gate on.** Set `minimum_coverage 100` on both runs. Green
on arrival. *Unblocks: everything in the deferred list below.*

### After the gate

Now safe, in rough priority order. Timezone work first, since it is a live
correctness bug affecting Members:

- **#86, timezone-aware scopes**, paired with the Provisional Date wording fix.
  These belong together: #86 moves the boundary to UK midnight, and the wording
  fix stops a Provisional Date being presented as a Scheduled Event. Both change
  what a Member sees on the homepage.
- **#88, view-layer fixes.** Prerequisite for strict loading, since it removes
  the query from the form partial.
- **`strict_loading_by_default`**, once #88 has landed and the gate can catch it.
- **#81, runtime guards** for stale sessions and an empty database.
- **#89, content security policy**, and **#90, moving the Google Maps API key
  out of source**.
- **#71, social sharing**, and **#69, stale IRC contact details**.
- **#67, Ruby 3.4.8 and Bundler 4.**
- **Rubocop, and #91's reek configuration**, last, since a formatter's diff is
  safest under complete coverage.

### Evidence log

These are the findings that are expensive to rediscover and easy to
misinterpret. Each is stated with the check that produced it, so a future
session can re-verify rather than re-derive. All were true on 2026-08-07.

1. **CI is not broken in the way it appears.** The `test` job passes (45 runs,
   72 assertions, 0 failures on #92). Only the `lint` job fails, at the
   `bundler-audit` step, which exits 1 before Brakeman runs. Flagged: `uri`
   1.0.3, `websocket-driver` 0.8.0, `rails-html-sanitizer` 1.6.2, `rack-session`.
   Check: `gh run list --workflow=test-suite.yml --limit 3` then
   `gh run view <id> --log-failed`.
2. **`main` has not moved since 2025-07-24**, commit `ebebdbd`. Roughly twelve
   and a half months of stall. Check: `git log -5 --format='%h %ad %s' --date=short`.
3. **`release.yml` has run exactly once, on 2025-07-24, and failed.** Its logs
   have since expired (HTTP 410). Automated deployment has never succeeded, on
   any commit. Check: `gh run list --workflow=release.yml --limit 10`.
4. **Production was nonetheless deployed by hand.** The live feed contains a
   `VTIMEZONE` block, `DESCRIPTION`, `SOURCE` and `REFRESH-INTERVAL`, all
   introduced in commits `3bb7f76` to `84723cb` dated 2025-05-09, which
   `release.yml` never shipped. Somebody ran Kamal manually. Check:
   `curl -s https://nwrug.org/events.ics | head -30`.
5. **Production is roughly `986b695`, one commit behind `main`**, missing only
   the dependency bump `6fc58d9`. Follows from findings 3 and 4.
6. **The deploy target is correct and alive.** `nwrug.org` resolves to
   `109.107.35.37`, the address in `config/deploy.yml`, and serves Rails over
   HTTPS with HSTS, so Kamal's proxy and its Let's Encrypt certificate are
   working. Check: `dig +short nwrug.org A` and `curl -sS -I https://nwrug.org`.
7. **`bin/setup` does not work on a clean machine, and the reason is
   invisible.** The working machine carries an untracked `.bundle/config`
   holding
   `BUNDLE_BUILD__MYSQL2: "--with-mysql-config=/opt/homebrew/opt/mysql-client/bin/mysql_config"`.
   `mysql-client` is keg-only on Homebrew, so without that flag the `mysql2`
   native extension fails to build. `/.bundle` is gitignored, so a fresh clone
   does not get it, and `README.md` says only that MySQL must be installed and
   running. This is the single most expensive finding to rediscover. Check:
   `cat .bundle/config` and `git ls-files .bundle/`.
8. **`config/database.yml` is listed in `.gitignore` but is still tracked**,
   because it was committed before the ignore rule was added. It is therefore
   present on a fresh clone, and CI works. Misleading but harmless. Check:
   `git ls-files --error-unmatch config/database.yml`. Do not trust `.gitignore`
   here.
9. **`config/environments/test.rb` line 16 reads
   `config.eager_load = ENV["CI"].present?`.** Coverage will therefore disagree
   between a Maintainer's machine and CI unless `track_files` is set explicitly.
10. **`app/helpers/sessions_helper.rb` is an empty module referenced nowhere.**
    It cannot be covered and must be deleted for 100% to be reachable. Check:
    `grep -rn SessionsHelper app/ test/`.
11. **There is no Scheduled Event in the future.** The homepage shows
    "Next Event: Thursday 20th August", which is a Provisional Date, and
    `ul#upcoming-events` on the events page is empty. The most recent Event in
    the feed was 2026-07-16. Check: `curl -s https://nwrug.org/ | grep -i "next event"`.
    This may well have changed by the time you read it, and if it has, that is
    good news rather than a stale finding.
12. **`citizencodeofconduct.org` no longer resolves at DNS level.** The domain
    is gone entirely, not merely erroring. It is linked from
    `app/views/pages/code-of-conduct.html.erb` on the phrase "harassing
    behaviour". The chosen replacement is
    <https://www.contributor-covenant.org/version/2/1/code_of_conduct/#our-standards>,
    which returns 200. Check: `dig +short citizencodeofconduct.org`.
13. **`release.yml` contains two further defects** beyond its trigger:
    `SERVER_ADDR: 109.107.35.37` is set and never referenced, and
    `BUNDLE_WITHOUT: “default development test production profiling”` uses
    typographic quotation marks, so it will not be parsed as intended. Slice 1
    only removes the trigger; both of these matter whenever automated deployment
    is reconnected.
14. **PR #92 references issue numbers that do not exist.** Its description cites
    "issue 001", "002" and "004" from a local numbering scheme used in an
    earlier working session, which does not map to the GitHub tracker. Its "004"
    is issue #86. Worth reconciling so the references are not followed to the
    wrong place.
15. **Twelve of the sixteen open issues came from a single audit** (#80 to #91,
    labelled `audit`) and already carry severity and category labels. Only #69,
    #70, #71 and #72 are unlabelled. The backlog is less untriaged than it first
    appears.
16. **The application is 307 lines of Ruby** across controllers, models,
    concerns and helpers, with 42 local tests passing. This is a small codebase,
    and estimates should reflect that. Check: `wc -l app/**/*.rb` and `bin/rake`.

### Decisions awaiting a Maintainer

- **Deploy credentials.** Slice 0 exists because it is unknown whether SSH
  access to `ubuntu@109.107.35.37`, a `ghcr.io/nwrug` token with
  `write:packages`, and the values of `SECRET_KEY_BASE`, `DB_HOST` and
  `NWRUG_DATABASE_PASSWORD` are available. If they are not, obtaining them is
  the real first task and may involve somebody other than the person reading
  this, most likely Tekin. Note that deploying with a different
  `SECRET_KEY_BASE` than the running container invalidates signed cookies, which
  here only signs out Organisers, so it is survivable but worth knowing.
- **Requiring a green build to merge.** Recommended immediately after slice 2,
  which is the moment it becomes free. Not yet agreed.
- **Two architecture decision records look justified**, on the grounds that both
  are hard to reverse, surprising without context, and the result of a genuine
  trade-off: that deploying is a human-run command rather than an automated
  consequence of merging, in a repository that visibly contains a release
  workflow; and that controllers are proven only by Feature tests while
  everything else is proven only by Unit tests, which becomes difficult to
  unpick once the gate is on. Neither has been written.
- **The August meetup.** See Out of Scope. This needs an Organiser, not a
  Maintainer.
