# Azure Core Foundation Pull Request

<!--
> THIS TEMPLATE IS MANDATORY AND SHOULD BE COMPLETED IN FULL.

> Thank you for your contribution !
> Please include a summary of the change and which issue is fixed.
> Please also include the context.
> List any dependencies that are required for this change.

Fixes #123
Fixes #456
Closes #123
Closes #456
-->

## Description
<!-- Include a brief description of your current changes: -->

- Change #1

### Pipeline Reference

The following pipeline has completed, and this PR is ready for review:

<!-- Insert your Pipeline Status Badge below -->

| Pipeline |
| -------- |
|          |

### Type of Change

<!-- Use the checkboxes [x] on the options that are relevant. -->

- [ ] Update to CI Environment or utilities (Workflows or supporting Artifacts.)
- [ ] `main.bicep` Updates:
  - [ ] Bugfix:
    - [ ] Someone has opened a bug report issue, and I have included "Closes #{bug_report_issue_number}" in the PR description.
    - [ ] The bug was found by the author, and no one has opened an issue to report it yet.
  - [ ] Feature Updates (Change does not affect current deployed configuration but adds functionality e.g. A new resource is being added)
  - [ ] Breaking Change (Change effects existing configuration of active resources and should have an outage window.)


## Developer Checklist
As the active developer and author of this change, I have checked the below items, so I am compliant with the developer & good coding practices available to me.

- [ ] I'm sure there are no other open Pull Requests for the same update/change
- [ ] I have the appropriate work items attached to this PR using the #Closes or #Fixes feature above to support this change
- [ ] I have tested my code within a feature branch my corresponding pipelines / checks run clean and green without any errors or warnings
- [ ] The PR Title starts with one of the following items relevant to my change: `fix:`,`feat:`,`ci:`