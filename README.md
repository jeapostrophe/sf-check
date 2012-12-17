sf-check
========

sf-check is a semi-automated grading system for select chapters of Software Foundations. Its semi-
automated (as opposed to fully-automated) nature comes from the two classes of exercises found in
Software Foundations.

The first class consists solely of SF-provided boilerplate definitions/theorems/etc. that must be 
filled in by the student. These exercises are graded automatically by running `coqc`. An exercise 
receives credit only if all exercise parts are soundly accepted by Coq.

The second class has some component which must be graded manually. This may involve writing a 
definition or proving a proposition from scratch, or composing an informal proof or something 
otherwise foreign to Coq. In any case, certain parts must be defined in Coq to flag the exercise 
for manual grading. This is explained in more depth later.

The grading system assumes the existence of a directory hierarchy

    students/<student-name>/<turnin>/<chapter>.v

where *student-name* is arbitrary, *turnin* is one of `0.0`, `0.5`, `1.0`, ..., `15.0`, and *chapter* 
exactly matches one of the 15 chapters in the course.

Grades are calculated by running

    racket coq.rkt [<depth>]

where *depth* can be 0-3 and defaults to 0. The *depth* parameter refers to the depth of the report 
where values correspond to the following point breakdowns

    0 - semester
    1 - turnin
    2 - chapter
    3 - exercise

The local grade given will almost certainly be less than the actual grade if exercises with a manual 
component have been completed. Any such exercises will be noted by the system.

Output roughly follows the format

    <student-name>              <grade>
    total             <semester-points>
      <turnin>          <turnin-points>
        <chapter>      <chapter-points>
        ...
      ...
      <flagged-exercise>
      ...

where *semester-grade* * 100 gives the percentage from which the letter grade is determined, and 
*X-points* is the point contribution of the corresponding *X*.

Exercises are worth a number of points proportional to the expected investment of time, as given in the 
introduction to SF. Lateness is penalized 10% of the remaining possible points per week sensitive to 
half-week intervals.

If an exercise appears in multiple turnins, only the earliest contributes points. This permits the 
natural workflow of keeping a working directory of chapters and copying a chapter-in-progress to 
the present turnin when submitting, ensuring that the local hierarchy mirrors the instructor's as 
much as possible.

## Curriculum

The `curriculum.sexp` file contains exercise information for each chapter. Exercise entries match the 
following pattern:

    (<name> <difficulty> <designation> <manual?> (<part-name> ...))

*name* is the name of the exercise given by the text, the name of the first part if no proper name is 
given, or `#f` if the exercise has no parts.

*difficulty* is the number of stars given by the text, or `#f` if none is given.

*designation* is the `optional`, `recommended`, or `extended` designation given by the text, or `#f` if 
absent. This field is ignored by this grading system.

*manual?* specifies whether this exercise has a component that requires manual grading. An exercise with 
such a component will not be flagged for grading unless every part of the exercise is soundly defined. 
For exercises with no Coq component, a dummy definition or proposition named after the exercise itself 
should be proven, perhaps like:

    Fact <name>: true = true.
    Proof. reflexivity. Qed.

`(*part-name* ...)` is a list of the parts that comprise the exercise. For <manual?> exercises, this is 
often a singleton list which item has the same name as the exercise itself. In such cases, a proposition 
with this name is seldom found in the text, but should be added, as in the *manual?* description.
