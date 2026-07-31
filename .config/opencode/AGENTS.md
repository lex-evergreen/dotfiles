When reading or writing code, consider alternatives and tradeoffs. Tradeoff order: behavioral correctness > simplicity > intent clarity > idiomaticity.
Adding indirection often reduces simplicty. Helper methods/functions are costly if they are scoped to more than one surface.
Avoid adding/perpetuating axes of flexibility that are unused or are not guaranteed to be used in the future. Constrain the state space as much as possible.
Names are part of intent clarity. Names should not promise things the code doesn't enforce. If behavior changes, names and docstrings should be updated in the same change.
Never make changes to remote resources without explicit instructions to do so (e.g., never `git push`, never use MCP tools that write to remote resources like GitHub).
