create or replace view aggJoin7773712478399853670 as (
with aggView1131131966185722712 as (select id as v12, title as v31 from title as t)
select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView1131131966185722712 where mk.movie_id=aggView1131131966185722712.v12);
create or replace view aggJoin6869429442523050010 as (
with aggView5715854199458137217 as (select id as v1 from company_name as cn where country_code= '[nl]')
select movie_id as v12 from movie_companies as mc, aggView5715854199458137217 where mc.company_id=aggView5715854199458137217.v1);
create or replace view aggJoin7547007407608063875 as (
with aggView2523490228851488476 as (select v12 from aggJoin6869429442523050010 group by v12)
select v18, v31 as v31 from aggJoin7773712478399853670 join aggView2523490228851488476 using(v12));
create or replace view aggJoin6504990884676829511 as (
with aggView9117588198997622041 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select v31 from aggJoin7547007407608063875 join aggView9117588198997622041 using(v18));
select MIN(v31) as v31 from aggJoin6504990884676829511;
