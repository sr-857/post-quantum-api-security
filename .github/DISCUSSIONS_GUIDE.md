# GitHub Discussions Configuration Guide

This repository uses GitHub Discussions for open-ended questions and
research conversation, reserving Issues for actionable bugs and feature
requests. This guide documents the recommended setup for maintainers
enabling Discussions on this repository.

## Enabling Discussions

1. Go to the repository **Settings** tab.
2. Under **Features**, check **Discussions**.
3. Click **Set up discussions** to initialize the default categories.

## Recommended Categories

Replace the default category set with the following, tailored to a
research repository:

| Category | Format | Purpose |
|---|---|---|
| **Announcements** | Announcement | Maintainer-only posts for new paper versions, Zenodo releases, major milestones |
| **Q&A** | Question/Answer | General questions about the paper's claims, methodology, or terminology |
| **Ideas** | Open-ended discussion | Suggestions for future research directions, not yet formalized as a Feature Request issue |
| **Show and Tell** | Open-ended discussion | Community members sharing related work, implementations, or citing usage |
| **General** | Open-ended discussion | Anything not covered above |

## Linking Discussions from Issues

The `.github/ISSUE_TEMPLATE/config.yml` file already links to
Discussions as a "contact link," steering open-ended questions away from
the Issues tracker. Ensure the URL in that file matches your repository's
actual Discussions URL after enabling the feature.

## Moderation Guidelines

Discussions are subject to the same [Code of Conduct](../CODE_OF_CONDUCT.md)
as the rest of the repository. Maintainers should:

- Pin the most recent **Announcements** post for visibility.
- Convert any bug reports or actionable feature requests posted in
  Discussions into proper Issues, using the templates in
  `.github/ISSUE_TEMPLATE/`, to keep tracked work in one place.
- Lock or archive stale discussion threads after major paper revisions
  that may have addressed the original question.

## Why Discussions Instead of Issues for Q&A

Research repositories tend to accumulate open-ended questions
("why did you choose ML-KEM-768 over ML-KEM-1024 for the default
recommendation?") that don't represent a bug or a concrete, scoped
feature request. Routing these to Discussions keeps the Issues tracker
focused on actionable work, consistent with the triage guidance in
[`CONTRIBUTING.md`](../CONTRIBUTING.md).
