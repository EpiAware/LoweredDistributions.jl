|                                                                                                   | 9afc6521b0c198...  |
|:--------------------------------------------------------------------------------------------------|:------------------:|
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ForwardDiff                 | 22.2 ± 7.7 μs      |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake forward            | 0.25 ± 0.02 ms     |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake reverse            | 1.26 ± 0.049 ms    |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ReverseDiff (tape)          | 0.804 ± 0.1 ms     |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme forward                        | 0.0967 ± 0.0059 ms |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme reverse                        | 0.415 ± 0.039 ms   |
| AD gradients/lower(composer) joint-CTMC transition gradient/ForwardDiff                           | 0.0432 ± 0.0038 ms |
| AD gradients/lower(composer) joint-CTMC transition gradient/Mooncake forward                      | 0.23 ± 0.017 ms    |
| AD gradients/lower(composer) joint-CTMC transition gradient/Mooncake reverse                      | 1.91 ± 0.2 ms      |
| AD gradients/lower(composer) joint-CTMC transition gradient/ReverseDiff (tape)                    | 2.73 ± 0.35 ms     |
| AD gradients/lower(composer) scalar-composer survival gradient/Enzyme forward                     | 0.0475 ± 0.0056 ms |
| AD gradients/lower(composer) scalar-composer survival gradient/Enzyme reverse                     | 0.553 ± 0.04 ms    |
| AD gradients/lower(composer) scalar-composer survival gradient/ForwardDiff                        | 20.5 ± 4.7 μs      |
| AD gradients/lower(composer) scalar-composer survival gradient/Mooncake forward                   | 0.127 ± 0.02 ms    |
| AD gradients/lower(composer) scalar-composer survival gradient/Mooncake reverse                   | 1.58 ± 0.079 ms    |
| AD gradients/lower(composer) scalar-composer survival gradient/ReverseDiff (tape)                 | 0.82 ± 0.099 ms    |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme forward         | 10.5 ± 3.8 μs      |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme reverse         | 0.254 ± 0.023 ms   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ForwardDiff            | 7.75 ± 0.78 μs     |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake forward       | 0.0381 ± 0.011 ms  |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake reverse       | 0.47 ± 0.12 ms     |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ReverseDiff (tape)     | 0.789 ± 0.096 ms   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme forward     | 9.51 ± 0.96 μs     |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme reverse     | 0.241 ± 0.026 ms   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ForwardDiff        | 4.69 ± 0.84 μs     |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake forward   | 25.8 ± 2.2 μs      |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake reverse   | 0.338 ± 0.036 ms   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ReverseDiff (tape) | 0.299 ± 0.041 ms   |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme forward                       | 9.67 ± 1.2 μs      |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme reverse                       | 0.236 ± 0.021 ms   |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ForwardDiff                          | 5.06 ± 1.1 μs      |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake forward                     | 26.5 ± 3.8 μs      |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake reverse                     | 0.303 ± 0.028 ms   |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ReverseDiff (tape)                   | 0.335 ± 0.051 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme forward                     | 9.71 ± 1.8 μs      |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme reverse                     | 0.241 ± 0.028 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ForwardDiff                        | 5.16 ± 0.97 μs     |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake forward                   | 27.1 ± 3.5 μs      |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake reverse                   | 0.314 ± 0.029 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ReverseDiff (tape)                 | 0.341 ± 0.051 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme forward                     | 10.2 ± 3.6 μs      |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme reverse                     | 0.242 ± 0.028 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ForwardDiff                        | 7.43 ± 0.74 μs     |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake forward                   | 0.0379 ± 0.012 ms  |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake reverse                   | 0.475 ± 0.05 ms    |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ReverseDiff (tape)                 | 0.794 ± 0.096 ms   |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme forward          | 27 ± 2.8 μs        |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme reverse          | 0.121 ± 0.012 ms   |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ForwardDiff             | 16.1 ± 0.79 μs     |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake forward        | 0.0649 ± 0.0046 ms |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake reverse        | 0.351 ± 0.042 ms   |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ReverseDiff (tape)      | 2.9 ± 0.35 ms      |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme forward                     | 24.5 ± 10 μs       |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme reverse                     | 0.25 ± 0.031 ms    |
| AD gradients/matrix_exp/transition_probability direct gradient/ForwardDiff                        | 13.1 ± 0.54 μs     |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake forward                   | 0.0698 ± 0.0085 ms |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake reverse                   | 0.428 ± 0.12 ms    |
| AD gradients/matrix_exp/transition_probability direct gradient/ReverseDiff (tape)                 | 0.78 ± 0.098 ms    |
| AD gradients/ode_problem solve survival gradient (PhaseType)/Enzyme forward                       | 16.9 ± 0.68 ms     |
| AD gradients/ode_problem solve survival gradient (PhaseType)/ForwardDiff                          | 0.29 ± 0.013 ms    |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/Enzyme forward               | 17 ± 0.58 ms       |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/ForwardDiff                  | 0.296 ± 0.014 ms   |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme forward                           | 6.19 ± 0.072 μs    |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme reverse                           | 1.32 ± 0.035 μs    |
| AD gradients/phase_type hyperexponential (α, S) gradient/ForwardDiff                              | 0.491 ± 0.051 μs   |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake forward                         | 11.4 ± 0.56 μs     |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake reverse                         | 14.7 ± 0.73 μs     |
| AD gradients/phase_type hyperexponential (α, S) gradient/ReverseDiff (tape)                       | 8.06 ± 0.21 μs     |
| Bridges/jump_problem (JumpProcesses)                                                              | 1.22 ± 0.079 μs    |
| Bridges/ode_problem (SciMLBase)                                                                   | 0.166 ± 0.0052 ms  |
| Bridges/reaction_system (Catalyst)                                                                | 0.0742 ± 0.0032 ms |
| Evaluation/ctmc builder + transition_probability                                                  | 4.77 ± 0.97 μs     |
| Evaluation/phase-type matrix_exp                                                                  | 3.8 ± 2.5 μs       |
| Lowering/canonical(Erlang branch)                                                                 | 0.148 ± 0.038 μs   |
| Lowering/canonical(PhaseType branch)                                                              | 0.126 ± 0.059 μs   |
| Lowering/canonical(fixed phases)                                                                  | 0.195 ± 0.028 μs   |
| Lowering/lower(Exponential)                                                                       | 1.98 ± 0.064 μs    |
| Lowering/lower(Gamma, Erlang branch)                                                              | 0.0469 ± 0.025 μs  |
| Lowering/lower(Gamma, PhaseType branch)                                                           | 0.126 ± 0.061 μs   |
| time_to_load                                                                                      | 0.509 ± 0.0023 s   |

|                                                                                                   | 9afc6521b0c198...         |
|:--------------------------------------------------------------------------------------------------|:-------------------------:|
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ForwardDiff                 | 0.22 k allocs: 26.3 kB    |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake forward            | 2.8 k allocs: 0.123 MB    |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake reverse            | 8.45 k allocs: 0.79 MB    |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ReverseDiff (tape)          | 8.96 k allocs: 0.371 MB   |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme forward                        | 0.8 k allocs: 0.0514 MB   |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme reverse                        | 2 k allocs: 0.196 MB      |
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

