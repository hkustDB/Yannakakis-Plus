create or replace view aggJoin1547114441747385037 as (
with aggView2332824926371932713 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView2332824926371932713 where cc.subject_id=aggView2332824926371932713.v5);
create or replace view aggJoin5910300925922846388 as (
with aggView6399835380673581299 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView6399835380673581299 where ci.person_id=aggView6399835380673581299.v31);
create or replace view aggJoin1556393143696406022 as (
with aggView5527927378965307523 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin1547114441747385037 join aggView5527927378965307523 using(v7));
create or replace view aggJoin6109434726241019195 as (
with aggView7017135631011221374 as (select v40 from aggJoin1556393143696406022 group by v40)
select id as v40, title as v41, kind_id as v26, production_year as v44 from title as t, aggView7017135631011221374 where t.id=aggView7017135631011221374.v40 and production_year>1950);
create or replace view aggJoin4627791845449368076 as (
with aggView7932306324967967320 as (select id as v26 from kind_type as kt where kind= 'movie')
select v40, v41, v44 from aggJoin6109434726241019195 join aggView7932306324967967320 using(v26));
create or replace view aggJoin6707386230742456887 as (
with aggView2408727949835193193 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin5910300925922846388 join aggView2408727949835193193 using(v9));
create or replace view aggJoin7680147427040829886 as (
with aggView2019483253127864797 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView2019483253127864797 where mk.keyword_id=aggView2019483253127864797.v23);
create or replace view aggJoin5999539268284660813 as (
with aggView7513758086070414748 as (select v40 from aggJoin7680147427040829886 group by v40)
select v40, v41, v44 from aggJoin4627791845449368076 join aggView7513758086070414748 using(v40));
create or replace view aggJoin143689219109214195 as (
with aggView6317055589660965274 as (select v40, MIN(v41) as v52 from aggJoin5999539268284660813 group by v40)
select v52 from aggJoin6707386230742456887 join aggView6317055589660965274 using(v40));
select MIN(v52) as v52 from aggJoin143689219109214195;
