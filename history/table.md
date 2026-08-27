|                                                                                                   | v0.1.0             | 5e99061c104bbe...  | v0.1.0 / 5e99061c104bbe... |
|:--------------------------------------------------------------------------------------------------|:------------------:|:------------------:|:--------------------------:|
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ForwardDiff                 | 22 ± 7.7 μs        | 21.9 ± 8 μs        | 1 ± 0.51                   |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake forward            | 0.202 ± 0.017 ms   | 0.202 ± 0.017 ms   | 0.997 ± 0.12               |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake reverse            | 1.3 ± 0.082 ms     | 1.36 ± 0.093 ms    | 0.96 ± 0.089               |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ReverseDiff (tape)          | 0.753 ± 0.18 ms    | 0.77 ± 0.17 ms     | 0.978 ± 0.32               |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme forward                        | 0.0955 ± 0.0065 ms | 0.0932 ± 0.0063 ms | 1.03 ± 0.099               |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme reverse                        | 0.479 ± 0.074 ms   | 0.452 ± 0.081 ms   | 1.06 ± 0.25                |
| AD gradients/lower(composer) joint-CTMC transition gradient/ForwardDiff                           | 0.0451 ± 0.0039 ms | 0.0457 ± 0.0039 ms | 0.988 ± 0.12               |
| AD gradients/lower(composer) joint-CTMC transition gradient/Mooncake forward                      | 0.213 ± 0.02 ms    | 0.219 ± 0.02 ms    | 0.97 ± 0.13                |
| AD gradients/lower(composer) joint-CTMC transition gradient/Mooncake reverse                      | 2.05 ± 0.21 ms     | 2.2 ± 0.26 ms      | 0.932 ± 0.15               |
| AD gradients/lower(composer) joint-CTMC transition gradient/ReverseDiff (tape)                    | 2.59 ± 0.62 ms     | 2.66 ± 0.55 ms     | 0.974 ± 0.31               |
| AD gradients/lower(composer) scalar-composer survival gradient/Enzyme forward                     | 0.0459 ± 0.0032 ms | 0.0482 ± 0.0036 ms | 0.953 ± 0.098              |
| AD gradients/lower(composer) scalar-composer survival gradient/Enzyme reverse                     | 0.671 ± 0.059 ms   | 0.651 ± 0.13 ms    | 1.03 ± 0.23                |
| AD gradients/lower(composer) scalar-composer survival gradient/ForwardDiff                        | 20.9 ± 4.2 μs      | 22.8 ± 4.4 μs      | 0.915 ± 0.26               |
| AD gradients/lower(composer) scalar-composer survival gradient/Mooncake forward                   | 0.101 ± 0.017 ms   | 0.109 ± 0.018 ms   | 0.923 ± 0.22               |
| AD gradients/lower(composer) scalar-composer survival gradient/Mooncake reverse                   | 1.71 ± 0.12 ms     | 1.85 ± 0.13 ms     | 0.922 ± 0.092              |
| AD gradients/lower(composer) scalar-composer survival gradient/ReverseDiff (tape)                 | 0.774 ± 0.19 ms    | 0.796 ± 0.19 ms    | 0.972 ± 0.33               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme forward         | 10.5 ± 1.4 μs      | 10.5 ± 1.6 μs      | 1 ± 0.2                    |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme reverse         | 0.324 ± 0.022 ms   | 0.318 ± 0.034 ms   | 1.02 ± 0.13                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ForwardDiff            | 8.39 ± 0.92 μs     | 8.3 ± 0.78 μs      | 1.01 ± 0.15                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake forward       | 0.0386 ± 0.012 ms  | 0.0388 ± 0.013 ms  | 0.993 ± 0.45               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake reverse       | 0.509 ± 0.035 ms   | 0.519 ± 0.029 ms   | 0.98 ± 0.087               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ReverseDiff (tape)     | 0.743 ± 0.18 ms    | 0.756 ± 0.16 ms    | 0.982 ± 0.31               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme forward     | 10.3 ± 3.2 μs      | 10.4 ± 3.2 μs      | 0.982 ± 0.43               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme reverse     | 0.312 ± 0.04 ms    | 0.3 ± 0.025 ms     | 1.04 ± 0.16                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ForwardDiff        | 5.28 ± 0.65 μs     | 5.26 ± 0.65 μs     | 1 ± 0.18                   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake forward   | 25.3 ± 2.6 μs      | 25.7 ± 3.3 μs      | 0.985 ± 0.16               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake reverse   | 0.355 ± 0.035 ms   | 0.381 ± 0.028 ms   | 0.932 ± 0.12               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ReverseDiff (tape) | 0.274 ± 0.038 ms   | 0.281 ± 0.044 ms   | 0.973 ± 0.2                |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme forward                       | 10.1 ± 2.4 μs      | 9.97 ± 2.7 μs      | 1.01 ± 0.36                |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme reverse                       | 0.313 ± 0.025 ms   | 0.3 ± 0.026 ms     | 1.04 ± 0.12                |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ForwardDiff                          | 5.97 ± 0.96 μs     | 5.73 ± 0.83 μs     | 1.04 ± 0.23                |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake forward                     | 26.6 ± 2.2 μs      | 26.6 ± 3 μs        | 1 ± 0.14                   |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake reverse                     | 0.338 ± 0.039 ms   | 0.361 ± 0.031 ms   | 0.936 ± 0.14               |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ReverseDiff (tape)                   | 0.318 ± 0.069 ms   | 0.318 ± 0.06 ms    | 1 ± 0.29                   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme forward                     | 9.94 ± 2.3 μs      | 9.64 ± 1.3 μs      | 1.03 ± 0.28                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme reverse                     | 0.309 ± 0.027 ms   | 0.299 ± 0.027 ms   | 1.04 ± 0.13                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ForwardDiff                        | 5.76 ± 0.95 μs     | 5.74 ± 0.92 μs     | 1 ± 0.23                   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake forward                   | 26.9 ± 3 μs        | 27.4 ± 3.2 μs      | 0.98 ± 0.16                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake reverse                   | 0.343 ± 0.038 ms   | 0.354 ± 0.034 ms   | 0.97 ± 0.14                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ReverseDiff (tape)                 | 0.32 ± 0.059 ms    | 0.327 ± 0.069 ms   | 0.977 ± 0.27               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme forward                     | 10.2 ± 1.7 μs      | 10.1 ± 1.8 μs      | 1 ± 0.24                   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme reverse                     | 0.308 ± 0.02 ms    | 0.299 ± 0.029 ms   | 1.03 ± 0.12                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ForwardDiff                        | 8.02 ± 0.6 μs      | 8.08 ± 0.68 μs     | 0.992 ± 0.11               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake forward                   | 0.0383 ± 0.013 ms  | 0.0384 ± 0.012 ms  | 0.999 ± 0.46               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake reverse                   | 0.486 ± 0.031 ms   | 0.498 ± 0.032 ms   | 0.976 ± 0.088              |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ReverseDiff (tape)                 | 0.741 ± 0.18 ms    | 0.755 ± 0.16 ms    | 0.983 ± 0.31               |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme forward          | 27 ± 3.5 μs        | 27.2 ± 3.2 μs      | 0.992 ± 0.17               |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme reverse          | 0.136 ± 0.011 ms   | 0.122 ± 0.0093 ms  | 1.11 ± 0.12                |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ForwardDiff             | 17.2 ± 2.2 μs      | 17.1 ± 1.2 μs      | 1 ± 0.15                   |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake forward        | 0.063 ± 0.0049 ms  | 0.0636 ± 0.0051 ms | 0.99 ± 0.11                |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake reverse        | 0.354 ± 0.026 ms   | 0.366 ± 0.028 ms   | 0.965 ± 0.1                |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ReverseDiff (tape)      | 2.69 ± 0.55 ms     | 2.73 ± 0.58 ms     | 0.983 ± 0.29               |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme forward                     | 25.8 ± 11 μs       | 26.3 ± 12 μs       | 0.98 ± 0.62                |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme reverse                     | 0.313 ± 0.025 ms   | 0.303 ± 0.029 ms   | 1.03 ± 0.13                |
| AD gradients/matrix_exp/transition_probability direct gradient/ForwardDiff                        | 14.4 ± 1.7 μs      | 13.5 ± 1.5 μs      | 1.06 ± 0.17                |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake forward                   | 0.0735 ± 0.0068 ms | 0.0738 ± 0.0074 ms | 0.997 ± 0.14               |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake reverse                   | 0.473 ± 0.036 ms   | 0.469 ± 0.031 ms   | 1.01 ± 0.1                 |
| AD gradients/matrix_exp/transition_probability direct gradient/ReverseDiff (tape)                 | 0.739 ± 0.16 ms    | 0.755 ± 0.16 ms    | 0.979 ± 0.3                |
| AD gradients/ode_problem solve survival gradient (PhaseType)/Enzyme forward                       | 16.6 ± 0.95 ms     | 17.1 ± 0.75 ms     | 0.967 ± 0.069              |
| AD gradients/ode_problem solve survival gradient (PhaseType)/ForwardDiff                          | 0.144 ± 0.0029 ms  | 0.143 ± 0.003 ms   | 1 ± 0.029                  |
| AD gradients/ode_problem solve survival gradient (PhaseType)/Mooncake forward                     | 0.122 ± 0.03 s     | 0.121 ± 0.023 s    | 1.01 ± 0.31                |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/Enzyme forward               | 16.7 ± 0.8 ms      | 17.2 ± 0.74 ms     | 0.968 ± 0.062              |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/ForwardDiff                  | 0.144 ± 0.0031 ms  | 0.143 ± 0.0028 ms  | 1.01 ± 0.03                |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/Mooncake forward             | 0.12 ± 0.028 s     | 0.122 ± 0.027 s    | 0.982 ± 0.31               |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme forward                           | 5.81 ± 0.1 μs      | 5.84 ± 0.11 μs     | 0.995 ± 0.026              |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme reverse                           | 1.36 ± 0.054 μs    | 1.37 ± 0.05 μs     | 0.991 ± 0.054              |
| AD gradients/phase_type hyperexponential (α, S) gradient/ForwardDiff                              | 0.506 ± 0.054 μs   | 0.512 ± 0.059 μs   | 0.987 ± 0.15               |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake forward                         | 11 ± 0.71 μs       | 10.9 ± 0.6 μs      | 1.01 ± 0.086               |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake reverse                         | 18.5 ± 0.78 μs     | 19.4 ± 0.8 μs      | 0.955 ± 0.056              |
| AD gradients/phase_type hyperexponential (α, S) gradient/ReverseDiff (tape)                       | 8.12 ± 0.37 μs     | 8.02 ± 0.3 μs      | 1.01 ± 0.059               |
| AD gradients/update(CTMC, rates) transition gradient/Enzyme forward                               | 23.9 ± 9.9 μs      | 24.3 ± 10 μs       | 0.982 ± 0.59               |
| AD gradients/update(CTMC, rates) transition gradient/Enzyme reverse                               | 0.317 ± 0.028 ms   | 0.306 ± 0.027 ms   | 1.03 ± 0.13                |
| AD gradients/update(CTMC, rates) transition gradient/ForwardDiff                                  | 13 ± 1.3 μs        | 13.2 ± 1.7 μs      | 0.985 ± 0.16               |
| AD gradients/update(CTMC, rates) transition gradient/Mooncake forward                             | 0.0731 ± 0.006 ms  | 0.0745 ± 0.0062 ms | 0.982 ± 0.11               |
| AD gradients/update(CTMC, rates) transition gradient/Mooncake reverse                             | 0.497 ± 0.045 ms   | 0.522 ± 0.032 ms   | 0.951 ± 0.1                |
| AD gradients/update(CTMC, rates) transition gradient/ReverseDiff (tape)                           | 0.689 ± 0.16 ms    | 0.693 ± 0.17 ms    | 0.994 ± 0.33               |
| AD gradients/update(Coxian, rates) survival gradient/Enzyme forward                               | 12.7 ± 2.9 μs      | 12.2 ± 2.8 μs      | 1.04 ± 0.34                |
| AD gradients/update(Coxian, rates) survival gradient/Enzyme reverse                               | 0.31 ± 0.022 ms    | 0.302 ± 0.032 ms   | 1.02 ± 0.13                |
| AD gradients/update(Coxian, rates) survival gradient/ForwardDiff                                  | 7.21 ± 1.5 μs      | 7.36 ± 0.76 μs     | 0.979 ± 0.23               |
| AD gradients/update(Coxian, rates) survival gradient/Mooncake forward                             | 0.045 ± 0.013 ms   | 0.0431 ± 0.012 ms  | 1.04 ± 0.42                |
| AD gradients/update(Coxian, rates) survival gradient/Mooncake reverse                             | 0.375 ± 0.043 ms   | 0.381 ± 0.043 ms   | 0.985 ± 0.16               |
| AD gradients/update(Coxian, rates) survival gradient/ReverseDiff (tape)                           | 0.318 ± 0.066 ms   | 0.318 ± 0.06 ms    | 1 ± 0.28                   |
| AD gradients/update(ErlangChain, rates) survival gradient/Enzyme forward                          | 10.8 ± 0.94 μs     | 11 ± 1.1 μs        | 0.976 ± 0.13               |
| AD gradients/update(ErlangChain, rates) survival gradient/Enzyme reverse                          | 0.328 ± 0.023 ms   | 0.316 ± 0.028 ms   | 1.04 ± 0.12                |
| AD gradients/update(ErlangChain, rates) survival gradient/ForwardDiff                             | 8.64 ± 0.69 μs     | 8.33 ± 0.61 μs     | 1.04 ± 0.11                |
| AD gradients/update(ErlangChain, rates) survival gradient/Mooncake forward                        | 0.0399 ± 0.012 ms  | 0.046 ± 0.013 ms   | 0.866 ± 0.36               |
| AD gradients/update(ErlangChain, rates) survival gradient/Mooncake reverse                        | 0.537 ± 0.063 ms   | 0.544 ± 0.055 ms   | 0.988 ± 0.15               |
| AD gradients/update(ErlangChain, rates) survival gradient/ReverseDiff (tape)                      | 0.763 ± 0.19 ms    | 0.773 ± 0.16 ms    | 0.988 ± 0.32               |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Enzyme forward                      | 11.6 ± 2.5 μs      | 11.7 ± 2.5 μs      | 0.994 ± 0.3                |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Enzyme reverse                      | 0.309 ± 0.034 ms   | 0.296 ± 0.023 ms   | 1.04 ± 0.14                |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/ForwardDiff                         | 6.7 ± 0.82 μs      | 7.04 ± 0.71 μs     | 0.951 ± 0.15               |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Mooncake forward                    | 0.0418 ± 0.011 ms  | 0.039 ± 0.011 ms   | 1.07 ± 0.41                |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Mooncake reverse                    | 0.345 ± 0.037 ms   | 0.35 ± 0.026 ms    | 0.988 ± 0.13               |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/ReverseDiff (tape)                  | 0.291 ± 0.047 ms   | 0.293 ± 0.047 ms   | 0.993 ± 0.23               |
| Bridges/jump_problem (JumpProcesses)                                                              | 1.7 ± 0.19 μs      | 2.62 ± 0.21 μs     | 0.649 ± 0.091              |
| Bridges/ode_problem (SciMLBase)                                                                   | 19.7 ± 0.38 μs     | 18.6 ± 0.34 μs     | 1.06 ± 0.028               |
| Bridges/reaction_system (Catalyst)                                                                | 0.0726 ± 0.0022 ms | 0.0754 ± 0.0026 ms | 0.963 ± 0.044              |
| Evaluation/ctmc builder + transition_probability                                                  | 4.96 ± 0.83 μs     | 4.95 ± 0.85 μs     | 1 ± 0.24                   |
| Evaluation/phase-type matrix_exp                                                                  | 3.71 ± 2.5 μs      | 3.81 ± 2.5 μs      | 0.974 ± 0.91               |
| Lowering/canonical(Erlang branch)                                                                 | 0.165 ± 0.053 μs   | 0.162 ± 0.043 μs   | 1.01 ± 0.42                |
| Lowering/canonical(PhaseType branch)                                                              | 0.147 ± 0.015 μs   | 0.143 ± 0.014 μs   | 1.03 ± 0.15                |
| Lowering/canonical(fixed phases)                                                                  | 0.232 ± 0.044 μs   | 0.225 ± 0.038 μs   | 1.03 ± 0.26                |
| Lowering/lower(Exponential)                                                                       | 2.12 ± 0.061 μs    | 2.5 ± 0.061 μs     | 0.849 ± 0.032              |
| Lowering/lower(Gamma, Erlang branch)                                                              | 0.0435 ± 0.025 μs  | 0.0441 ± 0.026 μs  | 0.985 ± 0.81               |
| Lowering/lower(Gamma, PhaseType branch)                                                           | 0.139 ± 0.072 μs   | 0.149 ± 0.067 μs   | 0.928 ± 0.64               |
| time_to_load                                                                                      | 0.529 ± 0.0046 s   | 0.517 ± 0.0043 s   | 1.02 ± 0.012               |

