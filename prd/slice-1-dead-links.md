# Slice 1: Dead Links on the Static Pages

**Written**: 2026-08-10. **Parent**: `prd/nwrug-recovery.md`, slice 1.
**Vocabulary**: see `CONTEXT.md` at the repo root.

> This is a slice PRD. The umbrella document is the source of truth for
> sequencing, evidence and decisions that span slices. Read its "Evidence log"
> if anything here seems surprising.

## Problem Statement

Two of the links NWRUG asks Members to follow lead nowhere, and both of them
lead nowhere in the most damaging place they could.

A Member reading the Code of Conduct is told to refrain from "harassing
behaviour", with those words linked to a definition of what that means. The
domain hosting that definition no longer exists at DNS level. So the one
sentence in the document that tells a Member what standard they are being held
to is the one sentence they cannot read. A Member who clicks it learns two
things: that they still do not know what counts as unacceptable, and that
nobody has checked this page in years. On a Code of Conduct, the second lesson
is worse than the first.

A Member reading the participation page, working up the nerve to offer a talk,
finds a reading list of advice for new speakers. One of those five links,
"Tips for new speakers", is also dead at DNS level. The page exists to lower
the barrier to speaking, and instead it demonstrates that the group's own
advice has rotted.

Neither page is protected by anything. The Code of Conduct is visited by no
test in the suite, so any change that breaks it ships silently. Nothing in the
project checks whether an outbound link still resolves, so this will happen
again and nobody will notice again.

There is also a smaller Maintainer problem riding along. The release workflow
carries two defects that have never broken a deploy but make it harder to read:
a server address that is set and never referenced, and a list of Bundler groups
wrapped in typographic quotation marks, so it excludes nothing it appears to
name. Both were noticed while diagnosing the deploy failure and are cheapest to
fix while they are still fresh.

## Solution

Repoint both dead links at pinned Internet Archive captures of the original
pages, so the words a Member is asked to read are the words the group actually
chose. Cover the Code of Conduct with a Feature test so the page cannot break
unnoticed. Tidy the two release workflow defects.

The choice to archive rather than substitute is deliberate and is the most
consequential decision in this slice. The obvious alternative for the Code of
Conduct is to link the Contributor Covenant, which is alive and maintained.
That would change which document defines unacceptable behaviour for NWRUG,
which is a change to the group's stated policy, and policy is not a Maintainer's
to change in a link-fixing pull request. Archiving preserves the standard
exactly as it was. Adopting the Contributor Covenant properly remains open and
is recorded in the umbrella as a decision awaiting a Maintainer.

Both archive links pin an explicit timestamp. This is not stylistic. The
"Tips for new speakers" site sat behind a bot check from mid-2022, and the
Internet Archive faithfully captured the "One moment, please..." verification
screen instead of the article. Those captures are about 1.2 KB against about
21 KB for the real page, and they are what Wayback's undated "newest" form
resolves to. An unpinned link would send Members to a verification screen.

## User Stories

### Members

1. As a Member, I want the Code of Conduct's definition of unacceptable behaviour to be readable, so that I know what standard I am being held to.
2. As a Member, I want the definition I am shown to be the one NWRUG actually adopted, so that the rules are not quietly rewritten while I am not looking.
3. As a Member, I want every link on the Code of Conduct to resolve, so that I can trust the group takes its own document seriously.
4. As a Member, I want a link that resolves to land on the content it promises, so that I am not sent to a verification screen or a parked domain.
5. As a Member, I want a deep link into a section to still land on that section, so that I am not left to search a long document for the paragraph that was meant.
6. As a Member, I want to know who to contact about an incident, so that I can report something safely.
7. As a Member considering giving a talk, I want the participation page's reading list to work, so that the advice offered to me is advice I can actually read.
8. As a Member, I want the participation page to describe accurately how to get involved, so that I can offer a talk or sponsorship.
9. As a Member, I want the group's older recommendations preserved rather than deleted when their source disappears, so that advice worth keeping is not lost to link rot.
10. As a Member, I want the site to stay up while it is being changed, so that my visit is not the one that hits a broken deploy.

### Maintainers

