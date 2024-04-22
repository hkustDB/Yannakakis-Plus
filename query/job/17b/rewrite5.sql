create or replace view aggJoin3462382103254498369 as (
with aggView3518824991509160946 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView3518824991509160946 where mc.company_id=aggView3518824991509160946.v20);
create or replace view aggJoin8398415064429122734 as (
with aggView4045455264999841898 as (select v3 from aggJoin3462382103254498369 group by v3)
select id as v3 from title as t, aggView4045455264999841898 where t.id=aggView4045455264999841898.v3);
create or replace view aggJoin5478071489947493101 as (
with aggView5159809516243104504 as (select v3 from aggJoin8398415064429122734 group by v3)
select movie_id as v3, keyword_id as v25 from movie_keyword as mk, aggView5159809516243104504 where mk.movie_id=aggView5159809516243104504.v3);
create or replace view aggJoin7888039017742957390 as (
with aggView2742645891859885588 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select v3 from aggJoin5478071489947493101 join aggView2742645891859885588 using(v25));
create or replace view aggJoin1118562405780021231 as (
with aggView3922571390497678597 as (select v3 from aggJoin7888039017742957390 group by v3)
select person_id as v26 from cast_info as ci, aggView3922571390497678597 where ci.movie_id=aggView3922571390497678597.v3);
create or replace view aggJoin8533034752571627677 as (
with aggView7205678652770656024 as (select v26 from aggJoin1118562405780021231 group by v26)
select name as v27 from name as n, aggView7205678652770656024 where n.id=aggView7205678652770656024.v26);
create or replace view aggJoin5540850279670687674 as (
with aggView7755993282905882039 as (select v27 from aggJoin8533034752571627677 group by v27)
select v27 from aggView7755993282905882039 where v27 LIKE 'Z%');
select MIN(v27) as v47 from aggJoin5540850279670687674;
