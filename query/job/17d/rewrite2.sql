create or replace view aggJoin5322051350955005165 as (
with aggView2670173531776032373 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView2670173531776032373 where mc.company_id=aggView2670173531776032373.v20);
create or replace view aggJoin8680583131313888769 as (
with aggView5855339338044172598 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView5855339338044172598 where mk.keyword_id=aggView5855339338044172598.v25);
create or replace view aggJoin3209865061468249007 as (
with aggView9129802021565578353 as (select v3 from aggJoin8680583131313888769 group by v3)
select v3 from aggJoin5322051350955005165 join aggView9129802021565578353 using(v3));
create or replace view aggJoin8826776917414952751 as (
with aggView5626990160786093071 as (select v3 from aggJoin3209865061468249007 group by v3)
select id as v3 from title as t, aggView5626990160786093071 where t.id=aggView5626990160786093071.v3);
create or replace view aggJoin7820035368213793811 as (
with aggView6519101747334121347 as (select v3 from aggJoin8826776917414952751 group by v3)
select person_id as v26 from cast_info as ci, aggView6519101747334121347 where ci.movie_id=aggView6519101747334121347.v3);
create or replace view aggJoin3153991365475553460 as (
with aggView2846329047956515135 as (select v26 from aggJoin7820035368213793811 group by v26)
select name as v27 from name as n, aggView2846329047956515135 where n.id=aggView2846329047956515135.v26);
create or replace view aggJoin8949085280963560343 as (
with aggView1363983304007073410 as (select v27 from aggJoin3153991365475553460 group by v27)
select v27 from aggView1363983304007073410 where v27 LIKE '%Bert%');
select MIN(v27) as v47 from aggJoin8949085280963560343;