11. As a Maintainer, I want the Code of Conduct exercised by a Feature test, so that a change which breaks the page fails the build rather than reaching Members.
12. As a Maintainer, I want the test to prove the page renders as a Member sees it, rather than that a controller action ran, so that it survives a change in how the page is produced.
13. As a Maintainer, I want a test that pins the replaced link to be labelled as a pinning test, so that a future reader does not mistake it for a regression test that once failed.
14. As a Maintainer, I want to know which external links on the site are dead, so that I am fixing a known list rather than discovering rot one Member complaint at a time.
15. As a Maintainer, I want the reason for archiving rather than substituting written down, so that the next person does not "improve" it into a policy change.
16. As a Maintainer, I want the timestamp-pinning rule recorded, so that nobody replaces a pinned capture with an undated one and silently reintroduces the bot-check page.
17. As a Maintainer, I want the release workflow to contain no configuration that does nothing, so that reading it tells me what actually happens.
18. As a Maintainer, I want the release workflow's Bundler group exclusions to mean what they say, so that a future change to them behaves as expected.
19. As a Maintainer, I want this slice to ship without waiting on the dependency backlog, so that a Member-facing fix is not held hostage to an infrastructure slice.
20. As a Maintainer, I want to know that this slice's build will be red for reasons that predate it, so that I merge it knowingly rather than treating red as normal.
21. As a Maintainer, I want the parent PRD corrected where this slice proves it wrong, so that the umbrella stays trustworthy.

## Implementation Decisions

### The Code of Conduct link

- The phrase "harassing behaviour" keeps its link and its surrounding wording.
  Only the target changes.
- The target becomes a **timestamp-pinned Internet Archive capture of the
  Citizen Code of Conduct**, retaining the `#unacceptable-behavior` fragment,
  which the capture preserves and which still lands on section 4:
  `https://web.archive.org/web/20200330154000/http://citizencodeofconduct.org/#unacceptable-behavior`
- The document's substance is not touched. No wording changes, no inlining of a
  definition, no change of which code of conduct NWRUG follows.

### The participation page link

- The "Tips for new speakers" entry keeps its link text and its description.
  Only the target changes.
- The target becomes a **timestamp-pinned Internet Archive capture** of the
  original article, "Tips for new speakers: Part 1" by Bill, published
  20 June 2016:
  `https://web.archive.org/web/20220630231506/http://rethink-testing.co.uk/?p=158`
- The capture chosen is the most recent one that is the article rather than the
  bot-check interstitial. Later captures return HTTP 200 but contain a
  verification screen, so recency alone is not a safe selection rule.
- Parts 2 and 3 of the series are also archived and are deliberately **not**
  added. Adding them changes what the page recommends, which is a content
  decision rather than a repair. Their capture timestamps are recorded in the
  umbrella so the option stays open.

### Link rot generally

- No automated link checking is introduced. A scheduled checker on a volunteer
  site that ships a few times a year would produce alerts nobody is on duty to
  read, which is the same failure this project is recovering from in a new
  costume. The full sweep of external links performed while scoping this slice
  is recorded in the umbrella's evidence log instead, so the next person starts
  from a list rather than from scratch.
- That sweep found exactly two dead domains. Two further links return HTTP 403
  to an automated request; both are bot-blocking rather than rot and are left
  alone.

### The release workflow

- The workflow-level environment variable holding the server address is
  **removed**. It is set and referenced nowhere; the address that matters lives
  in the deploy configuration.
- The Bundler group exclusion list is corrected to use **straight quotation
  marks**. It currently uses typographic quotation marks, so the value is a
  single string containing curly quotes and does not exclude the groups it
  names. This has never broken a deploy, and correcting it is not expected to
  change behaviour; it is corrected so the file stops lying about its intent.
- Nothing else in the workflow changes. In particular the trigger on pushes to
  the default branch stays, per the umbrella's Deployment decisions.

### Parent PRD corrections

The umbrella claims the Code of Conduct and participation pages have no
coverage, and that this slice gives the pages controller its first coverage.
Both claims are wrong and are corrected in the same pull request:

- The participation page is already visited by an existing Feature test, which
  asserts the Provisional Date wording.
- The pages controller declares a single empty action for the homepage; the two
  static pages have no actions and render implicitly. There is no meaningful
  controller coverage to gain.
- The genuine gap is that the Code of Conduct page is visited by no test.

The umbrella's slice 0 entry is also updated to record that a push-triggered
deploy was proven, not only a manually dispatched one.

## Testing Decisions

### What makes a good test here

A test should describe behaviour a Member could observe and should survive a
change in how that behaviour is produced. It asserts what a Member sees on the
page, not that a controller action was invoked or that a particular template was
selected. Because the test helper loads all fixtures, assertions check for the
presence of what is expected rather than comparing whole collections.

### Seam

