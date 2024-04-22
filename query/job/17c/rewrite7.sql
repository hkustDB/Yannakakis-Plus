create or replace view aggJoin1409950437685478350 as (
with aggView5817526695152026467 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView5817526695152026467 where mk.keyword_id=aggView5817526695152026467.v25);
create or replace view aggJoin8523567173131996160 as (
with aggView1237963557282924329 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView1237963557282924329 where mc.company_id=aggView1237963557282924329.v20);
create or replace view aggJoin6338955972052948164 as (
with aggView7035744418073306735 as (select v3 from aggJoin1409950437685478350 group by v3)
select v3 from aggJoin8523567173131996160 join aggView7035744418073306735 using(v3));
create or replace view aggJoin2710036182359108111 as (
with aggView499680753240754963 as (select v3 from aggJoin6338955972052948164 group by v3)
select id as v3 from title as t, aggView499680753240754963 where t.id=aggView499680753240754963.v3);
create or replace view aggJoin3432876111126821412 as (
with aggView6931396725979882801 as (select v3 from aggJoin2710036182359108111 group by v3)
select person_id as v26 from cast_info as ci, aggView6931396725979882801 where ci.movie_id=aggView6931396725979882801.v3);
create or replace view aggJoin7630712980753590141 as (
with aggView2818323498833135097 as (select v26 from aggJoin3432876111126821412 group by v26)
select name as v27 from name as n, aggView2818323498833135097 where n.id=aggView2818323498833135097.v26);
create or replace view aggJoin4346414601600886599 as (
with aggView7398131518179958186 as (select v27 from aggJoin7630712980753590141 group by v27)
select v27 from aggView7398131518179958186 where v27 LIKE 'X%');
select MIN(v27) as v47 from aggJoin4346414601600886599;
