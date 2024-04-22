create or replace view aggJoin2807901907965099975 as (
with aggView3467463045199107472 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView3467463045199107472 where cc.subject_id=aggView3467463045199107472.v5);
create or replace view aggJoin2062065717608785351 as (
with aggView7298146317021916952 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView7298146317021916952 where ci.person_id=aggView7298146317021916952.v31);
create or replace view aggJoin807681837042249433 as (
with aggView1953454294149481597 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin2807901907965099975 join aggView1953454294149481597 using(v7));
create or replace view aggJoin911545482485630115 as (
with aggView5844243996905795357 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView5844243996905795357 where t.kind_id=aggView5844243996905795357.v26 and production_year>1950);
create or replace view aggJoin2664277304484547549 as (
with aggView4199221654606106671 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin2062065717608785351 join aggView4199221654606106671 using(v9));
create or replace view aggJoin865088201940969944 as (
with aggView6635247673795739476 as (select v40 from aggJoin2664277304484547549 group by v40)
select v40 from aggJoin807681837042249433 join aggView6635247673795739476 using(v40));
create or replace view aggJoin4521333274454996747 as (
with aggView4189317893894515195 as (select v40 from aggJoin865088201940969944 group by v40)
select v40, v41, v44 from aggJoin911545482485630115 join aggView4189317893894515195 using(v40));
create or replace view aggJoin3374795920497617841 as (
with aggView4010672169933382002 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView4010672169933382002 where mk.keyword_id=aggView4010672169933382002.v23);
create or replace view aggJoin7532484675962804031 as (
with aggView3397239963732448868 as (select v40 from aggJoin3374795920497617841 group by v40)
select v41, v44 from aggJoin4521333274454996747 join aggView3397239963732448868 using(v40));
create or replace view aggView451061869909024204 as select v41 from aggJoin7532484675962804031 group by v41;
select MIN(v41) as v52 from aggView451061869909024204;
