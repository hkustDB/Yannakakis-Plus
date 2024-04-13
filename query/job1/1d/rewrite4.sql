create or replace view aggView1958597472080941021 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin889889949298325076 as select movie_id as v15 from movie_info_idx as mi_idx, aggView1958597472080941021 where mi_idx.info_type_id=aggView1958597472080941021.v3;
create or replace view aggView4628737968070144737 as select v15 from aggJoin889889949298325076 group by v15;
create or replace view aggJoin2520145641592245624 as select id as v15, title as v16, production_year as v19 from title as t, aggView4628737968070144737 where t.id=aggView4628737968070144737.v15 and production_year>2000;
create or replace view aggView8478547263555736571 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin2520145641592245624 group by v15;
create or replace view aggJoin5840859564724955257 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView8478547263555736571 where mc.movie_id=aggView8478547263555736571.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView291013252009928590 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3303794619735343522 as select v9, v28, v29 from aggJoin5840859564724955257 join aggView291013252009928590 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3303794619735343522;
