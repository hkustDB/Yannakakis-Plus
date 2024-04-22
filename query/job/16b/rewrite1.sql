create or replace view aggJoin3961766661621939657 as (
with aggView6217164032854888796 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView6217164032854888796 where an.person_id=aggView6217164032854888796.v2);
create or replace view aggView8615317153277173450 as select v3, v2 from aggJoin3961766661621939657 group by v3,v2;
create or replace view aggJoin3740651897376643769 as (
with aggView1975724097119544044 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView1975724097119544044 where mc.company_id=aggView1975724097119544044.v28);
create or replace view aggJoin369971559514668850 as (
with aggView973047051924655047 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView973047051924655047 where mk.keyword_id=aggView973047051924655047.v33);
create or replace view aggJoin1804074186592807859 as (
with aggView401883172866488130 as (select v11 from aggJoin3740651897376643769 group by v11)
select id as v11, title as v44 from title as t, aggView401883172866488130 where t.id=aggView401883172866488130.v11);
create or replace view aggJoin2891321616408619151 as (
with aggView4332304660317897271 as (select v11 from aggJoin369971559514668850 group by v11)
select v11, v44 from aggJoin1804074186592807859 join aggView4332304660317897271 using(v11));
create or replace view aggView6705182287058867860 as select v44, v11 from aggJoin2891321616408619151 group by v44,v11;
create or replace view aggJoin3649700334504247364 as (
with aggView865749532885147435 as (select v2, MIN(v3) as v55 from aggView8615317153277173450 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView865749532885147435 where ci.person_id=aggView865749532885147435.v2);
create or replace view aggJoin2015734969481637805 as (
with aggView8398363024341948110 as (select v11, MIN(v55) as v55 from aggJoin3649700334504247364 group by v11,v55)
select v44, v55 from aggView6705182287058867860 join aggView8398363024341948110 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin2015734969481637805;
