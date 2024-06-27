/*
Test: 5
Name: Changed Lead Provider
Summary: ECT is registered for training with a Lead Provider, then the ECTs
        Lead Provider is changed partway through their induction
Testing Instructions:
  1. ECT is registered at a school
  2. a Lead Provider is reported on the ECTs record
  3. a different Lead Provider is then reported on the ECTs Record
Expectation: 

Complications: 

Description:
  one induction period, one training period created at the beginning of the
  year New LP/DP/School pairing validated Training period stops partway through
  the year, new one created from that point on with the new LP Induction period
  continues throughout the year
  IP: IP: AB A, School A, Mentor A, start day 1, end day null
  TP: TP1: LP A, DP A, School A, PT FIP, start day 1, end day 2
  TP2: LP B, DP B, School A, PT FIP, start day 3, end day null"

IP Visibility:
  Visible to School A

TP Visibility:
  TP1 visible to LP/DP A&B, School A
  TP2 visible to LP/DP B, School A

Actual Result: 

Status: To Be Tested
*/


-- lead provider = 1
--
-- should only be able to see declarations from current
-- lead provider

select d.*, lp.name as lead_provider_name
from lead_providers lp
inner join provider_partnerships pp on lp.id = pp.lead_provider_id
inner join training t on pp.id = t.provider_partnership_id
inner join declarations d on t.id = d.training_id
where lp.id = 1;


-- lead provider = 2 (current)
--
-- should be able to see declarations from both current
-- and past lead providers

with current_teachers as (
  select te.id as teacher_id
  from lead_providers lp
  inner join provider_partnerships pp on lp.id = pp.lead_provider_id
  inner join training t on pp.id = t.provider_partnership_id
  inner join teachers te on t.teacher_id = te.id
  where t.finished_on is null
  and lp.id = 2
)
select d.*, lp.name
from current_teachers ct
inner join training t on ct.teacher_id = t.teacher_id
inner join declarations d on t.id = d.training_id
inner join provider_partnerships pp on t.provider_partnership_id = pp.id
inner join lead_providers lp on pp.lead_provider_id = lp.id
;
