
This folder contains dumps of the data from the main database as of April 4, 2011. It shows all the data we have collected to date during the private beta.

There are 4 files:

- targets: Places in the sky that have been observed for this application.
- observations: Times when the telescopes were pointed at a target. In a few cases, there are more than one observation of a target.
- assignments: Times when a portion of an observation was assigned to a user of the application to look for patterns.
- pattern_marks: Places where a user has marked an observation, saying they see a pattern.

Notes:
- No user data, just user id's, for privacy.
- We omitted observation_ranges. Each Observation is actually broken into 100 ranges (by frequency), and individual ranges are assigned to the user. So the user is only seeing 1/100 of the entire observation. The ranges themselves are not very interesting database records and the data is quite voluminous.
- Database ID's reference objects in other files in the set. This data could easily be used to populate a relational database.
- The first few assignments and pattern_marks are likely to be bogus, since we were really just testing the app. Those with user_id of 1 are especially questionable (that's me!)

Some questions to explore:
- What's the overall pattern mark percentage (pattern marks per assignment)?
- Which observations have the highest pattern mark percentage?
- Do multiple observations of the same target show the same behavior?
- Are there users whose pattern marks are more reliable than others?
- Do we have enough data to draw conclusions?
- Are there specific frequencies where we are seeing more pattern marks than others?

