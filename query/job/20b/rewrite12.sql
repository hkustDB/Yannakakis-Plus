create or replace view aggJoin519775009279435337 as (
with aggView7895414423849558019 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView7895414423849558019 where t.kind_id=aggView7895414423849558019.v26 and production_year>2000);
create or replace view aggJoin5620024704649517837 as (
with aggView5960311774002380893 as (select v40, MIN(v41) as v52 from aggJoin519775009279435337 group by v40)
select movie_id as v40, keyword_id as v23, v52 from movie_keyword as mk, aggView5960311774002380893 where mk.movie_id=aggView5960311774002380893.v40);
create or replace view aggJoin7759625743805069844 as (
with aggView7114180313780064022 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView7114180313780064022 where ci.person_role_id=aggView7114180313780064022.v9);
create or replace view aggJoin7462290919779633169 as (
with aggView7132278965067647856 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin7759625743805069844 join aggView7132278965067647856 using(v31));
create or replace view aggJoin1392563579898277481 as (
with aggView5029137688529143929 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView5029137688529143929 where cc.status_id=aggView5029137688529143929.v7);
create or replace view aggJoin1303371766035940951 as (
with aggView5960269825082549588 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin1392563579898277481 join aggView5960269825082549588 using(v5));
create or replace view aggJoin7377640281224460065 as (
with aggView1913016009416574121 as (select v40 from aggJoin1303371766035940951 group by v40)
select v40, v23, v52 as v52 from aggJoin5620024704649517837 join aggView1913016009416574121 using(v40));
create or replace view aggJoin6964945419182035222 as (
with aggView3016797793034952305 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40, v52 from aggJoin7377640281224460065 join aggView3016797793034952305 using(v23));
create or replace view aggJoin1476097749667110735 as (
with aggView4096090695451256838 as (select v40, MIN(v52) as v52 from aggJoin6964945419182035222 group by v40,v52)
select v52 from aggJoin7462290919779633169 join aggView4096090695451256838 using(v40));
select MIN(v52) as v52 from aggJoin1476097749667110735;
