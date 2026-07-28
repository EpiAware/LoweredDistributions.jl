|                                                                                                   | 4179db27e1dac1...  |
|:--------------------------------------------------------------------------------------------------|:------------------:|
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ForwardDiff                 | 22 ± 8.2 μs        |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake forward            | 0.257 ± 0.026 ms   |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake reverse            | 1.26 ± 0.068 ms    |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ReverseDiff (tape)          | 0.788 ± 0.13 ms    |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme forward         | 10.5 ± 4 μs        |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme reverse         | 0.26 ± 0.028 ms    |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ForwardDiff            | 7.64 ± 0.87 μs     |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake forward       | 0.0388 ± 0.012 ms  |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake reverse       | 0.46 ± 0.14 ms     |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ReverseDiff (tape)     | 0.769 ± 0.13 ms    |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme forward     | 9.78 ± 1.2 μs      |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme reverse     | 0.254 ± 0.027 ms   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ForwardDiff        | 5.24 ± 1.2 μs      |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake forward   | 25.3 ± 3.8 μs      |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake reverse   | 0.341 ± 0.031 ms   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ReverseDiff (tape) | 0.29 ± 0.052 ms    |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme forward                       | 9.81 ± 1.1 μs      |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme reverse                       | 0.247 ± 0.026 ms   |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ForwardDiff                          | 5.56 ± 1.1 μs      |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake forward                     | 26.5 ± 7.2 μs      |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake reverse                     | 0.303 ± 0.029 ms   |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ReverseDiff (tape)                   | 0.325 ± 0.054 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme forward                     | 9.75 ± 1.1 μs      |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme reverse                     | 0.246 ± 0.023 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ForwardDiff                        | 5.62 ± 1.1 μs      |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake forward                   | 26.5 ± 7.4 μs      |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake reverse                   | 0.319 ± 0.03 ms    |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ReverseDiff (tape)                 | 0.335 ± 0.057 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme forward                     | 10.3 ± 4 μs        |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme reverse                     | 0.246 ± 0.032 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ForwardDiff                        | 7.32 ± 1 μs        |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake forward                   | 0.038 ± 0.011 ms   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake reverse                   | 0.434 ± 0.14 ms    |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ReverseDiff (tape)                 | 0.77 ± 0.13 ms     |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme forward          | 27.3 ± 2.7 μs      |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme reverse          | 0.125 ± 0.015 ms   |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ForwardDiff             | 15.8 ± 0.73 μs     |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake forward        | 0.0622 ± 0.0042 ms |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake reverse        | 0.34 ± 0.07 ms     |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ReverseDiff (tape)      | 2.74 ± 0.49 ms     |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme forward                     | 24.2 ± 9.5 μs      |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme reverse                     | 0.255 ± 0.03 ms    |
| AD gradients/matrix_exp/transition_probability direct gradient/ForwardDiff                        | 12.7 ± 0.58 μs     |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake forward                   | 0.0721 ± 0.01 ms   |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake reverse                   | 0.408 ± 0.13 ms    |
| AD gradients/matrix_exp/transition_probability direct gradient/ReverseDiff (tape)                 | 0.766 ± 0.14 ms    |
| AD gradients/ode_problem solve survival gradient (PhaseType)/Enzyme forward                       | 17.4 ± 0.99 ms     |
| AD gradients/ode_problem solve survival gradient (PhaseType)/ForwardDiff                          | 0.291 ± 0.013 ms   |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/Enzyme forward               | 17.3 ± 0.98 ms     |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/ForwardDiff                  | 0.292 ± 0.014 ms   |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme forward                           | 6.2 ± 0.068 μs     |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme reverse                           | 1.28 ± 0.034 μs    |
| AD gradients/phase_type hyperexponential (α, S) gradient/ForwardDiff                              | 0.506 ± 0.14 μs    |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake forward                         | 11.3 ± 0.49 μs     |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake reverse                         | 14.1 ± 0.65 μs     |
| AD gradients/phase_type hyperexponential (α, S) gradient/ReverseDiff (tape)                       | 8.09 ± 0.2 μs      |
| Bridges/jump_problem (JumpProcesses)                                                              | 1.34 ± 0.25 μs     |
| Bridges/ode_problem (SciMLBase)                                                                   | 0.166 ± 0.0052 ms  |
| Bridges/reaction_system (Catalyst)                                                                | 0.0711 ± 0.0036 ms |
| Evaluation/ctmc builder + transition_probability                                                  | 5.13 ± 1.1 μs      |
| Evaluation/phase-type matrix_exp                                                                  | 4.25 ± 1.4 μs      |
| Lowering/canonical(Erlang branch)                                                                 | 0.147 ± 0.038 μs   |
| Lowering/canonical(PhaseType branch)                                                              | 0.127 ± 0.022 μs   |
| Lowering/canonical(fixed phases)                                                                  | 0.196 ± 0.027 μs   |
| Lowering/lower(Exponential)                                                                       | 1.3 ± 0.056 μs     |
| Lowering/lower(Gamma, Erlang branch)                                                              | 0.0485 ± 0.03 μs   |
| Lowering/lower(Gamma, PhaseType branch)                                                           | 0.128 ± 0.034 μs   |
| time_to_load                                                                                      | 0.502 ± 0.0032 s   |

|                                                                                                   | 4179db27e1dac1...         |
|:--------------------------------------------------------------------------------------------------|:-------------------------:|
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ForwardDiff                 | 0.22 k allocs: 26.3 kB    |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake forward            | 2.8 k allocs: 0.123 MB    |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake reverse            | 8.45 k allocs: 0.79 MB    |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ReverseDiff (tape)          | 8.96 k allocs: 0.371 MB   |
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

