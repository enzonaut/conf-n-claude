---
name: verify-before-claiming-progress
description: "User wants evidence of progress, not assumed/narrated status"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 28a8ff7d-a440-47f7-bd36-d85f0febd520
---

When reporting that a long-running or external process is happening (downloads, builds, installs), the user pushed back hard on status I had only assumed — e.g. I said Xcode was "still downloading" when it had never started, and they asked "were you guessing?"

**Why:** They lose trust when I narrate state as fact without verifying it. They explicitly asked me to "show something is happening."

**How to apply:** Only assert a process is running if I've verified it (process list, log mtime ticking, files growing on disk, exit codes). When I can't verify, say so plainly ("I can't tell if it started"). When they doubt progress, show concrete proof: `ps aux`, log tail with timestamps, file counts — not reassurance.
