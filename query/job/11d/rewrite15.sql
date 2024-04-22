create or replace view aggJoin6057801274662328381 as (
with aggView7916275020141800387 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]')
select movie_id as v24, company_type_id as v18, note as v19, v39 from movie_companies as mc, aggView7916275020141800387 where mc.company_id=aggView7916275020141800387.v17);
create or replace view aggJoin8573518118219321842 as (
with aggView6646350083890224580 as (select id as v24, title as v41 from title as t where production_year>1950)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView6646350083890224580 where ml.movie_id=aggView6646350083890224580.v24);
create or replace view aggJoin5289888116477030965 as (
with aggView6589153726261831389 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView6589153726261831389 where mk.keyword_id=aggView6589153726261831389.v22);
create or replace view aggJoin7403464178332751968 as (
with aggView3427906332776131470 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v39 from aggJoin6057801274662328381 join aggView3427906332776131470 using(v18));
create or replace view aggJoin307533259432754169 as (
with aggView2821527483839215555 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin7403464178332751968 group by v24,v39)
select v24, v39, v40 from aggJoin5289888116477030965 join aggView2821527483839215555 using(v24));
create or replace view aggJoin3832689525999730187 as (
with aggView8822223553412924196 as (select id as v13 from link_type as lt)
select v24, v41 from aggJoin8573518118219321842 join aggView8822223553412924196 using(v13));
create or replace view aggJoin7551504186439676270 as (
with aggView3029719745515251853 as (select v24, MIN(v41) as v41 from aggJoin3832689525999730187 group by v24,v41)
select v39 as v39, v40 as v40, v41 from aggJoin307533259432754169 join aggView3029719745515251853 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin7551504186439676270;
