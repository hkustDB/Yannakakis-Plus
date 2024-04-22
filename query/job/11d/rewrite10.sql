create or replace view aggView8619201520265671187 as select id as v24, title as v28 from title as t where production_year>1950;
create or replace view aggView6918002084462048926 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]';
create or replace view aggJoin5335923244175847349 as (
with aggView3148565944050387847 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView3148565944050387847 where mk.keyword_id=aggView3148565944050387847.v22);
create or replace view aggJoin3745738623371031490 as (
with aggView6346222628843673425 as (select v24 from aggJoin5335923244175847349 group by v24)
select movie_id as v24, company_id as v17, company_type_id as v18, note as v19 from movie_companies as mc, aggView6346222628843673425 where mc.movie_id=aggView6346222628843673425.v24);
create or replace view aggJoin738837042611552747 as (
with aggView790708271970571833 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v17, v19 from aggJoin3745738623371031490 join aggView790708271970571833 using(v18));
create or replace view aggJoin9019015133306362053 as (
with aggView613415708269780063 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView613415708269780063 where ml.link_type_id=aggView613415708269780063.v13);
create or replace view aggJoin5306249735418900196 as (
with aggView6665839666272512465 as (select v24 from aggJoin9019015133306362053 group by v24)
select v24, v17, v19 from aggJoin738837042611552747 join aggView6665839666272512465 using(v24));
create or replace view aggView1876826548422123220 as select v19, v24, v17 from aggJoin5306249735418900196 group by v19,v24,v17;
create or replace view aggJoin5632162351851726780 as (
with aggView8690924821419736175 as (select v17, MIN(v2) as v39 from aggView6918002084462048926 group by v17)
select v19, v24, v39 from aggView1876826548422123220 join aggView8690924821419736175 using(v17));
create or replace view aggJoin5083072408022222470 as (
with aggView6500037745847793290 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin5632162351851726780 group by v24,v39)
select v28, v39, v40 from aggView8619201520265671187 join aggView6500037745847793290 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v28) as v41 from aggJoin5083072408022222470;
