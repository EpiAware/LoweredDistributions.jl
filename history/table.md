|                                                                                                   | 3db79a680b8e98...  |
|:--------------------------------------------------------------------------------------------------|:------------------:|
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ForwardDiff                 | 17.7 ± 6 μs        |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake forward            | 0.164 ± 0.016 ms   |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake reverse            | 0.987 ± 0.034 ms   |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ReverseDiff (tape)          | 0.595 ± 0.13 ms    |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme forward                        | 0.0642 ± 0.0051 ms |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme reverse                        | 0.323 ± 0.031 ms   |
| AD gradients/lower(composer) joint-CTMC transition gradient/ForwardDiff                           | 0.0317 ± 0.0032 ms |
| AD gradients/lower(composer) joint-CTMC transition gradient/Mooncake forward                      | 0.13 ± 0.01 ms     |
| AD gradients/lower(composer) joint-CTMC transition gradient/Mooncake reverse                      | 1.54 ± 0.18 ms     |
| AD gradients/lower(composer) joint-CTMC transition gradient/ReverseDiff (tape)                    | 2.04 ± 0.33 ms     |
| AD gradients/lower(composer) scalar-composer survival gradient/Enzyme forward                     | 0.0338 ± 0.0042 ms |
| AD gradients/lower(composer) scalar-composer survival gradient/Enzyme reverse                     | 0.499 ± 0.031 ms   |
| AD gradients/lower(composer) scalar-composer survival gradient/ForwardDiff                        | 15 ± 3.6 μs        |
| AD gradients/lower(composer) scalar-composer survival gradient/Mooncake forward                   | 0.0767 ± 0.013 ms  |
| AD gradients/lower(composer) scalar-composer survival gradient/Mooncake reverse                   | 1.26 ± 0.065 ms    |
| AD gradients/lower(composer) scalar-composer survival gradient/ReverseDiff (tape)                 | 0.613 ± 0.13 ms    |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme forward         | 12.6 ± 1.3 μs      |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme reverse         | 0.244 ± 0.016 ms   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ForwardDiff            | 6.83 ± 0.59 μs     |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake forward       | 0.0328 ± 0.01 ms   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake reverse       | 0.39 ± 0.098 ms    |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ReverseDiff (tape)     | 0.589 ± 0.13 ms    |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme forward     | 10 ± 3.6 μs        |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme reverse     | 0.234 ± 0.02 ms    |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ForwardDiff        | 4.16 ± 0.51 μs     |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake forward   | 20.9 ± 1.9 μs      |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake reverse   | 0.269 ± 0.022 ms   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ReverseDiff (tape) | 0.22 ± 0.045 ms    |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme forward                       | 10.5 ± 3.8 μs      |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme reverse                       | 0.231 ± 0.016 ms   |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ForwardDiff                          | 4.68 ± 0.66 μs     |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake forward                     | 21.8 ± 3.3 μs      |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake reverse                     | 0.245 ± 0.02 ms    |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ReverseDiff (tape)                   | 0.244 ± 0.051 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme forward                     | 10.3 ± 3.8 μs      |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme reverse                     | 0.231 ± 0.017 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ForwardDiff                        | 4.56 ± 0.75 μs     |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake forward                   | 22.4 ± 2.9 μs      |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake reverse                   | 0.252 ± 0.02 ms    |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ReverseDiff (tape)                 | 0.252 ± 0.052 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme forward                     | 12.4 ± 1.1 μs      |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme reverse                     | 0.231 ± 0.017 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ForwardDiff                        | 6.84 ± 0.57 μs     |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake forward                   | 0.0323 ± 0.0099 ms |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake reverse                   | 0.376 ± 0.096 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ReverseDiff (tape)                 | 0.588 ± 0.12 ms    |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme forward          | 19.6 ± 3 μs        |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme reverse          | 0.0942 ± 0.0098 ms |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ForwardDiff             | 14.8 ± 0.64 μs     |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake forward        | 0.0504 ± 0.0035 ms |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake reverse        | 0.277 ± 0.039 ms   |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ReverseDiff (tape)      | 2.14 ± 0.45 ms     |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme forward                     | 20.6 ± 9.4 μs      |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme reverse                     | 0.235 ± 0.019 ms   |
| AD gradients/matrix_exp/transition_probability direct gradient/ForwardDiff                        | 11 ± 0.65 μs       |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake forward                   | 0.0628 ± 0.0054 ms |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake reverse                   | 0.36 ± 0.097 ms    |
| AD gradients/matrix_exp/transition_probability direct gradient/ReverseDiff (tape)                 | 0.585 ± 0.12 ms    |
| AD gradients/ode_problem solve survival gradient (PhaseType)/Enzyme forward                       | 13.1 ± 0.66 ms     |
| AD gradients/ode_problem solve survival gradient (PhaseType)/ForwardDiff                          | 0.23 ± 0.0066 ms   |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/Enzyme forward               | 13 ± 0.71 ms       |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/ForwardDiff                  | 0.229 ± 0.0063 ms  |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme forward                           | 4.58 ± 0.087 μs    |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme reverse                           | 1.09 ± 0.046 μs    |
| AD gradients/phase_type hyperexponential (α, S) gradient/ForwardDiff                              | 0.434 ± 0.073 μs   |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake forward                         | 8.42 ± 0.32 μs     |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake reverse                         | 11.9 ± 0.67 μs     |
| AD gradients/phase_type hyperexponential (α, S) gradient/ReverseDiff (tape)                       | 6.31 ± 0.24 μs     |
| Bridges/jump_problem (JumpProcesses)                                                              | 1.38 ± 0.64 μs     |
| Bridges/ode_problem (SciMLBase)                                                                   | 0.127 ± 0.0038 ms  |
| Bridges/reaction_system (Catalyst)                                                                | 0.0477 ± 0.0019 ms |
| Evaluation/ctmc builder + transition_probability                                                  | 4.41 ± 0.72 μs     |
| Evaluation/phase-type matrix_exp                                                                  | 3.27 ± 1.9 μs      |
| Lowering/canonical(Erlang branch)                                                                 | 0.132 ± 0.035 μs   |
| Lowering/canonical(PhaseType branch)                                                              | 0.11 ± 0.048 μs    |
| Lowering/canonical(fixed phases)                                                                  | 0.178 ± 0.023 μs   |
| Lowering/lower(Exponential)                                                                       | 1.24 ± 0.056 μs    |
| Lowering/lower(Gamma, Erlang branch)                                                              | 0.0406 ± 0.022 μs  |
| Lowering/lower(Gamma, PhaseType branch)                                                           | 0.11 ± 0.051 μs    |
| time_to_load                                                                                      | 0.387 ± 0.0009 s   |

