|                                                                                                   | v0.1.0             | 6e017a76a73d65...  | v0.1.0 / 6e017a76a73d65... |
|:--------------------------------------------------------------------------------------------------|:------------------:|:------------------:|:--------------------------:|
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ForwardDiff                 | 21.8 ± 7.3 μs      | 21.6 ± 7.3 μs      | 1.01 ± 0.48                |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake forward            | 0.246 ± 0.02 ms    | 0.24 ± 0.023 ms    | 1.03 ± 0.13                |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake reverse            | 1.32 ± 0.043 ms    | 1.28 ± 0.052 ms    | 1.03 ± 0.054               |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ReverseDiff (tape)          | 0.79 ± 0.11 ms     | 0.782 ± 0.13 ms    | 1.01 ± 0.22                |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme forward                        | 0.0943 ± 0.0065 ms | 0.0954 ± 0.0065 ms | 0.988 ± 0.096              |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme reverse                        | 0.44 ± 0.031 ms    | 0.443 ± 0.034 ms   | 0.993 ± 0.1                |
| AD gradients/lower(composer) joint-CTMC transition gradient/ForwardDiff                           | 0.0418 ± 0.0038 ms | 0.0426 ± 0.0035 ms | 0.981 ± 0.12               |
| AD gradients/lower(composer) joint-CTMC transition gradient/Mooncake forward                      | 0.199 ± 0.015 ms   | 0.213 ± 0.018 ms   | 0.938 ± 0.11               |
| AD gradients/lower(composer) joint-CTMC transition gradient/Mooncake reverse                      | 2.03 ± 0.2 ms      | 2.05 ± 0.18 ms     | 0.988 ± 0.13               |
| AD gradients/lower(composer) joint-CTMC transition gradient/ReverseDiff (tape)                    | 2.68 ± 0.4 ms      | 2.65 ± 0.44 ms     | 1.01 ± 0.22                |
| AD gradients/lower(composer) scalar-composer survival gradient/Enzyme forward                     | 0.0466 ± 0.0058 ms | 0.0436 ± 0.0052 ms | 1.07 ± 0.19                |
| AD gradients/lower(composer) scalar-composer survival gradient/Enzyme reverse                     | 0.549 ± 0.036 ms   | 0.563 ± 0.039 ms   | 0.974 ± 0.093              |
| AD gradients/lower(composer) scalar-composer survival gradient/ForwardDiff                        | 19.2 ± 4.5 μs      | 18.6 ± 4.8 μs      | 1.03 ± 0.36                |
| AD gradients/lower(composer) scalar-composer survival gradient/Mooncake forward                   | 0.113 ± 0.018 ms   | 0.117 ± 0.021 ms   | 0.965 ± 0.23               |
| AD gradients/lower(composer) scalar-composer survival gradient/Mooncake reverse                   | 1.66 ± 0.097 ms    | 1.67 ± 0.07 ms     | 0.991 ± 0.071              |
| AD gradients/lower(composer) scalar-composer survival gradient/ReverseDiff (tape)                 | 0.822 ± 0.15 ms    | 0.81 ± 0.14 ms     | 1.02 ± 0.25                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme forward         | 10.2 ± 3.6 μs      | 10.2 ± 3.5 μs      | 1 ± 0.49                   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme reverse         | 0.253 ± 0.024 ms   | 0.261 ± 0.027 ms   | 0.971 ± 0.14               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ForwardDiff            | 7.59 ± 0.8 μs      | 7.61 ± 0.76 μs     | 0.999 ± 0.14               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake forward       | 0.0391 ± 0.012 ms  | 0.0389 ± 0.012 ms  | 1.01 ± 0.44                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake reverse       | 0.472 ± 0.12 ms    | 0.462 ± 0.12 ms    | 1.02 ± 0.37                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ReverseDiff (tape)     | 0.772 ± 0.12 ms    | 0.767 ± 0.13 ms    | 1.01 ± 0.22                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme forward     | 9.44 ± 1.7 μs      | 10 ± 3.9 μs        | 0.94 ± 0.4                 |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme reverse     | 0.239 ± 0.024 ms   | 0.244 ± 0.025 ms   | 0.979 ± 0.14               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ForwardDiff        | 4.94 ± 0.96 μs     | 4.93 ± 1.1 μs      | 1 ± 0.29                   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake forward   | 25.4 ± 2.2 μs      | 25.9 ± 2.7 μs      | 0.982 ± 0.13               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake reverse   | 0.347 ± 0.03 ms    | 0.337 ± 0.032 ms   | 1.03 ± 0.13                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ReverseDiff (tape) | 0.294 ± 0.046 ms   | 0.294 ± 0.048 ms   | 1 ± 0.23                   |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme forward                       | 9.58 ± 1.4 μs      | 9.66 ± 1.6 μs      | 0.992 ± 0.22               |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme reverse                       | 0.234 ± 0.025 ms   | 0.24 ± 0.021 ms    | 0.976 ± 0.13               |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ForwardDiff                          | 5.15 ± 0.79 μs     | 5.07 ± 0.9 μs      | 1.02 ± 0.24                |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake forward                     | 26 ± 4.5 μs        | 26.7 ± 3.7 μs      | 0.975 ± 0.22               |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake reverse                     | 0.314 ± 0.031 ms   | 0.305 ± 0.037 ms   | 1.03 ± 0.16                |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ReverseDiff (tape)                   | 0.335 ± 0.046 ms   | 0.336 ± 0.048 ms   | 0.997 ± 0.2                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme forward                     | 9.64 ± 1.5 μs      | 9.54 ± 0.84 μs     | 1.01 ± 0.18                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme reverse                     | 0.235 ± 0.019 ms   | 0.242 ± 0.021 ms   | 0.971 ± 0.11               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ForwardDiff                        | 5.07 ± 0.96 μs     | 5.13 ± 1.1 μs      | 0.989 ± 0.29               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake forward                   | 27 ± 3.7 μs        | 26.9 ± 3.2 μs      | 1 ± 0.18                   |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake reverse                   | 0.334 ± 0.025 ms   | 0.325 ± 0.026 ms   | 1.03 ± 0.11                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ReverseDiff (tape)                 | 0.348 ± 0.046 ms   | 0.345 ± 0.05 ms    | 1.01 ± 0.2                 |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme forward                     | 10.1 ± 3.6 μs      | 10.2 ± 3.5 μs      | 0.987 ± 0.49               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme reverse                     | 0.235 ± 0.025 ms   | 0.238 ± 0.022 ms   | 0.985 ± 0.14               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ForwardDiff                        | 7.37 ± 0.74 μs     | 7.47 ± 0.86 μs     | 0.987 ± 0.15               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake forward                   | 0.0375 ± 0.012 ms  | 0.0378 ± 0.012 ms  | 0.992 ± 0.43               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake reverse                   | 0.45 ± 0.11 ms     | 0.456 ± 0.11 ms    | 0.988 ± 0.35               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ReverseDiff (tape)                 | 0.77 ± 0.11 ms     | 0.764 ± 0.11 ms    | 1.01 ± 0.2                 |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme forward          | 26.6 ± 2.7 μs      | 26.9 ± 2.5 μs      | 0.991 ± 0.14               |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme reverse          | 0.116 ± 0.0062 ms  | 0.117 ± 0.0097 ms  | 0.996 ± 0.098              |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ForwardDiff             | 15.8 ± 0.61 μs     | 15.8 ± 0.76 μs     | 1 ± 0.062                  |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake forward        | 0.0638 ± 0.0043 ms | 0.0634 ± 0.0046 ms | 1.01 ± 0.099               |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake reverse        | 0.346 ± 0.046 ms   | 0.336 ± 0.045 ms   | 1.03 ± 0.2                 |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ReverseDiff (tape)      | 2.76 ± 0.46 ms     | 2.76 ± 0.45 ms     | 1 ± 0.23                   |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme forward                     | 23.7 ± 9.5 μs      | 24 ± 9.8 μs        | 0.99 ± 0.57                |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme reverse                     | 0.241 ± 0.02 ms    | 0.246 ± 0.028 ms   | 0.98 ± 0.14                |
| AD gradients/matrix_exp/transition_probability direct gradient/ForwardDiff                        | 12.6 ± 0.79 μs     | 13.4 ± 1.7 μs      | 0.942 ± 0.13               |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake forward                   | 0.0696 ± 0.0079 ms | 0.0683 ± 0.0089 ms | 1.02 ± 0.18                |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake reverse                   | 0.437 ± 0.032 ms   | 0.425 ± 0.038 ms   | 1.03 ± 0.12                |
| AD gradients/matrix_exp/transition_probability direct gradient/ReverseDiff (tape)                 | 0.772 ± 0.14 ms    | 0.768 ± 0.15 ms    | 1 ± 0.26                   |
| AD gradients/ode_problem solve survival gradient (PhaseType)/Enzyme forward                       | 17 ± 0.66 ms       | 16.9 ± 0.58 ms     | 1.01 ± 0.052               |
| AD gradients/ode_problem solve survival gradient (PhaseType)/ForwardDiff                          | 0.294 ± 0.013 ms   | 0.291 ± 0.013 ms   | 1.01 ± 0.063               |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/Enzyme forward               | 17.1 ± 0.68 ms     | 16.9 ± 0.62 ms     | 1.01 ± 0.055               |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/ForwardDiff                  | 0.292 ± 0.013 ms   | 0.291 ± 0.013 ms   | 1 ± 0.063                  |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme forward                           | 6.19 ± 0.064 μs    | 6.26 ± 0.082 μs    | 0.988 ± 0.016              |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme reverse                           | 1.34 ± 0.037 μs    | 1.3 ± 0.037 μs     | 1.03 ± 0.041               |
| AD gradients/phase_type hyperexponential (α, S) gradient/ForwardDiff                              | 0.509 ± 0.062 μs   | 0.487 ± 0.053 μs   | 1.05 ± 0.17                |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake forward                         | 11.3 ± 0.45 μs     | 11.4 ± 0.51 μs     | 0.989 ± 0.059              |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake reverse                         | 15.3 ± 0.56 μs     | 15.3 ± 0.72 μs     | 0.999 ± 0.06               |
| AD gradients/phase_type hyperexponential (α, S) gradient/ReverseDiff (tape)                       | 7.96 ± 0.16 μs     | 8.01 ± 0.22 μs     | 0.994 ± 0.034              |
| AD gradients/update(CTMC, rates) transition gradient/Enzyme forward                               | 21.9 ± 8.7 μs      | 22.3 ± 8.9 μs      | 0.982 ± 0.56               |
| AD gradients/update(CTMC, rates) transition gradient/Enzyme reverse                               | 0.242 ± 0.021 ms   | 0.249 ± 0.027 ms   | 0.97 ± 0.14                |
| AD gradients/update(CTMC, rates) transition gradient/ForwardDiff                                  | 11.9 ± 1.2 μs      | 12.5 ± 1.3 μs      | 0.949 ± 0.14               |
| AD gradients/update(CTMC, rates) transition gradient/Mooncake forward                             | 0.0684 ± 0.006 ms  | 0.0694 ± 0.0069 ms | 0.986 ± 0.13               |
| AD gradients/update(CTMC, rates) transition gradient/Mooncake reverse                             | 0.471 ± 0.039 ms   | 0.462 ± 0.042 ms   | 1.02 ± 0.13                |
| AD gradients/update(CTMC, rates) transition gradient/ReverseDiff (tape)                           | 0.712 ± 0.14 ms    | 0.709 ± 0.13 ms    | 1 ± 0.27                   |
| AD gradients/update(Coxian, rates) survival gradient/Enzyme forward                               | 11.5 ± 1.2 μs      | 11.8 ± 1.8 μs      | 0.976 ± 0.18               |
| AD gradients/update(Coxian, rates) survival gradient/Enzyme reverse                               | 0.236 ± 0.024 ms   | 0.244 ± 0.024 ms   | 0.969 ± 0.13               |
| AD gradients/update(Coxian, rates) survival gradient/ForwardDiff                                  | 6.4 ± 1.1 μs       | 6.29 ± 1 μs        | 1.02 ± 0.24                |
| AD gradients/update(Coxian, rates) survival gradient/Mooncake forward                             | 0.0448 ± 0.012 ms  | 0.0447 ± 0.012 ms  | 1 ± 0.38                   |
| AD gradients/update(Coxian, rates) survival gradient/Mooncake reverse                             | 0.346 ± 0.031 ms   | 0.329 ± 0.037 ms   | 1.05 ± 0.15                |
| AD gradients/update(Coxian, rates) survival gradient/ReverseDiff (tape)                           | 0.34 ± 0.047 ms    | 0.336 ± 0.053 ms   | 1.01 ± 0.21                |
| AD gradients/update(ErlangChain, rates) survival gradient/Enzyme forward                          | 10.9 ± 0.9 μs      | 10.3 ± 0.98 μs     | 1.05 ± 0.13                |
| AD gradients/update(ErlangChain, rates) survival gradient/Enzyme reverse                          | 0.253 ± 0.024 ms   | 0.26 ± 0.024 ms    | 0.974 ± 0.13               |
| AD gradients/update(ErlangChain, rates) survival gradient/ForwardDiff                             | 7.92 ± 0.58 μs     | 7.7 ± 0.62 μs      | 1.03 ± 0.11                |
| AD gradients/update(ErlangChain, rates) survival gradient/Mooncake forward                        | 0.0404 ± 0.012 ms  | 0.0481 ± 0.013 ms  | 0.84 ± 0.34                |
| AD gradients/update(ErlangChain, rates) survival gradient/Mooncake reverse                        | 0.505 ± 0.039 ms   | 0.487 ± 0.041 ms   | 1.04 ± 0.12                |
| AD gradients/update(ErlangChain, rates) survival gradient/ReverseDiff (tape)                      | 0.791 ± 0.15 ms    | 0.789 ± 0.14 ms    | 1 ± 0.26                   |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Enzyme forward                      | 11.1 ± 1.2 μs      | 11.4 ± 1.5 μs      | 0.969 ± 0.16               |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Enzyme reverse                      | 0.233 ± 0.021 ms   | 0.238 ± 0.023 ms   | 0.98 ± 0.13                |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/ForwardDiff                         | 6.01 ± 0.95 μs     | 6.18 ± 0.92 μs     | 0.973 ± 0.21               |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Mooncake forward                    | 0.0386 ± 0.012 ms  | 0.0413 ± 0.012 ms  | 0.935 ± 0.4                |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Mooncake reverse                    | 0.331 ± 0.029 ms   | 0.32 ± 0.028 ms    | 1.04 ± 0.13                |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/ReverseDiff (tape)                  | 0.306 ± 0.047 ms   | 0.303 ± 0.052 ms   | 1.01 ± 0.23                |
| Bridges/jump_problem (JumpProcesses)                                                              | 1.48 ± 0.1 μs      | 1.39 ± 0.085 μs    | 1.06 ± 0.098               |
| Bridges/ode_problem (SciMLBase)                                                                   | 0.166 ± 0.0044 ms  | 0.166 ± 0.0046 ms  | 1 ± 0.038                  |
| Bridges/reaction_system (Catalyst)                                                                | 0.0798 ± 0.0024 ms | 0.125 ± 0.0071 ms  | 0.637 ± 0.041              |
| Evaluation/ctmc builder + transition_probability                                                  | 4.59 ± 0.89 μs     | 4.83 ± 1 μs        | 0.95 ± 0.27                |
| Evaluation/phase-type matrix_exp                                                                  | 3.54 ± 2.3 μs      | 4.21 ± 2.4 μs      | 0.84 ± 0.73                |
| Lowering/canonical(Erlang branch)                                                                 | 0.157 ± 0.035 μs   | 0.163 ± 0.035 μs   | 0.959 ± 0.29               |
| Lowering/canonical(PhaseType branch)                                                              | 0.125 ± 0.056 μs   | 0.125 ± 0.051 μs   | 1 ± 0.61                   |
| Lowering/canonical(fixed phases)                                                                  | 0.198 ± 0.027 μs   | 0.198 ± 0.029 μs   | 0.999 ± 0.2                |
| Lowering/lower(Exponential)                                                                       | 1.53 ± 0.047 μs    | 1.55 ± 0.049 μs    | 0.983 ± 0.043              |
| Lowering/lower(Gamma, Erlang branch)                                                              | 0.0458 ± 0.025 μs  | 0.0458 ± 0.025 μs  | 1 ± 0.77                   |
| Lowering/lower(Gamma, PhaseType branch)                                                           | 0.127 ± 0.061 μs   | 0.125 ± 0.054 μs   | 1.01 ± 0.66                |
| time_to_load                                                                                      | 0.486 ± 0.0024 s   | 0.495 ± 0.0008 s   | 0.982 ± 0.005              |

