ejs   = require './ejs'
state = require './state'

# The default search query.
query = new can.Map
    
    # The current query.
    'current': ''

    # Past queries, automatically set by observing `current`.
    'history': [ ]

# Observe query changes to trigger a service search.
query.bind 'current', (ev, q) ->
    # Push query at the head of the history and limit to 3 results.
    (history = @history[0...2]).splice(0, 0, q)
    @attr 'history', history

    # Say we are doing the search.
    do state.loading

    # Use the client to do the search.
    ejs.search q, (err, { total, docs }) ->
        # Trouble?
        return state.error err if err

        # No results?
        return do state.noResults unless total

        # Has results.
        state.hasResults(total, docs)

module.exports = query