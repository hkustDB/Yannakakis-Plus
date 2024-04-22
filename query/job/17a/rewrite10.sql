create or replace view aggJoin1993789196487204634 as (
with aggView8781157909367654965 as (select id as v26, name as v47 from name as n where name LIKE 'B%')
select movie_id as v3, v47 from cast_info as ci, aggView8781157909367654965 where ci.person_id=aggView8781157909367654965.v26);
create or replace view aggJoin5711268744863097797 as (
with aggView1033276277792263932 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView1033276277792263932 where mc.company_id=aggView1033276277792263932.v20);
create or replace view aggJoin3457264537565812414 as (
with aggView5712673820282239248 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView5712673820282239248 where mk.keyword_id=aggView5712673820282239248.v25);
create or replace view aggJoin4772361889458359925 as (
with aggView5024717253374197744 as (select v3 from aggJoin5711268744863097797 group by v3)
select id as v3 from title as t, aggView5024717253374197744 where t.id=aggView5024717253374197744.v3);
create or replace view aggJoin8732994527027711600 as (
with aggView245427860782625221 as (select v3 from aggJoin4772361889458359925 group by v3)
select v3 from aggJoin3457264537565812414 join aggView245427860782625221 using(v3));
create or replace view aggJoin3701235589081276955 as (
with aggView2365895167621555602 as (select v3 from aggJoin8732994527027711600 group by v3)
select v47 as v47 from aggJoin1993789196487204634 join aggView2365895167621555602 using(v3));
select MIN(v47) as v47 from aggJoin3701235589081276955;
