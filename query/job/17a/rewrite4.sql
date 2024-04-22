create or replace view aggJoin4209087922079218706 as (
with aggView2218826153214268556 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView2218826153214268556 where mc.company_id=aggView2218826153214268556.v20);
create or replace view aggJoin7192548024189291914 as (
with aggView7235157237466535225 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView7235157237466535225 where mk.keyword_id=aggView7235157237466535225.v25);
create or replace view aggJoin8337356291817208785 as (
with aggView1618492261781933634 as (select v3 from aggJoin7192548024189291914 group by v3)
select v3 from aggJoin4209087922079218706 join aggView1618492261781933634 using(v3));
create or replace view aggJoin4080189767639689017 as (
with aggView3929073354512515471 as (select v3 from aggJoin8337356291817208785 group by v3)
select id as v3 from title as t, aggView3929073354512515471 where t.id=aggView3929073354512515471.v3);
create or replace view aggJoin6724595448789941222 as (
with aggView6548485891594156167 as (select v3 from aggJoin4080189767639689017 group by v3)
select person_id as v26 from cast_info as ci, aggView6548485891594156167 where ci.movie_id=aggView6548485891594156167.v3);
create or replace view aggJoin7619679146064871283 as (
with aggView8037044506024444321 as (select v26 from aggJoin6724595448789941222 group by v26)
select name as v27 from name as n, aggView8037044506024444321 where n.id=aggView8037044506024444321.v26);
create or replace view aggJoin4787205101857692629 as (
with aggView3025255921880010983 as (select v27 from aggJoin7619679146064871283 group by v27)
select v27 from aggView3025255921880010983 where v27 LIKE 'B%');
select MIN(v27) as v47 from aggJoin4787205101857692629;
