create or replace view aggView1529758532729027172 as select name as v32, id as v31 from name as n;
create or replace view aggJoin2065970242416491485 as (
with aggView9164549046104961649 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView9164549046104961649 where t.kind_id=aggView9164549046104961649.v26 and production_year>2000);
create or replace view aggJoin886358630452280905 as (
with aggView7207343430306157161 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView7207343430306157161 where cc.status_id=aggView7207343430306157161.v7);
create or replace view aggJoin1570552757238275564 as (
with aggView685627196764500955 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView685627196764500955 where mk.keyword_id=aggView685627196764500955.v23);
create or replace view aggJoin4620948330411215052 as (
with aggView3912605213028635670 as (select v40 from aggJoin1570552757238275564 group by v40)
select v40, v5 from aggJoin886358630452280905 join aggView3912605213028635670 using(v40));
create or replace view aggJoin955155610494075864 as (
with aggView9124418413877845347 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin4620948330411215052 join aggView9124418413877845347 using(v5));
create or replace view aggJoin7766517517942194524 as (
with aggView2518376816008359840 as (select v40 from aggJoin955155610494075864 group by v40)
select v40, v41, v44 from aggJoin2065970242416491485 join aggView2518376816008359840 using(v40));
create or replace view aggView3746304303019718742 as select v40, v41 from aggJoin7766517517942194524 group by v40,v41;
create or replace view aggJoin1583902888211976450 as (
with aggView2523387312729007199 as (select v40, MIN(v41) as v53 from aggView3746304303019718742 group by v40)
select person_id as v31, person_role_id as v9, v53 from cast_info as ci, aggView2523387312729007199 where ci.movie_id=aggView2523387312729007199.v40);
create or replace view aggJoin2989247288614601430 as (
with aggView3109460369177783410 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v31, v53 from aggJoin1583902888211976450 join aggView3109460369177783410 using(v9));
create or replace view aggJoin1254693203187116598 as (
with aggView7460663908777403399 as (select v31, MIN(v53) as v53 from aggJoin2989247288614601430 group by v31,v53)
select v32, v53 from aggView1529758532729027172 join aggView7460663908777403399 using(v31));
select MIN(v32) as v52,MIN(v53) as v53 from aggJoin1254693203187116598;
