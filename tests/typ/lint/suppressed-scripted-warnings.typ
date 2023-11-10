// Test suppression of warnings in transient files.
// Ref: false
// ValidateTransientDiagnostics: true
---
// ValidateTransientDiagnostics should make it possible to test this behaviour, so let's make sure that actually works.
#import "@test/warner:0.1.0": cause_warn

// Due to ValidateTransientDiagnostics, the location is not matching the location of the method call that causes the diagnostic,
// instead it matches the location in the (package) file that causes the diagnostic.
// Warning: 8-15 I am emitted
#cause_warn("I am emitted")

---
#import "@test/warner:0.1.0": cause_warn
#import "@test/warner:0.1.0" as warner
#nowarn(warner)

#cause_warn("I am not emitted")

---
#import "@test/second-warner:0.1.0" as unsuppressed
#import "@test/warner:0.1.0" as suppressed
#nowarn(suppressed)

#suppressed.cause_warn("I am not emitted")
// The line in the package is matching the line of the statement here by design, to help with the test setup (see first test case).
// Warning: 27-34 I am emitted
#unsuppressed.cause_warn("I am emitted")
