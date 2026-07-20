|                                                                                              | c4cf1e57e0bb79...  |
|:---------------------------------------------------------------------------------------------|:------------------:|
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ForwardDiff            | 21.7 ± 7.9 μs      |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake forward       | 0.207 ± 0.024 ms   |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake reverse       | 1.18 ± 0.049 ms    |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ReverseDiff (tape)     | 0.763 ± 0.16 ms    |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ForwardDiff                     | 6.15 ± 1.2 μs      |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake forward                | 26.1 ± 6 μs        |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake reverse                | 0.308 ± 0.025 ms   |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ReverseDiff (tape)              | 0.316 ± 0.057 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme forward                | 9.86 ± 1.5 μs      |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme reverse                | 0.308 ± 0.04 ms    |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ForwardDiff                   | 6.18 ± 1.1 μs      |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake forward              | 26.2 ± 6.1 μs      |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake reverse              | 0.306 ± 0.026 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ReverseDiff (tape)            | 0.317 ± 0.059 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme forward                | 10.3 ± 4 μs        |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme reverse                | 0.305 ± 0.024 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ForwardDiff                   | 8.18 ± 0.89 μs     |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake forward              | 0.0383 ± 0.012 ms  |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake reverse              | 0.433 ± 0.14 ms    |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ReverseDiff (tape)            | 0.748 ± 0.15 ms    |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme forward     | 27.5 ± 3.3 μs      |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme reverse     | 0.125 ± 0.0079 ms  |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ForwardDiff        | 17.1 ± 0.71 μs     |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake forward   | 0.0629 ± 0.0044 ms |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake reverse   | 0.333 ± 0.06 ms    |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ReverseDiff (tape) | 2.72 ± 0.55 ms     |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme forward                | 25.5 ± 11 μs       |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme reverse                | 0.308 ± 0.021 ms   |
| AD gradients/matrix_exp/transition_probability direct gradient/ForwardDiff                   | 13.1 ± 0.56 μs     |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake forward              | 0.0762 ± 0.01 ms   |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake reverse              | 0.416 ± 0.14 ms    |
| AD gradients/matrix_exp/transition_probability direct gradient/ReverseDiff (tape)            | 0.741 ± 0.15 ms    |
| AD gradients/ode_problem solve survival gradient (PhaseType)/ForwardDiff                     | 0.286 ± 0.0099 ms  |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/Enzyme forward          | 17.1 ± 0.84 ms     |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/ForwardDiff             | 0.287 ± 0.01 ms    |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme forward                      | 5.88 ± 0.1 μs      |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme reverse                      | 1.37 ± 0.047 μs    |
| AD gradients/phase_type hyperexponential (α, S) gradient/ForwardDiff                         | 0.52 ± 0.12 μs     |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake forward                    | 10.5 ± 0.51 μs     |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake reverse                    | 14.1 ± 0.68 μs     |
| AD gradients/phase_type hyperexponential (α, S) gradient/ReverseDiff (tape)                  | 7.98 ± 0.26 μs     |
| Bridges/jump_problem (JumpProcesses)                                                         | 1.28 ± 0.11 μs     |
| Bridges/ode_problem (SciMLBase)                                                              | 0.161 ± 0.0049 ms  |
| Bridges/reaction_system (Catalyst)                                                           | 0.0579 ± 0.0018 ms |
| Evaluation/ctmc builder + transition_probability                                             | 5.36 ± 1.1 μs      |
| Evaluation/phase-type matrix_exp                                                             | 4.51 ± 1.9 μs      |
| Lowering/canonical(Erlang branch)                                                            | 0.163 ± 0.043 μs   |
| Lowering/canonical(PhaseType branch)                                                         | 0.14 ± 0.049 μs    |
| Lowering/canonical(fixed phases)                                                             | 0.214 ± 0.03 μs    |
| Lowering/lower(Exponential)                                                                  | 1.45 ± 0.059 μs    |
| Lowering/lower(Gamma, Erlang branch)                                                         | 0.0529 ± 0.029 μs  |
| Lowering/lower(Gamma, PhaseType branch)                                                      | 0.148 ± 0.063 μs   |
| time_to_load                                                                                 | 0.49 ± 0.0028 s    |

