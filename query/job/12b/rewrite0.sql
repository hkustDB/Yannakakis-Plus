create or replace view aggJoin7143272428422687169 as (
with aggView3602310527833907324 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView3602310527833907324 where mi.info_type_id=aggView3602310527833907324.v21);
create or replace view aggJoin6553898941211465189 as (
with aggView5750579165771690801 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView5750579165771690801 where mc.company_id=aggView5750579165771690801.v1);
create or replace view aggJoin986049638537231533 as (
with aggView544545785037051516 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select movie_id as v29 from movie_info_idx as mi_idx, aggView544545785037051516 where mi_idx.info_type_id=aggView544545785037051516.v26);
create or replace view aggJoin7063784571564564133 as (
with aggView4796891555165193253 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin6553898941211465189 join aggView4796891555165193253 using(v8));
create or replace view aggJoin286757645336794188 as (
with aggView2596214658596394886 as (select v29 from aggJoin986049638537231533 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView2596214658596394886 where t.id=aggView2596214658596394886.v29 and production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')));
create or replace view aggView4579709863373831157 as select v29, v30 from aggJoin286757645336794188 group by v29,v30;
create or replace view aggJoin5539789221166051061 as (
with aggView1342766005142311571 as (select v29 from aggJoin7063784571564564133 group by v29)
select v29, v22 from aggJoin7143272428422687169 join aggView1342766005142311571 using(v29));
create or replace view aggView5015232170872002753 as select v29, v22 from aggJoin5539789221166051061 group by v29,v22;
create or replace view aggJoin1592392442282595683 as (
with aggView8488637999170448577 as (select v29, MIN(v30) as v42 from aggView4579709863373831157 group by v29)
select v22, v42 from aggView5015232170872002753 join aggView8488637999170448577 using(v29));
select MIN(v22) as v41,MIN(v42) as v42 from aggJoin1592392442282595683;
