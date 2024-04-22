create or replace view aggJoin4250528505020191919 as (
with aggView548834104432251152 as (select id as v26, name as v47 from name as n where name LIKE '%B%')
select movie_id as v3, v47 from cast_info as ci, aggView548834104432251152 where ci.person_id=aggView548834104432251152.v26);
create or replace view aggJoin472735369552892681 as (
with aggView2441199747694258428 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView2441199747694258428 where mk.keyword_id=aggView2441199747694258428.v25);
create or replace view aggJoin328828657232405211 as (
with aggView8432647452667132030 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView8432647452667132030 where mc.company_id=aggView8432647452667132030.v20);
create or replace view aggJoin6791075960551684040 as (
with aggView6657490040613454974 as (select id as v3 from title as t)
select v3 from aggJoin328828657232405211 join aggView6657490040613454974 using(v3));
create or replace view aggJoin1116847352162049708 as (
with aggView5710470571193150371 as (select v3 from aggJoin6791075960551684040 group by v3)
select v3 from aggJoin472735369552892681 join aggView5710470571193150371 using(v3));
create or replace view aggJoin9042348818903046163 as (
with aggView4541573577498266593 as (select v3 from aggJoin1116847352162049708 group by v3)
select v47 as v47 from aggJoin4250528505020191919 join aggView4541573577498266593 using(v3));
select MIN(v47) as v47 from aggJoin9042348818903046163;
