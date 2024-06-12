with
  -- convert each started_on to finished_on span to
  -- a daterange. We want to cap ongoing ranges with
  -- the current_date so we're not looking into the future
  -- unnecessarily
  mentorship_ranges as (
    select
      mentee_id as participant_id,
      daterange(
        m.started_on,
        coalesce(m.finished_on, current_date)
      ) range
    from
      mentorships m
    ),

  -- combine the individual ranges into a multirange
  mentorship_multiranges as (
    select
      participant_id,
      range_agg(range) as multiranges
    from
      mentorship_ranges
    group by
      participant_id
  ),

  -- now repeat the two steps above for appropriate body
  -- associations
  appropriate_body_association_ranges as (
    select
      participant_id,
      daterange(
        aba.started_on,
        coalesce(aba.finished_on, current_date)
      ) range
    from
      appropriate_body_associations aba
  ),
  appropriate_body_association_multiranges as (
    select
      participant_id,
      range_agg(range) as multiranges
    from
      appropriate_body_association_ranges
    group by
      participant_id
  ),

  -- work out the intersections between the mentorship
  -- and appropriate body multiranges and unnest them
  -- to separate rows
  unnested_overlaps as (
    select
      mm.participant_id,
      unnest(mm.multiranges * abam.multiranges) as overlap
    from
      mentorship_multiranges mm
    inner join
      appropriate_body_association_multiranges abam
        on mm.participant_id = abam.participant_id
  )

-- finally convert the mentorship/ab overlaps into durations
-- and sum them for a total
select
  participant_id,
  sum(upper(overlap) - lower(overlap)) total_days
from
  unnested_overlaps
group by
  participant_id;