|                                                                                              | c4cf1e57e0bb79...         |
|:---------------------------------------------------------------------------------------------|:-------------------------:|
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ForwardDiff            | 0.22 k allocs: 26.3 kB    |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake forward       | 2.8 k allocs: 0.123 MB    |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake reverse       | 8.45 k allocs: 0.79 MB    |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ReverseDiff (tape)     | 8.96 k allocs: 0.371 MB   |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ForwardDiff                     | 0.125 k allocs: 8.48 kB   |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake forward                | 0.591 k allocs: 0.0316 MB |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake reverse                | 2.58 k allocs: 0.276 MB   |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ReverseDiff (tape)              | 3.78 k allocs: 0.156 MB   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme forward                | 0.261 k allocs: 13.7 kB   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme reverse                | 0.651 k allocs: 0.0715 MB |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ForwardDiff                   | 0.125 k allocs: 8.48 kB   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake forward              | 0.588 k allocs: 0.0315 MB |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake reverse              | 2.56 k allocs: 0.275 MB   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ReverseDiff (tape)            | 3.78 k allocs: 0.156 MB   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme forward                | 0.245 k allocs: 16.1 kB   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme reverse                | 0.631 k allocs: 0.0727 MB |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ForwardDiff                   | 0.117 k allocs: 12.1 kB   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake forward              | 0.556 k allocs: 0.0363 MB |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake reverse              | 3.12 k allocs: 0.571 MB   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ReverseDiff (tape)            | 8.87 k allocs: 0.367 MB   |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme forward     | 0.241 k allocs: 28.9 kB   |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme reverse     | 0.621 k allocs: 0.0874 MB |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ForwardDiff        | 0.115 k allocs: 25.8 kB   |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake forward   | 0.548 k allocs: 0.0613 MB |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake reverse   | 1.87 k allocs: 0.358 MB   |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ReverseDiff (tape) | 0.033 M allocs: 1.41 MB   |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme forward                | 0.496 k allocs: 0.0319 MB |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme reverse                | 0.65 k allocs: 0.0721 MB  |
| AD gradients/matrix_exp/transition_probability direct gradient/ForwardDiff                   | 0.123 k allocs: 21.7 kB   |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake forward              | 1.05 k allocs: 0.0694 MB  |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake reverse              | 2.99 k allocs: 0.563 MB   |
| AD gradients/matrix_exp/transition_probability direct gradient/ReverseDiff (tape)            | 8.86 k allocs: 0.367 MB   |
| AD gradients/ode_problem solve survival gradient (PhaseType)/ForwardDiff                     | 0.666 k allocs: 0.0489 MB |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/Enzyme forward          | 0.0548 M allocs: 2.35 MB  |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/ForwardDiff             | 0.674 k allocs: 0.0493 MB |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme forward                      | 29  allocs: 1.06 kB       |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme reverse                      | 18  allocs: 0.656 kB      |
| AD gradients/phase_type hyperexponential (α, S) gradient/ForwardDiff                         | 9  allocs: 0.406 kB       |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake forward                    | 0.124 k allocs: 7.08 kB   |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake reverse                    | 0.204 k allocs: 10.3 kB   |
| AD gradients/phase_type hyperexponential (α, S) gradient/ReverseDiff (tape)                  | 0.123 k allocs: 4.84 kB   |
| Bridges/jump_problem (JumpProcesses)                                                         | 0.052 k allocs: 2.38 kB   |
| Bridges/ode_problem (SciMLBase)                                                              | 0.596 k allocs: 0.0446 MB |
| Bridges/reaction_system (Catalyst)                                                           | 0.68 k allocs: 25.7 kB    |
| Evaluation/ctmc builder + transition_probability                                             | 0.11 k allocs: 7.69 kB    |
| Evaluation/phase-type matrix_exp                                                             | 0.114 k allocs: 6.22 kB   |
| Lowering/canonical(Erlang branch)                                                            | 4  allocs: 0.219 kB       |
| Lowering/canonical(PhaseType branch)                                                         | 4  allocs: 0.188 kB       |
| Lowering/canonical(fixed phases)                                                             | 4  allocs: 0.359 kB       |
| Lowering/lower(Exponential)                                                                  | 15  allocs: 0.797 kB      |
| Lowering/lower(Gamma, Erlang branch)                                                         | 3  allocs: 0.0938 kB      |
| Lowering/lower(Gamma, PhaseType branch)                                                      | 5  allocs: 0.219 kB       |
| time_to_load                                                                                 | 0.149 k allocs: 11.2 kB   |

