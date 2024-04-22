create or replace view aggJoin7469851609700588785 as (
with aggView2772004311035710855 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView2772004311035710855 where mc.company_id=aggView2772004311035710855.v20);
create or replace view aggJoin6389121795519302366 as (
with aggView5893520806148455222 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView5893520806148455222 where mk.keyword_id=aggView5893520806148455222.v25);
create or replace view aggJoin5939961710706640276 as (
with aggView6496467501677281158 as (select v3 from aggJoin6389121795519302366 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView6496467501677281158 where ci.movie_id=aggView6496467501677281158.v3);
create or replace view aggJoin8061804243909263167 as (
with aggView7521402839921919926 as (select v3 from aggJoin7469851609700588785 group by v3)
select id as v3 from title as t, aggView7521402839921919926 where t.id=aggView7521402839921919926.v3);
create or replace view aggJoin6193039559018717998 as (
with aggView1686191962633421218 as (select v3 from aggJoin8061804243909263167 group by v3)
select v26 from aggJoin5939961710706640276 join aggView1686191962633421218 using(v3));
create or replace view aggJoin5581214635243086403 as (
with aggView2942026111319238469 as (select v26 from aggJoin6193039559018717998 group by v26)
select name as v27 from name as n, aggView2942026111319238469 where n.id=aggView2942026111319238469.v26);
create or replace view aggJoin3079878455935293007 as (
with aggView5594059475586821469 as (select v27 from aggJoin5581214635243086403 group by v27)
select v27 from aggView5594059475586821469 where v27 LIKE '%Bert%');
select MIN(v27) as v47 from aggJoin3079878455935293007;