|                                                                                                   | 3db79a680b8e98...         |
|:--------------------------------------------------------------------------------------------------|:-------------------------:|
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ForwardDiff                 | 0.22 k allocs: 26.3 kB    |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake forward            | 2.8 k allocs: 0.123 MB    |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake reverse            | 8.45 k allocs: 0.79 MB    |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ReverseDiff (tape)          | 8.96 k allocs: 0.371 MB   |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme forward                        | 0.8 k allocs: 0.0514 MB   |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme reverse                        | 2 k allocs: 0.195 MB      |
| AD gradients/lower(composer) joint-CTMC transition gradient/ForwardDiff                           | 0.408 k allocs: 0.0391 MB |
| AD gradients/lower(composer) joint-CTMC transition gradient/Mooncake forward                      | 1.9 k allocs: 0.119 MB    |
| AD gradients/lower(composer) joint-CTMC transition gradient/Mooncake reverse                      | 11.8 k allocs: 1.07 MB    |
| AD gradients/lower(composer) joint-CTMC transition gradient/ReverseDiff (tape)                    | 0.0318 M allocs: 1.36 MB  |
| AD gradients/lower(composer) scalar-composer survival gradient/Enzyme forward                     | 0.595 k allocs: 28.8 kB   |
| AD gradients/lower(composer) scalar-composer survival gradient/Enzyme reverse                     | 1.47 k allocs: 0.111 MB   |
| AD gradients/lower(composer) scalar-composer survival gradient/ForwardDiff                        | 0.305 k allocs: 20.8 kB   |
| AD gradients/lower(composer) scalar-composer survival gradient/Mooncake forward                   | 1.44 k allocs: 0.0697 MB  |
| AD gradients/lower(composer) scalar-composer survival gradient/Mooncake reverse                   | 10.9 k allocs: 0.984 MB   |
| AD gradients/lower(composer) scalar-composer survival gradient/ReverseDiff (tape)                 | 9.19 k allocs: 0.379 MB   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme forward         | 0.259 k allocs: 16.7 kB   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme reverse         | 0.768 k allocs: 0.0801 MB |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ForwardDiff            | 0.124 k allocs: 12.5 kB   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake forward       | 0.586 k allocs: 0.0374 MB |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake reverse       | 3.29 k allocs: 0.58 MB    |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ReverseDiff (tape)     | 8.89 k allocs: 0.368 MB   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme forward     | 0.247 k allocs: 12.7 kB   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme reverse     | 0.708 k allocs: 0.0726 MB |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ForwardDiff        | 0.118 k allocs: 7.86 kB   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake forward   | 0.562 k allocs: 30.4 kB   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake reverse   | 2.73 k allocs: 0.279 MB   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ReverseDiff (tape) | 3.25 k allocs: 0.137 MB   |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme forward                       | 0.261 k allocs: 13.7 kB   |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme reverse                       | 0.647 k allocs: 0.0714 MB |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ForwardDiff                          | 0.125 k allocs: 8.48 kB   |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake forward                     | 0.588 k allocs: 0.0315 MB |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake reverse                     | 2.51 k allocs: 0.273 MB   |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ReverseDiff (tape)                   | 3.75 k allocs: 0.154 MB   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme forward                     | 0.261 k allocs: 13.7 kB   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme reverse                     | 0.651 k allocs: 0.0715 MB |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ForwardDiff                        | 0.125 k allocs: 8.48 kB   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake forward                   | 0.588 k allocs: 0.0315 MB |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake reverse                   | 2.56 k allocs: 0.275 MB   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ReverseDiff (tape)                 | 3.78 k allocs: 0.156 MB   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme forward                     | 0.245 k allocs: 16.1 kB   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme reverse                     | 0.631 k allocs: 0.0727 MB |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ForwardDiff                        | 0.117 k allocs: 12.1 kB   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake forward                   | 0.556 k allocs: 0.0363 MB |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake reverse                   | 3.12 k allocs: 0.571 MB   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ReverseDiff (tape)                 | 8.87 k allocs: 0.367 MB   |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme forward          | 0.241 k allocs: 28.9 kB   |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme reverse          | 0.621 k allocs: 0.0874 MB |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ForwardDiff             | 0.115 k allocs: 25.8 kB   |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake forward        | 0.548 k allocs: 0.0613 MB |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake reverse        | 1.87 k allocs: 0.358 MB   |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ReverseDiff (tape)      | 0.033 M allocs: 1.41 MB   |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme forward                     | 0.496 k allocs: 0.0319 MB |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme reverse                     | 0.65 k allocs: 0.0721 MB  |
| AD gradients/matrix_exp/transition_probability direct gradient/ForwardDiff                        | 0.123 k allocs: 21.7 kB   |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake forward                   | 1.05 k allocs: 0.0694 MB  |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake reverse                   | 2.99 k allocs: 0.563 MB   |
| AD gradients/matrix_exp/transition_probability direct gradient/ReverseDiff (tape)                 | 8.86 k allocs: 0.367 MB   |
| AD gradients/ode_problem solve survival gradient (PhaseType)/Enzyme forward                       | 0.0549 M allocs: 2.35 MB  |
| AD gradients/ode_problem solve survival gradient (PhaseType)/ForwardDiff                          | 0.666 k allocs: 0.0489 MB |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/Enzyme forward               | 0.0549 M allocs: 2.35 MB  |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/ForwardDiff                  | 0.674 k allocs: 0.0493 MB |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme forward                           | 29  allocs: 1.06 kB       |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme reverse                           | 18  allocs: 0.656 kB      |
| AD gradients/phase_type hyperexponential (α, S) gradient/ForwardDiff                              | 9  allocs: 0.406 kB       |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake forward                         | 0.124 k allocs: 7.08 kB   |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake reverse                         | 0.204 k allocs: 10.3 kB   |
| AD gradients/phase_type hyperexponential (α, S) gradient/ReverseDiff (tape)                       | 0.123 k allocs: 4.84 kB   |
| Bridges/jump_problem (JumpProcesses)                                                              | 0.052 k allocs: 2.38 kB   |
| Bridges/ode_problem (SciMLBase)                                                                   | 0.596 k allocs: 0.0446 MB |
| Bridges/reaction_system (Catalyst)                                                                | 0.68 k allocs: 25.7 kB    |
| Evaluation/ctmc builder + transition_probability                                                  | 0.11 k allocs: 7.69 kB    |
| Evaluation/phase-type matrix_exp                                                                  | 0.114 k allocs: 6.22 kB   |
| Lowering/canonical(Erlang branch)                                                                 | 4  allocs: 0.219 kB       |
| Lowering/canonical(PhaseType branch)                                                              | 4  allocs: 0.188 kB       |
| Lowering/canonical(fixed phases)                                                                  | 4  allocs: 0.359 kB       |
| Lowering/lower(Exponential)                                                                       | 15  allocs: 0.797 kB      |
| Lowering/lower(Gamma, Erlang branch)                                                              | 3  allocs: 0.0938 kB      |
| Lowering/lower(Gamma, PhaseType branch)                                                           | 5  allocs: 0.219 kB       |
| time_to_load                                                                                      | 0.149 k allocs: 11.2 kB   |

