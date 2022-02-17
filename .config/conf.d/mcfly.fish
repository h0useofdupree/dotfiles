set -gx MCFLY_FUZZY true
set -gx MCFLY_RESULTS 20
set -gx MCFLY_INTERFACE_VIEW BOTTOM
set -gx MCFLY_RESULTS_SORT LAST_RUN
mcfly init fish | source
