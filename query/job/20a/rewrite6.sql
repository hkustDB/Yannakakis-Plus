create or replace view aggJoin2182505621974630206 as (
with aggView1064778494624047189 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView1064778494624047189 where cc.subject_id=aggView1064778494624047189.v5);
create or replace view aggJoin3976228920595551203 as (
with aggView7884772212385250145 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView7884772212385250145 where ci.person_id=aggView7884772212385250145.v31);
create or replace view aggJoin4607757682633851008 as (
with aggView2274008424975137335 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin2182505621974630206 join aggView2274008424975137335 using(v7));
create or replace view aggJoin4991894637591889794 as (
with aggView5817176093302294763 as (select v40 from aggJoin4607757682633851008 group by v40)
select v40, v9 from aggJoin3976228920595551203 join aggView5817176093302294763 using(v40));
create or replace view aggJoin8483467427793875701 as (
with aggView2769359469978158730 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView2769359469978158730 where t.kind_id=aggView2769359469978158730.v26 and production_year>1950);
create or replace view aggJoin581248182958977471 as (
with aggView7340799428284535088 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin4991894637591889794 join aggView7340799428284535088 using(v9));
create or replace view aggJoin1033866695981815985 as (
with aggView5313238602175965073 as (select v40 from aggJoin581248182958977471 group by v40)
select movie_id as v40, keyword_id as v23 from movie_keyword as mk, aggView5313238602175965073 where mk.movie_id=aggView5313238602175965073.v40);
create or replace view aggJoin3267339232051996611 as (
with aggView4250598103253779885 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40 from aggJoin1033866695981815985 join aggView4250598103253779885 using(v23));
create or replace view aggJoin3836680651611468433 as (
with aggView394861949083760208 as (select v40 from aggJoin3267339232051996611 group by v40)
select v41, v44 from aggJoin8483467427793875701 join aggView394861949083760208 using(v40));
create or replace view aggView1086623994575437447 as select v41 from aggJoin3836680651611468433 group by v41;
select MIN(v41) as v52 from aggView1086623994575437447;
