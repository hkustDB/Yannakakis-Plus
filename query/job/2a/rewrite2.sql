create or replace view aggJoin3529622248153205799 as (
with aggView3140810363467864635 as (select id as v1 from company_name as cn where country_code= '[de]')
select movie_id as v12 from movie_companies as mc, aggView3140810363467864635 where mc.company_id=aggView3140810363467864635.v1);
create or replace view aggJoin8606976037692942110 as (
with aggView5740003234674777075 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v12 from movie_keyword as mk, aggView5740003234674777075 where mk.keyword_id=aggView5740003234674777075.v18);
create or replace view aggJoin4405978110190018511 as (
with aggView2440792401516031546 as (select v12 from aggJoin3529622248153205799 group by v12)
select v12 from aggJoin8606976037692942110 join aggView2440792401516031546 using(v12));
create or replace view aggJoin3071447514780979330 as (
with aggView5355047148038641620 as (select v12 from aggJoin4405978110190018511 group by v12)
select title as v20 from title as t, aggView5355047148038641620 where t.id=aggView5355047148038641620.v12);
create or replace view aggView5831714178361023906 as select v20 from aggJoin3071447514780979330 group by v20;
select MIN(v20) as v31 from aggView5831714178361023906;