|                                                                                                   | v0.1.0                    | 5e99061c104bbe...         | v0.1.0 / 5e99061c104bbe... |
|:--------------------------------------------------------------------------------------------------|:-------------------------:|:-------------------------:|:--------------------------:|
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ForwardDiff                 | 0.22 k allocs: 26.3 kB    | 0.22 k allocs: 26.3 kB    | 1                          |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake forward            | 2.8 k allocs: 0.123 MB    | 2.8 k allocs: 0.123 MB    | 1                          |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake reverse            | 8.45 k allocs: 0.79 MB    | 8.45 k allocs: 0.79 MB    | 1                          |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ReverseDiff (tape)          | 8.96 k allocs: 0.371 MB   | 8.96 k allocs: 0.371 MB   | 1                          |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme forward                        | 0.8 k allocs: 0.0514 MB   | 0.8 k allocs: 0.0514 MB   | 1                          |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme reverse                        | 2 k allocs: 0.196 MB      | 2 k allocs: 0.196 MB      | 1                          |
| AD gradients/lower(composer) joint-CTMC transition gradient/ForwardDiff                           | 0.408 k allocs: 0.0391 MB | 0.408 k allocs: 0.0391 MB | 1                          |
| AD gradients/lower(composer) joint-CTMC transition gradient/Mooncake forward                      | 1.9 k allocs: 0.119 MB    | 1.9 k allocs: 0.119 MB    | 1                          |
| AD gradients/lower(composer) joint-CTMC transition gradient/Mooncake reverse                      | 11.8 k allocs: 1.07 MB    | 11.8 k allocs: 1.07 MB    | 1                          |
| AD gradients/lower(composer) joint-CTMC transition gradient/ReverseDiff (tape)                    | 0.0318 M allocs: 1.36 MB  | 0.0318 M allocs: 1.36 MB  | 1                          |
| AD gradients/lower(composer) scalar-composer survival gradient/Enzyme forward                     | 0.595 k allocs: 28.8 kB   | 0.595 k allocs: 28.8 kB   | 1                          |
| AD gradients/lower(composer) scalar-composer survival gradient/Enzyme reverse                     | 1.47 k allocs: 0.111 MB   | 1.47 k allocs: 0.111 MB   | 1                          |
| AD gradients/lower(composer) scalar-composer survival gradient/ForwardDiff                        | 0.305 k allocs: 20.8 kB   | 0.305 k allocs: 20.8 kB   | 1                          |
| AD gradients/lower(composer) scalar-composer survival gradient/Mooncake forward                   | 1.44 k allocs: 0.0697 MB  | 1.44 k allocs: 0.0697 MB  | 1                          |
| AD gradients/lower(composer) scalar-composer survival gradient/Mooncake reverse                   | 10.9 k allocs: 0.984 MB   | 10.9 k allocs: 0.984 MB   | 1                          |
| AD gradients/lower(composer) scalar-composer survival gradient/ReverseDiff (tape)                 | 9.19 k allocs: 0.379 MB   | 9.19 k allocs: 0.379 MB   | 1                          |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme forward         | 0.259 k allocs: 16.7 kB   | 0.259 k allocs: 16.7 kB   | 1                          |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme reverse         | 0.768 k allocs: 0.0801 MB | 0.768 k allocs: 0.0801 MB | 1                          |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ForwardDiff            | 0.124 k allocs: 12.5 kB   | 0.124 k allocs: 12.5 kB   | 1                          |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake forward       | 0.586 k allocs: 0.0374 MB | 0.586 k allocs: 0.0374 MB | 1                          |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake reverse       | 3.29 k allocs: 0.58 MB    | 3.29 k allocs: 0.58 MB    | 1                          |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ReverseDiff (tape)     | 8.89 k allocs: 0.368 MB   | 8.89 k allocs: 0.368 MB   | 1                          |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme forward     | 0.247 k allocs: 12.7 kB   | 0.247 k allocs: 12.7 kB   | 1                          |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme reverse     | 0.708 k allocs: 0.0726 MB | 0.708 k allocs: 0.0726 MB | 1                          |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ForwardDiff        | 0.118 k allocs: 7.86 kB   | 0.118 k allocs: 7.86 kB   | 1                          |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake forward   | 0.562 k allocs: 30.4 kB   | 0.562 k allocs: 30.4 kB   | 1                          |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake reverse   | 2.73 k allocs: 0.279 MB   | 2.73 k allocs: 0.279 MB   | 1                          |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ReverseDiff (tape) | 3.25 k allocs: 0.137 MB   | 3.25 k allocs: 0.137 MB   | 1                          |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme forward                       | 0.261 k allocs: 13.7 kB   | 0.261 k allocs: 13.7 kB   | 1                          |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme reverse                       | 0.647 k allocs: 0.0714 MB | 0.647 k allocs: 0.0714 MB | 1                          |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ForwardDiff                          | 0.125 k allocs: 8.48 kB   | 0.125 k allocs: 8.48 kB   | 1                          |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake forward                     | 0.588 k allocs: 0.0315 MB | 0.588 k allocs: 0.0315 MB | 1                          |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake reverse                     | 2.51 k allocs: 0.273 MB   | 2.51 k allocs: 0.273 MB   | 1                          |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ReverseDiff (tape)                   | 3.75 k allocs: 0.154 MB   | 3.75 k allocs: 0.154 MB   | 1                          |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme forward                     | 0.261 k allocs: 13.7 kB   | 0.261 k allocs: 13.7 kB   | 1                          |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme reverse                     | 0.651 k allocs: 0.0715 MB | 0.651 k allocs: 0.0715 MB | 1                          |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ForwardDiff                        | 0.125 k allocs: 8.48 kB   | 0.125 k allocs: 8.48 kB   | 1                          |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake forward                   | 0.588 k allocs: 0.0315 MB | 0.588 k allocs: 0.0315 MB | 1                          |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake reverse                   | 2.56 k allocs: 0.275 MB   | 2.56 k allocs: 0.275 MB   | 1                          |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ReverseDiff (tape)                 | 3.78 k allocs: 0.156 MB   | 3.78 k allocs: 0.156 MB   | 1                          |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme forward                     | 0.245 k allocs: 16.1 kB   | 0.245 k allocs: 16.1 kB   | 1                          |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme reverse                     | 0.631 k allocs: 0.0727 MB | 0.631 k allocs: 0.0727 MB | 1                          |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ForwardDiff                        | 0.117 k allocs: 12.1 kB   | 0.117 k allocs: 12.1 kB   | 1                          |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake forward                   | 0.556 k allocs: 0.0363 MB | 0.556 k allocs: 0.0363 MB | 1                          |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake reverse                   | 3.12 k allocs: 0.571 MB   | 3.12 k allocs: 0.571 MB   | 1                          |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ReverseDiff (tape)                 | 8.87 k allocs: 0.367 MB   | 8.87 k allocs: 0.367 MB   | 1                          |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme forward          | 0.241 k allocs: 28.9 kB   | 0.241 k allocs: 28.9 kB   | 1                          |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme reverse          | 0.621 k allocs: 0.0874 MB | 0.621 k allocs: 0.0874 MB | 1                          |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ForwardDiff             | 0.115 k allocs: 25.8 kB   | 0.115 k allocs: 25.8 kB   | 1                          |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake forward        | 0.548 k allocs: 0.0613 MB | 0.548 k allocs: 0.0613 MB | 1                          |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake reverse        | 1.87 k allocs: 0.358 MB   | 1.87 k allocs: 0.358 MB   | 1                          |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ReverseDiff (tape)      | 0.033 M allocs: 1.41 MB   | 0.033 M allocs: 1.41 MB   | 1                          |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme forward                     | 0.496 k allocs: 0.0319 MB | 0.496 k allocs: 0.0319 MB | 1                          |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme reverse                     | 0.65 k allocs: 0.0721 MB  | 0.65 k allocs: 0.0721 MB  | 1                          |
| AD gradients/matrix_exp/transition_probability direct gradient/ForwardDiff                        | 0.123 k allocs: 21.7 kB   | 0.123 k allocs: 21.7 kB   | 1                          |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake forward                   | 1.05 k allocs: 0.0694 MB  | 1.05 k allocs: 0.0694 MB  | 1                          |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake reverse                   | 2.99 k allocs: 0.563 MB   | 2.99 k allocs: 0.563 MB   | 1                          |
| AD gradients/matrix_exp/transition_probability direct gradient/ReverseDiff (tape)                 | 8.86 k allocs: 0.367 MB   | 8.86 k allocs: 0.367 MB   | 1                          |
| AD gradients/ode_problem solve survival gradient (PhaseType)/Enzyme forward                       | 0.0543 M allocs: 2.3 MB   | 0.0543 M allocs: 2.3 MB   | 1                          |
| AD gradients/ode_problem solve survival gradient (PhaseType)/ForwardDiff                          | 0.152 k allocs: 7.85 kB   | 0.152 k allocs: 7.85 kB   | 1                          |
| AD gradients/ode_problem solve survival gradient (PhaseType)/Mooncake forward                     | 0.883 M allocs: 0.192 GB  | 0.883 M allocs: 0.192 GB  | 1                          |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/Enzyme forward               | 0.0543 M allocs: 2.3 MB   | 0.0543 M allocs: 2.3 MB   | 1                          |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/ForwardDiff                  | 0.16 k allocs: 8.2 kB     | 0.16 k allocs: 8.2 kB     | 1                          |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/Mooncake forward             | 0.883 M allocs: 0.192 GB  | 0.883 M allocs: 0.192 GB  | 1                          |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme forward                           | 29  allocs: 1.06 kB       | 29  allocs: 1.06 kB       | 1                          |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme reverse                           | 18  allocs: 0.656 kB      | 18  allocs: 0.656 kB      | 1                          |
| AD gradients/phase_type hyperexponential (α, S) gradient/ForwardDiff                              | 9  allocs: 0.406 kB       | 9  allocs: 0.406 kB       | 1                          |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake forward                         | 0.124 k allocs: 7.08 kB   | 0.124 k allocs: 7.08 kB   | 1                          |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake reverse                         | 0.204 k allocs: 10.3 kB   | 0.204 k allocs: 10.3 kB   | 1                          |
| AD gradients/phase_type hyperexponential (α, S) gradient/ReverseDiff (tape)                       | 0.123 k allocs: 4.84 kB   | 0.123 k allocs: 4.84 kB   | 1                          |
| AD gradients/update(CTMC, rates) transition gradient/Enzyme forward                               | 0.46 k allocs: 31 kB      | 0.46 k allocs: 31 kB      | 1                          |
| AD gradients/update(CTMC, rates) transition gradient/Enzyme reverse                               | 0.671 k allocs: 0.0752 MB | 0.671 k allocs: 0.0752 MB | 1                          |
| AD gradients/update(CTMC, rates) transition gradient/ForwardDiff                                  | 0.115 k allocs: 20 kB     | 0.115 k allocs: 20 kB     | 1                          |
| AD gradients/update(CTMC, rates) transition gradient/Mooncake forward                             | 1.02 k allocs: 0.0671 MB  | 1.02 k allocs: 0.0671 MB  | 1                          |
| AD gradients/update(CTMC, rates) transition gradient/Mooncake reverse                             | 3.14 k allocs: 0.48 MB    | 3.14 k allocs: 0.48 MB    | 1                          |
| AD gradients/update(CTMC, rates) transition gradient/ReverseDiff (tape)                           | 8.23 k allocs: 0.344 MB   | 8.23 k allocs: 0.344 MB   | 1                          |
| AD gradients/update(Coxian, rates) survival gradient/Enzyme forward                               | 0.402 k allocs: 21 kB     | 0.402 k allocs: 21 kB     | 1                          |
| AD gradients/update(Coxian, rates) survival gradient/Enzyme reverse                               | 0.702 k allocs: 0.0738 MB | 0.702 k allocs: 0.0738 MB | 1                          |
| AD gradients/update(Coxian, rates) survival gradient/ForwardDiff                                  | 0.131 k allocs: 10.6 kB   | 0.131 k allocs: 10.6 kB   | 1                          |
| AD gradients/update(Coxian, rates) survival gradient/Mooncake forward                             | 0.87 k allocs: 0.0458 MB  | 0.87 k allocs: 0.0458 MB  | 1                          |
| AD gradients/update(Coxian, rates) survival gradient/Mooncake reverse                             | 2.7 k allocs: 0.282 MB    | 2.7 k allocs: 0.282 MB    | 1                          |
| AD gradients/update(Coxian, rates) survival gradient/ReverseDiff (tape)                           | 3.68 k allocs: 0.153 MB   | 3.68 k allocs: 0.153 MB   | 1                          |
| AD gradients/update(ErlangChain, rates) survival gradient/Enzyme forward                          | 0.263 k allocs: 16.7 kB   | 0.263 k allocs: 16.7 kB   | 1                          |
| AD gradients/update(ErlangChain, rates) survival gradient/Enzyme reverse                          | 0.77 k allocs: 0.0824 MB  | 0.77 k allocs: 0.0824 MB  | 1                          |
| AD gradients/update(ErlangChain, rates) survival gradient/ForwardDiff                             | 0.126 k allocs: 12.4 kB   | 0.126 k allocs: 12.4 kB   | 1                          |
| AD gradients/update(ErlangChain, rates) survival gradient/Mooncake forward                        | 0.594 k allocs: 0.0374 MB | 0.594 k allocs: 0.0374 MB | 1                          |
| AD gradients/update(ErlangChain, rates) survival gradient/Mooncake reverse                        | 3.38 k allocs: 0.499 MB   | 3.38 k allocs: 0.499 MB   | 1                          |
| AD gradients/update(ErlangChain, rates) survival gradient/ReverseDiff (tape)                      | 9.07 k allocs: 0.376 MB   | 9.07 k allocs: 0.376 MB   | 1                          |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Enzyme forward                      | 0.372 k allocs: 19.6 kB   | 0.372 k allocs: 19.6 kB   | 1                          |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Enzyme reverse                      | 0.633 k allocs: 0.072 MB  | 0.633 k allocs: 0.072 MB  | 1                          |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/ForwardDiff                         | 0.121 k allocs: 9.91 kB   | 0.121 k allocs: 9.91 kB   | 1                          |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Mooncake forward                    | 0.812 k allocs: 0.043 MB  | 0.812 k allocs: 0.043 MB  | 1                          |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Mooncake reverse                    | 2.65 k allocs: 0.281 MB   | 2.65 k allocs: 0.281 MB   | 1                          |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/ReverseDiff (tape)                  | 3.43 k allocs: 0.144 MB   | 3.43 k allocs: 0.144 MB   | 1                          |
| Bridges/jump_problem (JumpProcesses)                                                              | 0.052 k allocs: 2.38 kB   | 0.052 k allocs: 2.38 kB   | 1                          |
| Bridges/ode_problem (SciMLBase)                                                                   | 0.082 k allocs: 3.41 kB   | 0.082 k allocs: 3.41 kB   | 1                          |
| Bridges/reaction_system (Catalyst)                                                                | 0.702 k allocs: 26.6 kB   | 0.702 k allocs: 26.6 kB   | 1                          |
| Evaluation/ctmc builder + transition_probability                                                  | 0.11 k allocs: 7.69 kB    | 0.11 k allocs: 7.69 kB    | 1                          |
| Evaluation/phase-type matrix_exp                                                                  | 0.114 k allocs: 6.22 kB   | 0.114 k allocs: 6.22 kB   | 1                          |
| Lowering/canonical(Erlang branch)                                                                 | 4  allocs: 0.219 kB       | 4  allocs: 0.219 kB       | 1                          |
| Lowering/canonical(PhaseType branch)                                                              | 4  allocs: 0.188 kB       | 4  allocs: 0.188 kB       | 1                          |
| Lowering/canonical(fixed phases)                                                                  | 4  allocs: 0.359 kB       | 4  allocs: 0.359 kB       | 1                          |
| Lowering/lower(Exponential)                                                                       | 15  allocs: 0.797 kB      | 15  allocs: 0.797 kB      | 1                          |
| Lowering/lower(Gamma, Erlang branch)                                                              | 3  allocs: 0.0938 kB      | 3  allocs: 0.0938 kB      | 1                          |
| Lowering/lower(Gamma, PhaseType branch)                                                           | 5  allocs: 0.219 kB       | 5  allocs: 0.219 kB       | 1                          |
| time_to_load                                                                                      | 0.149 k allocs: 11.2 kB   | 0.149 k allocs: 11.2 kB   | 1                          |