**No new seam.** This slice uses the project's existing Feature test seam:
Capybara driving the application over rack-test inside an integration test case.
That is the highest point at which a Member's experience of a static page
exists, and it is the only seam through which these pages can be reached at all,
since neither page has a controller action or a model behind it.

The project has two seams, Feature tests and Unit tests, and this slice adds
neither. The umbrella's earlier proposal of a third seam, for a deploy wrapper's
contract, is void because that wrapper is no longer being written.

### Prior art

`test/integration/next_event_details_test.rb` is the closest example and should
be read first. It is short, it visits pages by named route helper, and it
asserts on rendered content and on links by their visible text and target. Its
third test already visits the participation page. `test/integration/` holds four
further examples covering authentication, event administration, quiz
administration and viewing event details.

### What will be tested

- **The Code of Conduct page renders.** A Member can visit it and see the
  document. This is the coverage that does not exist today and is the substance
  of the slice's testing value.
- **The Code of Conduct's "harassing behaviour" link points at the archived
  definition.** This is a **pinning test**, not a regression test. It could not
  be made to fail before the fix in any meaningful sense, because the previous
  target was equally present in the markup and equally assertable; what changed
  is that the old target does not resolve, and resolution is not something a
  Feature test can observe. The test is worth having because it stops the link
  being replaced casually, and the pull request description should say so
  plainly rather than overclaim. The existing pull request against the Event
  model is the prior art for making that distinction honestly.
- **The participation page's "Tips for new speakers" link points at the archived
  article.** Same character: a pinning test, added alongside the existing
  coverage of that page rather than replacing it.

### What will not be tested

- **That the archived URLs resolve.** A Feature test cannot make a network
  request, and a test that could would be a test of the Internet Archive's
  uptime rather than of NWRUG's site. Both captures were verified by hand when
  this slice was scoped, and the verification is recorded in the umbrella.
- **The release workflow changes.** Removing an unreferenced variable and
  correcting quotation marks are confirmed by the next deploy succeeding, which
  happens on merge. This is a one-off confirmation, not a regression worth
  automating.

## Out of Scope

- **Adopting the Contributor Covenant**, or any other change to which code of
  conduct NWRUG follows. That is a policy change and needs the group's
  agreement. Recorded in the umbrella as a decision awaiting a Maintainer.
- **Inlining a definition of unacceptable behaviour** into the page so it can
  never rot again. Same reason: it changes the stated policy.
- **Rewriting any of the Code of Conduct's substance**, including its list of
  expected behaviours and its contact details.
- **Adding Parts 2 and 3 of "Tips for new speakers"**, or otherwise revising
  what the participation page recommends.
- **Automated link checking**, scheduled or in CI. See Implementation
  Decisions.
- **The two links that return HTTP 403 to automated requests.** They are
  bot-blocking, not rot, and work in a browser.
- **The stale contact details issue** covering abandoned channels. It is
  separately tracked and sequenced after the coverage gate.
- **Everything in the dependency backlog.** The build will be red on the
  dependency audit step when this slice is raised, for reasons that predate it
  and that the next slice fixes. This slice is merged knowingly red rather than
  waiting, because it is Member-facing and independent.
- **Coverage measurement and any coverage gate.** Introduced later in the
  umbrella's sequence. This slice adds tests because the page needs protecting,
  not to move a number.

## Further Notes

### Why this slice is small

The umbrella's original slice 1 was much larger: a deploy wrapper requiring a
named Destination, a split deploy configuration, and the removal of the
automatic deploy trigger, with the Code of Conduct fix carried along as a
Member-facing payload so that proving the pipeline and delivering value were the
same commit. Carrying out slice 0 showed that the pipeline never needed proving
in that way, and that each piece of the machinery was either unnecessary or
actively harmful. What remains is the payload, which was always the part a
Member would notice.

### Expected build state

The dependency audit step in CI fails on advisories that predate this work, so
the lint job will be red. The test job should pass. A red lint job on this pull
request is expected and is not evidence of a problem with the change.

### Deploying

Merging to the default branch deploys automatically and takes about two minutes.
The change is confined to two anchor targets, one workflow file and one test, so
the blast radius is small, but it does reach Members as soon as it merges.

### Suggested follow-up

Once the dependency backlog is cleared and a green build is required to merge,
the argument for automated link checking becomes stronger, because there would
finally be a signal somebody trusts. It is still likely to be the wrong tool for
a site that changes a few times a year, but it is worth reconsidering at that
point rather than never.
