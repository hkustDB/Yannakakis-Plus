create or replace view aggView2416903389341690142 as select title as v28, id as v24 from title as t where production_year<=2000 and production_year>=1950;
create or replace view aggView5329418749299971028 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin7975979599747363444 as (
with aggView4800709068552090756 as (select v24, MIN(v28) as v41 from aggView2416903389341690142 group by v24)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView4800709068552090756 where ml.movie_id=aggView4800709068552090756.v24);
create or replace view aggJoin6038795038116522185 as (
with aggView718141770058195569 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follow%')
select v24, v41, v40 from aggJoin7975979599747363444 join aggView718141770058195569 using(v13));
create or replace view aggJoin8798500145689228240 as (
with aggView2293123290738111612 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView2293123290738111612 where mk.keyword_id=aggView2293123290738111612.v22);
create or replace view aggJoin2455453565972696121 as (
with aggView2351100954504651135 as (select v24, MIN(v41) as v41, MIN(v40) as v40 from aggJoin6038795038116522185 group by v24,v40,v41)
select movie_id as v24, company_id as v17, company_type_id as v18, v41, v40 from movie_companies as mc, aggView2351100954504651135 where mc.movie_id=aggView2351100954504651135.v24);
create or replace view aggJoin2310387537858885885 as (
with aggView3726991763454106514 as (select v24 from aggJoin8798500145689228240 group by v24)
select v17, v18, v41 as v41, v40 as v40 from aggJoin2455453565972696121 join aggView3726991763454106514 using(v24));
create or replace view aggJoin1789985965275883703 as (
with aggView4037815930940563333 as (select id as v18 from company_type as ct where kind= 'production companies')
select v17, v41, v40 from aggJoin2310387537858885885 join aggView4037815930940563333 using(v18));
create or replace view aggJoin5595711814260121276 as (
with aggView6282097246344570104 as (select v17, MIN(v41) as v41, MIN(v40) as v40 from aggJoin1789985965275883703 group by v17,v40,v41)
select v2, v41, v40 from aggView5329418749299971028 join aggView6282097246344570104 using(v17));
select MIN(v2) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin5595711814260121276;
