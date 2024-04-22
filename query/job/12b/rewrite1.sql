create or replace view aggJoin6170557462260926537 as (
with aggView8087498834682174412 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView8087498834682174412 where mi.info_type_id=aggView8087498834682174412.v21);
create or replace view aggJoin4278449553370076524 as (
with aggView5594536762825740827 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView5594536762825740827 where mc.company_id=aggView5594536762825740827.v1);
create or replace view aggJoin2522286903321403700 as (
with aggView5710815221170040961 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin4278449553370076524 join aggView5710815221170040961 using(v8));
create or replace view aggJoin8126109189393521512 as (
with aggView11283840456024372 as (select v29 from aggJoin2522286903321403700 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView11283840456024372 where t.id=aggView11283840456024372.v29 and production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')));
create or replace view aggView4850609699684599284 as select v29, v30 from aggJoin8126109189393521512 group by v29,v30;
create or replace view aggJoin7765760875803624493 as (
with aggView2575389423893632574 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select movie_id as v29 from movie_info_idx as mi_idx, aggView2575389423893632574 where mi_idx.info_type_id=aggView2575389423893632574.v26);
create or replace view aggJoin4361132374661540808 as (
with aggView6704647172102587933 as (select v29 from aggJoin7765760875803624493 group by v29)
select v29, v22 from aggJoin6170557462260926537 join aggView6704647172102587933 using(v29));
create or replace view aggView5648707419918171360 as select v29, v22 from aggJoin4361132374661540808 group by v29,v22;
create or replace view aggJoin4021171691156244170 as (
with aggView6514303961829490050 as (select v29, MIN(v30) as v42 from aggView4850609699684599284 group by v29)
select v22, v42 from aggView5648707419918171360 join aggView6514303961829490050 using(v29));
select MIN(v22) as v41,MIN(v42) as v42 from aggJoin4021171691156244170;
