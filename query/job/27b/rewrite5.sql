create or replace view aggView5932535341155336521 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin4443981295558962105 as (
with aggView8842798271644839487 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Germany','Swedish','German') group by movie_id)
select movie_id as v37, subject_id as v5, status_id as v7 from complete_cast as cc, aggView8842798271644839487 where cc.movie_id=aggView8842798271644839487.v37);
create or replace view aggJoin4162433107083525009 as (
with aggView8227808445379026994 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v37, v7 from aggJoin4443981295558962105 join aggView8227808445379026994 using(v5));
create or replace view aggJoin1590356797952657977 as (
with aggView1889321282834652638 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin4162433107083525009 join aggView1889321282834652638 using(v7));
create or replace view aggJoin3988502177403399740 as (
with aggView1494547859608734082 as (select v37 from aggJoin1590356797952657977 group by v37)
select id as v37, title as v41, production_year as v44 from title as t, aggView1494547859608734082 where t.id=aggView1494547859608734082.v37 and production_year= 1998);
create or replace view aggView8523516121912231365 as select v37, v41 from aggJoin3988502177403399740 group by v37,v41;
create or replace view aggJoin6401942765044087037 as (
with aggView4314197130861357037 as (select v25, MIN(v10) as v52 from aggView5932535341155336521 group by v25)
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView4314197130861357037 where mc.company_id=aggView4314197130861357037.v25);
create or replace view aggJoin5260258821642013769 as (
with aggView8751015268268964806 as (select v37, MIN(v41) as v54 from aggView8523516121912231365 group by v37)
select movie_id as v37, link_type_id as v21, v54 from movie_link as ml, aggView8751015268268964806 where ml.movie_id=aggView8751015268268964806.v37);
create or replace view aggJoin6808244191856033663 as (
with aggView8842288028656083459 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView8842288028656083459 where mk.keyword_id=aggView8842288028656083459.v35);
create or replace view aggJoin5763854498397180128 as (
with aggView3859802344434024272 as (select v37 from aggJoin6808244191856033663 group by v37)
select v37, v26, v52 as v52 from aggJoin6401942765044087037 join aggView3859802344434024272 using(v37));
create or replace view aggJoin7391890534097192168 as (
with aggView6048343314129012906 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin5763854498397180128 join aggView6048343314129012906 using(v26));
create or replace view aggJoin8097612254187195604 as (
with aggView1920292530978342019 as (select v37, MIN(v52) as v52 from aggJoin7391890534097192168 group by v37,v52)
select v21, v54 as v54, v52 from aggJoin5260258821642013769 join aggView1920292530978342019 using(v37));
create or replace view aggJoin9039332901859041604 as (
with aggView946190216896707881 as (select v21, MIN(v54) as v54, MIN(v52) as v52 from aggJoin8097612254187195604 group by v21,v52,v54)
select link as v22, v54, v52 from link_type as lt, aggView946190216896707881 where lt.id=aggView946190216896707881.v21 and link LIKE '%follow%');
select MIN(v52) as v52,MIN(v22) as v53,MIN(v54) as v54 from aggJoin9039332901859041604;