|                                                                                                   | v0.1.0                    | 6e017a76a73d65...         | v0.1.0 / 6e017a76a73d65... |
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
| AD gradients/ode_problem solve survival gradient (PhaseType)/Enzyme forward                       | 0.0549 M allocs: 2.35 MB  | 0.0549 M allocs: 2.35 MB  | 1                          |
| AD gradients/ode_problem solve survival gradient (PhaseType)/ForwardDiff                          | 0.666 k allocs: 0.0489 MB | 0.666 k allocs: 0.0489 MB | 1                          |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/Enzyme forward               | 0.0549 M allocs: 2.35 MB  | 0.0549 M allocs: 2.35 MB  | 1                          |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/ForwardDiff                  | 0.674 k allocs: 0.0493 MB | 0.674 k allocs: 0.0493 MB | 1                          |
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
| Bridges/ode_problem (SciMLBase)                                                                   | 0.596 k allocs: 0.0446 MB | 0.596 k allocs: 0.0446 MB | 1                          |
| Bridges/reaction_system (Catalyst)                                                                | 0.68 k allocs: 25.7 kB    | 0.68 k allocs: 25.7 kB    | 1                          |
| Evaluation/ctmc builder + transition_probability                                                  | 0.11 k allocs: 7.69 kB    | 0.11 k allocs: 7.69 kB    | 1                          |
| Evaluation/phase-type matrix_exp                                                                  | 0.114 k allocs: 6.22 kB   | 0.114 k allocs: 6.22 kB   | 1                          |
| Lowering/canonical(Erlang branch)                                                                 | 4  allocs: 0.219 kB       | 4  allocs: 0.219 kB       | 1                          |
| Lowering/canonical(PhaseType branch)                                                              | 4  allocs: 0.188 kB       | 4  allocs: 0.188 kB       | 1                          |
| Lowering/canonical(fixed phases)                                                                  | 4  allocs: 0.359 kB       | 4  allocs: 0.359 kB       | 1                          |
| Lowering/lower(Exponential)                                                                       | 15  allocs: 0.797 kB      | 15  allocs: 0.797 kB      | 1                          |
| Lowering/lower(Gamma, Erlang branch)                                                              | 3  allocs: 0.0938 kB      | 3  allocs: 0.0938 kB      | 1                          |
| Lowering/lower(Gamma, PhaseType branch)                                                           | 5  allocs: 0.219 kB       | 5  allocs: 0.219 kB       | 1                          |
| time_to_load                                                                                      | 0.149 k allocs: 11.2 kB   | 0.149 k allocs: 11.2 kB   | 1                          |

