|                                                                                                   | v0.1.0             | 1ff0eed2187f9c...  | v0.1.0 / 1ff0eed2187f9c... |
|:--------------------------------------------------------------------------------------------------|:------------------:|:------------------:|:--------------------------:|
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ForwardDiff                 | 21.6 ± 7.4 μs      | 21.6 ± 7.6 μs      | 1 ± 0.49                   |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake forward            | 0.241 ± 0.02 ms    | 0.234 ± 0.021 ms   | 1.03 ± 0.13                |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake reverse            | 1.35 ± 0.053 ms    | 1.3 ± 0.081 ms     | 1.04 ± 0.077               |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ReverseDiff (tape)          | 0.807 ± 0.14 ms    | 0.791 ± 0.14 ms    | 1.02 ± 0.25                |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme forward                        | 0.285 ± 0.014 ms   | 0.0892 ± 0.0055 ms | 3.19 ± 0.25                |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme reverse                        | 0.653 ± 0.027 ms   | 0.454 ± 0.038 ms   | 1.44 ± 0.13                |
| AD gradients/lower(composer) joint-CTMC transition gradient/ForwardDiff                           | 0.206 ± 0.011 ms   | 0.0408 ± 0.0038 ms | 5.05 ± 0.54                |
| AD gradients/lower(composer) joint-CTMC transition gradient/Mooncake forward                      | 0.734 ± 0.029 ms   | 0.213 ± 0.016 ms   | 3.45 ± 0.29                |
| AD gradients/lower(composer) joint-CTMC transition gradient/Mooncake reverse                      | 2.54 ± 0.061 ms    | 2.01 ± 0.2 ms      | 1.26 ± 0.13                |
| AD gradients/lower(composer) joint-CTMC transition gradient/ReverseDiff (tape)                    | 2.89 ± 0.48 ms     | 2.68 ± 0.49 ms     | 1.08 ± 0.27                |
| AD gradients/lower(composer) scalar-composer survival gradient/Enzyme forward                     | 0.19 ± 0.014 ms    | 0.0438 ± 0.0048 ms | 4.33 ± 0.57                |
| AD gradients/lower(composer) scalar-composer survival gradient/Enzyme reverse                     | 0.713 ± 0.06 ms    | 0.569 ± 0.082 ms   | 1.25 ± 0.21                |
| AD gradients/lower(composer) scalar-composer survival gradient/ForwardDiff                        | 0.149 ± 0.015 ms   | 19.5 ± 4.6 μs      | 7.63 ± 1.9                 |
| AD gradients/lower(composer) scalar-composer survival gradient/Mooncake forward                   | 0.528 ± 0.027 ms   | 0.115 ± 0.016 ms   | 4.58 ± 0.67                |
| AD gradients/lower(composer) scalar-composer survival gradient/Mooncake reverse                   | 2.17 ± 0.11 ms     | 1.7 ± 0.1 ms       | 1.28 ± 0.1                 |
| AD gradients/lower(composer) scalar-composer survival gradient/ReverseDiff (tape)                 | 0.985 ± 0.074 ms   | 0.814 ± 0.15 ms    | 1.21 ± 0.23                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme forward         | 10.1 ± 0.95 μs     | 10.2 ± 0.95 μs     | 0.993 ± 0.13               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme reverse         | 0.26 ± 0.033 ms    | 0.261 ± 0.033 ms   | 0.996 ± 0.18               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ForwardDiff            | 7.44 ± 0.48 μs     | 7.44 ± 0.52 μs     | 1 ± 0.095                  |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake forward       | 0.0395 ± 0.011 ms  | 0.0397 ± 0.012 ms  | 0.994 ± 0.41               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake reverse       | 0.52 ± 0.041 ms    | 0.466 ± 0.032 ms   | 1.12 ± 0.12                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ReverseDiff (tape)     | 0.783 ± 0.15 ms    | 0.773 ± 0.14 ms    | 1.01 ± 0.26                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme forward     | 9.4 ± 1 μs         | 9.59 ± 3.2 μs      | 0.98 ± 0.34                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme reverse     | 0.249 ± 0.059 ms   | 0.245 ± 0.025 ms   | 1.02 ± 0.26                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ForwardDiff        | 4.69 ± 0.44 μs     | 4.7 ± 0.48 μs      | 0.997 ± 0.14               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake forward   | 26.1 ± 2.3 μs      | 27.2 ± 2.2 μs      | 0.958 ± 0.11               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake reverse   | 0.36 ± 0.03 ms     | 0.334 ± 0.032 ms   | 1.08 ± 0.14                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ReverseDiff (tape) | 0.298 ± 0.043 ms   | 0.292 ± 0.042 ms   | 1.02 ± 0.21                |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme forward                       | 9.49 ± 1.6 μs      | 9.82 ± 1.8 μs      | 0.966 ± 0.24               |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme reverse                       | 0.25 ± 0.036 ms    | 0.243 ± 0.023 ms   | 1.03 ± 0.18                |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ForwardDiff                          | 5.13 ± 0.53 μs     | 5.04 ± 0.56 μs     | 1.02 ± 0.15                |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake forward                     | 26.3 ± 1.7 μs      | 26.4 ± 1.7 μs      | 0.997 ± 0.09               |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake reverse                     | 0.342 ± 0.032 ms   | 0.313 ± 0.031 ms   | 1.09 ± 0.15                |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ReverseDiff (tape)                   | 0.335 ± 0.052 ms   | 0.328 ± 0.051 ms   | 1.02 ± 0.23                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme forward                     | 9.6 ± 1.6 μs       | 9.87 ± 1.9 μs      | 0.973 ± 0.25               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme reverse                     | 0.248 ± 0.027 ms   | 0.246 ± 0.023 ms   | 1.01 ± 0.15                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ForwardDiff                        | 5.2 ± 0.57 μs      | 5.09 ± 0.63 μs     | 1.02 ± 0.17                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake forward                   | 26.8 ± 2 μs        | 26.9 ± 1.9 μs      | 0.996 ± 0.1                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake reverse                   | 0.36 ± 0.033 ms    | 0.327 ± 0.03 ms    | 1.1 ± 0.14                 |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ReverseDiff (tape)                 | 0.345 ± 0.054 ms   | 0.339 ± 0.049 ms   | 1.02 ± 0.22                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme forward                     | 10.1 ± 0.94 μs     | 10.1 ± 0.91 μs     | 0.999 ± 0.13               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme reverse                     | 0.239 ± 0.024 ms   | 0.242 ± 0.026 ms   | 0.99 ± 0.14                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ForwardDiff                        | 7.24 ± 0.46 μs     | 7.26 ± 0.47 μs     | 0.998 ± 0.091              |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake forward                   | 0.0377 ± 0.011 ms  | 0.0385 ± 0.011 ms  | 0.981 ± 0.41               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake reverse                   | 0.475 ± 0.037 ms   | 0.441 ± 0.032 ms   | 1.08 ± 0.11                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ReverseDiff (tape)                 | 0.783 ± 0.14 ms    | 0.771 ± 0.14 ms    | 1.01 ± 0.26                |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme forward          | 26.4 ± 2.7 μs      | 26.7 ± 2.8 μs      | 0.989 ± 0.15               |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme reverse          | 0.115 ± 0.0077 ms  | 0.118 ± 0.0093 ms  | 0.98 ± 0.1                 |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ForwardDiff             | 15.8 ± 2 μs        | 15.8 ± 2.2 μs      | 1 ± 0.19                   |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake forward        | 0.064 ± 0.004 ms   | 0.0635 ± 0.004 ms  | 1.01 ± 0.089               |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake reverse        | 0.38 ± 0.024 ms    | 0.357 ± 0.026 ms   | 1.06 ± 0.1                 |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ReverseDiff (tape)      | 2.79 ± 0.51 ms     | 2.76 ± 0.51 ms     | 1.01 ± 0.26                |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme forward                     | 24.1 ± 9.9 μs      | 23.8 ± 9.2 μs      | 1.01 ± 0.57                |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme reverse                     | 0.255 ± 0.036 ms   | 0.253 ± 0.025 ms   | 1.01 ± 0.17                |
| AD gradients/matrix_exp/transition_probability direct gradient/ForwardDiff                        | 12.9 ± 1.6 μs      | 13.8 ± 1.6 μs      | 0.936 ± 0.16               |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake forward                   | 0.0691 ± 0.0055 ms | 0.0689 ± 0.0063 ms | 1 ± 0.12                   |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake reverse                   | 0.445 ± 0.032 ms   | 0.428 ± 0.033 ms   | 1.04 ± 0.11                |
| AD gradients/matrix_exp/transition_probability direct gradient/ReverseDiff (tape)                 | 0.781 ± 0.14 ms    | 0.769 ± 0.14 ms    | 1.02 ± 0.26                |
| AD gradients/ode_problem solve survival gradient (PhaseType)/Enzyme forward                       | 16.8 ± 0.69 ms     | 16.7 ± 0.69 ms     | 1.01 ± 0.058               |
| AD gradients/ode_problem solve survival gradient (PhaseType)/ForwardDiff                          | 0.14 ± 0.0034 ms   | 0.141 ± 0.003 ms   | 0.992 ± 0.032              |
| AD gradients/ode_problem solve survival gradient (PhaseType)/Mooncake forward                     | 0.11 ± 0.018 s     | 0.112 ± 0.023 s    | 0.981 ± 0.26               |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/Enzyme forward               | 16.6 ± 0.62 ms     | 16.7 ± 0.66 ms     | 0.991 ± 0.054              |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/ForwardDiff                  | 0.141 ± 0.0033 ms  | 0.14 ± 0.0032 ms   | 1.01 ± 0.033               |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/Mooncake forward             | 0.111 ± 0.019 s    | 0.111 ± 0.019 s    | 0.999 ± 0.24               |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme forward                           | 6.05 ± 0.067 μs    | 6.11 ± 0.08 μs     | 0.991 ± 0.017              |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme reverse                           | 1.34 ± 0.043 μs    | 1.39 ± 0.063 μs    | 0.962 ± 0.054              |
| AD gradients/phase_type hyperexponential (α, S) gradient/ForwardDiff                              | 0.526 ± 0.06 μs    | 0.476 ± 0.054 μs   | 1.11 ± 0.18                |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake forward                         | 11.6 ± 0.48 μs     | 11.6 ± 0.56 μs     | 1 ± 0.064                  |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake reverse                         | 16.4 ± 0.73 μs     | 15.5 ± 0.78 μs     | 1.06 ± 0.072               |
| AD gradients/phase_type hyperexponential (α, S) gradient/ReverseDiff (tape)                       | 8.01 ± 0.26 μs     | 8 ± 0.25 μs        | 1 ± 0.045                  |
| AD gradients/update(CTMC, rates) transition gradient/Enzyme forward                               | 22.6 ± 8.7 μs      | 21.4 ± 7.9 μs      | 1.06 ± 0.56                |
| AD gradients/update(CTMC, rates) transition gradient/Enzyme reverse                               | 0.254 ± 0.029 ms   | 0.261 ± 0.036 ms   | 0.974 ± 0.17               |
| AD gradients/update(CTMC, rates) transition gradient/ForwardDiff                                  | 12.2 ± 1.4 μs      | 12.9 ± 1.5 μs      | 0.95 ± 0.15                |
| AD gradients/update(CTMC, rates) transition gradient/Mooncake forward                             | 0.0687 ± 0.0048 ms | 0.0698 ± 0.0056 ms | 0.983 ± 0.1                |
| AD gradients/update(CTMC, rates) transition gradient/Mooncake reverse                             | 0.516 ± 0.04 ms    | 0.477 ± 0.041 ms   | 1.08 ± 0.13                |
| AD gradients/update(CTMC, rates) transition gradient/ReverseDiff (tape)                           | 0.725 ± 0.15 ms    | 0.712 ± 0.15 ms    | 1.02 ± 0.31                |
| AD gradients/update(Coxian, rates) survival gradient/Enzyme forward                               | 12.1 ± 1.4 μs      | 11.3 ± 1.4 μs      | 1.06 ± 0.18                |
| AD gradients/update(Coxian, rates) survival gradient/Enzyme reverse                               | 0.25 ± 0.028 ms    | 0.252 ± 0.026 ms   | 0.992 ± 0.15               |
| AD gradients/update(Coxian, rates) survival gradient/ForwardDiff                                  | 6.78 ± 1.1 μs      | 6.59 ± 0.58 μs     | 1.03 ± 0.19                |
| AD gradients/update(Coxian, rates) survival gradient/Mooncake forward                             | 0.047 ± 0.012 ms   | 0.0405 ± 0.012 ms  | 1.16 ± 0.44                |
| AD gradients/update(Coxian, rates) survival gradient/Mooncake reverse                             | 0.367 ± 0.038 ms   | 0.333 ± 0.035 ms   | 1.1 ± 0.16                 |
| AD gradients/update(Coxian, rates) survival gradient/ReverseDiff (tape)                           | 0.341 ± 0.061 ms   | 0.332 ± 0.05 ms    | 1.03 ± 0.24                |
| AD gradients/update(ErlangChain, rates) survival gradient/Enzyme forward                          | 10.3 ± 0.77 μs     | 10.2 ± 0.67 μs     | 1.01 ± 0.1                 |
| AD gradients/update(ErlangChain, rates) survival gradient/Enzyme reverse                          | 0.266 ± 0.035 ms   | 0.267 ± 0.027 ms   | 0.997 ± 0.16               |
| AD gradients/update(ErlangChain, rates) survival gradient/ForwardDiff                             | 7.48 ± 0.48 μs     | 7.42 ± 0.52 μs     | 1.01 ± 0.095               |
| AD gradients/update(ErlangChain, rates) survival gradient/Mooncake forward                        | 0.0429 ± 0.012 ms  | 0.0421 ± 0.012 ms  | 1.02 ± 0.41                |
| AD gradients/update(ErlangChain, rates) survival gradient/Mooncake reverse                        | 0.539 ± 0.035 ms   | 0.487 ± 0.038 ms   | 1.11 ± 0.11                |
| AD gradients/update(ErlangChain, rates) survival gradient/ReverseDiff (tape)                      | 0.802 ± 0.14 ms    | 0.793 ± 0.14 ms    | 1.01 ± 0.25                |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Enzyme forward                      | 11.7 ± 1.3 μs      | 11.7 ± 1.7 μs      | 1 ± 0.18                   |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Enzyme reverse                      | 0.245 ± 0.031 ms   | 0.246 ± 0.027 ms   | 0.997 ± 0.17               |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/ForwardDiff                         | 5.97 ± 0.49 μs     | 6.54 ± 0.52 μs     | 0.913 ± 0.1                |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Mooncake forward                    | 0.0439 ± 0.011 ms  | 0.0395 ± 0.011 ms  | 1.11 ± 0.43                |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Mooncake reverse                    | 0.378 ± 0.031 ms   | 0.32 ± 0.026 ms    | 1.18 ± 0.14                |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/ReverseDiff (tape)                  | 0.314 ± 0.046 ms   | 0.305 ± 0.045 ms   | 1.03 ± 0.21                |
| Bridges/jump_problem (JumpProcesses)                                                              | 1.26 ± 0.096 μs    | 1.27 ± 0.076 μs    | 0.989 ± 0.096              |
| Bridges/ode_problem (SciMLBase)                                                                   | 20.2 ± 0.34 μs     | 19.7 ± 0.32 μs     | 1.03 ± 0.024               |
| Bridges/reaction_system (Catalyst)                                                                | 0.15 ± 0.0049 ms   | 0.0922 ± 0.0038 ms | 1.63 ± 0.086               |
| Evaluation/ctmc builder + transition_probability                                                  | 4.32 ± 0.47 μs     | 4.46 ± 0.63 μs     | 0.97 ± 0.17                |
| Evaluation/phase-type matrix_exp                                                                  | 3.26 ± 1.6 μs      | 3.43 ± 2.3 μs      | 0.951 ± 0.79               |
| Lowering/canonical(Erlang branch)                                                                 | 0.151 ± 0.05 μs    | 0.145 ± 0.039 μs   | 1.04 ± 0.44                |
| Lowering/canonical(PhaseType branch)                                                              | 0.128 ± 0.0087 μs  | 0.136 ± 0.016 μs   | 0.935 ± 0.13               |
| Lowering/canonical(fixed phases)                                                                  | 0.191 ± 0.028 μs   | 0.198 ± 0.041 μs   | 0.961 ± 0.24               |
| Lowering/lower(Exponential)                                                                       | 23.8 ± 1.8 μs      | 1.51 ± 0.049 μs    | 15.8 ± 1.3                 |
| Lowering/lower(Gamma, Erlang branch)                                                              | 29.9 ± 23 ns       | 29 ± 25 ns         | 1.03 ± 1.2                 |
| Lowering/lower(Gamma, PhaseType branch)                                                           | 0.129 ± 0.071 μs   | 0.127 ± 0.077 μs   | 1.01 ± 0.83                |
| time_to_load                                                                                      | 0.513 ± 0.0019 s   | 0.519 ± 0.005 s    | 0.989 ± 0.01               |

|                                                                                                   | v0.1.0                    | 1ff0eed2187f9c...         | v0.1.0 / 1ff0eed2187f9c... |
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

