create or replace view aggJoin2470306151327979512 as (
with aggView1292040329881491834 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]')
select movie_id as v24, company_type_id as v18, note as v19, v39 from movie_companies as mc, aggView1292040329881491834 where mc.company_id=aggView1292040329881491834.v17);
create or replace view aggJoin7054243655997201227 as (
with aggView775688200540409687 as (select id as v24, title as v41 from title as t where production_year>1950)
select movie_id as v24, keyword_id as v22, v41 from movie_keyword as mk, aggView775688200540409687 where mk.movie_id=aggView775688200540409687.v24);
create or replace view aggJoin6959733766049687535 as (
with aggView6379394362182239900 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select v24, v41 from aggJoin7054243655997201227 join aggView6379394362182239900 using(v22));
create or replace view aggJoin5700710004854810562 as (
with aggView7344930902529681864 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v39 from aggJoin2470306151327979512 join aggView7344930902529681864 using(v18));
create or replace view aggJoin3980036665083500570 as (
with aggView2341981191271019093 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView2341981191271019093 where ml.link_type_id=aggView2341981191271019093.v13);
create or replace view aggJoin1518835554593614395 as (
with aggView3106541116163132965 as (select v24 from aggJoin3980036665083500570 group by v24)
select v24, v19, v39 as v39 from aggJoin5700710004854810562 join aggView3106541116163132965 using(v24));
create or replace view aggJoin749278427491601492 as (
with aggView6902851926954483381 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin1518835554593614395 group by v24,v39)
select v41 as v41, v39, v40 from aggJoin6959733766049687535 join aggView6902851926954483381 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin749278427491601492;
