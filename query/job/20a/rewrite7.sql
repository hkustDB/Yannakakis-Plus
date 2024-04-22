create or replace view aggJoin8499897375970316766 as (
with aggView7930192899268851600 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView7930192899268851600 where cc.subject_id=aggView7930192899268851600.v5);
create or replace view aggJoin6901209331403132913 as (
with aggView3596501044449134811 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView3596501044449134811 where ci.person_id=aggView3596501044449134811.v31);
create or replace view aggJoin8276090615188177429 as (
with aggView7338696678200674632 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin8499897375970316766 join aggView7338696678200674632 using(v7));
create or replace view aggJoin825406890740235593 as (
with aggView2952469271814520888 as (select v40 from aggJoin8276090615188177429 group by v40)
select id as v40, title as v41, kind_id as v26, production_year as v44 from title as t, aggView2952469271814520888 where t.id=aggView2952469271814520888.v40 and production_year>1950);
create or replace view aggJoin4577242967505895610 as (
with aggView7992755575513321287 as (select id as v26 from kind_type as kt where kind= 'movie')
select v40, v41, v44 from aggJoin825406890740235593 join aggView7992755575513321287 using(v26));
create or replace view aggJoin8255835299251295057 as (
with aggView2769361235483702232 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin6901209331403132913 join aggView2769361235483702232 using(v9));
create or replace view aggJoin7176421403534374371 as (
with aggView2508261546260709779 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView2508261546260709779 where mk.keyword_id=aggView2508261546260709779.v23);
create or replace view aggJoin3018966264082734800 as (
with aggView7161157832613325923 as (select v40 from aggJoin7176421403534374371 group by v40)
select v40 from aggJoin8255835299251295057 join aggView7161157832613325923 using(v40));
create or replace view aggJoin2746226002445500055 as (
with aggView2021933702250458385 as (select v40 from aggJoin3018966264082734800 group by v40)
select v41, v44 from aggJoin4577242967505895610 join aggView2021933702250458385 using(v40));
create or replace view aggView1674511899045810164 as select v41 from aggJoin2746226002445500055 group by v41;
select MIN(v41) as v52 from aggView1674511899045810164;
