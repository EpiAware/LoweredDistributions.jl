|                                                                                                   | v0.1.0             | c41bf366a75137...  | v0.1.0 / c41bf366a75137... |
|:--------------------------------------------------------------------------------------------------|:------------------:|:------------------:|:--------------------------:|
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ForwardDiff                 | 21.2 ± 7.1 μs      | 21.8 ± 7.4 μs      | 0.973 ± 0.46               |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake forward            | 0.249 ± 0.021 ms   | 0.256 ± 0.02 ms    | 0.972 ± 0.11               |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/Mooncake reverse            | 1.27 ± 0.053 ms    | 1.29 ± 0.077 ms    | 0.985 ± 0.072              |
| AD gradients/ctmc(specs...) builder + transition_probability gradient/ReverseDiff (tape)          | 0.789 ± 0.13 ms    | 0.787 ± 0.15 ms    | 1 ± 0.26                   |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme forward                        | 0.0918 ± 0.0053 ms | 0.112 ± 0.0061 ms  | 0.823 ± 0.065              |
| AD gradients/lower(composer) joint-CTMC transition gradient/Enzyme reverse                        | 0.442 ± 0.038 ms   | 0.433 ± 0.027 ms   | 1.02 ± 0.11                |
| AD gradients/lower(composer) joint-CTMC transition gradient/ForwardDiff                           | 0.0396 ± 0.0035 ms | 0.0389 ± 0.0032 ms | 1.02 ± 0.12                |
| AD gradients/lower(composer) joint-CTMC transition gradient/Mooncake forward                      | 0.209 ± 0.015 ms   | 0.245 ± 0.022 ms   | 0.853 ± 0.099              |
| AD gradients/lower(composer) joint-CTMC transition gradient/Mooncake reverse                      | 2.03 ± 0.17 ms     | 2 ± 0.18 ms        | 1.02 ± 0.13                |
| AD gradients/lower(composer) joint-CTMC transition gradient/ReverseDiff (tape)                    | 2.7 ± 0.45 ms      | 2.65 ± 0.34 ms     | 1.02 ± 0.21                |
| AD gradients/lower(composer) scalar-composer survival gradient/Enzyme forward                     | 0.0448 ± 0.0058 ms | 0.0424 ± 0.0047 ms | 1.06 ± 0.18                |
| AD gradients/lower(composer) scalar-composer survival gradient/Enzyme reverse                     | 0.555 ± 0.04 ms    | 0.547 ± 0.037 ms   | 1.01 ± 0.1                 |
| AD gradients/lower(composer) scalar-composer survival gradient/ForwardDiff                        | 18.1 ± 4.8 μs      | 19 ± 4.9 μs        | 0.955 ± 0.35               |
| AD gradients/lower(composer) scalar-composer survival gradient/Mooncake forward                   | 0.117 ± 0.018 ms   | 0.116 ± 0.019 ms   | 1 ± 0.22                   |
| AD gradients/lower(composer) scalar-composer survival gradient/Mooncake reverse                   | 1.66 ± 0.095 ms    | 1.62 ± 0.095 ms    | 1.02 ± 0.084               |
| AD gradients/lower(composer) scalar-composer survival gradient/ReverseDiff (tape)                 | 0.814 ± 0.12 ms    | 0.811 ± 0.16 ms    | 1 ± 0.24                   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme forward         | 10.2 ± 3.5 μs      | 10.3 ± 3.4 μs      | 0.984 ± 0.47               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Enzyme reverse         | 0.256 ± 0.02 ms    | 0.256 ± 0.022 ms   | 1 ± 0.12                   |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ForwardDiff            | 7.59 ± 0.77 μs     | 7.71 ± 1.6 μs      | 0.985 ± 0.23               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake forward       | 0.0382 ± 0.011 ms  | 0.0377 ± 0.012 ms  | 1.01 ± 0.43                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/Mooncake reverse       | 0.467 ± 0.12 ms    | 0.465 ± 0.12 ms    | 1.01 ± 0.37                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (integer shape)/ReverseDiff (tape)     | 0.775 ± 0.13 ms    | 0.766 ± 0.09 ms    | 1.01 ± 0.21                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme forward     | 9.74 ± 1.6 μs      | 9.62 ± 1.5 μs      | 1.01 ± 0.22                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Enzyme reverse     | 0.247 ± 0.023 ms   | 0.242 ± 0.018 ms   | 1.02 ± 0.12                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ForwardDiff        | 4.81 ± 1.2 μs      | 4.78 ± 1.3 μs      | 1.01 ± 0.38                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake forward   | 25.6 ± 3.1 μs      | 25.4 ± 2.2 μs      | 1.01 ± 0.15                |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/Mooncake reverse   | 0.336 ± 0.03 ms    | 0.341 ± 0.029 ms   | 0.984 ± 0.12               |
| AD gradients/lower(dist) adaptive Erlang survival gradient (non-integer shape)/ReverseDiff (tape) | 0.293 ± 0.049 ms   | 0.291 ± 0.041 ms   | 1.01 ± 0.22                |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme forward                       | 9.67 ± 1.5 μs      | 9.54 ± 1.3 μs      | 1.01 ± 0.21                |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Enzyme reverse                       | 0.246 ± 0.026 ms   | 0.243 ± 0.021 ms   | 1.01 ± 0.14                |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ForwardDiff                          | 5.14 ± 0.88 μs     | 5 ± 1 μs           | 1.03 ± 0.27                |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake forward                     | 25.6 ± 4.9 μs      | 26.3 ± 4.5 μs      | 0.972 ± 0.25               |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/Mooncake reverse                     | 0.306 ± 0.028 ms   | 0.302 ± 0.032 ms   | 1.01 ± 0.14                |
| AD gradients/lower(dist) adaptive-dispatch survival gradient/ReverseDiff (tape)                   | 0.327 ± 0.056 ms   | 0.333 ± 0.051 ms   | 0.981 ± 0.23               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme forward                     | 9.48 ± 1.3 μs      | 9.66 ± 1.6 μs      | 0.981 ± 0.21               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Enzyme reverse                     | 0.242 ± 0.023 ms   | 0.238 ± 0.018 ms   | 1.02 ± 0.12                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ForwardDiff                        | 5.14 ± 0.95 μs     | 5.31 ± 1.3 μs      | 0.969 ± 0.3                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake forward                   | 26.7 ± 4 μs        | 27 ± 4.3 μs        | 0.988 ± 0.22               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/Mooncake reverse                   | 0.313 ± 0.028 ms   | 0.327 ± 0.034 ms   | 0.956 ± 0.13               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² > 1)/ReverseDiff (tape)                 | 0.335 ± 0.054 ms   | 0.345 ± 0.056 ms   | 0.972 ± 0.22               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme forward                     | 9.93 ± 3.6 μs      | 10.1 ± 3.5 μs      | 0.987 ± 0.5                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Enzyme reverse                     | 0.24 ± 0.023 ms    | 0.235 ± 0.022 ms   | 1.02 ± 0.14                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ForwardDiff                        | 7.39 ± 0.78 μs     | 7.17 ± 1.8 μs      | 1.03 ± 0.28                |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake forward                   | 0.037 ± 0.011 ms   | 0.0377 ± 0.011 ms  | 0.982 ± 0.41               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/Mooncake reverse                   | 0.438 ± 0.12 ms    | 0.44 ± 0.12 ms     | 0.995 ± 0.38               |
| AD gradients/lower(dist, PhaseType) survival gradient (c² ≤ 1)/ReverseDiff (tape)                 | 0.769 ± 0.13 ms    | 0.765 ± 0.088 ms   | 1.01 ± 0.2                 |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme forward          | 26.6 ± 2.6 μs      | 26.8 ± 2.7 μs      | 0.994 ± 0.14               |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Enzyme reverse          | 0.119 ± 0.0088 ms  | 0.118 ± 0.0061 ms  | 1.01 ± 0.092               |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ForwardDiff             | 15.7 ± 0.66 μs     | 15.5 ± 0.52 μs     | 1.01 ± 0.055               |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake forward        | 0.0619 ± 0.0042 ms | 0.0624 ± 0.0041 ms | 0.993 ± 0.094              |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/Mooncake reverse        | 0.336 ± 0.054 ms   | 0.339 ± 0.044 ms   | 0.993 ± 0.2                |
| AD gradients/lower(dist, PhaseType; phases) fixed-count survival gradient/ReverseDiff (tape)      | 2.78 ± 0.47 ms     | 2.76 ± 0.33 ms     | 1.01 ± 0.21                |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme forward                     | 23.7 ± 8.8 μs      | 23.9 ± 9.8 μs      | 0.992 ± 0.55               |
| AD gradients/matrix_exp/transition_probability direct gradient/Enzyme reverse                     | 0.25 ± 0.022 ms    | 0.241 ± 0.021 ms   | 1.04 ± 0.13                |
| AD gradients/matrix_exp/transition_probability direct gradient/ForwardDiff                        | 12.5 ± 0.66 μs     | 13.6 ± 1.5 μs      | 0.917 ± 0.11               |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake forward                   | 0.0693 ± 0.008 ms  | 0.0671 ± 0.0078 ms | 1.03 ± 0.17                |
| AD gradients/matrix_exp/transition_probability direct gradient/Mooncake reverse                   | 0.416 ± 0.12 ms    | 0.429 ± 0.047 ms   | 0.969 ± 0.29               |
| AD gradients/matrix_exp/transition_probability direct gradient/ReverseDiff (tape)                 | 0.768 ± 0.12 ms    | 0.767 ± 0.16 ms    | 1 ± 0.26                   |
| AD gradients/ode_problem solve survival gradient (PhaseType)/Enzyme forward                       | 20.3 ± 0.6 ms      | 17.4 ± 0.62 ms     | 1.17 ± 0.054               |
| AD gradients/ode_problem solve survival gradient (PhaseType)/ForwardDiff                          | 0.288 ± 0.012 ms   | 0.288 ± 0.012 ms   | 0.999 ± 0.058              |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/Enzyme forward               | 20.4 ± 0.64 ms     | 17.5 ± 0.56 ms     | 1.17 ± 0.053               |
| AD gradients/ode_problem solve survival gradient (PhaseType, direct)/ForwardDiff                  | 0.291 ± 0.012 ms   | 0.289 ± 0.012 ms   | 1.01 ± 0.059               |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme forward                           | 6.09 ± 0.074 μs    | 6.13 ± 0.082 μs    | 0.994 ± 0.018              |
| AD gradients/phase_type hyperexponential (α, S) gradient/Enzyme reverse                           | 1.29 ± 0.03 μs     | 1.34 ± 0.041 μs    | 0.964 ± 0.037              |
| AD gradients/phase_type hyperexponential (α, S) gradient/ForwardDiff                              | 0.488 ± 0.046 μs   | 0.499 ± 0.055 μs   | 0.976 ± 0.14               |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake forward                         | 11.1 ± 0.46 μs     | 11.4 ± 0.51 μs     | 0.975 ± 0.06               |
| AD gradients/phase_type hyperexponential (α, S) gradient/Mooncake reverse                         | 15.5 ± 0.62 μs     | 17.5 ± 0.8 μs      | 0.887 ± 0.054              |
| AD gradients/phase_type hyperexponential (α, S) gradient/ReverseDiff (tape)                       | 8.01 ± 0.22 μs     | 8.17 ± 0.18 μs     | 0.98 ± 0.034               |
| AD gradients/update(CTMC, rates) transition gradient/Enzyme forward                               | 21.7 ± 7.9 μs      | 22.4 ± 9.1 μs      | 0.968 ± 0.53               |
| AD gradients/update(CTMC, rates) transition gradient/Enzyme reverse                               | 0.265 ± 0.024 ms   | 0.248 ± 0.026 ms   | 1.07 ± 0.15                |
| AD gradients/update(CTMC, rates) transition gradient/ForwardDiff                                  | 11.5 ± 0.5 μs      | 12.4 ± 1.2 μs      | 0.934 ± 0.1                |
| AD gradients/update(CTMC, rates) transition gradient/Mooncake forward                             | 0.0793 ± 0.0072 ms | 0.0718 ± 0.0073 ms | 1.11 ± 0.15                |
| AD gradients/update(CTMC, rates) transition gradient/Mooncake reverse                             | 0.464 ± 0.031 ms   | 0.473 ± 0.041 ms   | 0.981 ± 0.11               |
| AD gradients/update(CTMC, rates) transition gradient/ReverseDiff (tape)                           | 0.719 ± 0.11 ms    | 0.713 ± 0.14 ms    | 1.01 ± 0.25                |
| AD gradients/update(Coxian, rates) survival gradient/Enzyme forward                               | 11.5 ± 1.5 μs      | 11.8 ± 2.1 μs      | 0.975 ± 0.22               |
| AD gradients/update(Coxian, rates) survival gradient/Enzyme reverse                               | 0.247 ± 0.02 ms    | 0.241 ± 0.022 ms   | 1.03 ± 0.12                |
| AD gradients/update(Coxian, rates) survival gradient/ForwardDiff                                  | 6.87 ± 0.74 μs     | 7.36 ± 1.3 μs      | 0.934 ± 0.19               |
| AD gradients/update(Coxian, rates) survival gradient/Mooncake forward                             | 0.0432 ± 0.014 ms  | 0.0443 ± 0.013 ms  | 0.975 ± 0.42               |
| AD gradients/update(Coxian, rates) survival gradient/Mooncake reverse                             | 0.336 ± 0.031 ms   | 0.344 ± 0.036 ms   | 0.975 ± 0.14               |
| AD gradients/update(Coxian, rates) survival gradient/ReverseDiff (tape)                           | 0.328 ± 0.057 ms   | 0.337 ± 0.055 ms   | 0.974 ± 0.23               |
| AD gradients/update(ErlangChain, rates) survival gradient/Enzyme forward                          | 10.2 ± 1.1 μs      | 10.4 ± 0.74 μs     | 0.981 ± 0.13               |
| AD gradients/update(ErlangChain, rates) survival gradient/Enzyme reverse                          | 0.263 ± 0.021 ms   | 0.257 ± 0.024 ms   | 1.02 ± 0.12                |
| AD gradients/update(ErlangChain, rates) survival gradient/ForwardDiff                             | 7.42 ± 0.74 μs     | 8.11 ± 0.87 μs     | 0.915 ± 0.13               |
| AD gradients/update(ErlangChain, rates) survival gradient/Mooncake forward                        | 0.0417 ± 0.012 ms  | 0.0391 ± 0.011 ms  | 1.07 ± 0.43                |
| AD gradients/update(ErlangChain, rates) survival gradient/Mooncake reverse                        | 0.483 ± 0.036 ms   | 0.489 ± 0.046 ms   | 0.986 ± 0.12               |
| AD gradients/update(ErlangChain, rates) survival gradient/ReverseDiff (tape)                      | 0.793 ± 0.14 ms    | 0.791 ± 0.16 ms    | 1 ± 0.27                   |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Enzyme forward                      | 11.2 ± 1.5 μs      | 11.1 ± 1.4 μs      | 1.01 ± 0.19                |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Enzyme reverse                      | 0.238 ± 0.019 ms   | 0.234 ± 0.016 ms   | 1.02 ± 0.11                |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/ForwardDiff                         | 6.19 ± 0.83 μs     | 6.12 ± 0.95 μs     | 1.01 ± 0.21                |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Mooncake forward                    | 0.0421 ± 0.014 ms  | 0.039 ± 0.015 ms   | 1.08 ± 0.54                |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/Mooncake reverse                    | 0.32 ± 0.029 ms    | 0.323 ± 0.03 ms    | 0.989 ± 0.13               |
| AD gradients/update(PhaseType, [α; vec(S)]) survival gradient/ReverseDiff (tape)                  | 0.306 ± 0.052 ms   | 0.301 ± 0.042 ms   | 1.02 ± 0.22                |
| Bridges/jump_problem (JumpProcesses)                                                              | 1.29 ± 0.26 μs     | 1.33 ± 0.28 μs     | 0.971 ± 0.28               |
| Bridges/ode_problem (SciMLBase)                                                                   | 0.165 ± 0.0045 ms  | 0.165 ± 0.0047 ms  | 1 ± 0.04                   |
| Bridges/reaction_system (Catalyst)                                                                | 0.082 ± 0.0026 ms  | 0.0891 ± 0.0034 ms | 0.92 ± 0.046               |
| Evaluation/ctmc builder + transition_probability                                                  | 4.68 ± 0.99 μs     | 4.69 ± 1 μs        | 0.997 ± 0.3                |
| Evaluation/phase-type matrix_exp                                                                  | 3.93 ± 1.8 μs      | 3.93 ± 2.2 μs      | 0.999 ± 0.73               |
| Lowering/canonical(Erlang branch)                                                                 | 0.144 ± 0.034 μs   | 0.147 ± 0.043 μs   | 0.983 ± 0.37               |
| Lowering/canonical(PhaseType branch)                                                              | 0.124 ± 0.05 μs    | 0.126 ± 0.057 μs   | 0.987 ± 0.6                |
| Lowering/canonical(fixed phases)                                                                  | 0.188 ± 0.023 μs   | 0.191 ± 0.035 μs   | 0.983 ± 0.22               |
| Lowering/lower(Exponential)                                                                       | 1.52 ± 0.043 μs    | 1.5 ± 0.051 μs     | 1.01 ± 0.045               |
| Lowering/lower(Gamma, Erlang branch)                                                              | 0.0463 ± 0.026 μs  | 0.0449 ± 0.024 μs  | 1.03 ± 0.79                |
| Lowering/lower(Gamma, PhaseType branch)                                                           | 0.124 ± 0.054 μs   | 0.133 ± 0.064 μs   | 0.932 ± 0.6                |
| time_to_load                                                                                      | 0.492 ± 0.0064 s   | 0.49 ± 0.004 s     | 1 ± 0.015                  |

|                                                                                                   | v0.1.0                    | c41bf366a75137...         | v0.1.0 / c41bf366a75137... |
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

